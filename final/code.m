function [C, IC,comp]=code(matrix,filename,tolerance)
[C,~,IC] = uniquetol(matrix,tolerance);
C =single(C);
len = length(IC);
if(len<2^8)
    IC = uint8(IC);
elseif(len<2^16)
    IC = uint16(IC);
elseif(len<2^32)
    IC = uint32(IC);
end
%IC=single(IC);
save(filename,'C','IC');
s1=whos('C');
s2=whos('IC');
s=dir(filename);
s=s.bytes;
%comp=s1.bytes+s2.bytes;
comp=s;

end