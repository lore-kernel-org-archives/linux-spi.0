From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v3 0/3] Init device ids from ACPI of_compatible
Date: Mon, 23 Jan 2017 19:13:11 +0200
Message-ID: <CAHp75VdtbtGmcrPn2R-082b8Ohffke00oBzT0=W0vzBpaSV6iw@mail.gmail.com>
References: <cover.1468409668.git.leonard.crestez@intel.com> <1485187737-22414-1-git-send-email-dan@emutex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jarkko Nikula <jarkko.nikula@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-i2c@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: "Dan O'Donovan" <dan@emutex.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485187737-22414-1-git-send-email-dan@emutex.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Jan 23, 2017 at 6:08 PM, Dan O'Donovan <dan@emutex.com> wrote:
> (Re-submitting this patch set originally created by Leonard Crestez,
> possibly abandoned by Leonard due to a change in employment)
>
> When using devicetree, stuff like i2c_client.name or spi_device.modalias
> is initialized to the first DT compatible id with the vendor prefix
> stripped. Since some drivers rely on this in order to differentiate between
> hardware variants try to replicate it when using ACPI with DT ids.
>
> This also makes it so that the i2c_device_id parameter passed to probe is
> non-NULL when matching with ACPI and DT ids.
>
> Tested using ACPI overlays but there is no actual dependency. This series
> just extends the PRP0001 feature to be more useful for I2C/SPI.
>
> The patches only touches the ACPI-specific parts of the i2c and spi core.

The series looks good. Few nitpicks in the comments of corresponding
patches though.
FWIW:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

>
> Here is an example .dsl for an SPI accelerometer connected to minnowboard max:
>
> Device (ACCL)
> {
>     Name (_ADR, Zero)
>     Name (_HID, "PRP0001")
>     Name (_UID, One)
>
>     Method (_CRS, 0, Serialized)
>     {
>         Name (RBUF, ResourceTemplate ()
>         {
>             SPISerialBus(1, PolarityLow, FourWireMode, 16,
>                     ControllerInitiated, 1000000, ClockPolarityLow,
>                     ClockPhaseFirst, "\\_SB.SPI1",)
>             GpioInt (Edge, ActiveHigh, Exclusive, PullDown, 0x0000,
>                      "\\_SB.GPO2", 0x00, ResourceConsumer, , )
>             { // Pin list
>                     1
>             }
>         })
>         Return (RBUF)
>     }
>     Name (_DSD, Package ()
>     {
>         ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
>         Package ()
>         {
>             Package () {"compatible", "st,lis3dh"},
>         }
>     })
> }
>
> Link to v2: https://lkml.org/lkml/2016/7/13/392
> Changes:
>  * Use appropriate subject prefix for each subsystem (Mark Brown)
>  * Use ACPI info as before if getting OF info fails (Mark Brown)
>  * Minor cosmetic/readability improvements (Rafael J. Wysocki)
>
> Link to v1: https://www.spinics.net/lists/linux-acpi/msg66469.html
> Changes:
>  * Rebase on after acpi overlays got it.
>  * Change acpi_of_modalias outlen param to size_t
>  * Use {} after else
>
> Crestez Dan Leonard (3):
>   ACPI / bus: Export acpi_of_modalias equiv of of_modalias_node
>   i2c: acpi: Initialize info.type from of_compatible
>   spi: acpi: Initialize modalias from of_compatible
>
>  drivers/acpi/bus.c      | 35 +++++++++++++++++++++++++++++++++++
>  drivers/i2c/i2c-core.c  |  8 +++++++-
>  drivers/spi/spi.c       | 10 +++++++++-
>  include/acpi/acpi_bus.h |  1 +
>  4 files changed, 52 insertions(+), 2 deletions(-)
>
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
