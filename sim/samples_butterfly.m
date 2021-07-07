fp=fopen('samples.txt','w');
for i=1:1000
    x_Ar=(rand(1)*2-1)/2;
    x_Ai=(rand(1)*2-1)/2;
    x_Br=(rand(1)*2-1)/2;
    x_Bi=(rand(1)*2-1)/2;
    x_Wr=(rand(1)*2-1)/2;
    x_Wi=(rand(1)*2-1)/2;
    fprintf(fp,'%s\n', fi(x_Ar,1,20,19).bin);
    fprintf(fp,'%s\n', fi(x_Ai,1,20,19).bin);
    fprintf(fp,'%s\n', fi(x_Br,1,20,19).bin);
    fprintf(fp,'%s\n', fi(x_Bi,1,20,19).bin);
    fprintf(fp,'%s\n', fi(x_Wr,1,20,19).bin);
    fprintf(fp,'%s\n', fi(x_Wi,1,20,19).bin);
end
fclose(fp);