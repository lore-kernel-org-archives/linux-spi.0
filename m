From: Vladimir Oltean <olteanv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 00/12] TCFQ to XSPI migration for NXP DSPI driver
Date: Thu,  5 Mar 2020 00:00:32 +0200
Message-ID: <20200304220044.11193-1-olteanv@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        eha-/iRVSOupHO4@public.gmane.org, angelo-BIYBQhTR83Y@public.gmane.org, andrew.smirnov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        gustavo-L1vi/lXTdts+Va1GwOuvDg@public.gmane.org, weic-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, mhosny-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Vladimir Oltean <vladimir.oltean-3arQi8VN3Tc@public.gmane.org>

This series aims to remove the most inefficient transfer method from the
NXP DSPI driver.

TCFQ (Transfer Complete Flag) mode works by transferring one word,
waiting for its TX confirmation interrupt (or polling on the equivalent
status bit), sending the next word, etc, until the buffer is complete.

The issue with this mode is that it's fundamentally incompatible with
any sort of batching such as writing to a FIFO. But actually, due to
previous patchset ("Compatible string consolidation for NXP DSPI driver"):

https://patchwork.kernel.org/cover/11414593/

all existing users of TCFQ mode today already support a more advanced
feature set, in the form of XSPI (extended SPI). XSPI brings 2 extra
features:

- Word sizes up to 32 bits. This is sub-utilized today, and acceleration
  of smaller-than-32 bpw values is provided.
- "Command cycling", basically the ability to write multiple words in a
  row and receiving an interrupt only after the completion of the last
  one. This is what enables us to make use of the full FIFO depth of
  this controller.

Series was tested on the NXP LS1021A-TSN and LS1043A-RDB boards, both
functionally as well as from a performance standpoint.

The command used to benchmark the increased throughput was:

spidev_test --device /dev/spidev1.0 --bpw 8 --size 256 --cpha --iter 10000000 --speed 20000000

where spidev1.0 is a dummy spidev node, using a chip select that no
peripheral responds to.

On LS1021A, which has a 4-entry-deep FIFO and a less powerful CPU, the
performance increase brought by this patchset is from 2700 kbps to 5800
kbps.

On LS1043A, which has a 16-entry-deep FIFO and a more powerful CPU, the
performance increases from 4100 kbps to 13700 kbps.

On average, SPI software timestamping is not adversely affected by the
extra batching, due to the extra patches.

There is one extra patch which clarifies why the TCFQ users were not
converted to the "other" mode in this driver that makes use of the FIFO,
which would be EOQ mode.

My request to the many people on CC (known users and/or contributors) is
to give this series a test to ensure there are no regressions, and for
the Coldfire maintainers to clarify whether the EOQ limitation is
acceptable for them in the long run.

Vladimir Oltean (12):
  spi: spi-fsl-dspi: Simplify bytes_per_word gymnastics
  spi: spi-fsl-dspi: Remove unused chip->void_write_data
  spi: spi-fsl-dspi: Don't mask off undefined bits
  spi: spi-fsl-dspi: Add comments around dspi_pop_tx and dspi_push_rx
    functions
  spi: spi-fsl-dspi: Rename fifo_{read,write} and {tx,cmd}_fifo_write
  spi: spi-fsl-dspi: Implement .max_message_size method for EOQ mode
  spi: Do spi_take_timestamp_pre for as many times as necessary
  spi: spi-fsl-dspi: Convert TCFQ users to XSPI FIFO mode
  spi: spi-fsl-dspi: Accelerate transfers using larger word size if
    possible
  spi: spi-fsl-dspi: Optimize dspi_setup_accel for lowest interrupt
    count
  spi: spi-fsl-dspi: Use EOQ for last word in buffer even for XSPI mode
  spi: spi-fsl-dspi: Take software timestamp in dspi_fifo_write

 drivers/spi/spi-fsl-dspi.c | 421 ++++++++++++++++++++++++-------------
 drivers/spi/spi.c          |  19 +-
 include/linux/spi/spi.h    |   3 +-
 3 files changed, 288 insertions(+), 155 deletions(-)

-- 
2.17.1
