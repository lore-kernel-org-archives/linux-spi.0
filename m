From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 0/2] spi/bcm63xx: add device tree support
Date: Thu, 10 Sep 2015 17:29:33 +0200
Message-ID: <1441898975-22540-1-git-send-email-jogo@openwrt.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Add support for probing spi-bcm63xx through device tree.

Depends on "spi/bcm63xx: cleanup and decouple from arch code".

Jonas Gorski (2):
  spi/bcm63xx: document device tree bindings
  spi/bcm63xx: add support for probing through devicetree

 .../devicetree/bindings/spi/spi-bcm63xx.txt        | 33 +++++++++++++
 drivers/spi/spi-bcm63xx.c                          | 56 ++++++++++++++++------
 2 files changed, 75 insertions(+), 14 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-bcm63xx.txt

-- 
2.1.4
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
