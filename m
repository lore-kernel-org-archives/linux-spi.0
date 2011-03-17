From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] rtc-{ds1390,ds3234,m41t94}: Use spi_get_drvdata() for SPI
 devices
Date: Thu, 17 Mar 2011 14:47:56 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1103171446130.23741@ayla.of.borg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-7
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: rtc-linux@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>,
	spi-devel-general@lists.sourceforge.net
To: Alessandro Zummo <a.zummo@towertech.it>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The recently increased type checking in platform_get_drvdata() reveals =
a few
offenders:

drivers/rtc/rtc-ds1390.c:161: warning: passing argument 1 of =A1platfor=
m_get_drvdata=A2 from incompatible pointer type
drivers/rtc/rtc-ds3234.c:161: warning: passing argument 1 of =A1platfor=
m_get_drvdata=A2 from incompatible pointer type
drivers/rtc/rtc-m41t94.c:139: warning: passing argument 1 of =A1platfor=
m_get_drvdata=A2 from incompatible pointer type

Use spi_get_drvdata() instead of platform_get_drvdata().

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/rtc/rtc-ds1390.c |    2 +-
 drivers/rtc/rtc-ds3234.c |    2 +-
 drivers/rtc/rtc-m41t94.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-ds1390.c b/drivers/rtc/rtc-ds1390.c
index 26a86d2..b038d2c 100644
--- a/drivers/rtc/rtc-ds1390.c
+++ b/drivers/rtc/rtc-ds1390.c
@@ -158,7 +158,7 @@ static int __devinit ds1390_probe(struct spi_device=
 *spi)
=20
 static int __devexit ds1390_remove(struct spi_device *spi)
 {
-	struct ds1390 *chip =3D platform_get_drvdata(spi);
+	struct ds1390 *chip =3D spi_get_drvdata(spi);
=20
 	rtc_device_unregister(chip->rtc);
 	kfree(chip);
diff --git a/drivers/rtc/rtc-ds3234.c b/drivers/rtc/rtc-ds3234.c
index a774ca3..bbd2622 100644
--- a/drivers/rtc/rtc-ds3234.c
+++ b/drivers/rtc/rtc-ds3234.c
@@ -158,7 +158,7 @@ static int __devinit ds3234_probe(struct spi_device=
 *spi)
=20
 static int __devexit ds3234_remove(struct spi_device *spi)
 {
-	struct rtc_device *rtc =3D platform_get_drvdata(spi);
+	struct rtc_device *rtc =3D spi_get_drvdata(spi);
=20
 	rtc_device_unregister(rtc);
 	return 0;
diff --git a/drivers/rtc/rtc-m41t94.c b/drivers/rtc/rtc-m41t94.c
index c8c97a4..e259ed7 100644
--- a/drivers/rtc/rtc-m41t94.c
+++ b/drivers/rtc/rtc-m41t94.c
@@ -136,7 +136,7 @@ static int __devinit m41t94_probe(struct spi_device=
 *spi)
=20
 static int __devexit m41t94_remove(struct spi_device *spi)
 {
-	struct rtc_device *rtc =3D platform_get_drvdata(spi);
+	struct rtc_device *rtc =3D spi_get_drvdata(spi);
=20
 	if (rtc)
 		rtc_device_unregister(rtc);
--=20
1.7.0.4


Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
							    -- Linus Torvalds
