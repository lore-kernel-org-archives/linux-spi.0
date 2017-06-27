From: Amelie Delaunay <amelie.delaunay-qxv4g6HH51o@public.gmane.org>
Subject: [PATCHv2 0/9] STM32 SPI various fixes
Date: Tue, 27 Jun 2017 17:45:12 +0200
Message-ID: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Amelie Delaunay <amelie.delaunay-qxv4g6HH51o@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patchset answers to the reviews done after STM32 SPI driver introduction.

Amelie Delaunay (9):
  dt-bindings: spi: stm32: use SoC specific compatible
  spi: stm32: fix compatible to fit with new bindings
  dt-bindings: spi: stm32: fix example with st,spi-midi-ns property
  spi: stm32: replace st,spi-midi with st,spi-midi-ns to fit bindings
  spi: stm32: use normal conditional statements instead of ternary
    operator
  spi: stm32: add runtime PM support
  spi: stm32: enhance DMA error management
  spi: stm32: fix potential dereference null return value
  spi: spidev: add Aardvark to device tree compatibility list

 .../devicetree/bindings/spi/spi-stm32.txt          |  11 +-
 drivers/spi/spi-stm32.c                            | 130 +++++++++++++++------
 drivers/spi/spidev.c                               |   1 +
 3 files changed, 99 insertions(+), 43 deletions(-)

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
