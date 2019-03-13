function code(mtrx)
uni = uniquetol(mtrx,0.00002);
len = length(uni);
for i=1:len
    mtrx(mtrx==uni(i)) = i;
end

if(len<2^8)
    out = uint8(mtrx);
elseif(len<2^16)
    out = uint16(mtrx);
elseif(len<2^32)
    out = uint32(mtrx);
end

save('unique.mat', 'uni');
save('output.mat', 'out');
end