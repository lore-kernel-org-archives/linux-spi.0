From: <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: [PATCH 0/2] SPI: Enable devicetree spi child nodes
Date: Tue, 7 Oct 2014 14:48:15 -0500
Message-ID: <1412711297-31857-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>,
	<tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <tthayer-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>,
	<axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>, <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>,
	<andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <jkosina-AlSwsSmVLrQ@public.gmane.org>, <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	<robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>

This patch series is used to enable the spidev as a child of the
SPI device tree node. This patch was tested on the Altera
SOCFPGA platform.

Thor Thayer (2):
  spi: dw: Initialize of_node to discover device tree node children
  arm: dts: socfpga: Add SPI nodes & update copyright.

 Documentation/devicetree/bindings/spi/spi-dw.txt |    1 +
 arch/arm/boot/dts/socfpga.dtsi                   |   52 ++++++++++++++++++----
 arch/arm/configs/socfpga_defconfig               |    1 +
 drivers/spi/spi-dw-mmio.c                        |    5 ++-
 drivers/spi/spi-dw.c                             |    3 ++
 5 files changed, 53 insertions(+), 9 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
