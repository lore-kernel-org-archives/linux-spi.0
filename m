From: <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: [RFC/PATCH 0/2] spi: spi-dw: Select 16b or 32b register access
Date: Wed, 4 Mar 2015 14:31:13 -0600
Message-ID: <1425501075-17081-1-git-send-email-tthayer@opensource.altera.com>
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
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>

The Altera Arria10 SoC requires 32 bit accesses to peripherals. The
DesignWare SPI peripheral registers are on 32bit boundaries so this
patch is minimal. Function pointers are used to select 32bit access
or 16bit accesses.

Thor Thayer (2):
  dt-binding: spi: spi-dw: Select 16b or 32b access for Designware SPI
  spi: dw-spi: Pointers select 16b vs. 32b DesignWare access

 Documentation/devicetree/bindings/spi/spi-dw.txt |    1 +
 drivers/spi/spi-dw-mmio.c                        |    7 +++-
 drivers/spi/spi-dw.c                             |   38 +++++++++++++---------
 drivers/spi/spi-dw.h                             |   10 +++---
 4 files changed, 35 insertions(+), 21 deletions(-)

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
