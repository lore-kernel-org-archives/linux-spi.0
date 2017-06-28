From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v2 0/4] Apple SPI properties
Date: Wed, 28 Jun 2017 19:20:19 +0200
Message-ID: <cover.1498636759.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        linux-acpi@vger.kernel.org, linux-spi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Retrieve device properties on Macs with an Apple-specific _DSM and
use them in lieu of _CRS data upon SPI slave initialization, v2.

Please refer to the cover letter of v1 for further details:
http://www.spinics.net/lists/linux-acpi/msg75537.html

The series has now been tested successfully by Ronald.

Changes v1 -> v2:

Patch 2:
- Rebase on uuid-types branch. (Andy, Rafael)
- Don't align assignments. (Mika)
- Move IS_ENABLED() and dmi_match() conditionals into callee. (Mika)
- Tone down messages indicating an unsupported properties version or
  illegal property type to KERN_INFO to avoid scaring or annoying users
  who may see it on every boot despite "quiet", but still allowing
  diagnosis of issues that may ensue. (Mika)

Patch 3:
- Newly inserted patch in v2 to fix an enumeration issue. (Ronald)

Patch 4 (was patch 3 in v1):
- Move IS_ENABLED() and dmi_match() conditionals into callee. (Mika)
- Allow acpi_spi_parse_apple_properties() to augment or override _CRS
  by calling it unconditionally rather than only if _CRS is empty.

Thanks,

Lukas


Lukas Wunner (4):
  ACPI / property: Don't evaluate objects for devices w/o handle
  ACPI / property: Support Apple _DSM properties
  ACPI / scan: Recognize Apple SPI and I2C slaves
  spi: Use Apple device properties in absence of ACPI resources

 drivers/acpi/property.c | 126 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/scan.c     |   6 +++
 drivers/spi/spi.c       |  30 ++++++++++++
 3 files changed, 162 insertions(+)

-- 
2.11.0

