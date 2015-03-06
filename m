From: <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: [RFC/PATCHv2 0/3] spi: spi-dw: Select 16b or 32b register access
Date: Fri, 6 Mar 2015 17:46:31 -0600
Message-ID: <1425685594-26595-1-git-send-email-tthayer@opensource.altera.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>,
	<tthayer.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>,
	<baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>, <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	<jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <jkosina-AlSwsSmVLrQ@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <dinguyen-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>

The Altera Arria10 SoC interconnect requires 32 bit write accesses to 
APB peripherals. The DesignWare SPI peripheral registers are on 32bit 
boundaries so this patch is minimal. Function pointers are used to select
32bit access or 16bit accesses

Thor Thayer (3):
  spi: dw-spi: Single Register read to clear IRQs
  dt-binding: spi: spi-dw: Select 16b or 32b access for Designware SPI
  spi: dw-spi: Pointers select 16b vs. 32b DesignWare access

 Documentation/devicetree/bindings/spi/spi-dw.txt |    1 +
 drivers/spi/spi-dw-mmio.c                        |    7 ++++-
 drivers/spi/spi-dw.c                             |   31 ++++++++++++----------
 drivers/spi/spi-dw.h                             |   12 +++++++++
 4 files changed, 36 insertions(+), 15 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
