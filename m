From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH RESEND] spi: spidev: Allow matching DT compatible strings
 from ACPI
Date: Tue, 28 Jun 2016 12:22:34 +0300
Message-ID: <20160628092234.GG1711@lahna.fi.intel.com>
References: <1467027248-6191-1-git-send-email-mika.westerberg@linux.intel.com>
 <20160627122448.GU28202@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160627122448.GU28202-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Jun 27, 2016 at 01:24:48PM +0100, Mark Brown wrote:
> On Mon, Jun 27, 2016 at 02:34:08PM +0300, Mika Westerberg wrote:
> 
> > Allow the same devices to be used in ACPI based systems if they provide
> > proper DT compatible string.
> 
> Please allow a reasonable time for review, especially for an invasive
> change like this which needs a bunch of research to figure out how
> sensible the infrastructure to shove DT into ACPI is.

Sure.

Can I ask your opinion regarding an alternative approach to this?

Instead of adding these "pseudo", Linux specific devices to DT or ACPI
to support raw SPI access, what if we amend spidev a bit:

  - Introduce CONFIG_SPI_SPIDEV_MASTER which is part of spidev.c
    and can be selected separately.

  - If that option is set we create /dev/spi-<bus_num> for each SPI
    master.

  - Introduce two new ioctls SPI_IOC_RD/WR_CS which allow setting
    of chip select.

The /dev/spi-0 then can be used analogous to /dev/i2c-0. You first need
to program wanted chip select using those new ioctls. Then you can use
the device as normal spidev (all existing file operations and ioctls
still work). You can pick another chip select as needed. If there is an
actual SPI device bound to a chip select, that cannot be used through
/dev/spi-0.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
