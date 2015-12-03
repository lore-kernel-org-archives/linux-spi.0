From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4/7] spi: lm70llp: correct alignment
Date: Thu,  3 Dec 2015 18:29:56 +0530
Message-ID: <1449147599-26705-4-git-send-email-sudipm.mukherjee@gmail.com>
References: <1449147599-26705-1-git-send-email-sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449147599-26705-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

checkpatch complains about the allignment with open parenthesis.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/spi/spi-lm70llp.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-lm70llp.c b/drivers/spi/spi-lm70llp.c
index 133e76c..5f526ce 100644
--- a/drivers/spi/spi-lm70llp.c
+++ b/drivers/spi/spi-lm70llp.c
@@ -229,8 +229,8 @@ static void spi_lm70llp_attach(struct parport *p)
 	 */
 	pp->port = p;
 	pd = parport_register_device(p, DRVNAME,
-			NULL, NULL, NULL,
-			PARPORT_FLAG_EXCL, pp);
+				     NULL, NULL, NULL,
+				     PARPORT_FLAG_EXCL, pp);
 	if (!pd) {
 		status = -ENOMEM;
 		goto out_free_master;
@@ -273,7 +273,7 @@ static void spi_lm70llp_attach(struct parport *p)
 	pp->spidev_lm70 = spi_new_device(pp->bitbang.master, &pp->info);
 	if (pp->spidev_lm70)
 		dev_dbg(&pp->spidev_lm70->dev, "spidev_lm70 at %s\n",
-				dev_name(&pp->spidev_lm70->dev));
+			dev_name(&pp->spidev_lm70->dev));
 	else {
 		printk(KERN_WARNING "%s: spi_new_device failed\n", DRVNAME);
 		status = -ENODEV;
-- 
1.9.1
