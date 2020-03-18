From: patchwork-bot+linux-spi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Subject: Patchwork housekeeping for: spi-devel-general
Date: Wed, 18 Mar 2020 00:20:14 +0000
Message-ID: <158449081446.11775.5459057414285589247.git-patchwork-housekeeping@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Latest series: [v5] NXP DSPI bugfixes and support for LS1028A (2020-03-18T00:15:55)
  Superseding: [v3] NXP DSPI bugfixes and support for LS1028A (2020-03-14T22:43:28):
    [v3,01/12] spi: spi-fsl-dspi: Don't access reserved fields in SPI_MCR
    [v3,02/12] spi: spi-fsl-dspi: Fix little endian access to PUSHR CMD and TXDATA
    [v3,03/12] spi: spi-fsl-dspi: Fix bits-per-word acceleration in DMA mode
    [v3,04/12] spi: spi-fsl-dspi: Avoid reading more data than written in EOQ mode
    [v3,05/12] spi: spi-fsl-dspi: Protect against races on dspi->words_in_flight
    [v3,06/12] spi: spi-fsl-dspi: Replace interruptible wait queue with a simple completion
    [v3,07/12] spi: spi-fsl-dspi: Avoid NULL pointer in dspi_slave_abort for non-DMA mode
    [v3,08/12] spi: spi-fsl-dspi: Fix interrupt-less DMA mode taking an XSPI code path
    [v3,09/12] spi: spi-fsl-dspi: Move invariant configs out of dspi_transfer_one_message
    [v3,10/12] spi: spi-fsl-dspi: Add support for LS1028A
    [v3,11/12] arm64: dts: ls1028a: Specify the DMA channels for the DSPI controllers
    [v3,12/12] arm64: dts: ls1028a-rdb: Add a spidev node for the mikroBUS


-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/pwbot
