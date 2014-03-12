From: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 0/3] xtensa xtfpga SPI controller driver
Date: Wed, 12 Mar 2014 16:21:02 +0400
Message-ID: <1394626865-15105-1-git-send-email-jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, Marc Gauthier <marc-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

this series adds driver for SPI controller used on xtfpga xtensa platform,
device tree binding documentation and an entry to MAINTAINERS.

Changes v1 -> v2:
- support 8 bit transfers;
- busy-wait for maximum 100 usec (instead of 100 msec) polling BUSY register;
- use chipselect callback to check transfer size.

Max Filippov (3):
  spi: add xtfpga SPI controller driver
  spi/xtensa-xtfpga: add DT binding documentation
  MAINTAINERS: add xtfpga platform section

 .../devicetree/bindings/spi/spi-xtensa-xtfpga.txt  |   9 +
 MAINTAINERS                                        |   6 +
 drivers/spi/Kconfig                                |  13 ++
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-xtensa-xtfpga.c                    | 187 +++++++++++++++++++++
 5 files changed, 216 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-xtensa-xtfpga.txt
 create mode 100644 drivers/spi/spi-xtensa-xtfpga.c

-- 
1.8.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
