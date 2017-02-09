From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH v6 0/3] Init device ids from ACPI of_compatible
Date: Thu, 09 Feb 2017 14:53:46 +0100
Message-ID: <3478468.E7ygkzlUDi@aspire.rjw.lan>
References: <1486195228-10929-1-git-send-email-dan@emutex.com> <1486312214-20770-1-git-send-email-dan@emutex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Jarkko Nikula <jarkko.nikula-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
        Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dan O'Donovan <dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1486312214-20770-1-git-send-email-dan-M3NBUjLqch7QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sunday, February 05, 2017 04:30:11 PM Dan O'Donovan wrote:
> When using devicetree, stuff like i2c_client.name or spi_device.modalias
> is initialized to the first DT compatible id with the vendor prefix
> stripped. Since some drivers rely on this in order to differentiate between
> hardware variants, try to replicate it when using ACPI with DT ids.
> 
> This also makes it so that the i2c_device_id parameter passed to probe is
> non-NULL when matching with ACPI and DT ids.
> 
> Tested using ACPI overlays but there is no actual dependency. This series
> just extends the PRP0001 feature to be more useful for I2C/SPI.
> 
> The patches only touches the ACPI-specific parts of the i2c and spi core.
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
> 	Name (RBUF, ResourceTemplate ()
> 	{
> 	    SPISerialBus(1, PolarityLow, FourWireMode, 16,
> 		    ControllerInitiated, 1000000, ClockPolarityLow,
> 		    ClockPhaseFirst, "\\_SB.SPI1",)
> 	    GpioInt (Edge, ActiveHigh, Exclusive, PullDown, 0x0000,
> 		     "\\_SB.GPO2", 0x00, ResourceConsumer, , )
> 	    { // Pin list
> 		    1
> 	    }
> 	})
> 	Return (RBUF)
>     }
>     Name (_DSD, Package ()
>     {
> 	ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> 	Package ()
> 	{
> 	    Package () {"compatible", "st,lis3dh"},
> 	}
>     })
> }
> 
> Credit to Leonard Crestez for the original version of this patch set.
> 
> Link to v5: http://www.spinics.net/lists/linux-acpi/msg71902.html
> Changes:
>  * Change formatting of arguments passed to acpi_set_modalias (Mark Brown)
> 
> Link to v4: http://www.spinics.net/lists/linux-acpi/msg71657.html
> Changes:
>  * add acpi_set_modalias wrapper to handle fallback to ACPI ID (Mark Brown)
> 
> Link to v3: http://www.spinics.net/lists/linux-acpi/msg71531.html
> Changes:
>  * Minor cosmetic/readability improvements (Andy Shevchenko)
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
> Dan O'Donovan (3):
>   ACPI / bus: Export acpi_of_modalias equiv of of_modalias_node
>   i2c: acpi: Initialize info.type from of_compatible
>   spi: acpi: Initialize modalias from of_compatible

All [1-3/3] applied.

Thanks,
Rafael

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
