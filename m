From: Ralf Ramsauer <ralf.ramsauer-XqyLlMioih3Nn6Kn0k1nHrNAH6kLmebB@public.gmane.org>
Subject: [PATCH] spi: tegra114: correct register name in definition
Date: Thu,  5 Oct 2017 13:22:36 +0200
Message-ID: <20171005112236.4242-1-ralf.ramsauer@oth-regensburg.de>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Ralf Ramsauer <ralf.ramsauer-XqyLlMioih3Nn6Kn0k1nHrNAH6kLmebB@public.gmane.org>
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Jonathan Hunter <jonathanh-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

According to "Tegra K1 Processor Technical Reference Manual" (p. 2448),
bit 20 of SPI_COMMAND1 is called CS_SW_VAL and not CS_SS_VAL.

Signed-off-by: Ralf Ramsauer <ralf.ramsauer-XqyLlMioih3Nn6Kn0k1nHrNAH6kLmebB@public.gmane.org>
---
 drivers/spi/spi-tegra114.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index 44550182a4a3..a76acedd7e2f 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -50,7 +50,7 @@
 #define SPI_IDLE_SDA_PULL_LOW			(2 << 18)
 #define SPI_IDLE_SDA_PULL_HIGH			(3 << 18)
 #define SPI_IDLE_SDA_MASK			(3 << 18)
-#define SPI_CS_SS_VAL				(1 << 20)
+#define SPI_CS_SW_VAL				(1 << 20)
 #define SPI_CS_SW_HW				(1 << 21)
 /* SPI_CS_POL_INACTIVE bits are default high */
 						/* n from 0 to 3 */
@@ -705,9 +705,9 @@ static u32 tegra_spi_setup_transfer_one(struct spi_device *spi,
 
 		command1 |= SPI_CS_SW_HW;
 		if (spi->mode & SPI_CS_HIGH)
-			command1 |= SPI_CS_SS_VAL;
+			command1 |= SPI_CS_SW_VAL;
 		else
-			command1 &= ~SPI_CS_SS_VAL;
+			command1 &= ~SPI_CS_SW_VAL;
 
 		tegra_spi_writel(tspi, 0, SPI_COMMAND2);
 	} else {
-- 
2.14.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
