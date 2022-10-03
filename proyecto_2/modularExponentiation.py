# Iterative Python3 program
# to compute modular power

# Iterative Function to calculate
# (x^y)%p in O(log y)
# Reference: https://www.geeksforgeeks.org/modular-exponentiation-power-in-modular-arithmetic/

def power(x, y, p) :
	res = 1	 # Initialize result

	# Update x if it is more
	# than or equal to p
	x = x % p
	
	if (x == 0) :
		return 0

	while (y > 0) :
		
		# If y is odd, multiply
		# x with result
		if ((y & 1) == 1) :
			res = (res * x) % p

		# y must be even now
		y = y >> 1	 # y = y/2
		x = (x * x) % p
		
	return res
	

# Driver Code
if __name__ == "__main__":
    x = 89; y = 211; p = 14
    print("Power is ", power(x, y, p))


# This code is contributed by Nikita Tiwari.
