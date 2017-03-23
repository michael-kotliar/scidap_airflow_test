cwlVersion: v1.0
class: Workflow

inputs:
  input_file:
    type: File

outputs:
  output_file:
    type: File
    outputSource: Dockstore/output_file

steps:
  Dockstore:
    run: ../tools/ga4gh.cwl
    in:
      input_file: input_file
    out: [output_file]