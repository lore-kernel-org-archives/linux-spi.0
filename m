From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2 7/8] spi: lm70llp: use dev_warn
Date: Mon,  7 Dec 2015 16:17:34 +0530
Message-ID: <1449485255-1103-7-git-send-email-sudipm.mukherjee@gmail.com>
References: <1449485255-1103-1-git-send-email-sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449485255-1103-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

As we have a struct device available it is better to use dev_warn()
instead of printk.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/spi/spi-lm70llp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-lm70llp.c b/drivers/spi/spi-lm70llp.c
index 9d45a63..393eb2b 100644
--- a/drivers/spi/spi-lm70llp.c
+++ b/drivers/spi/spi-lm70llp.c
@@ -249,9 +249,8 @@ static void spi_lm70llp_attach(struct parport *p)
 	 */
 	status = spi_bitbang_start(&pp->bitbang);
 	if (status < 0) {
-		printk(KERN_WARNING
-			"%s: spi_bitbang_start failed with status %d\n",
-			DRVNAME, status);
+		dev_warn(&pd->dev, "spi_bitbang_start failed with status %d\n",
+			 status);
 		goto out_off_and_release;
 	}
 
@@ -278,7 +277,7 @@ static void spi_lm70llp_attach(struct parport *p)
 		dev_dbg(&pp->spidev_lm70->dev, "spidev_lm70 at %s\n",
 			dev_name(&pp->spidev_lm70->dev));
 	else {
-		printk(KERN_WARNING "%s: spi_new_device failed\n", DRVNAME);
+		dev_warn(&pd->dev, "spi_new_device failed\n");
 		status = -ENODEV;
 		goto out_bitbang_stop;
 	}
-- 
1.9.1
