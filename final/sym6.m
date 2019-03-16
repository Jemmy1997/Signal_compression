function [xd,CompressionRatio]=sym6 (x,type,Size,loss)
wname = 'sym6';
level=3;
[C,L] = wavedec(x,level, wname);
[thr,sorh,keepapp] = ddencmp('cmp','wv',x);

if (type == 1 && loss == 1),
    [C,L] = wavedec(x(:,1),level, wname); 
    [thr,sorh,keepapp] = ddencmp('cmp','wv',x(:,1)); 
    
end
if (type == 1 && loss == 2),
    thr=thr*10^2;
end
if (type == 2 && loss == 1),
    thr = thr*10;
end
if (type == 2 && loss == 2),
    thr=thr*10^5;
end
if (type == 3 && loss == 1),
% thr=thr*1;
end
if (type == 3 && loss == 2),
    thr = thr*10^5;
end
if (type == 4 && loss == 1),
%     thr=thr*1;
end
if (type == 4 && loss == 2),
    thr = thr*10^5;
end

[XC,CXC,LXC,PERF0,PERFL2] = wdencmp('gbl',C, L, wname,level,thr,sorh,keepapp);
C=CXC;
L=LXC;
save ('compressed.mat','C');
fileinfo2 = dir('compressed.mat');
Size2 = fileinfo2.bytes;
CompressionRatio = Size/Size2;
xd = waverec(C,L,wname);
if (type == 1),
    save('output1.wav','xd');
end  
if (type == 2),
    save('output1.mat','xd');
end
if (type == 3),
    save('output1.mat','xd');
end 
if (type == 4),
    save('output1.xlsx','xd');
end   

end