From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: [PATCH 2/2] spi: cadence: Fix 3-to-8 mux mode
Date: Thu, 27 Nov 2014 16:12:18 +0100
Message-ID: <1417101138-2619-2-git-send-email-lars@metafoo.de>
References: <1417101138-2619-1-git-send-email-lars@metafoo.de>
Cc: Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Soren Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1417101138-2619-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

In 3-to-8 mux mode for the CS pins we need to set the PERI_SEL bit in the
control register. Currently the driver never sets this bit even when
configured for 3-to-8 mux mode. This patch adds code which sets the bit
during device initialization when necessary.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
---
 drivers/spi/spi-cadence.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence.c b/drivers/spi/spi-cadence.c
index 2404937..5a67498 100644
--- a/drivers/spi/spi-cadence.c
+++ b/drivers/spi/spi-cadence.c
@@ -47,6 +47,7 @@
 #define CDNS_SPI_CR_CPHA_MASK		0x00000004 /* Clock Phase Control */
 #define CDNS_SPI_CR_CPOL_MASK		0x00000002 /* Clock Polarity Control */
 #define CDNS_SPI_CR_SSCTRL_MASK		0x00003C00 /* Slave Select Mask */
+#define CDNS_SPI_CR_PERI_SEL_MASK	0x00000200 /* Peripheral Select Decode */
 #define CDNS_SPI_CR_BAUD_DIV_MASK	0x00000038 /* Baud Rate Divisor Mask */
 #define CDNS_SPI_CR_MSTREN_MASK		0x00000001 /* Master Enable Mask */
 #define CDNS_SPI_CR_MANSTRTEN_MASK	0x00008000 /* Manual TX Enable Mask */
@@ -148,6 +149,11 @@ static inline void cdns_spi_write(struct cdns_spi *xspi, u32 offset, u32 val)
  */
 static void cdns_spi_init_hw(struct cdns_spi *xspi)
 {
+	u32 ctrl_reg = CDNS_SPI_CR_DEFAULT_MASK;
+
+	if (xspi->is_decoded_cs)
+		ctrl_reg |= CDNS_SPI_CR_PERI_SEL_MASK;
+
 	cdns_spi_write(xspi, CDNS_SPI_ER_OFFSET,
 		       CDNS_SPI_ER_DISABLE_MASK);
 	cdns_spi_write(xspi, CDNS_SPI_IDR_OFFSET,
@@ -160,8 +166,7 @@ static void cdns_spi_init_hw(struct cdns_spi *xspi)
 
 	cdns_spi_write(xspi, CDNS_SPI_ISR_OFFSET,
 		       CDNS_SPI_IXR_ALL_MASK);
-	cdns_spi_write(xspi, CDNS_SPI_CR_OFFSET,
-		       CDNS_SPI_CR_DEFAULT_MASK);
+	cdns_spi_write(xspi, CDNS_SPI_CR_OFFSET, ctrl_reg);
 	cdns_spi_write(xspi, CDNS_SPI_ER_OFFSET,
 		       CDNS_SPI_ER_ENABLE_MASK);
 }
-- 
1.8.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
