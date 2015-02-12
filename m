From: Aurelien BOUIN <a.bouin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/4] spi: imx: checkpatch cleanup
Date: Thu, 12 Feb 2015 13:07:26 +0100
Message-ID: <1423742848-15369-2-git-send-email-a.bouin@gmail.com>
References: <1423742848-15369-1-git-send-email-a.bouin@gmail.com>
Cc: festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Aurelien BOUIN <a.bouin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1423742848-15369-1-git-send-email-a.bouin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch solve various issue detected by checkpatch.pl

Signed-off-by: Aurelien BOUIN <a.bouin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index fe1b769..f8400b2 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -282,7 +282,8 @@ static unsigned int mx51_ecspi_clkdiv(unsigned int fin, unsigned int fspi,
 		(post << MX51_ECSPI_CTRL_POSTDIV_OFFSET);
 }
 
-static void __maybe_unused mx51_ecspi_intctrl(struct spi_imx_data *spi_imx, int enable)
+static void __maybe_unused mx51_ecspi_intctrl(struct spi_imx_data *spi_imx,
+		int enable)
 {
 	unsigned val = 0;
 
@@ -426,7 +427,8 @@ static void __maybe_unused mx51_ecspi_reset(struct spi_imx_data *spi_imx)
  * the i.MX35 has a slightly different register layout for bits
  * we do not use here.
  */
-static void __maybe_unused mx31_intctrl(struct spi_imx_data *spi_imx, int enable)
+static void __maybe_unused mx31_intctrl(struct spi_imx_data *spi_imx,
+		int enable)
 {
 	unsigned int val = 0;
 
@@ -504,7 +506,8 @@ static void __maybe_unused mx31_reset(struct spi_imx_data *spi_imx)
 #define MX21_CSPICTRL_DR_SHIFT	14
 #define MX21_CSPICTRL_CS_SHIFT	19
 
-static void __maybe_unused mx21_intctrl(struct spi_imx_data *spi_imx, int enable)
+static void __maybe_unused mx21_intctrl(struct spi_imx_data *spi_imx,
+		int enable)
 {
 	unsigned int val = 0;
 
@@ -1111,6 +1114,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 
 	for (i = 0; i < master->num_chipselect; i++) {
 		int cs_gpio = of_get_named_gpio(np, "cs-gpios", i);
+
 		if (!gpio_is_valid(cs_gpio) && mxc_platform_info)
 			cs_gpio = mxc_platform_info->chipselect[i];
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
