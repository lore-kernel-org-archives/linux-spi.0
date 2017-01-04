From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] spi: rspi: Remove useless memory allocation failure message
Date: Wed,  4 Jan 2017 11:15:07 +0100
Message-ID: <1483524908-32497-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Printing an error on memory allocation failure is unnecessary.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 48b0d2162ae62da3..2af58a72d702bf17 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1227,10 +1227,8 @@ static int rspi_probe(struct platform_device *pdev)
 	const struct spi_ops *ops;
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct rspi_data));
-	if (master == NULL) {
-		dev_err(&pdev->dev, "spi_alloc_master error.\n");
+	if (master == NULL)
 		return -ENOMEM;
-	}
 
 	of_id = of_match_device(rspi_of_match, &pdev->dev);
 	if (of_id) {
-- 
1.9.1
