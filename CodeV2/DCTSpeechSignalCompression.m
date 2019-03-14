%% sound
% To hear, type soundsc(her,fs), pause(1), soundsc(him,fs)
[y,fs]=audioread('Windows XP Startup.wav');
%% Ult signal
 %y=load('ult_sig.mat');
 %y=x.ult_sig;
%% MR
% y = xlsread('MRS.xlsx');
%% Use the discrete cosine transform to compress the female voice signal. 
... Decompose the signal into DCT basis vectors.
...There are as many terms in the decomposition as there are samples in the signal. 
...The expansion coefficients in vector X measure how much energy is stored in each of the components. 
...Sort the coefficients from largest to smallest.
Size =size(y,2);
comp=0; % compressed file size
new=[];
for i=1:Size,
x = y(:,i)';
%display(size(x));
X = dct(x);
X2=X;
[XX,ind] = sort(abs(X),'descend');
%% Find how many DCT coefficients represent 99.9% of the energy in the signal. 
...Express the number as a percentage of the total.
need = 1;
new=[];
%%norm(X(ind(1:need)))/norm(X)<0.999
while norm(X(ind(1:need)))/norm(X)<0.999
   need = need+100;
end

xpc = need/length(X)*100;
%% Set to zero the coefficients that contain the remaining 0.1% of the energy. 
...Reconstruct the signal from the compressed representation.
...Plot the original signal, its reconstruction, and the difference between the two.
X(ind(need+1:end)) = 0;
filename=strcat('CH',num2str(i),'.mat');
[C,IC,Size]=code(X,filename,0.0001);
comp=comp+Size;
X=decode(C,IC);
xx=idct(X);
new=[new xx'];
% xx = idct(X);
figure
plot([x;xx;x-xx]')
legend('Original',[int2str(xpc) '% of coeffs.'],'Difference', ...
       'Location','best')
figure
subplot(2,1,1);
plot(x);
legend('Original')
subplot(2,1,2);
plot(xx);
legend('compressed')
end;
%% compression ratio
s=whos('y');
s=s.bytes;
fprintf('compression ratio = %d \n',s/comp);
sound(new,fs);