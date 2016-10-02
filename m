From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 00/11] spi: fsl-espi: improvements and additional
 functionality
Date: Sun, 2 Oct 2016 14:22:26 +0200
Message-ID: <bb965b00-4e18-10f4-4fda-c207f1b4af46@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch series includes a number of improvements and support for
additional features like
- RXSKIP mode
- dual output read mode

Heiner Kallweit (11):
  spi: fsl-espi: reject MSB-first transfers with word sizes other than 8 or 16
  spi: fsl-espi: remove unneeded check for SPI_QE_CPU_MODE
  spi: fsl-espi: fix handling of word sizes other than 8 bit
  spi: fsl-espi: fix writing to TX FIFO
  spi: fsl-espi: rename len in struct mpc8xxx_spi to rx_len and make it unsigned
  spi: fsl-espi: simplify and inline function fsl_espi_change_mode
  spi: fsl-espi: fix and improve reading from RX FIFO
  spi: fsl-espi: make better use of the RX FIFO
  spi: fsl-espi: extend and improve transfer error handling
  spi: fsl-espi: add support for RXSKIP mode
  spi: fsl-espi: add support for dual read mode

 drivers/spi/spi-fsl-espi.c | 306 +++++++++++++++++++++++++--------------------
 drivers/spi/spi-fsl-lib.h  |   5 +-
 2 files changed, 176 insertions(+), 135 deletions(-)

-- 
2.10.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
