cwlVersion: v1.0
class: Workflow

requirements:
  - class: SubworkflowFeatureRequirement
  - class: ScatterFeatureRequirement
  - class: StepInputExpressionRequirement
  - class: InlineJavascriptRequirement

inputs:

  fasta_input_file:
    type: File
  fastq_input_file:
    type: File

outputs:
  indices_folder:
    type: Directory
    outputSource: bowtie2/indices_folder

  bam_bai_files:
    type: File
    outputSource: bowtie2/bam_bai_files

steps:
  bowtie2:
    run: bowtie2.cwl
    in:
      fasta_input_file: fasta_input_file
      fastq_input_file: fastq_input_file
    out: [indices_folder, bam_bai_files]
