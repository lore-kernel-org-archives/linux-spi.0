From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/PROTO 6/9 option 2/3] spi: sh-msiof: Add clock notifier to enforce valid parent clock
Date: Fri, 12 Aug 2016 18:38:42 +0200
Message-ID: <1471019925-29083-7-git-send-email-geert+renesas@glider.be>
References: <1471019925-29083-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-clk@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: linux-renesas-soc@vger.kernel.org
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1471019925-29083-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Use clock notifiers to avoid changing the clock rate to an out-of-range
setting for already configured devices. This will allow dynamic
configuration of the MSIOF parent clock.

Not-Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Not intended for upstream merge.
---
 drivers/spi/spi-sh-msiof.c | 65 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 63 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 72f80a088cddd395..656eaa4d03ed497b 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -53,6 +53,8 @@ struct sh_msiof_spi_priv {
 	void *rx_dma_page;
 	dma_addr_t tx_dma_addr;
 	dma_addr_t rx_dma_addr;
+	struct notifier_block clk_rate_change_nb;
+	u32 dev_max_speed_hz;
 };
 
 #define TMDR1	0x00	/* Transmit Mode Register 1 */
@@ -180,6 +182,10 @@ struct sh_msiof_spi_priv {
 #define IER_RFOVFE	0x00000008 /* Receive FIFO Overflow Enable */
 
 
+/* Maximum internal divider */
+#define MAX_DIV		1024
+
+
 static u32 sh_msiof_read(struct sh_msiof_spi_priv *p, int reg_offs)
 {
 	switch (reg_offs) {
@@ -253,7 +259,7 @@ static struct {
 static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
 				      unsigned long parent_rate, u32 spi_hz)
 {
-	unsigned long div = 1024;
+	unsigned long div = MAX_DIV;
 	u32 brps, scr;
 	size_t k;
 
@@ -526,6 +532,53 @@ static void sh_msiof_spi_read_fifo_s32u(struct sh_msiof_spi_priv *p,
 		put_unaligned(swab32(sh_msiof_read(p, RFDR) >> fs), &buf_32[k]);
 }
 
+static int sh_msiof_clk_notifier_cb(struct notifier_block *nb,
+				    unsigned long event, void *data)
+{
+	struct clk_notifier_data *ndata = data;
+	struct sh_msiof_spi_priv *p =
+		container_of(nb, struct sh_msiof_spi_priv, clk_rate_change_nb);
+
+	// FIXME locking
+
+	if (!p->dev_max_speed_hz)
+		return NOTIFY_OK;
+
+	switch (event) {
+	case PRE_RATE_CHANGE:
+		dev_info(&p->pdev->dev, "%s: %pC old_rate %lu new_rate %lu\n",
+			 "PRE_RATE_CHANGE", ndata->clk, ndata->old_rate,
+			 ndata->new_rate);
+		if (p->dev_max_speed_hz < ndata->new_rate / MAX_DIV) {
+			dev_err(&p->pdev->dev,
+				"New parent clock rate too high for %u\n",
+				p->dev_max_speed_hz);
+			return NOTIFY_STOP;
+		}
+		if (p->dev_max_speed_hz > ndata->new_rate) {
+			dev_warn(&p->pdev->dev,
+				 "New parent clock rate too low for %u, ignoring\n",
+				 p->dev_max_speed_hz);
+		}
+		return NOTIFY_OK;
+
+	case POST_RATE_CHANGE:
+		dev_info(&p->pdev->dev, "%s: %pC old_rate %lu new_rate %lu\n",
+			 "POST_RATE_CHANGE", ndata->clk, ndata->old_rate,
+			 ndata->new_rate);
+		return NOTIFY_OK;
+
+	case ABORT_RATE_CHANGE:
+		return NOTIFY_OK;
+
+	default:
+		dev_info(&p->pdev->dev,
+			 "0x%lx: %pC old_rate %lu new_rate %lu\n", event,
+			 ndata->clk, ndata->old_rate, ndata->new_rate);
+		return NOTIFY_DONE;
+	}
+}
+
 static int sh_msiof_spi_setup(struct spi_device *spi)
 {
 	struct device_node	*np = spi->master->dev.of_node;
@@ -535,12 +588,14 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
 
 	rate = clk_get_rate(p->clk);
 	max_speed_hz = rate;
-	min_speed_hz = rate / 1024;
+	min_speed_hz = rate / MAX_DIV;
 
 	dev_info(&p->pdev->dev,
 		 "%s: master speed min %u max %u, device speed max = %u\n",
 		 __func__, min_speed_hz, max_speed_hz, spi->max_speed_hz);
 
+	p->dev_max_speed_hz = spi->max_speed_hz;
+
 	pm_runtime_get_sync(&p->pdev->dev);
 
 	if (!np) {
@@ -1263,6 +1318,10 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	p->pdev = pdev;
 	pm_runtime_enable(&pdev->dev);
 
+	p->clk_rate_change_nb.notifier_call = sh_msiof_clk_notifier_cb;
+	if (clk_notifier_register(p->clk, &p->clk_rate_change_nb))
+		dev_warn(&pdev->dev, "Unable to register clock notifier.\n");
+
 	/* Platform data may override FIFO sizes */
 	p->tx_fifo_size = chipdata->tx_fifo_size;
 	p->rx_fifo_size = chipdata->rx_fifo_size;
@@ -1299,6 +1358,7 @@ static int sh_msiof_spi_probe(struct platform_device *pdev)
 	return 0;
 
  err2:
+	clk_notifier_unregister(p->clk, &p->clk_rate_change_nb);
 	sh_msiof_release_dma(p);
 	pm_runtime_disable(&pdev->dev);
  err1:
@@ -1310,6 +1370,7 @@ static int sh_msiof_spi_remove(struct platform_device *pdev)
 {
 	struct sh_msiof_spi_priv *p = platform_get_drvdata(pdev);
 
+	clk_notifier_unregister(p->clk, &p->clk_rate_change_nb);
 	sh_msiof_release_dma(p);
 	pm_runtime_disable(&pdev->dev);
 	return 0;
-- 
1.9.1
