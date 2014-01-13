From: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/4] module autoloading fixes
Date: Mon, 13 Jan 2014 21:47:23 +0800
Message-ID: <1389620843-3755-1-git-send-email-rui.zhang@intel.com>
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org,
	jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi, all,

This patch set fixes a couple of module autoloading problem.

Patch 1/4 fixes a bug in ACPI device 'modalias' and 'uevent' attributes,
          although the bug can rarely be reproduced (only if there is an
          output error of snprintf, or the ids are longer than 1024 bytes)
Patch 2/4 introduces two new APIs for exporting ACPI style 'modalias' and
          'uevent' attributes in other buses.
Patch 3/4 introduce support for ACPI style 'modalias' and 'uevent'
          attributes in platform, I2C and SPI bus.
Patch 4/4 add OF style 'modalias' support for platform bus.

I did some tests and can confirm that the code for ACPI enumerated platform
bus device works well.
I tried with a patch with convert ACPI Fan device/driver to platform bus,
and can confirm that the code for ACPI enumerated platform device works well,
both the platform Fan driver and device show their modalias as "acpi:PNP0C0B".

thanks,
rui

----------------------------------------------------------------
Zhang Rui (4):
      ACPI: fix create_modalias() return value handling
      ACPI: add module autoloading support for ACPI enumerated devices
      fix module autoloading for ACPI enumerated devices
      OF: introduce OF style 'modalias' support for platform bus.

 drivers/acpi/scan.c       |   73 +++++++++++++++++++++++++++++++++++++++++----
 drivers/base/platform.c   |   16 +++++++++-
 drivers/i2c/i2c-core.c    |   11 +++++++
 drivers/of/device.c       |    3 ++
 drivers/spi/spi.c         |   10 +++++++
 include/linux/acpi.h      |   15 ++++++++++
 include/linux/of_device.h |    6 ++++
 7 files changed, 127 insertions(+), 7 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
