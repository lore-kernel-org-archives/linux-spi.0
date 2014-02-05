From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: Use SPI_BPW_MASK macro at appropriate places
Date: Wed, 05 Feb 2014 21:59:18 +0800
Message-ID: <1391608758.5368.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Scott Jiang <Scott.Jiang.Linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-bfin-v3.c | 3 ++-
 drivers/spi/spi-ti-qspi.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bfin-v3.c b/drivers/spi/spi-bfin-v3.c
index 8f85988..4089d0e 100644
--- a/drivers/spi/spi-bfin-v3.c
+++ b/drivers/spi/spi-bfin-v3.c
@@ -822,7 +822,8 @@ static int bfin_spi_probe(struct platform_device *pdev)
 	master->cleanup = bfin_spi_cleanup;
 	master->setup = bfin_spi_setup;
 	master->transfer_one_message = bfin_spi_transfer_one_message;
-	master->bits_per_word_mask = BIT(32 - 1) | BIT(16 - 1) | BIT(8 - 1);
+	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
+				     SPI_BPW_MASK(8);
 
 	drv_data = spi_master_get_devdata(master);
 	drv_data->master = master;
diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 3d09265..7eb2cef 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -435,7 +435,8 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	master->auto_runtime_pm = true;
 	master->transfer_one_message = ti_qspi_start_transfer_one;
 	master->dev.of_node = pdev->dev.of_node;
-	master->bits_per_word_mask = BIT(32 - 1) | BIT(16 - 1) | BIT(8 - 1);
+	master->bits_per_word_mask = SPI_BPW_MASK(32) | SPI_BPW_MASK(16) |
+				     SPI_BPW_MASK(8);
 
 	if (!of_property_read_u32(np, "num-cs", &num_cs))
 		master->num_chipselect = num_cs;
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
