function [F, F_label, feats] = util_addPartyToFeatures(F, F_label, P)

% 1 is democrat
% 0 is republican

F = [F P ~P];
feats = {'Democrat'; 'Republican'};
F_label = [F_label; feats];

end