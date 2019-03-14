function [C, IC,comp]=code(matrix,filename,tolerance)
[C,~,IC] = uniquetol(matrix,tolerance);
C =single(C);
IC=single(IC);
save(filename,'C','IC');
s1=whos('C');
s2=whos('IC');
comp=s1.bytes+s2.bytes;
end