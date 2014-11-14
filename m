From: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH V3 0/2] spi: IMG SPFI driver
Date: Fri, 14 Nov 2014 10:48:30 -0800
Message-ID: <1415990912-31744-1-git-send-email-abrestic@chromium.org>
Cc: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	James Hartley <James.Hartley-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>,
	Ezequiel Garcia <Ezequiel.Garcia-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This series adds support for the Sychronous Peripheral Flash Interface
master found on IMG SoCs.  The controller supports up to 5 chip-select
lines and single, dual, and optionally quad, mode transfers.

Tested on a platform using the MIPS-based Pistachio SoC with additional
out-of-tree patches - support for Pistachio will be submitted soon.

Based on 3.18-rc4.

Changes from v2:
 - fixed build errors due to missing #include
Changes from v1:
 - added runtime PM support
 - renamed spi-img -> spi-img-spfi
 - addressed Mark's review comments

Andrew Bresticker (2):
  spi: Add binding document for IMG SPFI controller
  spi: Add driver for IMG SPFI controller

 .../devicetree/bindings/spi/spi-img-spfi.txt       |  37 +
 drivers/spi/Kconfig                                |   7 +
 drivers/spi/Makefile                               |   1 +
 drivers/spi/spi-img-spfi.c                         | 746 +++++++++++++++++++++
 4 files changed, 791 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-img-spfi.txt
 create mode 100644 drivers/spi/spi-img-spfi.c

-- 
2.1.0.rc2.206.gedb03e5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
