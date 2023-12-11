# RNAseq_glyphosate

Description of the process: 

RNAseq files were downloaded from the SRA entry with this accession number: PRJNA764068 (https://www.ncbi.nlm.nih.gov/pmc/articles/PMC8535903/)
The option filtered and trimmed was chosen. 

The genomic sequence (.fna) of the canadian horseweed was downloaded (as well as the annotation gtf file for later). These files were found here: 
The following workflow can be executed using the RNAseq.ipynb file following adjustment of directory and file names. 
1) A fastQC analysis was executed and the quality of the reads was deemed satisfactory. https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/010/389/155/GCF_010389155.1_C_canadensis_v1/
2) Since the files were too large for my personal computer, as well as our lab computer, they were uploaded to the google drive and the following commands were executed in python in a google colaboratory environment. (.ipynb file) (A python version of the same code has been downloaded, but it was written to work in a google colaboratory environment which includes 14 gigabytes of RAM, 3 times more than my laptop.) I 
3) An set of indices was created using hisat2. 
4) The RNAseq fastq files were aligned to the index files using hisat2 and the sam files of the output were stored in the working directory.
5) Samtools was used to convert the sam files to bam
6) featurecounts was used to generate a count table (parameterized for unpaired reads using the -U option). For paired-end reads a different syntax should be used.

At this point the analysis was moved to R (Rstudio), which is the best interface to use DESEQ2 (DESEQ2.R)
1) The counts.txt was converted into a csv file and loaded into DESEQ2
2) The conditions were specified
3) A quick PCA was run to check the data
4) A dispersion estimate was plotted
5) A volcano plot was generated
6) (Optional: A .xlsx file was saved in the working directory with the results file.)

I have also included a pdf file with the plots I generated, as well as the 5 most differentially expressed genes. 

Due to the low annotation of the canadian horseweed genome, a gene symbol could not be assigned to each locus tag, so the results file has the locus tags. 
