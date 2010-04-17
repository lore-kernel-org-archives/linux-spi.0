From: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH v3 0/2] spi: driver for
	Cirrus	EP93xx SPI controller
Date: Sat, 17 Apr 2010 07:59:13 +0300
Message-ID: <20100417045913.GA19534@gw.healthdatacare.com>
References: <cover.1271156934.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636D710785@AUSP01VMBX24.collaborationhost.net>
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
In-Reply-To: <0D753D10438DA54287A00B0270842697636D710785-gaq956PjLg32KbjnnMDalRurcAul1UnsRrxOEX5GOmysTnJN9+BGXg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Apr 16, 2010 at 01:28:05PM -0500, H Hartley Sweeten wrote:
> 
> I finally was able to get this working on my system.  Not sure what the issue
> was earlier.

Great :)

> The only thing I don't like right off hand is the chip select handling.
> 
> The way it currently is done you are limited to using only the built-in GPIO's
> of the EP93xx.  This prohibits a system from using an external i2c/spi/etc.
> gpio expander to provide more chip selects.  And if a platform is not setup
> correctly, the BUG_ON in cs_to_gpio in your example for the tx72xx is pretty
> nasty.

Yes the example was just a hack.

However, I'm not sure what you mean by limited only to built-in GPIOs? Currently
the driver does:

        info->cs_control(spi->chip_select, value, info->data);

when it wants to assert/deassert the chip select. I don't see how this is
limited to built-in GPIOs only (maybe I'm missing something). Now it is in
responsibility of platform board files to allocate necessary chipselect lines,
and translate 'spi->chip_select' and 'value' to something meaningful.

> Ryan and I worked out a runtime setup/cleanup for the spi device chip selects
> in the spi driver I have in my tree.  I will take a look at it and see how
> much trouble it will be to implement in your driver.

Ok.

> Anyway, now that I have your driver functioning I will be able to actually
> provide some feedback to you.

That sounds good.

Thanks,
MW

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
