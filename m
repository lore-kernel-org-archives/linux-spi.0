From: Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH 0/3] Init device ids from ACPI of_compatible
Date: Wed, 15 Jun 2016 21:30:26 +0300
Message-ID: <cover.1466014238.git.leonard.crestez@intel.com>
Cc: Crestez Dan Leonard <leonard.crestez@intel.com>,
	Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org,
	Wolfram Sang <wsa@the-dreams.de>, linux-spi@vger.kernel.org,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	Octavian Purdila <octavian.purdila@intel.com>
To: linux-acpi@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

When using devicetree stuff like i2c_client.name or spi_device.modalias
is initialized to the first DT compatible id with the vendor prefix
stripped. Since some drivers rely on this try to replicate it when using
ACPI with DT ids.

Drivers rely on these ids in order to differentiate between hardware variants
supported by the same driver. As far as I can tell the alternative would be for
drivers to dig into ACPI_COMPANION manually somehow?

This also makes it so that the i2c_device_id parameter passed to probe is
non-NULL when matching with ACPI and DT ids.

The patches only touch the ACPI-specific parts of the i2c and spi core.

These patches are on top of v4.7-rc3. I tested this using Octavin Purdila's
patches for "acpi overlays" but this series does not depend on that. Patch 2
has a conflict with acpi overlays because acpi_i2c_add_device was split into
multiple functions.

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

The driver for that device supports tens of models is not aware of ACPI.

Like to prev thread: https://www.spinics.net/lists/linux-acpi/msg66469.html
Like to acpi overlays: https://www.spinics.net/lists/linux-acpi/msg66638.html

Crestez Dan Leonard (3):
  acpi: Export acpi_of_modalias equiv of of_modalias_node
  acpi i2c: Initialize info.type from of_compatible
  acpi spi: Initialize modalias from of_compatible

 drivers/acpi/bus.c      | 36 ++++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-core.c  |  8 +++++++-
 drivers/spi/spi.c       | 10 +++++++++-
 include/acpi/acpi_bus.h |  1 +
 4 files changed, 53 insertions(+), 2 deletions(-)

-- 
2.5.5

