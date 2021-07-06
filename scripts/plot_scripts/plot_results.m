% Plot results from the SINGE manuscript.
%% Figure 3
% Plots the precision-recall performance of SINGE, SINCERITIES, Jump3,
% SCODE, and GENIE3 for the Mouse Embryonic Stem Cell to Endoderm Di?
% erentiation dataset.
load data/Figure3_data
figure(3); plot_pr5(truth,isc,SINGE,SINCERITIES,Jump3,SCODE,GENIE3);
%% Figure 4
% Plots the precision-recall performance of SINGE, SINCERITIES, Jump3,
% SCODE, and GENIE3 for the Mouse Retinoic Acid-driven Di?erentiation dataset.
load data/Figure4_data_single
figure(4); plot_pr5(truth,igo,SINGE,SINCERITIES,Jump3,SCODE,GENIE3);
%% Figure 5
% Plots the precision-recall performance of SINGE, SINCERITIES, Jump3,
% SCODE, and GENIE3 for each regulator in the ESCAPE dataset.
load data/Figure4_data
figure(5); scatter_pr5(gene_list,truth,igo,0.1,SINGE,SINCERITIES,Jump3,SCODE,GENIE3);