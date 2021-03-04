## Date 02-19-2021
## Author Ruqian Lyu
## Iterate reads in a BAM file and append XX to CB tag

## Use docopt

import hts
import times
import os
import strutils
import docopt

#var argv:seq[string]

when(isMainModule):
  let doc = """
  Usage: 
    appendCB [options] <BAM-or-CRAM> <output.bam>

  Options:
    -a --append <append>    code to append to
    -t --threads <threads>    number of BAM decompression threads [default: 4]
    -g --generate    whether new CB tag will be generated if read does not have CB tag

  Example:
      appendCB --append X possorted.bam output.bam  
  """
  let args = docopt(doc,quit = false) 
  var  threads = parse_int($args["--threads"])

  var 
    b:Bam
    out_bam:Bam
    ap:string
    generate:bool = args["--generate"]

  if($args["--append"]) == "nil":
    quit "append is required"
  else:
    ap = $args["--append"]
    

  if not open(b, $args["<BAM-or-CRAM>"], threads=threads, index = true):
    quit "couldn't open input bam"
  if not open(out_bam, $args["<output.bam>"], index = true,threads=threads, mode="w"):
    quit "couldn't open output bam"
  out_bam.write_header(b.hdr)
  for record in b:
    var cbt = tag[string](record, "CB")
    if cbt.isNone:
      if generate:
        record.set_tag("CB",ap)
      else: continue
    var cb = cbt.get
    cb = cb & ap
    record.set_tag("CB",cb)
    out_bam.write(record)
  out_bam.close()
  b.close()
