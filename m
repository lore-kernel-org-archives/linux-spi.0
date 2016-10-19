From: Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/3] Support H3 SPI controller
Date: Wed, 19 Oct 2016 23:02:31 +0900
Message-ID: <20161019140234.13518-1-woogyom.kim@gmail.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Milo Kim <woogyom.kim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

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

Milo Kim (3):
  spi: sun6i: Add binding for Allwinner H3 SPI controller
  spi: sun6i: Support Allwinner H3 SPI controller
  spi: sun6i: Use the driver data to get the buffer size

 .../devicetree/bindings/spi/spi-sun6i.txt          | 25 +++++++++++-
 drivers/spi/Kconfig                                |  4 +-
 drivers/spi/spi-sun6i.c                            | 44 +++++++++++++++-------
 3 files changed, 56 insertions(+), 17 deletions(-)

-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
