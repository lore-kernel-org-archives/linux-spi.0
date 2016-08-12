From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/PROTO 2/9 common] spi: sh-msiof: Print max and transfer frequency
Date: Fri, 12 Aug 2016 18:38:38 +0200
Message-ID: <1471019925-29083-3-git-send-email-geert+renesas@glider.be>
References: <1471019925-29083-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-clk@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: linux-renesas-soc@vger.kernel.org
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1471019925-29083-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Not-Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Not intended for upstream merge.
---
 drivers/spi/spi-sh-msiof.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index ffa5efdf266a8276..72f80a088cddd395 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -272,6 +272,13 @@ static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
 	k = min_t(int, k, ARRAY_SIZE(sh_msiof_spi_div_table) - 1);
 
 	scr = sh_msiof_spi_div_table[k].brdv | SCR_BRPS(brps);
+	dev_info(&p->pdev->dev, "clk at %lu Hz, brps = %u, brdv = %u%s\n",
+		 parent_rate, brps, sh_msiof_spi_div_table[k].div,
+		 ((sh_msiof_spi_div_table[k].div == 1 && brps > 2) ||
+		  (brps > 32)) ? " INVALID!" : "");
+	dev_info(&p->pdev->dev, "wanted: %u Hz, actual: %lu Hz\n", spi_hz,
+		 parent_rate / sh_msiof_spi_div_table[k].div / brps);
+
 	sh_msiof_write(p, TSCR, scr);
 	if (!(p->master->flags & SPI_MASTER_MUST_TX))
 		sh_msiof_write(p, RSCR, scr);
@@ -523,6 +530,16 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
 {
 	struct device_node	*np = spi->master->dev.of_node;
 	struct sh_msiof_spi_priv *p = spi_master_get_devdata(spi->master);
+	u32 max_speed_hz, min_speed_hz;
+	unsigned long rate;
+
+	rate = clk_get_rate(p->clk);
+	max_speed_hz = rate;
+	min_speed_hz = rate / 1024;
+
+	dev_info(&p->pdev->dev,
+		 "%s: master speed min %u max %u, device speed max = %u\n",
+		 __func__, min_speed_hz, max_speed_hz, spi->max_speed_hz);
 
 	pm_runtime_get_sync(&p->pdev->dev);
 
-- 
1.9.1
