From: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 0/5] Add MSPI support for Cygnus
Date: Wed, 8 Apr 2015 11:04:30 -0700
Message-ID: <1428516275-12819-1-git-send-email-jonathar@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Richardson <jonathar-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Scott Branden <sbranden-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>,
	Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	bcm-kernel-feedback-list <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>,
	<devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rafal Milecki <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dtor-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Anatol Pomazau <anatol-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patchset adds support for the MSPI controller on Cygnus. The existing MSPI
driver in the kernel was written for BCMA which is a Broadcom AMBA bus variant
used on certain chips such as the 53xx.

This patch makes BCMA support optional. The current config is being renamed to
make it chip nonspecific supporting BCMA, and a new config is added to support
non-BCMA chips. DT support is now mandatory to allow removal of a hardcoded SPI
device.

Support is also added to set the baud rate. The controller currently runs at the
slowest speed possible.

Changes from v1:
 - Split previous patch 2 into two patches to make it easier to review. One
   commit for the file rename, and one for the actual changes to rename
   variables, functions, etc.
 - Checked return value of clk_get_rate().
 - ifdef indentation fix.

Jonathan Richardson (5):
  ARM: dts: Add binding for Broadcom MSPI driver.
  spi: bcm53xx: Refactor driver to make nonspecific to 53xx SoCs
  spi: bcm-mspi: Refactor to make driver nonspecific to 53xx SoCs
  spi: bcm-mspi: Make BCMA optional to support non-BCMA chips
  spi: bcm-mspi: Add support to set serial baud clock rate

 .../devicetree/bindings/spi/brcm,mspi-spi.txt      |   36 ++
 drivers/spi/Kconfig                                |   12 +-
 drivers/spi/Makefile                               |    3 +-
 drivers/spi/spi-bcm-mspi.c                         |  457 ++++++++++++++++++++
 drivers/spi/spi-bcm-mspi.h                         |   84 ++++
 drivers/spi/spi-bcm53xx.c                          |  299 -------------
 drivers/spi/spi-bcm53xx.h                          |   72 ---
 7 files changed, 587 insertions(+), 376 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/brcm,mspi-spi.txt
 create mode 100644 drivers/spi/spi-bcm-mspi.c
 create mode 100644 drivers/spi/spi-bcm-mspi.h
 delete mode 100644 drivers/spi/spi-bcm53xx.c
 delete mode 100644 drivers/spi/spi-bcm53xx.h

-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
