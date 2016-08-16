From: LABBE Corentin <clabbe.montjoie@gmail.com>
Subject: [PATCH 1/2] spi: spi-fsl-dspi: constify devtype_data
Date: Tue, 16 Aug 2016 11:50:20 +0200
Message-ID: <1471341021-22522-1-git-send-email-clabbe.montjoie@gmail.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	LABBE Corentin <clabbe.montjoie@gmail.com>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

of_id->data is const, so instead of casting the pointer to drop its
const status, this patch constify the devtype_data pointer.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/spi/spi-fsl-dspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 9e9dadb..ab6b9e1 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -159,7 +159,7 @@ struct fsl_dspi {
 	u8			cs;
 	u16			void_write_data;
 	u32			cs_change;
-	struct fsl_dspi_devtype_data *devtype_data;
+	const struct fsl_dspi_devtype_data *devtype_data;
 
 	wait_queue_head_t	waitq;
 	u32			waitflags;
@@ -686,7 +686,7 @@ static int dspi_probe(struct platform_device *pdev)
 	}
 	master->bus_num = bus_num;
 
-	dspi->devtype_data = (struct fsl_dspi_devtype_data *)of_id->data;
+	dspi->devtype_data = of_id->data;
 	if (!dspi->devtype_data) {
 		dev_err(&pdev->dev, "can't get devtype_data\n");
 		ret = -EFAULT;
-- 
2.7.3
