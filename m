From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: [PATCH] atmel_spi.c: use resource_size()
Date: Mon, 14 Dec 2009 17:22:25 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090200EA75@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: <haavard.skinnemoen@atmel.com>
To: "kernel list" <linux-kernel@vger.kernel.org>,
	<spi-devel-general@lists.sourceforge.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933140AbZLNWWb@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Use resource_size().

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Haavard Skinnemoen <hskinnemoen@atmel.com>

---

diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
index f5b3fdb..b4fe99a 100644
--- a/drivers/spi/atmel_spi.c
+++ b/drivers/spi/atmel_spi.c
@@ -788,7 +788,7 @@ static int __init atmel_spi_probe(struct platform_device *pdev)
 	spin_lock_init(&as->lock);
 	INIT_LIST_HEAD(&as->queue);
 	as->pdev = pdev;
-	as->regs = ioremap(regs->start, (regs->end - regs->start) + 1);
+	as->regs = ioremap(regs->start, resource_size(regs));
 	if (!as->regs)
 		goto out_free_buffer;
 	as->irq = irq; 
