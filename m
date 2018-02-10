From: =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Subject: [PATCH 3/4] spi: orion: Prepare space for per-child options
Date: Sat, 10 Feb 2018 12:20:23 +0100
Message-ID: <11b0dbc2b01dcd1e2f1e94ee1199442d5f2492ce.1518704854.git.jan.kundrat@cesnet.cz>
References: <bc8bf712358fbb000ea7e2ea9e1aec42b21988e6.1518704854.git.jan.kundrat@cesnet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
        Chris Packham <Chris.Packham-6g8wRflRTwXFdCa3tKVlE6U/zSkkHjvu@public.gmane.org>,
        Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Christophe JAILLET <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <bc8bf712358fbb000ea7e2ea9e1aec42b21988e6.1518704854.git.jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Aggregating all options for a particular child underneath a common
struct looks cleaner compared to having a separate array for each
per-child option.

Signed-off-by: Jan Kundrát <jan.kundrat-xoNZbkdr4U2lVyrhU4qvOw@public.gmane.org>
---
This is just a precursor for the next one in series ("spi: orion: Software control for inter-word delays").
---
 drivers/spi/spi-orion.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 56e419a7ed78..1eccc2287079 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -90,6 +90,10 @@ struct orion_direct_acc {
 	u32			size;
 };
 
+struct orion_child_options {
+	struct orion_direct_acc direct_access;
+};
+
 struct orion_spi {
 	struct spi_master	*master;
 	void __iomem		*base;
@@ -98,7 +102,7 @@ struct orion_spi {
 	const struct orion_spi_dev *devdata;
 	int			unused_hw_gpio;
 
-	struct orion_direct_acc	direct_access[ORION_NUM_CHIPSELECTS];
+	struct orion_child_options	child[ORION_NUM_CHIPSELECTS];
 };
 
 static inline void __iomem *spi_reg(struct orion_spi *orion_spi, u32 reg)
@@ -436,7 +440,7 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
 	 * Use SPI direct write mode if base address is available. Otherwise
 	 * fall back to PIO mode for this transfer.
 	 */
-	if ((orion_spi->direct_access[cs].vaddr) && (xfer->tx_buf) &&
+	if ((orion_spi->child[cs].direct_access.vaddr) && (xfer->tx_buf) &&
 	    (word_len == 8)) {
 		unsigned int cnt = count / 4;
 		unsigned int rem = count % 4;
@@ -445,12 +449,12 @@ orion_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
 		 * Send the TX-data to the SPI device via the direct
 		 * mapped address window
 		 */
-		iowrite32_rep(orion_spi->direct_access[cs].vaddr,
+		iowrite32_rep(orion_spi->child[cs].direct_access.vaddr,
 			      xfer->tx_buf, cnt);
 		if (rem) {
 			u32 *buf = (u32 *)xfer->tx_buf;
 
-			iowrite8_rep(orion_spi->direct_access[cs].vaddr,
+			iowrite8_rep(orion_spi->child[cs].direct_access.vaddr,
 				     &buf[cnt], rem);
 		}
 
@@ -707,14 +711,14 @@ static int orion_spi_probe(struct platform_device *pdev)
 		 * This needs to get extended for the direct SPI-NOR / SPI-NAND
 		 * support, once this gets implemented.
 		 */
-		spi->direct_access[cs].vaddr = devm_ioremap(&pdev->dev,
+		spi->child[cs].direct_access.vaddr = devm_ioremap(&pdev->dev,
 							    r->start,
 							    PAGE_SIZE);
-		if (!spi->direct_access[cs].vaddr) {
+		if (!spi->child[cs].direct_access.vaddr) {
 			status = -ENOMEM;
 			goto out_rel_axi_clk;
 		}
-		spi->direct_access[cs].size = PAGE_SIZE;
+		spi->child[cs].direct_access.size = PAGE_SIZE;
 
 		dev_info(&pdev->dev, "CS%d configured for direct access\n", cs);
 	}
-- 
2.14.3


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
