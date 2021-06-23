//process_output_multiple.nf
nextflow.enable.dsl=2

process FASTQC {
    input:
    path read

    output:
    path "fqc_res/*"

    script:
    """
    mkdir fqc_res
    fastqc $read -o fqc_res
    """
}

read_ch = channel.fromPath("data/yeast/reads/ref1*.fq.gz")

workflow {
  FASTQC(read_ch)
  FASTQC.out.view()
}
