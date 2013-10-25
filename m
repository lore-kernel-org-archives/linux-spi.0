From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [RFC 0/2] I2C and SPI dev_name change for ACPI enumerated slaves
Date: Fri, 25 Oct 2013 15:18:58 +0300
Message-ID: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi

We've run into problem of changing I2C device names while developing
ALSA SoC drivers for x86 based systems. Changing device names makes
more difficult to match devices by their name. Which is what we use
within ASoC subsystem.

These changing names comes from changing adapter/bus numbering which
could occur due variable amount of bus controllers, probe order, add-on
cards or different BIOS settings.

Patches here try to solve the problem on ACPI 5 based systems by
using stable ACPI device name with a "i2c-"/"spi-" prefix for I2C/SPI
slave device names.

Both patches are independent from each other and can go through their
own subsystems.

Jarkko Nikula (2):
  i2c: Use stable dev_name for ACPI enumerated I2C slaves
  spi: Use stable dev_name for ACPI enumerated SPI slaves

 drivers/i2c/i2c-core.c | 24 ++++++++++++++++++++----
 drivers/spi/spi.c      | 21 ++++++++++++++++++---
 2 files changed, 38 insertions(+), 7 deletions(-)

-- 
1.8.4.rc3
