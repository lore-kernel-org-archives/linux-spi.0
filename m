From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 09/23] spi: fsl-espi: simplify fsl_espi_setup_transfer
Date: Fri, 2 Sep 2016 22:24:08 +0200
Message-ID: <a9bea8c8-df0e-1d54-aca5-e794678c2da7@gmail.com>
References: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Simplify fsl_espi_setup_transfer a little.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
- changed order of patches to do trivial changes first
  (was patch 21 of the series before)
---
 drivers/spi/spi-fsl-espi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index c0023c0..51696a6 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -187,12 +187,10 @@ static void fsl_espi_setup_transfer(struct spi_device *spi,
 	mpc8xxx_spi->get_rx = cs->get_rx;
 	mpc8xxx_spi->get_tx = cs->get_tx;
 
-	bits_per_word = bits_per_word - 1;
-
 	/* mask out bits we are going to set */
 	cs->hw_mode &= ~(CSMODE_LEN(0xF) | CSMODE_DIV16 | CSMODE_PM(0xF));
 
-	cs->hw_mode |= CSMODE_LEN(bits_per_word);
+	cs->hw_mode |= CSMODE_LEN(bits_per_word - 1);
 
 	if ((mpc8xxx_spi->spibrg / hz) > 64) {
 		cs->hw_mode |= CSMODE_DIV16;
-- 
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
