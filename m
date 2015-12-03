From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 7/7] spi: lm70llp: use new parport device model
Date: Thu,  3 Dec 2015 18:29:59 +0530
Message-ID: <1449147599-26705-7-git-send-email-sudipm.mukherjee@gmail.com>
References: <1449147599-26705-1-git-send-email-sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449147599-26705-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Modify spi-lm70llp driver to use the new parallel port device model.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/spi/spi-lm70llp.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-lm70llp.c b/drivers/spi/spi-lm70llp.c
index 39cf5dc..9537248 100644
--- a/drivers/spi/spi-lm70llp.c
+++ b/drivers/spi/spi-lm70llp.c
@@ -198,6 +198,7 @@ static void spi_lm70llp_attach(struct parport *p)
 	struct spi_lm70llp	*pp;
 	struct spi_master	*master;
 	int			status;
+	struct pardev_cb	lm70llp_cb;
 
 	if (lm70llp) {
 		pr_warn("spi_lm70llp instance already loaded. Aborting.\n");
@@ -227,9 +228,11 @@ static void spi_lm70llp_attach(struct parport *p)
 	 * Parport hookup
 	 */
 	pp->port = p;
-	pd = parport_register_device(p, DRVNAME,
-				     NULL, NULL, NULL,
-				     PARPORT_FLAG_EXCL, pp);
+	memset(&lm70llp_cb, 0, sizeof(lm70llp_cb));
+	lm70llp_cb.private = pp;
+	lm70llp_cb.flags = PARPORT_FLAG_EXCL;
+	pd = parport_register_dev_model(p, DRVNAME, &lm70llp_cb, 0);
+
 	if (!pd) {
 		status = -ENOMEM;
 		goto out_free_master;
@@ -319,8 +322,9 @@ static void spi_lm70llp_detach(struct parport *p)
 
 static struct parport_driver spi_lm70llp_drv = {
 	.name =		DRVNAME,
-	.attach =	spi_lm70llp_attach,
+	.match_port =	spi_lm70llp_attach,
 	.detach =	spi_lm70llp_detach,
+	.devmodel =	true,
 };
 
 static int __init init_spi_lm70llp(void)
-- 
1.9.1
