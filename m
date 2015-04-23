From: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>
Subject: [PATCH] spi: fsl-spi: fix devm_ioremap_resource() error case
Date: Thu, 23 Apr 2015 14:11:47 +0200 (CEST)
Message-ID: <20150423121147.AFEA31A2439@localhost.localdomain>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

devm_ioremap_resource() doesn't return NULL but an ERR_PTR on error.

Reported-by: Jonas Gorsky <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Signed-off-by: Christophe Leroy <christophe.leroy-GgN8y9CXRhA@public.gmane.org>

---
 drivers/spi/spi-fsl-cpm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index 4e5c945..1e66644 100644
--- a/drivers/spi/spi-fsl-cpm.c
+++ b/drivers/spi/spi-fsl-cpm.c
@@ -305,10 +305,15 @@ int fsl_spi_cpm_init(struct mpc8xxx_spi *mspi)
 
 	if (mspi->flags & SPI_CPM1) {
 		struct resource *res;
+		void *pram;
 
 		res = platform_get_resource(to_platform_device(dev),
 					    IORESOURCE_MEM, 1);
-		mspi->pram = devm_ioremap_resource(dev, res);
+		pram = devm_ioremap_resource(dev, res);
+		if (IS_ERR(pram))
+			mspi->pram = NULL;
+		else
+			mspi->pram = pram;
 	} else {
 		unsigned long pram_ofs = fsl_spi_cpm_get_pram(mspi);
 
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
