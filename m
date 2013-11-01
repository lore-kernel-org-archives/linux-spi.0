From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCHv2 0/3] I2C and SPI dev_name change for ACPI enumerated slaves
Date: Fri,  1 Nov 2013 14:35:53 +0200
Message-ID: <1383309356-25430-1-git-send-email-jarkko.nikula@linux.intel.com>
References: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-acpi@vger.kernel.org,
	Jarkko Nikula <jarkko.nikula@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Mark Brown <broonie@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1382703540-3769-1-git-send-email-jarkko.nikula@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi

Second version of the set that changes I2C and SPI slave device names
to be generated from stable ACPI device names on ACPI 5 based systems
instead of using bus numbers which could change.

Slave device name change goes as

	"x-00yz" -> "i2c-INTABCD:ij"
	"spix.y" -> "spi-INTABCD:ij"

This version adds patch to include/acpi/acpi_bus.h that allow us to
remove #if IS_ENABLED(CONFIG_ACPI) checks that were added in the
first version.

Set goes on top linux-pm/linux-next commit e56b4d2.

First version here:
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-October/067737.html

Jarkko Nikula (3):
  ACPI: Expose struct acpi_device and acpi_bus_get_device() to non-ACPI
    builds
  i2c: Use stable dev_name for ACPI enumerated I2C slaves
  spi: Use stable dev_name for ACPI enumerated SPI slaves

 drivers/i2c/i2c-core.c  | 24 ++++++++++++++++++++----
 drivers/spi/spi.c       | 20 +++++++++++++++++---
 include/acpi/acpi_bus.h |  9 +++++++--
 3 files changed, 44 insertions(+), 9 deletions(-)

-- 
1.8.4.rc3

