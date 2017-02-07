<div id="fixed_width_content">
      

<center><h2>Gene Set Omic Analysis (GSOA) </h2></center>
<style> hr.hasClass{ width:100%; border:0px; height:1.5px; background-color:black;} </style> <hr class="hasClass">
<br>

<b><h4> Preparing Data </h4></b>

<b><p> GSOA requires the following files:<p></b>

1) A file containing genomic measurements (e.g., gene-expression, SNP, CNV, methylation)

<h5> Example: </h5>

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{font-family:Arial, sans-serif;font-size:12px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
.tg th{font-family:Arial, sans-serif;font-size:12px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
.tg .tg-yw4l{vertical-align:top}
</style>
<table class="tg">
  <tr>
    <th class="tg-yw4l"> </th>
    <th class="tg-yw4l">Sample 1</th>
    <th class="tg-yw4l">Sample 2</th>
    <th class="tg-yw4l">Sample 3</th>
    <th class="tg-yw4l">Sample 4</th>
  </tr>
  <tr>
    <td class="tg-yw4l">Gene 1</td>
    <td class="tg-yw4l">0.523 </td>
    <td class="tg-yw4l">0.991 </td>
    <td class="tg-yw4l">0.421 </td>
    <td class="tg-yw4l">0.829 </td>
  </tr>
  <tr>
    <td class="tg-yw4l">Gene 2</td>
    <td class="tg-yw4l">8.891 </td>
    <td class="tg-yw4l">7.673 </td>
    <td class="tg-yw4l">3.333 </td>
    <td class="tg-yw4l">9.103</td>
  </tr>
  <tr>
    <td class="tg-yw4l">Gene 3</td>
    <td class="tg-yw4l">4.444 </td>
    <td class="tg-yw4l">5.551 </td>
    <td class="tg-yw4l">6.102</td>
    <td class="tg-yw4l">0.013 </td>
  </tr> </table><br>

This file should be a simple matrix where samples represent columns and omic features represent rows. Values on each row should be separated by tabs, and the header row should contain sample names. Each row should start with a value that indicates a name for the omic feature that is represented. Multiple rows per omic feature may be listed---for example, when a omic-profiling technology produces multiple data values per gene. .
Alternatively, this can be a GCT file. It is possible to input multiple omic data files. These should be uploaded together from the omic files input tab. Samples that do not overlap across all the omic files will be excluded.

<br>
<br>

2) A file containing phenotype labels for each sample in genomic data file 

<b><h5> Example: </h5></b>

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{font-family:Arial, sans-serif;font-size:12px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
.tg th{font-family:Arial, sans-serif;font-size:12px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
.tg .tg-yw4l{vertical-align:top}
</style>
<table class="tg">
<table class="tg">
  <tr>
    <td class="tg-yw4l">Sample 1</td>
    <td class="tg-yw4l">Control </td>
  </tr>
  <tr>
    <td class="tg-yw4l">Sample 2</td>
    <td class="tg-yw4l">Control </td>
  </tr>
  <tr>
    <td class="tg-yw4l">Sample 3</td>
    <td class="tg-yw4l">Treated </td>
  </tr> 
    <tr>
    <td class="tg-yw4l">Sample 4</td>
    <td class="tg-yw4l">Treated</td>
</tr>  </table>
<br>

Data file #2 should contain two columns; the first value in each row should be a sample identifier (and should correspond exactly with the identifiers in data file #1), and the second value should indicate which class (e.g., condition or phenotype status) that the sample represents. This file should have no header row. Values on each row should be separated by tabs. Alternatively, this can be a CLS file. If a CLS file is used, Data file #1 must be a GCT file.
<br>
<br>



3)  A file containing gene sets which genes map to genomic measurments

<style type="text/css">
.tg  {border-collapse:collapse;border-spacing:0;}
.tg td{font-family:Arial, sans-serif;font-size:12px;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
.tg th{font-family:Arial, sans-serif;font-size:12px;font-weight:normal;padding:5px 5px;border-style:solid;border-width:1px;overflow:hidden;word-break:normal;}
.tg .tg-yw4l{vertical-align:top}
</style>
<table class="tg">
<table class="tg">
  <tr>
    <td class="tg-yw4l">GeneSet 1</td>
    <td class="tg-yw4l">Description... </td>
    <td class="tg-yw4l">Gene 1 </td>
    <td class="tg-yw4l">Gene 2 </td>
    <td class="tg-yw4l">  </td>
  </tr>
  <tr>
    <td class="tg-yw4l">GeneSet 2</td>
    <td class="tg-yw4l">Description... </td>
    <td class="tg-yw4l">Gene 2 </td>
    <td class="tg-yw4l">Gene 3 </td>
    <td class="tg-yw4l">Gene 4 </td>
  </tr>
  <tr>
    <td class="tg-yw4l">GeneSet 3</td>
    <td class="tg-yw4l">Description... </td>
    <td class="tg-yw4l"Gene 2 </td>
    <td class="tg-yw4l"Gene 5 </td>
    <td class="tg-yw4l"Gene 6 </td>
  </tr> 
 </table>
<br>
<br>

Data file #3 should be in Gene Matrix Transposed (GMT) format as used by the Molecular Signatures Database. The feature names (e.g., gene symbols or IDs) should be identical to those used in data file #1. For this format, the first value in each row is the gene-set name, the second value is a descriptor, and the remaining values are the genes associated with that gene set. This file should have no header row. Values on each row should be separated by tabs.
<br>
<br>

<b><h4> Loading Data </h4></b>

<b><h4> Specifying Parameters </h4></b>

Required:

Optional: 


When executing this tool, you must specify the above four parameters to scripts/run. Optionally, you may specify the additional parameters described below.
The number processing cores that should be used when executing the analysis. Default: the code will automatically determine how many cores are on the computer and will use approximately 3/4 of those cores.
For each gene set, the classification algorithm calculates a probability that each sample belongs to a given class/condition/phenotype. If a file path is specified for this parameter, that file will contain those probabilities. Default: no output file.
GSOA performs a p-value calculation procedure using randomly selected gene sets. Use this parameter to specify how many random iterations should be used. Default: 100.
This parameter enables the user to exclude genes from the analysis without having to remove them from the input data files. Specify a comma separated list of gene names that coincide with the row identifiers in data file #1. Default: none.
The user can specify the number of cross-validation folds. Default: 5. The value "n" can be specified to perform leave-one-out cross validation. In addition, if the number of samples for any class is fewer than the number of folds, leave-one-out cross validation will be used.
By default the Support Vector Machines algorithm (RBF kernel) is used for classification. With this parameter, the user can specify an alternative classification algorithm. The following options are currently available: svmlinear, svmpoly, svmsigmoid, naivebayes, knn, decisiontree, randomforest. Default: svmrbf. By default, the svm algorithms use a value of 1.0 for the C parameter and 0.0 for gamma. Alternate values can be specified by suffixing the algorithm name with these parameter values. So, for example, if you wanted to use the rbf kernel with a value of 10.0 for C and 1.0 for gamma, you would specify the algorithm as "svmrbf_10.0_1.0". Perhaps better (though more computationally intensive), you can specify "auto" (for example, svmrbf_auto), which will use a grid search to auto-tune the parameters.
<br>
<br>    
</p>


<p>
Download the following demo data files from <a href="https://drive.google.com/file/d/0B-HGhGW-uF4ATHhqX1Noa2RTN2s/view?usp=sharing" target="_blank">here</a>.
<p>

<b><h5> Demo Data </h5></b>

1) <a href="https://drive.google.com/file/d/0B-HGhGW-uF4ATHhqX1Noa2RTN2s/view?usp=sharing" target="_blank"> P53_collapsed_symbols.gct </a> : a file containing gene expression data for each sample <br />
<br />
2) <a href="https://drive.google.com/file/d/0B-HGhGW-uF4ATHhqX1Noa2RTN2s/view?usp=sharing" target="_blank"> P53_classFile.txt </a> : a file containing phenotype labels for each sample in gene expression dataset <br /> <br />
3) <a href="https://drive.google.com/file/d/0B-HGhGW-uF4ATHhqX1Noa2RTN2s/view?usp=sharing" target="_blank"> c1.all.v4.0.symbols.gmt </a> : a file containing gene sets which genes map to genomic measurments <br /> 
<br />




</div>
