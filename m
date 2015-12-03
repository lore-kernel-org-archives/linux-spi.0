From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 6/7] spi: lm70llp: remove printk
Date: Thu,  3 Dec 2015 18:29:58 +0530
Message-ID: <1449147599-26705-6-git-send-email-sudipm.mukherjee@gmail.com>
References: <1449147599-26705-1-git-send-email-sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449147599-26705-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Using pr_* macros are more prefferable than using printk. Start using
pr_* family of macros and define pr_fmt to be used with it.
While at it remove DRVNAME from an existing pr_info() as the name is now
being printed by pr_fmt.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/spi/spi-lm70llp.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-lm70llp.c b/drivers/spi/spi-lm70llp.c
index 62d0f6d..39cf5dc 100644
--- a/drivers/spi/spi-lm70llp.c
+++ b/drivers/spi/spi-lm70llp.c
@@ -13,6 +13,7 @@
  * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  * GNU General Public License for more details.
  */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
 #include <linux/init.h>
 #include <linux/module.h>
@@ -199,9 +200,7 @@ static void spi_lm70llp_attach(struct parport *p)
 	int			status;
 
 	if (lm70llp) {
-		printk(KERN_WARNING
-			"%s: spi_lm70llp instance already loaded. Aborting.\n",
-			DRVNAME);
+		pr_warn("spi_lm70llp instance already loaded. Aborting.\n");
 		return;
 	}
 
@@ -246,9 +245,7 @@ static void spi_lm70llp_attach(struct parport *p)
 	 */
 	status = spi_bitbang_start(&pp->bitbang);
 	if (status < 0) {
-		printk(KERN_WARNING
-			"%s: spi_bitbang_start failed with status %d\n",
-			DRVNAME, status);
+		pr_warn("spi_bitbang_start failed with status %d\n", status);
 		goto out_off_and_release;
 	}
 
@@ -275,7 +272,7 @@ static void spi_lm70llp_attach(struct parport *p)
 		dev_dbg(&pp->spidev_lm70->dev, "spidev_lm70 at %s\n",
 			dev_name(&pp->spidev_lm70->dev));
 	else {
-		printk(KERN_WARNING "%s: spi_new_device failed\n", DRVNAME);
+		pr_warn("spi_new_device failed\n");
 		status = -ENODEV;
 		goto out_bitbang_stop;
 	}
@@ -296,7 +293,7 @@ out_parport_unreg:
 out_free_master:
 	spi_master_put(master);
 out_fail:
-	pr_info("%s: spi_lm70llp probe fail, status %d\n", DRVNAME, status);
+	pr_info("spi_lm70llp probe fail, status %d\n", status);
 }
 
 static void spi_lm70llp_detach(struct parport *p)
-- 
1.9.1
