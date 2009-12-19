From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH] spi/mpc8xxx: don't check platform_get_irq's return value against zero
Date: Sat, 19 Dec 2009 16:13:41 +0100
Message-ID: <1261235621-19116-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20091217163944.GA6453@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Vrabel <dvrabel@arcom.com>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	Kumar Gala <galak@kernel.crashing.org>,
	Anton Vorontsov <avorontsov@ru.mvista.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	spi-devel-general@lists.sourceforge.net
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752446AbZLSPN5@vger.kernel.org>
In-Reply-To: <20091217163944.GA6453@oksana.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

platform_get_irq returns -ENXIO on failure, so !irq was probably
always true.  Make irq a signed variable and compare irq <=3D 0.  Note
that a return value of zero is still handled as error even though this
could mean irq0.

This is a followup to 305b3228f9ff4d59f49e6d34a7034d44ee8ce2f0 that
changed the return value of platform_get_irq from 0 to -ENXIO on error.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: David Vrabel <dvrabel@arcom.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Cc: David Brownell <dbrownell@users.sourceforge.net>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: spi-devel-general@lists.sourceforge.net
---
Hello,

as requested by Anton Vorontsov I made irq signed instead of casting to
int when comparing to zero.

Best regards
Uwe

 drivers/spi/spi_mpc8xxx.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
index 1fb2a6e..08065fb 100644
--- a/drivers/spi/spi_mpc8xxx.c
+++ b/drivers/spi/spi_mpc8xxx.c
@@ -1328,7 +1328,7 @@ static struct of_platform_driver of_mpc8xxx_spi_d=
river =3D {
 static int __devinit plat_mpc8xxx_spi_probe(struct platform_device *pd=
ev)
 {
 	struct resource *mem;
-	unsigned int irq;
+	int irq;
 	struct spi_master *master;
=20
 	if (!pdev->dev.platform_data)
@@ -1339,7 +1339,7 @@ static int __devinit plat_mpc8xxx_spi_probe(struc=
t platform_device *pdev)
 		return -EINVAL;
=20
 	irq =3D platform_get_irq(pdev, 0);
-	if (!irq)
+	if (irq <=3D 0)
 		return -EINVAL;
=20
 	master =3D mpc8xxx_spi_probe(&pdev->dev, mem, irq);
--=20
1.6.5.2
