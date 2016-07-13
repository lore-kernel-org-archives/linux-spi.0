From: Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH v2 0/3] Init device ids from ACPI of_compatible
Date: Wed, 13 Jul 2016 14:53:39 +0300
Message-ID: <cover.1468409668.git.leonard.crestez@intel.com>
Cc: Crestez Dan Leonard <leonard.crestez@intel.com>,
	Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org,
	Wolfram Sang <wsa@the-dreams.de>, linux-spi@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>
To: linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Jarkko Nikula <jarkko.nikula@intel.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

When using devicetree stuff like i2c_client.name or spi_device.modalias
is initialized to the first DT compatible id with the vendor prefix
stripped. Since some drivers rely on this in order to differentiate between
hardware variants try to replicate it when using ACPI with DT ids.

This also makes it so that the i2c_device_id parameter passed to probe is
non-NULL when matching with ACPI and DT ids.

These patches are on top of linux-pm/linux-next. I delayed v2 until ACPI
overlays got in in order to avoid conflicts. I tested using ACPI overlays but
there is no actual dependency. This series just extends the PRP0001 feature to
be more useful for I2C/SPI.

The patches only touches the ACPI-specific parts of the i2c and spi core.

Here is an example .dsl for an SPI accelerometer connected to minnowboard max:

Device (ACCL)
{
    Name (_ADR, Zero)
    Name (_HID, "PRP0001")
    Name (_CID, "PRP0001")
    Name (_UID, One)

    Method (_CRS, 0, Serialized)
    {
	Name (RBUF, ResourceTemplate ()
	{
	    SPISerialBus(1, PolarityLow, FourWireMode, 16,
		    ControllerInitiated, 1000000, ClockPolarityLow,
		    ClockPhaseFirst, "\\_SB.SPI1",)
	    GpioInt (Edge, ActiveHigh, Exclusive, PullDown, 0x0000,
		     "\\_SB.GPO2", 0x00, ResourceConsumer, , )
	    { // Pin list
		    1
	    }
	})
	Return (RBUF)
    }
    Name (_DSD, Package ()
    {
	ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
	Package ()
	{
	    Package () {"compatible", "st,lis3dh"},
	}
    })
}

Link to v1: https://www.spinics.net/lists/linux-acpi/msg66469.html
Changes:
 * Rebase on after acpi overlays got it.
 * Change acpi_of_modalias outlen param to size_t
 * Use {} after else

Crestez Dan Leonard (3):
  acpi: Export acpi_of_modalias equiv of of_modalias_node
  acpi i2c: Initialize info.type from of_compatible
  acpi spi: Initialize modalias from of_compatible

 drivers/acpi/bus.c      | 36 ++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-core.c  |  8 +++++++-
 drivers/spi/spi.c       | 11 ++++++++++-
 include/acpi/acpi_bus.h |  1 +
 4 files changed, 54 insertions(+), 2 deletions(-)

-- 
2.7.4
