From: Martin Guy <martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v7 1/2] spi: implemented driver for
	Cirrus EP93xx SPI controller
Date: Sun, 9 May 2010 17:47:34 +0100
Message-ID: <AANLkTiks2l9N1uXisctdI3aiNmFavIHzvwbOTcgeFGbZ@mail.gmail.com>
References: <cover.1273120206.git.mika.westerberg@iki.fi>
	<3729cd3650f5af6aebfc5bae02ff6aad1b9b1e82.1273120206.git.mika.westerberg@iki.fi>
	<AANLkTimZywbu5KVvnUouLUoY1GUxWGlYoSgIbUlRDT5w@mail.gmail.com>
	<20100509092917.GR26418@gw.healthdatacare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org,
	ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100509092917.GR26418-WfG2TfFPcQ9S6P4I59wummXnswh1EIUO@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 5/9/10, Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org> wrote:
> On Sat, May 08, 2010 at 06:32:47PM +0100, Martin Guy wrote:
>  > On 5/6/10, Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org> wrote:
>  > > This patch adds an SPI master driver for the Cirrus EP93xx SPI controller found
>  > >  in EP93xx chips.
>
> >    I'm confused by the change in this version of the structure of the
>  > board setup code.
>
>  For Sim.One, I modified your patches a bit and resulting patch is
>  included. Note that I have hooked EGPIO9 as a chip select but in
>  normal case (SFRMOUT) you can just do following (leave .controller_data
>  as NULL):

Many thanks. If you want to submit this to mainline there are just a
couple of changes to make:

> +#define MMC_CHIP_SELECT_GPIO EP93XX_GPIO_LINE_EGPIO9

EGPIO9 is part of the keyboard controller - I don't think we can
hijack that for a patch to the mainline kernel! I've used EGPIO15
which is unused and on TP17 just south of the CPU.

>                 .mode                   = SPI_MODE_0,

Using SPI_MODE_3 increases the read speed from 319 kB/s to 367 kB/s -
even when using a GPIO as the chip select.

Your 4GB card fix works here too, though I'm seeing no difference in
anything between using SFRMOUT and a GPIO for the chip select. Did you
see any functionality or performance improvements using a GPIO for CS
with the SD cards you are testing?

Thanks again

    M

------------------------------------------------------------------------------
