function [AUPRs early_AUPRs] =  scatter_pr5(tf, truth, ind, eTh, metric, SINCERITIES_MAT, ALTJump3, SCODE, GENIE3)
truth = truth - diag(diag(truth));
for i = 1:length(ind)
    [pre1,recall1,AUPR1(i),early_AUPR1(i)] = pr_fun(metric(ind(i),:),truth(ind(i),:),eTh);
    [pre2,recall2,AUPR2(i),early_AUPR2(i)] = pr_fun(SINCERITIES_MAT(ind(i),:),truth(ind(i),:),eTh);
    [pre3,recall3,AUPR3(i),early_AUPR3(i)] = pr_fun(ALTJump3(ind(i),:),truth(ind(i),:),eTh);
    [pre4,recall4,AUPR4(i),early_AUPR4(i)] = pr_fun(SCODE(ind(i),:),truth(ind(i),:),eTh);
    [pre5,recall5,AUPR5(i),early_AUPR5(i)] = pr_fun(SCODE(ind(i),:),truth(ind(i),:),eTh);
    randpre(i) = pre4(end);
end
msize = 30;

subplot(2,1,1);hold on; box on;
scatter(1:length(ind),AUPR1,msize,'o','filled');
scatter(1:length(ind),AUPR2,msize,'s','filled');
scatter(1:length(ind),AUPR3,msize,'*');
scatter(1:length(ind),AUPR4,msize,'d','filled');
scatter(1:length(ind),AUPR5,msize,'m<','filled');
text(1:length(ind),randpre,'--');
xticks(1:length(ind))
xticklabels(tf(ind))
xtickangle(30)
l = {'SCINGE','SINCERITIES','Jump3','SCODE','GENIE3'};
legend(l,'Location','best');
ylabel('Average precision');
subplot(2,1,2);hold on; box on;
scatter(1:length(ind),early_AUPR1/eTh,msize,'o','filled');
scatter(1:length(ind),early_AUPR2/eTh,msize,'s','filled');
scatter(1:length(ind),early_AUPR3/eTh,msize,'*');
scatter(1:length(ind),early_AUPR4/eTh,msize,'d','filled');
scatter(1:length(ind),early_AUPR5/eTh,msize,'m<','filled');
text(1:length(ind),randpre,'--');
xticks(1:length(ind))
xticklabels(tf(ind))
xtickangle(30)
l = {'SCINGE','SINCERITIES','JUMP3','SCODE','GENIE3'};
legend(l,'Location','best');
ylabel('Average early precision');

AUPRs = [AUPR1;AUPR2;AUPR3;AUPR4;randpre];
early_AUPRs = [early_AUPR1/eTh;early_AUPR2/eTh;early_AUPR3/eTh;early_AUPR4/eTh;randpre];