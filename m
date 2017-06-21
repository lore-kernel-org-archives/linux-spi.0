From: Lukas Wunner <lukas@wunner.de>
Subject: [PATCH 0/3] Apple SPI properties
Date: Wed, 21 Jun 2017 20:05:53 +0200
Message-ID: <cover.1498044532.git.lukas@wunner.de>
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

Invoke an Apple-specific _DSM on ACPI scan, convert the resulting device
properties to _DSD format for further consumption by the ACPI core and
take advantage of these properties when setting up an SPI slave if _CRS
data is empty.

The series intends to pave the way for mainlining an out-of-tree driver
for the SPI keyboard built into recent MacBooks and MacBook Pros:
https://github.com/cb22/macbook12-spi-driver/

It follows up on a discussion on linux-acpi@ in March 2016.  This post
contained an excerpt of the DSDT of an affected MacBook:
https://www.spinics.net/lists/linux-spi/msg06964.html

I tested the ACPI patches extensively on my own machine.  The SPI patch
however needs a Tested-by from one of the developers of the out-of-tree
driver (cc: Ronald, Federico).  The SPI patch compiles without the ACPI
patches, so need not go in through the same tree.

Special thanks to Andy Shevchenko for doing some early reviewing of the
patches on GitHub.

Kind regards,

Lukas


Lukas Wunner (3):
  ACPI / property: Don't evaluate objects for devices w/o handle
  ACPI / property: Support Apple _DSM properties
  spi: Use Apple device properties in absence of ACPI resources

 drivers/acpi/property.c | 123 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/spi/spi.c       |  30 ++++++++++++
 2 files changed, 153 insertions(+)

-- 
2.11.0

