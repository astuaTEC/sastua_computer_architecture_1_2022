import numpy as np
from PIL import Image
import cv2

def interpolate_bilinear(array_in, width_in, height_in, array_out, width_out, height_out):
    for i in range(height_out):
        for j in range(width_out):
            # Relative coordinates of the pixel in output space
            x_out = j / width_out
            y_out = i / height_out

            # Corresponding absolute coordinates of the pixel in input space
            x_in = (x_out * width_in)
            y_in = (y_out * height_in)

            # Nearest neighbours coordinates in input space
            x_prev = int(np.floor(x_in))
            x_next = x_prev + 1
            y_prev = int(np.floor(y_in))
            y_next = y_prev + 1

            # Sanitize bounds - no need to check for < 0
            x_prev = min(x_prev, width_in - 1)
            x_next = min(x_next, width_in - 1)
            y_prev = min(y_prev, height_in - 1)
            y_next = min(y_next, height_in - 1)
            
            # Distances between neighbour nodes in input space
            Dy_next = y_next - y_in;
            Dy_prev = 1. - Dy_next; # because next - prev = 1
            Dx_next = x_next - x_in;
            Dx_prev = 1. - Dx_next; # because next - prev = 1
            
            # Interpolate over 3 RGB layers
           
            array_out[i][j] = Dy_prev * (array_in[y_next][x_prev] * Dx_next + array_in[y_next][x_next] * Dx_prev) \
                + Dy_next * (array_in[y_prev][x_prev] * Dx_next + array_in[y_prev][x_next] * Dx_prev)
                
    return array_out

if __name__ == "__main__":
    # load image
    # im = Image.open("./patches/patch_13.jpg")
    im = cv2.imread("./patches/patch_13.jpg", 0)
    width_2 = im.shape[0] *3
    height_2 = im.shape[1] *3

    # Go to normalized float and undo gamma
    # Note : sRGB gamma is not a pure power TF, but that will do
    im2 = (np.array(im) / 255.)**2.4

    # Interpolate in float64
    out = np.zeros((height_2, width_2, 3))
    out = interpolate_bilinear(im, im.shape[0], im.shape[1], out, width_2, height_2)

    # print(out)

    # Redo gamma and save back in uint8
    out = (out**(1/2.4) * 255.).astype(np.uint8)
    img = Image.fromarray(out)

    img.show()