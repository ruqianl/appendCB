# Bam operating tools using `hts-nim` module which is a nim-versioned `htslib` that provide utilities for working with high throughput sequencing data object

Nim is a programming language that is believed to be more efficient than Python while having a descriptive syntax.
More about Nim programming language: https://nim-lang.org/
More about hts-nim lib: https://github.com/brentp/hts-nim
## In this repository, I will share some example code snippets that perform specific tasks on bam/sam files

### How to execute these tools

A static binary build of `appendCB` is available fore downloading and executable across multiple GNU Linux OS

### appendCB

appendCB iterates read records in the provided BAM file and append the code provided in the option. If there is 
no CB tag available, by default, it skips the current record. If -g is supplied, it then generates new CB tag with 
values as the contents supplied in -a.

```
Usage:
    appendCB [options] <BAM-or-CRAM> <output.bam>

  Options:
    -a --append <append>    code to append to
    -t --threads <threads>    number of BAM decompression threads [default: 4]
    -g --generate

  Example:
      appendCB --append X possorted.bam output.bam

```
