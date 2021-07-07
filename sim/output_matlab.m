fp=fopen('samples.txt','r');
fpi=fopen('output_butterfly_matlab.txt','w');
format long e
while (feof(fp)==0)

    Ar=fgetl(fp);
    Ai=fgetl(fp);
    Br=fgetl(fp);
    Bi=fgetl(fp);
    Wr=fgetl(fp);
    Wi=fgetl(fp);
    
    Ar_dec=fi_to_dec(Ar);
    Ai_dec=fi_to_dec(Ai);
    Br_dec=fi_to_dec(Br);
    Bi_dec=fi_to_dec(Bi);
    Wr_dec=fi_to_dec(Wr);
    Wi_dec=fi_to_dec(Wi);
    
    Ar_primo=Ar_dec+Br_dec*Wr_dec-(Bi_dec*Wi_dec);
    Ai_primo=Ai_dec+Br_dec*Wi_dec+Bi_dec*Wr_dec;
    Br_primo=-Ar_primo+2*Ar_dec;
    Bi_primo=2*Ai_dec-Ai_primo;
    fprintf(fpi,'%d\n', Ar_primo);
    fprintf(fpi,'%d\n', Ai_primo);
    fprintf(fpi,'%d\n', Br_primo);
    fprintf(fpi,'%d\n', Bi_primo);

end

fclose(fpi);
fclose(fp);