From: <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 0/2] SPI controller driver for Netlogic XLP SoCs
Date: Wed, 19 Aug 2015 10:39:15 +0530
Message-ID: <1439960957-4213-1-git-send-email-kamlakant.patel@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Kamlakant Patel <kamlakant.patel-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>

This patch set adds support for SPI controller driver on Netlogic
XLP MIPS64 SOCs.

Kamlakant Patel (2):
  spi/xlp: SPI controller driver for Netlogic XLP SoCs
  spi: Add DT bindings documentation for Netlogic XLP SPI controller

 Documentation/devicetree/bindings/spi/spi-xlp.txt |   40 ++
 drivers/spi/Kconfig                               |   11 +
 drivers/spi/Makefile                              |    1 +
 drivers/spi/spi-xlp.c                             |  454 +++++++++++++++++++++
 4 files changed, 506 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-xlp.txt
 create mode 100644 drivers/spi/spi-xlp.c

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
