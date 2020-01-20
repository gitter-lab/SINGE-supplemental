function [true_mat, valid_source, pubmed] = build_truth(edges, tf)
true_mat = zeros(numel(tf));
valid_source = []; GLItargets = {};% UNtargets = []; UNEdge = {};
invalid_target = [];
pubmed = [];
for i = 1:length(edges)
    temp = split(edges{i,:});
    if strfind(temp{7},'MESC')
        source = find(strcmpi(tf,temp{1}));
        target = find(strcmpi(tf,temp{3}));
        if ~isempty(source)&&~isempty(target)
            true_mat(source,target) = 1;
        end
        if ~isempty(source)
            valid_source = [valid_source source];
            pubmed = [pubmed str2num(temp{5})];
        end
        if 0
        if any(strcmpi(UN,temp{3}))
            UNEdge = [UNEdge; {temp{1} temp{3}}];
            UNtargets = [UNtargets i];
        end
        end
    end
end
if 0
for i = 1:length(tf)
    temp = split(edges{i,:});
    source = find(strcmpi(temp,cell2mat(tf(i))));
    if isempty(source)
        invalid_source = [invalid_source i];
    end
end
end
