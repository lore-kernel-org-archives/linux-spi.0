From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 17/28] spi: fsl-espi: avoid processing uninitalized data on error
Date: Tue, 18 Oct 2016 00:13:38 +0200
Message-ID: <20161017221355.1861551-5-arnd@arndb.de>
References: <20161017220342.1627073-1-arnd@arndb.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Heiner Kallweit <heiner.kallweit@web.de>,
        Nobuteru Hayashi <hayashi.nbb@ncos.nec.co.jp>,
        linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161017220342.1627073-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

When we get a spurious interrupt in fsl_espi_irq, we end up
processing four uninitalized bytes of data, as shown in this
warning message:

   drivers/spi/spi-fsl-espi.c: In function 'fsl_espi_irq':
   drivers/spi/spi-fsl-espi.c:462:4: warning: 'rx_data' may be used uninitialized in this function [-Wmaybe-uninitialized]

This adds another check so we skip the data in this case.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/spi-fsl-espi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 7451585..2c175b9 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -458,7 +458,7 @@ static void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 
 		mspi->len -= rx_nr_bytes;
 
-		if (mspi->rx)
+		if (rx_nr_bytes && mspi->rx)
 			mspi->get_rx(rx_data, mspi);
 	}
 
-- 
2.9.0
