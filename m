From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v3 0/6] Apple SPI properties
Date: Fri, 14 Jul 2017 00:36:19 +0200
Message-ID: <cover.1499983092.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lv Zheng <lv.zheng@intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org,
        linux-spi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Retrieve device properties on Macs with an Apple-specific _DSM and
use them in lieu of _CRS data upon SPI slave initialization, v3.

Please refer to the cover letters of v1 and v2 for further details:
http://www.spinics.net/lists/linux-acpi/msg75537.html
http://www.spinics.net/lists/linux-acpi/msg75735.html

Special thanks to Ronald Tschalär for patient testing/debugging
and Andy Shevchenko for equally patient reviewing on GitHub.

Changes v2 -> v3:

Patch 1 + 2:
- Newly inserted patches in v3 to avoid repeated DMI checks for Apple
  hardware:  The result of the first DMI check in osi.c is cached.
  Two other existing DMI checks are converted to use the result.
  Because one of them is in a module (sbs.ko), the bool is_apple_system
  needs to be exported.  On non-x86, the DMI checks and Apple-specific
  code are omitted altogether. (Andy, Rafael)

Patch 4:
- Use bitmap to keep track of valid properties.  Move to x86/apple.c
  to avoid cluttering up generic ACPI code. (Andy, Rafael)

Patch 5:
- Use fwnode_property_present() instead of device_property_present(),
  the latter doesn't work as the fwnode pointer of the struct device
  embedded in a struct acpi_device is always NULL. (Ronald)

Patch 6:
- Check buffer length for extra safety.  Rename "o" to "obj",
  use 32 bit division to calculate max_speed_hz. (Andy)

Thanks,

Lukas


Lukas Wunner (6):
  ACPI / osi: Exclude x86 DMI quirks on other arches
  ACPI / x86: Consolidate Apple DMI checks
  ACPI / property: Don't evaluate objects for devices w/o handle
  ACPI / property: Support Apple _DSM properties
  ACPI / scan: Recognize Apple SPI and I2C slaves
  spi: Use Apple device properties in absence of ACPI resources

 drivers/acpi/Makefile    |   1 +
 drivers/acpi/internal.h  |   6 +++
 drivers/acpi/osi.c       |   8 +++
 drivers/acpi/pci_root.c  |   3 +-
 drivers/acpi/property.c  |   6 +++
 drivers/acpi/sbs.c       |  24 +--------
 drivers/acpi/scan.c      |   6 +++
 drivers/acpi/x86/apple.c | 137 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi.c        |  31 +++++++++++
 include/linux/acpi.h     |   6 +++
 10 files changed, 203 insertions(+), 25 deletions(-)
 create mode 100644 drivers/acpi/x86/apple.c

-- 
2.11.0

