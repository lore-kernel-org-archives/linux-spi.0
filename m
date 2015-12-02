From: Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/4] spi: butterfly: use new parport device model
Date: Wed,  2 Dec 2015 19:17:51 +0530
Message-ID: <1449064071-4915-4-git-send-email-sudipm.mukherjee@gmail.com>
References: <1449064071-4915-1-git-send-email-sudipm.mukherjee@gmail.com>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Sudip Mukherjee <sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1449064071-4915-1-git-send-email-sudipm.mukherjee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Modify spi-butterfly driver to use the new parallel port device model.

Signed-off-by: Sudip Mukherjee <sudip-ofJRbWXBVFamYgehrs7/Lw@public.gmane.org>
---

Only change is in the module loading part. It has been tested by
inserting and removing the module repeatedly, tested with unbind also.

 drivers/spi/spi-butterfly.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-butterfly.c b/drivers/spi/spi-butterfly.c
index f16ef7f..22a31e4 100644
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
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
