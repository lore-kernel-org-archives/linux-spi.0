From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 2/5] spi: sh-msiof: Extract sh_msiof_spi_{start,stop}() helpers
Date: Fri, 20 Jun 2014 12:16:17 +0200
Message-ID: <1403259380-13634-3-git-send-email-geert+renesas@glider.be>
References: <1403259380-13634-1-git-send-email-geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1403259380-13634-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Based on an old patch by Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
 drivers/spi/spi-sh-msiof.c | 51 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 7e5b15b48c04..8bfa97e03502 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -509,6 +509,40 @@ static int sh_msiof_prepare_message(struct spi_master *master,
 	return 0;
 }
 
+static int sh_msiof_spi_start(struct sh_msiof_spi_priv *p, void *rx_buf)
+{
+	int ret;
+
+	/* setup clock and rx/tx signals */
+	ret = sh_msiof_modify_ctr_wait(p, 0, CTR_TSCKE);
+	if (rx_buf && !ret)
+		ret = sh_msiof_modify_ctr_wait(p, 0, CTR_RXE);
+	if (!ret)
+		ret = sh_msiof_modify_ctr_wait(p, 0, CTR_TXE);
+
+	/* start by setting frame bit */
+	if (!ret)
+		ret = sh_msiof_modify_ctr_wait(p, 0, CTR_TFSE);
+
+	return ret;
+}
+
+static int sh_msiof_spi_stop(struct sh_msiof_spi_priv *p, void *rx_buf)
+{
+	int ret;
+
+	/* shut down frame, rx/tx and clock signals */
+	ret = sh_msiof_modify_ctr_wait(p, CTR_TFSE, 0);
+	if (!ret)
+		ret = sh_msiof_modify_ctr_wait(p, CTR_TXE, 0);
+	if (rx_buf && !ret)
+		ret = sh_msiof_modify_ctr_wait(p, CTR_RXE, 0);
+	if (!ret)
+		ret = sh_msiof_modify_ctr_wait(p, CTR_TSCKE, 0);
+
+	return ret;
+}
+
 static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
 				  void (*tx_fifo)(struct sh_msiof_spi_priv *,
 						  const void *, int, int),
@@ -536,15 +570,9 @@ static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
 	if (tx_buf)
 		tx_fifo(p, tx_buf, words, fifo_shift);
 
-	/* setup clock and rx/tx signals */
-	ret = sh_msiof_modify_ctr_wait(p, 0, CTR_TSCKE);
-	if (rx_buf)
-		ret = ret ? ret : sh_msiof_modify_ctr_wait(p, 0, CTR_RXE);
-	ret = ret ? ret : sh_msiof_modify_ctr_wait(p, 0, CTR_TXE);
-
-	/* start by setting frame bit */
 	reinit_completion(&p->done);
-	ret = ret ? ret : sh_msiof_modify_ctr_wait(p, 0, CTR_TFSE);
+
+	ret = sh_msiof_spi_start(p, rx_buf);
 	if (ret) {
 		dev_err(&p->pdev->dev, "failed to start hardware\n");
 		goto err;
@@ -560,12 +588,7 @@ static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
 	/* clear status bits */
 	sh_msiof_reset_str(p);
 
-	/* shut down frame, rx/tx and clock signals */
-	ret = sh_msiof_modify_ctr_wait(p, CTR_TFSE, 0);
-	ret = ret ? ret : sh_msiof_modify_ctr_wait(p, CTR_TXE, 0);
-	if (rx_buf)
-		ret = ret ? ret : sh_msiof_modify_ctr_wait(p, CTR_RXE, 0);
-	ret = ret ? ret : sh_msiof_modify_ctr_wait(p, CTR_TSCKE, 0);
+	ret = sh_msiof_spi_stop(p, rx_buf);
 	if (ret) {
 		dev_err(&p->pdev->dev, "failed to shut down hardware\n");
 		goto err;
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
