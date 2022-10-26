module divisorFrecuencia(input C_50Mhz,
                  output reg C_1Hz = 1);


//C_1Hz = 1; //Señal de salida (&lt;em&gt;Se debe asignar un estado lógico&lt;/em&gt;).

reg[24:0] contador = 0; //Variable Contador equivale a 25 millones de estados.

always @(posedge C_50Mhz)
    begin
        contador = contador + 1; //0.5 segundos LED encendido
        if(contador == 250000)
        begin
            contador = 0;
            C_1Hz = ~C_1Hz; //0.5 segundos LED apagado
        end
    end
endmodule 