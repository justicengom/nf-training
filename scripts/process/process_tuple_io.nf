//process_tuple_io.nf
nextflow.enable.dsl=2

process QUANT {
  input:
    tuple val(sample_id), path(reads)
    //each is needed so the process can run multiple times
    each index
  output:
    tuple val(sample_id), path("${sample_id}_salmon_output")
  script:
  """
   salmon quant  -i $index \
   -l A \
   -1 ${reads[0]} \
   -2 ${reads[1]} \
   -o ${sample_id}_salmon_output
  """
}

reads_ch = Channel.fromFilePairs('data/yeast/reads/ref1_{1,2}.fq.gz')
index_ch = Channel.fromPath('data/yeast/salmon_index')

workflow {
  QUANT(reads_ch,index_ch)
  QUANT.out.view()
}
