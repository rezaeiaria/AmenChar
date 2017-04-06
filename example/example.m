% -------------------------------------------------------------------------
% 0. Load dataset and classes
% -------------------------------------------------------------------------

% 0.0. Add all directories to your MATLABA path
addpath(genpath('.'));

% Load a dataset
load example\amazon-video.mat

% Choose classes from features
classes = {'animation', 'classics'};

% Find class membership matrix (C) and 
% remove the features selected as a class
[C, F, F_label] = util_class(F, F_label, classes);

% -------------------------------------------------------------------------
% 1. Find communities
% -------------------------------------------------------------------------

% Load communities
% You can use ANY algorithms to find any sorts of target subgraphs here.
load example\coms.mat

% (Optional) Filter attributes to only those that appear 
% in selected communities to achieve higher speed.
[F,F_label] = util_filterComFeatures(coms, F, F_label);

% -------------------------------------------------------------------------
% 2. Find AMEN attribute weights
% -------------------------------------------------------------------------

% We find the attribute weights (Xs) and update attributes to those 
% with non-zero weight for at least ONE subgraph in either of classes
[Xs, F_label] = main_getAmenWeights(A, F, F_label, classes, coms);


% -------------------------------------------------------------------------
% 3. Partition attributes
% -------------------------------------------------------------------------

% Partition the attributes
[part] = main_partition(Xs);

% Sort attributes by their "utility" along with their labels
[util, util_labels] = main_filterUtility(Xs, part, F_label);


% 3.3. See output for yourself
for class=1:numel(Xs)
    fprintf('Class: %s\n', classes{class});
    disp(util_labels{class}(1:10));
end


