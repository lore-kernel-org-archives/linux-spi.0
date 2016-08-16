From: LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [PATCH 2/2] spi: spi-fsl-dspi: fix a possible NULL dereference
Date: Tue, 16 Aug 2016 11:50:21 +0200
Message-ID: <1471341021-22522-2-git-send-email-clabbe.montjoie@gmail.com>
References: <1471341021-22522-1-git-send-email-clabbe.montjoie@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	LABBE Corentin <clabbe.montjoie@gmail.com>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471341021-22522-1-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

of_match_device could return NULL, and so cause a NULL pointer
dereference later.

For fixing this problem, we use of_device_get_match_data(), this will
simplify the code a little by using a standard function for
getting the match data.

Reported-by: coverity (CID 1324129)
Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index ab6b9e1..d57baf6 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -651,8 +651,6 @@ static int dspi_probe(struct platform_device *pdev)
 	struct resource *res;
 	void __iomem *base;
 	int ret = 0, cs_num, bus_num;
-	const struct of_device_id *of_id =
-			of_match_device(fsl_dspi_dt_ids, &pdev->dev);
 
 	master = spi_alloc_master(&pdev->dev, sizeof(struct fsl_dspi));
 	if (!master)
@@ -686,7 +684,7 @@ static int dspi_probe(struct platform_device *pdev)
 	}
 	master->bus_num = bus_num;
 
-	dspi->devtype_data = of_id->data;
+	dspi->devtype_data = of_device_get_match_data(&pdev->dev);
 	if (!dspi->devtype_data) {
 		dev_err(&pdev->dev, "can't get devtype_data\n");
 		ret = -EFAULT;
-- 
2.7.3
