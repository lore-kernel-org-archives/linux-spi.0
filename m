From: Barry Song <21cnbao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/2] spi: sirf: replace kmalloc by devm_kzalloc
Date: Thu,  7 May 2015 07:13:10 +0000
Message-ID: <1430982791-8681-1-git-send-email-21cnbao@gmail.com>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, workgroup.linux-kQvG35nSl+M@public.gmane.org,
	Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>, Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>

Signed-off-by: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
Signed-off-by: Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
---
 drivers/spi/spi-sirf.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-sirf.c b/drivers/spi/spi-sirf.c
index a69ccb7..ae4bd11 100644
--- a/drivers/spi/spi-sirf.c
+++ b/drivers/spi/spi-sirf.c
@@ -758,7 +758,7 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 	/* We are not using dummy delay between command and data */
 	writel(0, sspi->base + SIRFSOC_SPI_DUMMY_DELAY_CTL);
 
-	sspi->dummypage = kmalloc(2 * PAGE_SIZE, GFP_KERNEL);
+	sspi->dummypage = devm_kzalloc(&pdev->dev, 2 * PAGE_SIZE, GFP_KERNEL);
 	if (!sspi->dummypage) {
 		ret = -ENOMEM;
 		goto free_clk;
@@ -766,12 +766,10 @@ static int spi_sirfsoc_probe(struct platform_device *pdev)
 
 	ret = spi_bitbang_start(&sspi->bitbang);
 	if (ret)
-		goto free_dummypage;
+		goto free_clk;
 	dev_info(&pdev->dev, "registerred, bus number = %d\n", master->bus_num);
 
 	return 0;
-free_dummypage:
-	kfree(sspi->dummypage);
 free_clk:
 	clk_disable_unprepare(sspi->clk);
 	clk_put(sspi->clk);
@@ -794,7 +792,6 @@ static int  spi_sirfsoc_remove(struct platform_device *pdev)
 	sspi = spi_master_get_devdata(master);
 
 	spi_bitbang_stop(&sspi->bitbang);
-	kfree(sspi->dummypage);
 	clk_disable_unprepare(sspi->clk);
 	clk_put(sspi->clk);
 	dma_release_channel(sspi->rx_chan);
-- 
2.3.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
