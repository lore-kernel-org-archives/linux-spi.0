From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: [PATCH] spi_mpc8xxx.c: use resource_size()
Date: Mon, 14 Dec 2009 17:37:15 -0500
Message-ID: <BD79186B4FD85F4B8E60E381CAEE19090200EA8D@mi8nycmail19.Mi8.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "David Brownell" <dbrownell@users.sourceforge.net>,
	<galak@kernel.crashing.org>
To: "kernel list" <linux-kernel@vger.kernel.org>,
	<spi-devel-general@lists.sourceforge.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755688AbZLNWhS@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Use resource_size().

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Kumar Gala <galak@kernel.crashing.org>

---

diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
index 930135d..d72db76 100644
--- a/drivers/spi/spi_mpc8xxx.c
+++ b/drivers/spi/spi_mpc8xxx.c
@@ -1013,7 +1013,7 @@ mpc8xxx_spi_probe(struct device *dev, struct resource *mem, unsigned int irq)
 
 	init_completion(&mpc8xxx_spi->done);
 
-	mpc8xxx_spi->base = ioremap(mem->start, mem->end - mem->start + 1);
+	mpc8xxx_spi->base = ioremap(mem->start, resource_size(mem));
 	if (mpc8xxx_spi->base == NULL) {
 		ret = -ENOMEM;
 		goto err_ioremap; 
