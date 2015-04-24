From: Alban Bedel <albeu-GANU6spQydw@public.gmane.org>
Subject: [PATCH 0/4] spi: spi-ath79: Devicetree support and misc fixes
Date: Fri, 24 Apr 2015 16:19:20 +0200
Message-ID: <1429885164-28501-1-git-send-email-albeu@free.fr>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Ralf Baechle <ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Alban Bedel <albeu-GANU6spQydw@public.gmane.org>,
	Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mips-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello all,

this serie add a DT support for the ATH79 SPI controller and fix a few
trivial bugs. While adding DT support we also remove the unused custom
controller data in favor of the generic GPIO based chip select.

The clock patch add the missing clk_un/prepare to fix the warnings once
the platform is moved to the generic clock framework.

Finally the last patch is to ensure that CS_HIGH chips using CS0 get the
proper CS level before the first transfer.

Alban

Alban Bedel (4):
  devicetree: add binding documentation for the AR7100 SPI controller
  spi: spi-ath79: Add device tree support
  spi: spi-ath79: Use clk_prepare_enable and clk_disable_unprepare
  spi: spi-ath79: Set the initial state of CS0

 .../devicetree/bindings/spi/spi-ath79.txt          | 24 +++++++++++++++
 .../include/asm/mach-ath79/ath79_spi_platform.h    |  4 ---
 drivers/spi/spi-ath79.c                            | 34 ++++++++++++++--------
 3 files changed, 46 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-ath79.txt

-- 
2.0.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
