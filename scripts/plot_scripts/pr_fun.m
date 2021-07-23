function [precision, recall, AP, AEP] = pr_fun(metric_matrix, truth_matrix, early_threshold)
%build_true_truth
if nargin<3
    if nargin<2
        display('Error: Need Metric and Truth Matrix');
    end
    early_threshold = 0.1;
end
metric_matrix = abs(metric_matrix);
reshaped_metric = reshape(metric_matrix,size(truth_matrix,1)*size(truth_matrix,2),1);

[sorted sortind]= sort(reshaped_metric,'descend');
rows = repmat([1:size(truth_matrix,1)]',1,size(truth_matrix,2));
cols = repmat([1:size(truth_matrix,2)],size(truth_matrix,1),1);
indices = rows+sqrt(-1)*cols;
newind = reshape(indices,numel(truth_matrix),1);
rownum = real(newind(sortind));
colnum = imag(newind(sortind));
trutharr = [];
for i = 1:size(truth_matrix,1)*size(truth_matrix,2)
    trutharr = [trutharr truth_matrix(rownum(i),colnum(i))];
end
precision = cumsum(trutharr)./cumsum(ones(size(trutharr)));
recall = cumsum(trutharr)./sum((trutharr));
dx = diff(recall);
ay = (precision(1:end-1)+precision(2:end))/2;
AP = sum(dx.*ay);

edx = diff(recall(recall<early_threshold));
eay = (precision(1:length(edx))+precision(2:length(edx)+1))/2;
AEP = sum(edx.*eay);