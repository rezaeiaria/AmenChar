# AMENChar

AMENChar is a MATLAB library that characterizing (and possibly *differentiating*) attributes among different classes 
of subgraphs in an **_attributed graph_**. These attributes can be used to further study the differences in the 
two classes, such as differences in structure of communities or behavior of individuals.

## Installation
For installation, you should add all files in the main directory to MATLAB's path. You can do that with opening MATLAB in the main directory and using:

``addpath(genpath('.'));``

## Usage
You can see an example of the usage in ``~/example/example.m``. Below, we go through the example step by step.

1.  Load an attributed graph. You can see our datasets [here](http://www3.cs.stonybrook.edu/~arezaei/project/amen_char.html#data).

    ```matlab
    % Load a dataset
    load example\amazon-video.mat
    ```
2. Find subgraphs of interest for your classes. Here, we use graph attributes to create classes. We first identify nodes with a specific attribute and then find **_local communities_** around those nodes. The resulting subgraphs are our *subgraphs of interest*. We finally remove attributes selected as classes from the pool of attributes to avoid trivial results.
	
	```matlab
	% Choose classes from features
	classes = {'animation', 'classics'};
	
	% Find class membership matrix (C) and 
	% remove the features selected as a class
	% You can use ANY other method to choose classes
	[C, F, F_label] = util_class(F, F_label, classes);
	
	% Load communities
	% You can use ANY algorithms to find any sorts of target subgraphs here.
	load example\coms.mat
	
	% (Optional) Filter attributes to only those that appear 
	% in selected communities to achieve higher speed.
	[F,F_label] = util_filterComFeatures(coms, F, F_label);
	```
	**_NOTE_**: `coms` should be a MATLAB cell array of size `<# of classes> x 1`. Each cell is also a cell array with every row a vector of the IDs of nodes inside a target subgraph. Examine `~/example/coms.mat` in MATLAB for more details.
3. Find the attribute weights of the subgraphs.

	```matlab
	% Find attribute weights (Xs) and update attributes to those with
	% non-zero weight for at least ONE subgraph in either of classes
	[Xs, F_label] = main_getAmenWeights(A, F, F_label, classes, coms);
	``` 
4. Finally, partition and rank attributes for both classes.
	
	```matlab
	% Partition the attributes
	[part] = main_partition(Xs);
	
	% Sort attributes by their "utility" along with their labels
	[util, util_labels] = main_filterUtility(Xs, part, F_label);
	```
5. By printing the top 5 attributes for both classes, you will have the following results.
	
	```matlab
	'Animation Class'      'Classics Class'              
	'Kids & Family'        'Musicals & Performing Arts'
	'3-6 Years'            'Comedy'                    
	'7-9 Years'            'Musicals'                  
	'10-12 Years'          'Drama'                     
	'Warner Home Video'    'Mystery & Suspense'        
	```

#### **Alternate SWP Optimization**



If you want to use our (faster) heuristics instead of the (1-1/e) approx. solution, open the file ``main_partition.m`` and change line ``[part, ~] = SWP_Amen(Xs);`` to either of the following:

- ``[part, ~] = SWP_linear(Xs);`` for the *Simplified* heuristic with pre-normalized weights.
- ``[part, ~] = SWP_topK(Xs, K)`` for only finding **_top-K_** attributes for each class.


## Citing
If our datasets or our codes are useful in your research, we kindly ask you to cite the paper below:

	@inproceedings{rezaei2017ties,
		author = {Rezaei, Aria and Perozzi, Bryan and Akoglu, Leman},
		title = {Ties That Bind: Characterizing Classes by Attributes and Social Ties},
		booktitle = {Proceedings of the 26th International Conference on World Wide Web Companion},
		series = {WWW '17 Companion},
		year = {2017},
		isbn = {978-1-4503-4914-7},
		location = {Perth, Australia},
		pages = {973--981},
		numpages = {9},
		url = {https://doi.org/10.1145/3041021.3055138},
		doi = {10.1145/3041021.3055138},
		acmid = {3055138},
		publisher = {International World Wide Web Conferences Steering Committee},
		address = {Republic and Canton of Geneva, Switzerland},
		keywords = {attributed graphs, community understanding, homophily, social networks, subspace discovery},
	} 

## Acknowledgement
The optimization code for the *Submodular Welfare Problem* is provided by *Andreas Krause* [here](https://www.mathworks.com/matlabcentral/fileexchange/20504-submodular-function-optimization). If their code has been useful in your work, please cite them properly.
