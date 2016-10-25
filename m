From: Arnd Bergmann <arnd@arndb.de>
Subject: [v4.9 PATCH] spi: fsl-espi: avoid processing uninitalized data on error
Date: Tue, 25 Oct 2016 22:57:10 +0200
Message-ID: <20161025205718.1637880-1-arnd@arndb.de>
Cc: Arnd Bergmann <arnd@arndb.de>, stable@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Nobuteru Hayashi <hayashi.nbb@ncos.nec.co.jp>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

When we get a spurious interrupt in fsl_espi_irq, we end up
processing four uninitalized bytes of data, as shown in this
warning message:

   drivers/spi/spi-fsl-espi.c: In function 'fsl_espi_irq':
   drivers/spi/spi-fsl-espi.c:462:4: warning: 'rx_data' may be used uninitialized in this function [-Wmaybe-uninitialized]

This adds another check so we skip the data in this case.

Fixes: 6319a68011b8 ("spi/fsl-espi: avoid infinite loops on fsl_espi_cpu_irq()")
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/spi-fsl-espi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

This is a bugfix that we should get into v4.9. It conflicts with
a rework of that function that is currently scheduled in spi-next
for v4.10, but is also required there in some form.

I suppose we also want this backported to -stable, as we also get
the warning in older kernels, and the patch that introduced
the condition apparently address to fix the hardware problem
that would now lead to incorrect data instead of an infinite loop.

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
