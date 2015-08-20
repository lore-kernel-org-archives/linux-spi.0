From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/9] spi/sunxi patches
Date: Thu, 20 Aug 2015 16:15:22 +0200
Message-ID: <cover.1440080122.git.hramrach@gmail.com>
Reply-To: hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
  Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
  Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
  Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
  Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
  Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
  linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
  linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
Return-path: <linux-sunxi+bncBCQMLUOX54MBBAWE26XAKGQEKJCXICI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Hello,

Since the sun4i dmaengine and DT label conversion patches are in this shoul=
d be
now workable.

 - fix some minor issues with the spi driver
 - add spi dt nodes on some boards
 - include the DMA patch which depends on the dmaengine

Thanks

Michal

Emilio L=C3=B3pez (1):
  spi: sun4i: add DMA support

Michal Suchanek (8):
  spi: sunxi: fix transfer timeout
  spi: sun4i: fix FIFO limit
  spi: sunxi: check that transfer speed is non-zero
  ARM: dts: sun7i: cubieboard2: Enable SPI0
  ARM: dts: sunxi: add spi aliases on cubieboards
  ARM: dts: sun5i: add SPI pins on A13 and A10s
  ARM: dts: sunxi: A10s Olinuxino Micro: add spi2.
  ARM: dts: sunxi: Add SPI aliases on A10s Olinuxino.

 arch/arm/boot/dts/sun4i-a10-cubieboard.dts       |   1 +
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts |  10 ++
 arch/arm/boot/dts/sun5i-a10s.dtsi                |  21 +++
 arch/arm/boot/dts/sun5i.dtsi                     |  49 +++++++
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts      |   8 ++
 drivers/spi/spi-sun4i.c                          | 166 +++++++++++++++++++=
+---
 drivers/spi/spi-sun6i.c                          |  25 +++-
 7 files changed, 257 insertions(+), 23 deletions(-)

--=20
2.1.4

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
