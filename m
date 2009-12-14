From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: [PATCH] spi_bfin5xx.c: use resource_size()
Date: Mon, 14 Dec 2009 17:33:43 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090200EA82@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "David Brownell" <dbrownell@users.sourceforge.net>,
	<cooloney@kernel.org>
To: "kernel list" <linux-kernel@vger.kernel.org>,
	<spi-devel-general@lists.sourceforge.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932235AbZLNWdr@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Use resource_size().

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Bryan Wu <cooloney@kernel.org>

---

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 73e24ef..1d41058 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -1294,7 +1294,7 @@ static int __init bfin_spi_probe(struct platform_device *pdev)
 		goto out_error_get_res;
 	}
 
-	drv_data->regs_base = ioremap(res->start, (res->end - res->start + 1));
+	drv_data->regs_base = ioremap(res->start, resource_size(res));
 	if (drv_data->regs_base == NULL) {
 		dev_err(dev, "Cannot map IO\n");
 		status = -ENXIO; 
