From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 00/23] spi: fsl-espi: several cleanups, improvements, and few
 fixes
Date: Thu, 25 Aug 2016 06:42:53 +0200
Message-ID: <c6d032d3-3ac3-5826-1087-26ffa4cb8feb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch series includes several cleanups, improvements, and few
smaller fixes. It was successfully tested on a P1014-based
WiFi router with SPI NOR flash.

There are also some functional extensions in the pipe, I'll send
them part of a separate patch set.

Heiner Kallweit (23):
  spi: fsl-espi: don't include irq.h
  spi: fsl-espi: pre-allocate message buffer
  spi: fsl-espi: remove unused elements n_rx and n_tx in struct fsl_espi_transfer
  spi: fsl-espi: change return type of fsl_espi_setup_transfer to void
  spi: fsl-espi: change return type of fsl_espi_cpu_bufs to void
  spi: fsl-espi: add missing static declaration to fsl_espi_cpu_irq
  spi: fsl-espi: remove unneeded variable in fsl_espi_do_trans
  spi: fsl-espi: factor out filling the local buffer
  spi: fsl-espi: remove element status from struct fsl_espi_transfer
  spi: fsl-espi: fix status handling in fsl_espi_do_one_msg
  spi: fsl-espi: remove element actual_length from struct fsl_espi_trans
  spi: fsl-espi: eliminate struct fsl_espi_transfer
  spi: fsl-espi: merge fsl_espi_cmd_trans and fsl_espi_rw_trans
  spi: fsl-espi: remove unneeded check in fsl_espi_do_trans
  spi: fsl-espi: improve return value handling in fsl_espi_bufs
  spi: fsl-espi: merge fsl_espi_bufs and fsl_espi_cpu_bufs
  spi: fsl-espi: improve ISR frame
  spi: fsl-espi: factor out initial message checking
  spi: fsl-espi: centralize populating struct spi_transfer
  spi: fsl-espi: factor out handling of read data
  spi: fsl-espi: simplify fsl_espi_setup_transfer
  spi: fsl-espi: improve message length handling
  spi: fsl-espi: merge fsl_espi_trans and fsl_espi_do_trans

 drivers/spi/spi-fsl-espi.c | 326 +++++++++++++++++----------------------------
 drivers/spi/spi-fsl-lib.h  |   1 +
 2 files changed, 121 insertions(+), 206 deletions(-)

-- 
2.9.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
