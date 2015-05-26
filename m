From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] spi: sirf: add the reset for USP-based SPI
Date: Tue, 26 May 2015 05:21:34 +0000
Message-ID: <1432617694-15974-1-git-send-email-21cnbao@gmail.com>
Cc: workgroup.linux-kQvG35nSl+M@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>

USP-based SPI need a disable and enable, otherwise it doesn't work.
this patch adds it as HW initialization.

Signed-off-by: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
---
 drivers/spi/spi-sirf.c | 70 ++++++++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 28 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index f9b864f..7072276 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -248,34 +248,6 @@ static const struct sirf_spi_register usp_spi_register = {
 	.usp_int_en_clr		= 0x140,
 };
 
-struct sirf_spi_comp_data {
-	const struct sirf_spi_register *regs;
-	enum sirf_spi_type type;
-	unsigned int dat_max_frm_len;
-	unsigned int fifo_size;
-};
-
-static const struct sirf_spi_comp_data sirf_real_spi = {
-	.regs = &real_spi_register,
-	.type = SIRF_REAL_SPI,
-	.dat_max_frm_len = 64 * 1024,
-	.fifo_size = 256,
-};
-
-static const struct sirf_spi_comp_data sirf_usp_spi_p2 = {
-	.regs = &usp_spi_register,
-	.type = SIRF_USP_SPI_P2,
-	.dat_max_frm_len = 1024 * 1024,
-	.fifo_size = 128,
-};
-
-static const struct sirf_spi_comp_data sirf_usp_spi_a7 = {
-	.regs = &usp_spi_register,
-	.type = SIRF_USP_SPI_A7,
-	.dat_max_frm_len = 1024 * 1024,
-	.fifo_size = 512,
-};
-
 struct sirfsoc_spi {
 	struct spi_bitbang bitbang;
 	struct completion rx_done;
@@ -321,6 +293,23 @@ struct sirfsoc_spi {
 	unsigned int dat_max_frm_len;
 };
 
+struct sirf_spi_comp_data {
+	const struct sirf_spi_register *regs;
+	enum sirf_spi_type type;
+	unsigned int dat_max_frm_len;
+	unsigned int fifo_size;
+	void (*hwinit)(struct sirfsoc_spi *sspi);
+};
+
+static void sirfsoc_usp_hwinit(struct sirfsoc_spi *sspi)
+{
+	/* reset USP and let USP can operate */
+	writel(readl(sspi->base + sspi->regs->usp_mode1) &
+		~SIRFSOC_USP_EN, sspi->base + sspi->regs->usp_mode1);
+	writel(readl(sspi->base + sspi->regs->usp_mode1) |
+		SIRFSOC_USP_EN, sspi->base + sspi->regs->usp_mode1);
+}
+
 static void spi_sirfsoc_rx_word_u8(struct sirfsoc_spi *sspi)
 {
 	u32 data;
@@ -1047,6 +1036,29 @@ static void spi_sirfsoc_cleanup(struct spi_device *spi)
 	}
 }
 
+static const struct sirf_spi_comp_data sirf_real_spi = {
+	.regs = &real_spi_register,
+	.type = SIRF_REAL_SPI,
+	.dat_max_frm_len = 64 * 1024,
+	.fifo_size = 256,
+};
+
+static const struct sirf_spi_comp_data sirf_usp_spi_p2 = {
+	.regs = &usp_spi_register,
+	.type = SIRF_USP_SPI_P2,
+	.dat_max_frm_len = 1024 * 1024,
+	.fifo_size = 128,
+	.hwinit = sirfsoc_usp_hwinit,
+};
+
+static const struct sirf_spi_comp_data sirf_usp_spi_a7 = {
+	.regs = &usp_spi_register,
+	.type = SIRF_USP_SPI_A7,
+	.dat_max_frm_len = 1024 * 1024,
+	.fifo_size = 512,
+	.hwinit = sirfsoc_usp_hwinit,
+};
+
 static const struct of_device_id spi_sirfsoc_of_match[] = {
 	{ .compatible = "sirf,prima2-spi", .data = &sirf_real_spi},
 	{ .compatible = "sirf,prima2-usp-spi", .data = &sirf_usp_spi_p2},
@@ -1136,6 +1148,8 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 		goto free_tx_dma;
 	}
 	clk_prepare_enable(sspi->clk);
+	if (spi_comp_data->hwinit)
+		spi_comp_data->hwinit(sspi);
 	sspi->ctrl_freq = clk_get_rate(sspi->clk);
 
 	init_completion(&sspi->rx_done);
-- 
2.3.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
