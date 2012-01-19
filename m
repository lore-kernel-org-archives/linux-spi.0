From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: mc13xxx: add I2C support
Date: Thu, 19 Jan 2012 15:22:24 +0800
Message-ID: <20120119072222.GD2247@S2101-09.ap.freescale.net>
References: <1326934894-29516-1-git-send-email-marc@cpdesign.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Marc Reilly <marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1326934894-29516-1-git-send-email-marc-DtE7ei5U7Kg0n/F98K4Iww@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Marc,

On Thu, Jan 19, 2012 at 12:01:31PM +1100, Marc Reilly wrote:
> Hi,
>=20
> This series (based on 3.2) adds I2C support for the mc13xxx family PM=
ICs.
> The patches are similar, but not identical to my previous patches for=
 this [1], the
> main difference being the way the config items are done in patch 2.
>=20
The series looks nice.

> I don't have the hardware to retest on SPI hardware, I'd appreciate i=
f someone could=20
> double check it still works.
>=20
I just gave it a spin on my imx51 babbage board where mc13892 is
connected on spi.  The spi access works fine as before, since the part
still gets recognized correctly.

BTW, I see the following compile error.

  CC      drivers/regulator/mc13892-regulator.o
In file included from include/linux/mfd/mc13892.h:12:0,
                 from drivers/regulator/mc13892-regulator.c:13:
include/linux/mfd/mc13xxx.h:87:15: error: field =E2=80=98lock=E2=80=99 =
has incomplete type

And I fixed it as below.

---8<----
diff --git a/include/linux/mfd/mc13xxx.h b/include/linux/mfd/mc13xxx.h
index c17fc60..4ca8439 100644
--- a/include/linux/mfd/mc13xxx.h
+++ b/include/linux/mfd/mc13xxx.h
@@ -10,6 +10,7 @@
 #define __LINUX_MFD_MC13XXX_H

 #include <linux/interrupt.h>
+#include <linux/mutex.h>

 struct mc13xxx;

---->8---

--=20
Regards,
Shawn
