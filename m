From: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] spi: Check conflicting CS based on spi->chip_select
 instead of device name
Date: Thu, 9 Jan 2014 18:05:05 +0200
Message-ID: <20140109160505.GC2494@intel.com>
References: <1389273835-8615-1-git-send-email-mika.westerberg@linux.intel.com>
 <52CEAB4A.605@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <52CEAB4A.605-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Jan 09, 2014 at 03:59:38PM +0200, Jarkko Nikula wrote:
> On 01/09/2014 03:23 PM, Mika Westerberg wrote:
> >Commit e13ac47bec20 (spi: Use stable dev_name for ACPI enumerated SPI
> >slaves) changed the SPI device naming to be based on ACPI device name
> >instead of carrying bus number and chip select for devices enumerated
> >from ACPI namespace.
> >
> >In case of a buggy BIOS that lists multiple SPI devices sharing the same
> >chip select (even though they should use different) the current code fails
> >to detect that and allows the devices to be added to the bus.
> >
> >Fix this by walking through the bus and comparing spi->chip_select instead
> >of device name. This should work regardless what the device name will be in
> >future.
> >
> >Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> >Signed-off-by: Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> >---
> >  drivers/spi/spi.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> >
> >diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> >index 349ebba4b199..13dcc360bde6 100644
> >--- a/drivers/spi/spi.c
> >+++ b/drivers/spi/spi.c
> >
> I guess this is a valid fix in that sense that before my patch those
> ill-defined SPI devices were not added. Is this something which
> should go to 3.13?

This is pretty rare case so I wouldn't expect any current HSW machines for
example to have such bugs. I'm not even sure if the SPI bus on LPSS is used
anywhere outside Intel currently.

However, we happen to have few development machines here where this bug
exists.

Up to Mark to decide whether this is urgent enough to be included in 3.13.

> Acked-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>

Thanks.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
