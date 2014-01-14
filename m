From: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/4] module autoloading fixes
Date: Tue, 14 Jan 2014 16:46:34 +0800
Message-ID: <1389689198-2641-1-git-send-email-rui.zhang@intel.com>
Cc: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org,
	rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

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
