From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCHv4 0/3] I2C and SPI dev_name change for ACPI enumerated slaves
Date: Thu, 14 Nov 2013 14:03:50 +0200
Message-ID: <1384430633-23426-1-git-send-email-jarkko.nikula@linux.intel.com>
References: <1384419661-28293-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Return-path: <linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1384419661-28293-1-git-send-email-jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-i2c-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

v4:
This version adds and uses acpi_dev_name() accessor instead defining
struct acpi_device stub for !CONFIG_ACPI 

v3:
Third version of the set that changes I2C and SPI slave device names
to be generated from stable ACPI device names on ACPI 5 based systems
instead of using bus numbers which could change.

Slave device name change goes as

	"x-00yz" -> "i2c-INTABCD:ij"
	"spix.y" -> "spi-INTABCD:ij"

This version is actually a bit cleaner thanks to Rafael's
"ACPI / driver core: Store an ACPI device pointer in struct acpi_dev_node"
in git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

Set goes on top of linux-pm/linux-next due dependency to 1/3. As we are now
in merge-window I'm fine if 1/3 goes in first and I queue 2-3/3 later
to i2c and spi trees.

Jarkko Nikula (3):
  ACPI: Provide acpi_dev_name accessor for struct acpi_device device
    name
  i2c: Use stable dev_name for ACPI enumerated I2C slaves
  spi: Use stable dev_name for ACPI enumerated SPI slaves

 drivers/i2c/i2c-core.c | 21 +++++++++++++++++----
 drivers/spi/spi.c      | 17 ++++++++++++++---
 include/linux/acpi.h   | 10 ++++++++++
 3 files changed, 41 insertions(+), 7 deletions(-)

-- 
1.8.4.2
