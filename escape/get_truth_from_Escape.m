function [truth,ind] = get_truth_from_Escape(gene_list_file)
load(gene_list_file);
eval('unzip escape_data/chip_x.txt.zip escape_data');
eval('unzip escape_data/logof.txt.zip escape_data');
edges = importdata('escape_data/chip_x.txt');
[truth_chip ,ind_chip]= build_truth_chip(edges,gene_list);
edges = importdata('escape_data/logof.txt');
[truth_logof,ind_logof] = build_truth_logof(edges,gene_list);
%truth(ind_chip,:) = truth_chip(ind_chip,:);
%truth(ind_logof,:) = (truth(ind_logof,:)|truth_logof(ind_logof,:))*1;
ind = union(ind_chip,ind_logof);
truth = (truth_chip|truth_logof)*1;
truth = truth - diag(diag(truth));
end