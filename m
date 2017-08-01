From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH v4 0/5] Apple SPI properties
Date: Tue, 1 Aug 2017 14:10:41 +0200
Message-ID: <cover.1501570421.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ronald Tschalaer <ronald@innovation.ch>,
        Federico Lorenzi <florenzi@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Leif Liddy <leif.liddy@gmail.com>,
        Daniel Roschka <danielroschka@phoenitydawn.de>,
        Mark Brown <broonie@kernel.org>, linux-acpi@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lv Zheng <lv.zheng@intel.com>,
        Darren Hart <dvhart@infradead.org>
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <yehezkel.bernat@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Retrieve device properties on Macs with an Apple-specific _DSM and
use them in lieu of _CRS data upon SPI slave initialization
in preparation of supporting the SPI keyboard on 2015+ MacBooks, v4.

Please refer to the cover letter of v1 for further details:
http://www.spinics.net/lists/linux-acpi/msg75537.html

Changes v3 -> v4:

Patch 1:
- Extend consolidation of Apple DMI checks to the entire tree
  instead of just the ACPI core. (Rafael, Andy, Darren)

Patches 2 - 5 are as before.

Thanks,

Lukas


Lukas Wunner (5):
  treewide: Consolidate Apple DMI checks
  ACPI / property: Don't evaluate objects for devices w/o handle
  ACPI / property: Support Apple _DSM properties
  ACPI / scan: Recognize Apple SPI and I2C slaves
  spi: Use Apple device properties in absence of ACPI resources

 arch/x86/include/asm/setup.h            |   1 +
 arch/x86/kernel/early-quirks.c          |   4 +-
 arch/x86/kernel/quirks.c                |  10 +++
 arch/x86/kernel/setup.c                 |   2 +
 drivers/acpi/Makefile                   |   1 +
 drivers/acpi/internal.h                 |   6 ++
 drivers/acpi/osi.c                      |  37 ++-------
 drivers/acpi/pci_root.c                 |   4 +-
 drivers/acpi/property.c                 |   6 ++
 drivers/acpi/sbs.c                      |  25 +-----
 drivers/acpi/scan.c                     |   7 ++
 drivers/acpi/x86/apple.c                | 141 ++++++++++++++++++++++++++++++++
 drivers/firmware/efi/apple-properties.c |   5 +-
 drivers/pci/quirks.c                    |   5 +-
 drivers/spi/spi.c                       |  32 ++++++++
 drivers/thunderbolt/icm.c               |  13 +--
 drivers/thunderbolt/tb.c                |   4 +-
 include/linux/platform_data/x86/apple.h |  13 +++
 18 files changed, 244 insertions(+), 72 deletions(-)
 create mode 100644 drivers/acpi/x86/apple.c
 create mode 100644 include/linux/platform_data/x86/apple.h

-- 
2.11.0

