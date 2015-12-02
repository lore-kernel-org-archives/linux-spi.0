From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: butterfly: use new parport device model" to the spi tree
Date: Wed, 02 Dec 2015 20:11:03 +0000
Message-ID: <E1a4Djz-00030v-I4@debutante>
References: <1449064071-4915-4-git-send-email-sudipm.mukherjee@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sudip Mukherjee <sudip-ofJRbWXBVFamYgehrs7/Lw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449064071-4915-4-git-send-email-sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: butterfly: use new parport device model

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

>From 1d3029cc5f17081afdc2d6b7b50f9d0366cdbae1 Mon Sep 17 00:00:00 2001
From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Wed, 2 Dec 2015 19:17:51 +0530
Subject: [PATCH] spi: butterfly: use new parport device model

Modify spi-butterfly driver to use the new parallel port device model.

Signed-off-by: Sudip Mukherjee <sudip-ofJRbWXBVFamYgehrs7/Lw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-butterfly.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-butterfly.c b/drivers/spi/spi-butterfly.c
index f16ef7fb10f1..22a31e4a1a11 100644
--- a/drivers/spi/spi-butterfly.c
+++ b/drivers/spi/spi-butterfly.c
@@ -189,6 +189,7 @@ static void butterfly_attach(struct parport *p)
 	struct butterfly	*pp;
 	struct spi_master	*master;
 	struct device		*dev = p->physport->dev;
+	struct pardev_cb	butterfly_cb;
 
 	if (butterfly || !dev)
 		return;
@@ -221,9 +222,9 @@ static void butterfly_attach(struct parport *p)
 	 * parport hookup
 	 */
 	pp->port = p;
-	pd = parport_register_device(p, "spi_butterfly",
-				     NULL, NULL, NULL,
-				     0 /* FLAGS */, pp);
+	memset(&butterfly_cb, 0, sizeof(butterfly_cb));
+	butterfly_cb.private = pp;
+	pd = parport_register_dev_model(p, "spi_butterfly", &butterfly_cb, 0);
 	if (!pd) {
 		status = -ENOMEM;
 		goto clean0;
@@ -321,8 +322,9 @@ static void butterfly_detach(struct parport *p)
 
 static struct parport_driver butterfly_driver = {
 	.name =		"spi_butterfly",
-	.attach =	butterfly_attach,
+	.match_port =	butterfly_attach,
 	.detach =	butterfly_detach,
+	.devmodel = true,
 };
 
 static int __init butterfly_init(void)
-- 
2.6.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
