fp=fopen('output_butterfly_matlab.txt','r');
fpi=fopen('output_butterfly_modelsim.txt','r');
fpj=fopen('results_butterfly.txt','w');
format long e
correct=1;
err=0.000001957;  %min error 0.000001957 (errore dovuto al rounding)
for i=1:4000
    matlab_value=str2double(fgetl(fp));
    modelsim_value=fi_to_dec(fgetl(fpi))*2; %moltiplicazione per 2 in quanto è presente uno SF=2
    if(abs(matlab_value-modelsim_value)<=err)
        fprintf(fpj,'%d', i);
        fprintf(fpj,'%s\n', ' ok');
    else
        correct=0;
        fprintf(fpj,'%d', i);
        fprintf(fpj,'%s\n', ' noooooooooooooooooooooooooooooooooooooooo');
    end
end
fclose(fpj);
fclose(fpi);
fclose(fp);