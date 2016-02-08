From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH v2 0/4] spi: pxa2xx: Chip select fixes for Intel Baytrail and Braswell
Date: Mon,  8 Feb 2016 17:14:27 +0200
Message-ID: <1454944471-50119-1-git-send-email-mika.westerberg@linux.intel.com>
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Bastien Nocera <bugzilla-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

It turns out that in Windows SPI drivers are responsible for handling ACPI
DeviceSelection field themselves.  Furthermore there has been separate
drivers for big core and atom SPI host controllers. For atom (including
Baytrail and Braswell) the driver starts DeviceSelection from 1 instead of 0
as expected by the Linux SPI core.

As an example Microsoft Surface 3 has touch screen connected to SPI bus
described in ACPI DSDT like this:

    Scope (_SB.PCI0.SPI1)
    {
        Device (NTRG)
        {
            Name (_HID, "MSHW0037")  // _HID: Hardware ID
            ...
            Name (CRS1, ResourceTemplate ()
            {
                SpiSerialBus (0x0001, // SPI DeviceSelection
                    PolarityLow, FourWireMode, 0x10,
                    ControllerInitiated, 0x007A1200, ClockPolarityLow,
                    ClockPhaseFirst, "\\_SB.PCI0.SPI1",
                    0x00, ResourceConsumer, ,
                    )

This fails to enumerate because ACPI DeviceSelection of 1 is greater than
number of chip selects the driver supports [1].

This series adds a new hook to struct spi_master ->fw_translate_cs() that
allows a driver to translate the chip select number from firmware to the
numbering scheme expected by the Linux SPI core and implement that for both
Baytrail and Braswell.

In addition to that we add support for the second chip select found on
Braswell.

This is a second revision of the series. Changes to the v1:
 
 - Added Jarkko's Reviewed-by
 - Use runtime ACPI check in pxa2xx_spi_fw_translate_cs() to prevent build
   breakage found by kbuild test robot.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=104291

Mika Westerberg (4):
  spi: Let drivers translate ACPI DeviceSelection to suitable Linux chip select
  spi: pxa2xx: Translate ACPI DeviceSelection to Linux chip select on Baytrail
  spi: pxa2xx: Move chip select control bits into lpss_config structure
  spi: pxa2xx: Add support for both chip selects on Intel Braswell

 drivers/spi/spi-pxa2xx.c   | 108 ++++++++++++++++++++++++++++++++++-----------
 drivers/spi/spi.c          |  19 +++++++-
 include/linux/pxa2xx_ssp.h |   1 +
 include/linux/spi/spi.h    |   5 +++
 4 files changed, 107 insertions(+), 26 deletions(-)

-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
