function [xd,CompressionRatio]=sym6(x,type,Size,loss)
wname = 'sym6';
if (loss == 1),
    [cA,cD] = dwt(x,wname);
     C = cD;
     C= rle(C);
     save ('compressed.mat','C');
     C = irle(C);
     xd = idwt(cA,cD,wname);
 
else
    level = 3;
    [C,L] = wavedec(x,level, wname);
    [thr,sorh,keepapp] = ddencmp('cmp','wv',x);
    if (type == 1),
    thr=thr*10^6;
    end
    if (type == 2),
      thr=thr*10^5;
    end
    if (type == 3),
      thr = thr*10^5;
    end
    if (type == 4 ),
      thr = thr*10^5;
    end
       [XC,CXC,LXC,PERF0,PERFL2] = wdencmp('gbl',C, L, wname,level,thr,sorh,keepapp);
       C=CXC;
       L=LXC;
       save ('compressed.mat','C');
       xd = waverec(C,L,wname);
      
end    

fileinfo2 = dir('compressed.mat');
Size2 = fileinfo2.bytes;
CompressionRatio = Size/Size2;
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
