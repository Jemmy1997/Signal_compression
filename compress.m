function [compressedFile, ratio] = compress(signal, type, domain, loss, size)
% signal=0;
% switch path
%     case '*.mat'
%         load(path);
%         if(type==1)
%             signal = val';
%         else(type==2)
%             signal = ult_sig;
%         end
%     case '*.wav'
%         [signal, fs] = audioread(path);
%     case '*.xlsx'
%         signal = xlsread(path);
% end

% subplot(1,2,1);
% plot(signal);

if(domain==1)
        [compressedFile, ratio] = CT(signal, size);
else
        [compressedFile, ratio] = wt(signal, type, domain, loss);
end

end