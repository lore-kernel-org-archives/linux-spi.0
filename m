From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/5] sunxi spi fixes
Date: Wed, 25 May 2016 00:56:37 +0200
Message-ID: <cover.1464130597.git.hramrach@gmail.com>
Reply-To: hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
  Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
  Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
  linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
Return-path: <linux-sunxi+bncBCQMLUOX54MBBI43TW5AKGQE3MRKLNI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Hello,

This series addresses some issues with sunxi SPI drivers.

The last patch adding DMA support is not completed. It addresses some issue=
s
with the previous version of the patch and it works in practice but some is=
sues
still remain.

Thanks

Michal

Emilio L=C3=B3pez (1):
  RFC spi: sun4i: add DMA support

Michal Suchanek (4):
  spi: sunxi: fix transfer timeout
  spi: sun4i: fix FIFO limit
  spi: sunxi: expose maximum transfer size limit
  spi: sunxi: set maximum and minimum speed of SPI master

 drivers/spi/spi-sun4i.c | 186 ++++++++++++++++++++++++++++++++++++++++++++=
+---
 drivers/spi/spi-sun6i.c |  20 +++++-
 2 files changed, 194 insertions(+), 12 deletions(-)

--=20
2.8.1

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
