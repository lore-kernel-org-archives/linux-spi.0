From: Dan O'Donovan <dan@emutex.com>
Subject: [PATCH v4 0/3] Init device ids from ACPI of_compatible
Date: Fri, 27 Jan 2017 13:30:12 +0000
Message-ID: <1485523815-9629-1-git-send-email-dan@emutex.com>
References: <1485187737-22414-1-git-send-email-dan@emutex.com>
Cc: Len Brown <lenb@kernel.org>, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Dan O'Donovan <dan@emutex.com>
To: linux-acpi@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jarkko Nikula <jarkko.nikula@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485187737-22414-1-git-send-email-dan@emutex.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

When using devicetree, stuff like i2c_client.name or spi_device.modalias
is initialized to the first DT compatible id with the vendor prefix
stripped. Since some drivers rely on this in order to differentiate between
hardware variants, try to replicate it when using ACPI with DT ids.

This also makes it so that the i2c_device_id parameter passed to probe is
non-NULL when matching with ACPI and DT ids.

Tested using ACPI overlays but there is no actual dependency. This series
just extends the PRP0001 feature to be more useful for I2C/SPI.

The patches only touches the ACPI-specific parts of the i2c and spi core.

Here is an example .dsl for an SPI accelerometer connected to minnowboard max:

Device (ACCL)
{
    Name (_ADR, Zero)
    Name (_HID, "PRP0001")
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

Link to v3: http://www.spinics.net/lists/linux-acpi/msg71531.html
Changes:
 * Minor cosmetic/readability improvements (Andy Shevchenko)

Link to v2: https://lkml.org/lkml/2016/7/13/392
Changes:
 * Use appropriate subject prefix for each subsystem (Mark Brown)
 * Use ACPI info as before if getting OF info fails (Mark Brown)
 * Minor cosmetic/readability improvements (Rafael J. Wysocki)

Link to v1: https://www.spinics.net/lists/linux-acpi/msg66469.html
Changes:
 * Rebase on after acpi overlays got it.
 * Change acpi_of_modalias outlen param to size_t
 * Use {} after else

Crestez Dan Leonard (3):
  ACPI / bus: Export acpi_of_modalias equiv of of_modalias_node
  i2c: acpi: Initialize info.type from of_compatible
  spi: acpi: Initialize modalias from of_compatible

 drivers/acpi/bus.c      | 35 +++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-core.c  |  7 ++++++-
 drivers/spi/spi.c       |  9 ++++++++-
 include/acpi/acpi_bus.h |  1 +
 4 files changed, 50 insertions(+), 2 deletions(-)

-- 
2.7.4
