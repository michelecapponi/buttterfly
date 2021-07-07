function [dec]= fi_to_dec(fi);
format long e
if(str2double(fi(1))==1)
    dec=-1;
else
    dec=0;
end

for i=2:20
    if(str2double(fi(i))==1)
        dec=dec+str2double(fi(i))*(2^(-i+1));
    end
end