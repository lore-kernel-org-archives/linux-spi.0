From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-fsl-dspi: constify devtype_data" to the spi tree
Date: Tue, 16 Aug 2016 12:30:36 +0100
Message-ID: <E1bZcZo-0004oq-Da@debutante>
References: <1471341021-22522-1-git-send-email-clabbe.montjoie@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: LABBE Corentin <clabbe.montjoie@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471341021-22522-1-git-send-email-clabbe.montjoie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-fsl-dspi: constify devtype_data

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 94b968b5a3e282edbdf21735edbeb93a5a1fa119 Mon Sep 17 00:00:00 2001
From: LABBE Corentin <clabbe.montjoie@gmail.com>
Date: Tue, 16 Aug 2016 11:50:20 +0200
Subject: [PATCH] spi: spi-fsl-dspi: constify devtype_data

of_id->data is const, so instead of casting the pointer to drop its
const status, this patch constify the devtype_data pointer.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-fsl-dspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 9e9dadb52b3d..ab6b9e1f79a3 100644
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
2.8.1
