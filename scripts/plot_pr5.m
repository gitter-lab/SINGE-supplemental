function [AUPRs early_AUPRs] =  plot_pr(truth, ind, metric, SINCERITIES_MAT, ALTJump3, SCODE, Genie3)
%figure; 
hold on; box on; %axis square;
truth = truth - diag(diag(truth));
[pre1,recall1,AUPRs(1),early_AUPRs(1)] = pr_fun(metric(ind,:),truth(ind,:),0.1);
[pre2,recall2,AUPRs(2),early_AUPRs(2)] = pr_fun(SINCERITIES_MAT(ind,:),truth(ind,:),0.1);
[pre3,recall3,AUPRs(3),early_AUPRs(3)] = pr_fun(ALTJump3(ind,:),truth(ind,:),0.1);
[pre4,recall4,AUPRs(4),early_AUPRs(4)] = pr_fun(SCODE(ind,:),truth(ind,:),0.1);
[pre5,recall5,AUPRs(5),early_AUPRs(5)] = pr_fun(Genie3(ind,:),truth(ind,:),0.1);

plot(recall1,pre1,'b','LineWidth',1.5)
plot(recall2,pre2,'r','LineWidth',1.5)
plot(recall3,pre3,'g','LineWidth',1.5)
plot(recall4,pre4,'c','LineWidth',1.5)
plot(recall5,pre5,'m','LineWidth',1.5)
plot(recall4,pre4(end)*ones(size(pre4)),'k--','LineWidth',1.5)
%plot(.1*ones(11,1),[0:10]'/10,'k-.')
l{1} = sprintf('SINGE (A = %0.2g, E = %0.2g)',AUPRs(1),early_AUPRs(1)*10);
l{2} = [sprintf('SINCERITIES (A = %0.2g, E = %0.2g)',AUPRs(2),early_AUPRs(2)*10)];
l{3} = [sprintf('JUMP3 (A = %0.2g, E = %0.2g)',AUPRs(3),early_AUPRs(3)*10)];
l{4} = [sprintf('SCODE (A = %0.2g, E = %0.2g)',AUPRs(4),early_AUPRs(4)*10)];
l{5} = [sprintf('GENIE3 (A = %0.2g, E = %0.2g)',AUPRs(5),early_AUPRs(5)*10)];
l{6} = [sprintf('Baseline Precision = %0.2g',pre4(end))];
%l{6} = [sprintf('Partial Recall Threshold',pre4(end))];
legend(l);
xlabel('Recall');
ylabel('Precision');
early_AUPRs = early_AUPRs*10;