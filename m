From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 0/3] Init device ids from ACPI of_compatible
Date: Wed, 13 Jul 2016 14:09:30 +0200
Message-ID: <CAJZ5v0hzEfZC5RSEhA64vHAqJtsTuqqSDn2RzuQUTaGEDBaF3Q@mail.gmail.com>
References: <cover.1468409668.git.leonard.crestez@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: ACPI Devel Maling List <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>,
	Jarkko Nikula <jarkko.nikula-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-i2c <linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Octavian Purdila <octavian.purdila-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Crestez Dan Leonard <leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1468409668.git.leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jul 13, 2016 at 1:53 PM, Crestez Dan Leonard
<leonard.crestez-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> When using devicetree stuff like i2c_client.name or spi_device.modalias
> is initialized to the first DT compatible id with the vendor prefix
> stripped. Since some drivers rely on this in order to differentiate between
> hardware variants try to replicate it when using ACPI with DT ids.
>
> This also makes it so that the i2c_device_id parameter passed to probe is
> non-NULL when matching with ACPI and DT ids.
>
> These patches are on top of linux-pm/linux-next. I delayed v2 until ACPI
> overlays got in in order to avoid conflicts. I tested using ACPI overlays but
> there is no actual dependency. This series just extends the PRP0001 feature to
> be more useful for I2C/SPI.
>
> The patches only touches the ACPI-specific parts of the i2c and spi core.
>
> Here is an example .dsl for an SPI accelerometer connected to minnowboard max:
>
> Device (ACCL)
> {
>     Name (_ADR, Zero)
>     Name (_HID, "PRP0001")
>     Name (_CID, "PRP0001")

This is bad ASL.

Generally, it is a bug to use the same device ID in both _HID and
_CID.  It will work, but it is incorrect.

Thanks,
Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
