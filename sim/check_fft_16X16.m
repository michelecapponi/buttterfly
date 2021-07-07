fpi=fopen('output_fft.txt','r');
fpj=fopen('results_fft.txt','w');
format long e
j=0;
for i=1:96
    if(j>15)
        j=0;
    end
    modelsim_value=fi_to_dec(fgetl(fpi))*32; %moltiplicazione per 32 in quanto è presente uno SF=32
    fprintf(fpj,'r%d=%d\n', j, modelsim_value);
    modelsim_value=fi_to_dec(fgetl(fpi))*32; %moltiplicazione per 32 in quanto è presente uno SF=32
    fprintf(fpj,'i%d=%d\n', j, modelsim_value);
    j=j+1;
    if(mod(i,16)==0)
        fprintf(fpj,'\n\n\n\n');
    end
end
fclose(fpj);
fclose(fpi);