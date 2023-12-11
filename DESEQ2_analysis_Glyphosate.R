#Download necessary packages 

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("DESeq2")
BiocManager::install("EnhancedVolcano")
install.packages('textshaping')
library(DESeq2)
library(EnhancedVolcano)
library(textshaping)

# Read csv file (from feautreCounts analysis)
counts <- read.csv("counts_min.csv", header = TRUE, row.names = 1)
#remove rows with very low numbers. 500 is arbitrary but adjust depending on how many genes it cuts off. 
#For my analysis I was not interested in genes with a very low count, so I was aiming to get around 15000 genes. 
counts <- subset(counts, rowSums(counts) > 500)

#assign a condition variable. G= glyphosate and W=water
condition <- factor(c("G","G","W","W"))
#Name the coolumns after our conditions (not necessary for 4 columns but useful with many samples)
coldata <-data.frame (row.names = colnames(counts), condition)

# Create DESeqDataSet
dds <- DESeqDataSetFromMatrix(countData = counts, 
                              colData = coldata,
                              design = ~ condition)

# Run DESeq2 analysis
dds <- DESeq(dds)

#create a vs data variable
vsdata <- vst(dds, blind=FALSE)

#Run a PCA for a quick QC of the dataset
plotPCA(vsdata, intgroup = "condition")
#Plot dispersion estimates. IDeally their trendline should be below 1 
plotDispEsts(dds)

# Get differential expression results table
results <- results(dds, contrast = c("condition", "W", "G"))
summary(results)
results
library(ggplot2)
counts
EnhancedVolcano(results,
                x = "log2FoldChange",
                y = "padj",
                lab = rownames(results),  # Use 'lab' instead of 'label'
                pCutoff = 0.05,
                FCcutoff = 1)

#optional: save results into excel to get a closer look 
install.packages('xlsx')
library(xlsx)
excel_file <- "results_deseq.xlsx"

write.xlsx2(results, excel_file, sheetName = "Results", row.names = TRUE)
