From: David Daney <ddaney.cavm@gmail.com>
Subject: [PATCH 0/3] of/spi/eeprom: Configure at25 from device tree and autoload its driver.
Date: Fri, 11 May 2012 15:05:20 -0700
Message-ID: <1336773923-17866-1-git-send-email-ddaney.cavm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
	linux-doc@vger.kernel.org, David Daney <david.daney@cavium.com>
To: devicetree-discuss@lists.ozlabs.org,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-doc-owner@vger.kernel.org>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: David Daney <david.daney@cavium.com>

As per the Subject, given a device tree fragment like this:

	spi@1070000001000 {
		compatible = "cavium,octeon-3010-spi";
		reg = <0x10700 0x00001000 0x0 0x100>;
		interrupts = <0 58>;
		#address-cells = <1>;
		#size-cells = <0>;

		eeprom@0 {
			compatible = "st,m95256", "atmel,at25";
			reg = <0>;
			spi-max-frequency = <5000000>;
			spi-cpha;
			spi-cpol;

			pagesize = <64>;
			size = <32768>;
			address-width = <16>;
		};
	};

The at25 module is autoloaded and configured from the device tree data.

1/3) Make of_modalias_node() work better for auto loading drivers.

2/3) Use MODALIAS prefixed with "spi:" for SPI drivers so modprobe can
     find the proper driver module.

3/3) Use standard eeprom device tree binding to configure at25,
     convert MODULE_ALIAS(), to equivalent MODULE_DEVICE_TABLE().

David Daney (3):
  of: Add prefix parameter to of_modalias_node().
  spi: Use consistent MODALIAS values.
  eeprom/of: Add device tree bindings to at25.

 drivers/misc/eeprom/at25.c   |   61 +++++++++++++++++++++++++++++++++++++++---
 drivers/of/base.c            |   22 +++++++++++----
 drivers/of/of_i2c.c          |    2 +-
 drivers/of/of_spi.c          |    2 +-
 drivers/spi/spi.c            |   39 +++++++++++++++++++++++---
 include/linux/of.h           |    3 +-
 sound/soc/fsl/mpc8610_hpcd.c |    2 +-
 sound/soc/fsl/p1022_ds.c     |    2 +-
 8 files changed, 113 insertions(+), 20 deletions(-)

-- 
1.7.2.3

