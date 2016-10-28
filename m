From: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/4] Support H3 SPI controller
Date: Fri, 28 Oct 2016 15:54:08 +0900
Message-ID: <20161028065412.23008-1-woogyom.kim@gmail.com>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Allwinner H3 SPI controller has same architecture as A31.
So most configuration is identical except one thing - FIFO capacity.

                         A31    H3
------------------------------------
Number of controllers     4      2
Number of FIFO depth     128    64
Transfer bits             8      8

Register maps are sharable, so sun6i SPI driver is reusable with
device configuration.

Tested on Nano Pi M1 and SPI slave device is TI LP8860.

v2:
  Include DTS patches
  Use of_device_get_match_data() helper to get device specific data
  Fix build warning of 64bit CPU architecture
    (warning: cast from pointer to integer of different size
     [-Wpointer-to-int-cast])

Milo Kim (4):
  ARM: dts: sun8i: Add SPI pinctrl node in H3
  ARM: dts: sun8i: Add SPI controller node in H3
  spi: sun6i: Add binding for Allwinner H3 SPI controller
  spi: sun6i: Support Allwinner H3 SPI controller

 .../devicetree/bindings/spi/spi-sun6i.txt          | 25 +++++++++++-
 arch/arm/boot/dts/sun8i-h3.dtsi                    | 46 ++++++++++++++++++++++
 drivers/spi/spi-sun6i.c                            | 18 ++++++---
 3 files changed, 82 insertions(+), 7 deletions(-)

-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
