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
    outputSource: files_to_folder/folder

  bam_bai_files:
    type: File
    outputSource: samtools_sort_index/bamBaiPair

steps:
  bowtie2_generate_indices:
    run: ../tools/bowtie2-build.cwl
    in:
      reference_in: fasta_input_file
    out: [indices]

  files_to_folder:
    run: ../tools/files-to-folder.cwl
    in:
      input_files: bowtie2_generate_indices/indices
    out: [folder]

  bowtie2_map:
    run: ../tools/bowtie2-map.cwl
    in:
      filelist: fastq_input_file
      output_filename:
        default: output.sam
      indices_folder: files_to_folder/folder
    out: [output]

  samtools_sort_index:
    run: ../tools/samtools-sort-index.cwl
    in:
      sortInput: bowtie2_map/output
    out: [bamBaiPair]