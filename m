From: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Subject: [PATCH] spi: omap2-mcspi: fix blatant abuse of the resource subsystem
Date: Fri, 18 Jul 2014 13:30:53 +0200
Message-ID: <1405683053-14104-1-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>,
	Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>,
	Charulatha V <charu-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Aua. This really hurts. I wonder how this could ever be admitted to
the Linux kernel...
=46urther comments suppressed because the would most likely violate the
CDA.

If someone should not grasp what this patch does, they should consider
what happens upon unloading/reloading the kernel module.

Signed-off-by: Lothar Wa=C3=9Fmann <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcsp=
i.c
index 68441fa..cb23f5d 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1379,15 +1379,13 @@ static int omap2_mcspi_probe(struct platform_de=
vice *pdev)
 		goto free_master;
 	}
=20
-	r->start +=3D regs_offset;
-	r->end +=3D regs_offset;
-	mcspi->phys =3D r->start;
-
 	mcspi->base =3D devm_ioremap_resource(&pdev->dev, r);
 	if (IS_ERR(mcspi->base)) {
 		status =3D PTR_ERR(mcspi->base);
 		goto free_master;
 	}
+	mcspi->phys =3D r->start + regs_offset;
+	mcspi->base +=3D regs_offset;
=20
 	mcspi->dev =3D &pdev->dev;
=20
--=20
1.7.10.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
