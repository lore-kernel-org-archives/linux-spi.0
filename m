From: Ben Gardiner <ben.l.gardiner@gmail.com>
Subject: [PATCH] spi: spi-davinci: deassert CS on setup()
Date: Tue, 10 Sep 2013 13:10:22 -0400
Message-ID: <1378833022-31046-1-git-send-email-ben.l.gardiner@gmail.com>
Cc: linux-kernel@vger.kernel.org
To: grant.likely@secretlab.ca, spi-devel-general@lists.sourceforge.net,
	davinci-linux-open-source@linux.davincidsp.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The mmc_spi driver's mmc_cs_off() function states that "chipselect will always
be inactive after setup()"; however, the spi-davinci driver's setup() leaves CS
state unchanged.

Add a call to davinci_spi_chipselect(spi, BITBANG_CS_INACTIVE) to the spi-
davinci drivers' setup() function.

Signed-off-by: Ben Gardiner <ben.l.gardiner@gmail.com>
---
 drivers/spi/spi-davinci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-davinci.c b/drivers/spi/spi-davinci.c
index 707966b..f0f4dbd 100644
--- a/drivers/spi/spi-davinci.c
+++ b/drivers/spi/spi-davinci.c
@@ -404,6 +404,7 @@ static int davinci_spi_setup(struct spi_device *spi)
 		    (pdata->chip_sel[spi->chip_select] == SPI_INTERN_CS))
 			set_io_bits(dspi->base + SPIPC0, 1 << spi->chip_select);
 
+		davinci_spi_chipselect(spi, BITBANG_CS_INACTIVE);
 	}
 
 	if (spi->mode & SPI_READY)
-- 
1.8.1.2
