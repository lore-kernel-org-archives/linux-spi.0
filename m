From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: imx: support loopback mode on imx35" to the spi tree
Date: Wed, 14 Sep 2016 18:16:17 +0100
Message-ID: <E1bkDnF-0001uB-MK@debutante>
References: <20160901203957.GA7994@reykholt.kaiser.cx>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Kaiser <martin-XxZfDwE/svGeZLLa646FqQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160901203957.GA7994-i8im91xUMdo3MargkJlfT5YgPPQkE1Si@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: imx: support loopback mode on imx35

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 15ca92156e6242060dff91c8d8e7fe7ae82d424a Mon Sep 17 00:00:00 2001
From: Martin Kaiser <martin-XxZfDwE/svGeZLLa646FqQ@public.gmane.org>
Date: Thu, 1 Sep 2016 22:39:58 +0200
Subject: [PATCH] spi: imx: support loopback mode on imx35

imx35 and compatible chipsets support loopback mode by setting a
loopback control bit in the test register. Make this setting available
for data transfers, similar to what we do for imx51.

Signed-off-by: Martin Kaiser <martin-XxZfDwE/svGeZLLa646FqQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-imx.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 5cc72be30744..53e7a326c213 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -455,6 +455,9 @@ static void mx51_ecspi_reset(struct spi_imx_data *spi_imx)
 #define MX31_CSPISTATUS		0x14
 #define MX31_STATUS_RR		(1 << 3)
 
+#define MX31_CSPI_TESTREG	0x1C
+#define MX31_TEST_LBC		(1 << 14)
+
 /* These functions also work for the i.MX35, but be aware that
  * the i.MX35 has a slightly different register layout for bits
  * we do not use here.
@@ -510,6 +513,13 @@ static int mx31_config(struct spi_device *spi, struct spi_imx_config *config)
 
 	writel(reg, spi_imx->base + MXC_CSPICTRL);
 
+	reg = readl(spi_imx->base + MX31_CSPI_TESTREG);
+	if (spi->mode & SPI_LOOP)
+		reg |= MX31_TEST_LBC;
+	else
+		reg &= ~MX31_TEST_LBC;
+	writel(reg, spi_imx->base + MX31_CSPI_TESTREG);
+
 	return 0;
 }
 
@@ -1186,7 +1196,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 	spi_imx->bitbang.master->prepare_message = spi_imx_prepare_message;
 	spi_imx->bitbang.master->unprepare_message = spi_imx_unprepare_message;
 	spi_imx->bitbang.master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
-	if (is_imx51_ecspi(spi_imx))
+	if (is_imx35_cspi(spi_imx) || is_imx51_ecspi(spi_imx))
 		spi_imx->bitbang.master->mode_bits |= SPI_LOOP;
 
 	init_completion(&spi_imx->xfer_done);
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
