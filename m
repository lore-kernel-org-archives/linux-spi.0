From: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH v3 0/2] spi: driver for
	Cirrus	EP93xx SPI controller
Date: Mon, 19 Apr 2010 20:44:46 +0300
Message-ID: <20100419174446.GH19534@gw.healthdatacare.com>
References: <cover.1271156934.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D710785@AUSP01VMBX24.collaborationhost.net>
	<20100417045913.GA19534@gw.healthdatacare.com>
	<0D753D10438DA54287A00B0270842697636D78D9CF@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0D753D10438DA54287A00B0270842697636D78D9CF-gaq956PjLg32KbjnnMDalRurcAul1UnsRrxOEX5GOmysTnJN9+BGXg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Apr 19, 2010 at 12:04:30PM -0500, H Hartley Sweeten wrote:
> On Friday, April 16, 2010 9:59 PM, Mika Westerberg wrote:
...
> > when it wants to assert/deassert the chip select. I don't see how this is
> > limited to built-in GPIOs only (maybe I'm missing something). Now it is in
> > responsibility of platform board files to allocate necessary chipselect lines,
> > and translate 'spi->chip_select' and 'value' to something meaningful.
> 
> The way you are currently handling the chip select limits you to the built-in
> GPIO's because the 'gpio_request' happens early in the platform init before any
> external gpio expanders might be available.
> 
> The best example is if your first SPI device is actually a GPIO expander that
> is chip selected by a built-in GPIO.  This GPIO expander is then used to provide
> the chip selects for additional SPI devices on the bus.

Ok.. got it. I didn't consider that one.

> >> Ryan and I worked out a runtime setup/cleanup for the spi device chip selects
> >> in the spi driver I have in my tree.  I will take a look at it and see how
> >> much trouble it will be to implement in your driver.
> >
> > Ok.
> 
> I have a patch almost working.
> 
> Have you had time to implement any of the changes that Grant Likely proposed?

Mostly yes. I'm still considering whether I should drop the polling mode.

> One of them dealt with the ep93xx_spi_{de}select_device functions.  Before I
> post my proposed changes I would like to make sure it is based on your most
> current code.

I changed chipselect functions to be something like (espi->cs_control is copied
from info structure):

        if (espi->cs_control)
                espi->cs_control(spi->chip_select, !!(spi->mode & SPI_CS_HIGH),
                                 espi->cs_data);

I'm not exactly sure whether this is what Grant meant, however.

> BTW, my patch will also handle Martin Guy's issue with using a null chip select.

Yeah. I also have that fixed.

Do you want me to send next revision so that you can base your proposed changes
on top of that or how to proceed?

> Actually, the chip-select isn't really null since the SFRMOUT line is still
> asserted (active-low) during any SPI transfer but the effect is still the same.

Too bad that SFRMOUT cannot be used as GPIO, we could then use it as proper
software controlled chipselect ;)

Thanks,
MW

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
