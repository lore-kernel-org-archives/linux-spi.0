From: jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCHv3 0/3] spi: support for Socionext Synquacer platform
Date: Fri, 19 Jan 2018 16:06:53 +0530
Message-ID: <1516358213-4400-1-git-send-email-jassisinghbrar@gmail.com>
Cc: tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ard.biesheuvel-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
        masami.hiramatsu-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
        Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Jassi Brar <jaswinder.singh-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Hello,

 Support for Socionext's FIP controller intended for flash device interfacing.
The controller can operate in 'direct' or 'command' mode. One mode directly
talks and provide a read/write i/f to the flash device. Other works as plain
SPI mode. This driver runs the controller as a SPI controller.

Changes since v2:
	# Made iHCLK clock property required in DT, and iPCLK an optional extra.
	# Hardcode max number of slaves to 4, as specified in the manual.

Changes since v1:
        # Changed licence header to C++ style comment.
        # Removed redundant lock and transfer_mode backup member.
        # Fixed divisor to allow upto 254.

Jassi Brar (3):
  dt-bindings: spi: Add DT bindings for Synquacer
  spi: Add spi driver for Socionext Synquacer platform
  MAINTAINERS: Add entry for Synquacer SPI driver

 .../devicetree/bindings/spi/spi-synquacer.txt      |  23 +
 MAINTAINERS                                        |   7 +
 drivers/spi/Kconfig                                |  11 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-synquacer.c                        | 661 +++++++++++++++++++++
 5 files changed, 703 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-synquacer.txt
 create mode 100644 drivers/spi/spi-synquacer.c

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
