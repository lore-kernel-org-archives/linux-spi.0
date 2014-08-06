From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 00/12] spi: rspi and sh-msiof driver updates
Date: Wed,  6 Aug 2014 14:58:57 +0200
Message-ID: <1407329949-5695-1-git-send-email-geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	dmaengine@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>, Simon Horman <horms@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

	Hi Mark, Simon,

Here's a series of Renesas RSPI/QSPI and SH-MSIOF SPI driver updates.
I grouped them in three parts:
  - [1-5] are for the rspi driver (Mark),
  - [6-8] are for the sh-msiof driver (Mark),
  - [9-12] are for the R-Car Gen2 DTSes (Simon).

Summary of changes:
  - [1] and [6] are bug fixes I have sent before, but that weren't applied
    due to dependency confusion,
  - [2] is a new cosmetic fix,
  - [3] makes rspi use a new helper function that will be available as of
    v3.17-rc1,
  - [4-5] and [7-8] make DMA work with the new R-Car DMAC driver,
    developed by Laurent Pinchart in the series "[PATCH v2 0/8] R-Car Gen2
    DMA Controller driver"
    (http://www.spinics.net/lists/linux-sh/msg33890.html),
  - [9-12] enable DMA in DT for r8a7791 and r8a7790, and depend on
    "[PATCH v2 8/8] ARM: shmobile: r8a7791: Add DMAC devices to DT"
    (http://www.spinics.net/lists/linux-sh/msg33897.html) resp.
    "[PATCH v2 7/8] ARM: shmobile: r8a7790: Add DMAC devices to DT"
    (http://www.spinics.net/lists/linux-sh/msg33896.html) of the
    aforementioned series.

This has been tested on r8a7791/koelsch.

Geert Uytterhoeven (12):
   [1] spi: rspi: Fix leaking of unused DMA descriptors
   [2] spi: rspi: Remove unneeded semicolon
   [3] spi: rspi: Use devm_kasprintf()
   [4] spi: rspi: Configure DMA slave bus width to 8 bit
   [5] spi: rspi: Add DT support to DMA setup
   [6] spi: sh-msiof: Fix leaking of unused DMA descriptors
   [7] spi: sh-msiof: Configure DMA slave bus width
   [8] spi: sh-msiof: Add DT support to DMA setup
   [9] ARM: shmobile: r8a7791 dtsi: Enable DMA for QSPI
  [10] ARM: shmobile: r8a7791 dtsi: Enable DMA for MSIOF
  [11] ARM: shmobile: r8a7790 dtsi: Enable DMA for QSPI
  [12] ARM: shmobile: r8a7790 dtsi: Enable DMA for MSIOF

 Documentation/devicetree/bindings/spi/sh-msiof.txt |  17 ++-
 Documentation/devicetree/bindings/spi/spi-rspi.txt |   5 +
 arch/arm/boot/dts/r8a7790.dtsi                     |  18 ++-
 arch/arm/boot/dts/r8a7791.dtsi                     |  14 +-
 drivers/spi/spi-rspi.c                             | 147 +++++++++++++--------
 drivers/spi/spi-sh-msiof.c                         | 103 +++++++++------
 6 files changed, 195 insertions(+), 109 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
