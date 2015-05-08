From: <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Add Mediatek SPI driver
Date: Fri, 8 May 2015 16:55:40 +0800
Message-ID: <1431075343-7887-1-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>,
	Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>,
	Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
	Eddie Huang <eddie.huang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
	Hongzhou Yang <hongzhou.yang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
	Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Mediatek SPI BUS controller has 3 hardware restrictions:
1. Hw has the restriction that in one transfer, length must be a multiple of
   1024, when it's greater than 1024bytes.
2. Hw tx/rx have 4bytes aligned restriction.
3. For MT8173 IC: RX must enable TX, then TX transfer dummy data; TX don't need
   to enable RX.
Some workarounds are done in SPI driver code base on v4.1-rc1.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
