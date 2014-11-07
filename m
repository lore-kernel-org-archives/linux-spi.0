From: Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/2] Add SPI support for Diolan DLN2
Date: Fri,  7 Nov 2014 14:45:12 +0200
Message-ID: <1415364314-30320-1-git-send-email-laurentiu.palcu@intel.com>
Cc: Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Laurentiu Palcu <laurentiu.palcu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Johan Havold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

This patchset adds support for the SPI module of the Diolan DLN2 USB to
I2C/SPI/GPIO bridge [1].

This patch depends on another patchset, [1], not yet merged, which adds support
for the other two modules: I2C and GPIO.

[1] http://www.diolan.com/products/dln2/features.html
[2] http://marc.info/?l=linux-kernel&m=141528172903850&w=2

laurentiu

Laurentiu Palcu (2):
  spi: add support for DLN-2 USB-SPI adapter
  mfd: dln2: add support for USB-SPI module

 drivers/mfd/dln2.c     |  12 +
 drivers/spi/Kconfig    |  10 +
 drivers/spi/Makefile   |   1 +
 drivers/spi/spi-dln2.c | 795 +++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 818 insertions(+)
 create mode 100644 drivers/spi/spi-dln2.c

-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
