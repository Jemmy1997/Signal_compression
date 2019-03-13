function output = decode()
load('output.mat');
load('unique.mat');
out = double(out);
for i=1:length(uni);
    out(out==i) = uni(i);
end
output = out;
end