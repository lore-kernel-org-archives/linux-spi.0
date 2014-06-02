From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 00/18] spi: rspi: Add DMA support for QSPI on R-Car Gen2
Date: Mon,  2 Jun 2014 15:38:02 +0200
Message-ID: <1401716301-29612-1-git-send-email-geert+renesas@glider.be>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch series refactors the Renesas SPI driver and adds DMA support
using the SPI DMA framework for QSPI on R-Car Gen2, for Single, Dual, and
Quad SPI Transfers.
It also adds DMA support for RZ/A1H, but this was untested.

Apart from refactorings that don't change behavior:
  - [02/18] reverts a (harmless?) behavioral change for RSPI on SH,
  - [03/18] removes 16-bit DMA support, which has no in-tree users.
	    16-bit DMA support requires using a double-sized buffer to
	    accomodate the interleaved data format.
	    If there's a strong requirement to keep this, I think it's best
	    to re-add support after this series.
  - [09/18] drops the ability of RSPI on SH to work with a single DMA
	    channel, as the SPI DMA framework needs both RX and TX DMA
	    to function,
  - [15/18] Adds DMA support for QSPI on R-Car Gen2,
  - [16/18] Adds DMA support for RSPI on RZ/A1H,
  - [18/18] adds DT preliminary DT support, as the format of the DMA
	    specifiers depends on the DT bindings for SHDMA, which are still
	    under development.

This was tested on r8a7791/koelsch (PIO and DMA), and r7s72100/genmai (PIO
only).

Performance figures for reading from a QSPI FLASH driven at 24.375 MHz
on r8a7791/koelsch are:
  - Single:  1.1 Mbps PIO, 23 Mbps DMA
  - Dual  : 12.7 Mbps PIO, 48 Mbps DMA
  - Quad  : 13   Mbps PIO, 70 Mbps DMA

Thanks for your comments!

  [01/18] spi: rspi: Extract rspi_wait_for_{tx_empty,rx_full}()
  [02/18] spi: rspi: Do not call rspi_receive_init() for TX-only
  [03/18] [RFC] spi: rspi: Remove unused 16-bit DMA support
  [04/18] spi: rspi: Use core SPI_MASTER_MUST_[RT]X handling
  [05/18] spi: rspi: Extract rspi_pio_transfer()
  [06/18] spi: rspi: Don't consider DMA configuration failures fatal
  [07/18] spi: rspi: Extract rspi_request_dma_chan()
  [08/18] spi: rspi: Remove unneeded resource test in DMA setup
  [09/18] spi: rspi: SPI DMA core needs both RX and TX DMA to function
  [10/18] spi: rspi: Use SPI core DMA mapping framework
  [11/18] spi: rspi: Move RSPI-specific setup out of DMA routines
  [12/18] spi: rspi: Pass sg_tables instead of spi_tranfer to rspi_*_dma()
  [13/18] spi: rspi: Merge rspi_*_dma() into rspi_dma_transfer()
  [14/18] spi: rspi: Absorb rspi_rz_transfer_out_in() into 
          spi_rz_transfer_one()
  [15/18] spi: rspi: Add DMA support for QSPI on R-Car Gen2
  [16/18] spi: rspi: Add DMA support for RSPI on RZ/A1H
  [17/18] spi: rspi: Extract rspi_common_transfer()
  [18/18] [RFC] spi: rspi: Add DT support to DMA setup

 Documentation/devicetree/bindings/spi/spi-rspi.txt |   6 +
 drivers/spi/spi-rspi.c                             | 604 ++++++++-------------
 include/linux/spi/rspi.h                           |   2 -
 3 files changed, 228 insertions(+), 384 deletions(-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
