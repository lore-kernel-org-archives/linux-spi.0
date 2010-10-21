From: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Subject: Re: [PATCH v3 00/12] tnetv107x ssp driver stack
Date: Thu, 21 Oct 2010 15:59:02 -0700
Message-ID: <20101021155902.b9702f72.akpm@linux-foundation.org>
References: <1287694873-12904-1-git-send-email-cyril@ti.com>
	<87mxq7p4hv.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org,
	dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org,
	Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lrg-kDsPt+C1G03kYMGBc/C6ZA@public.gmane.org
To: Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <87mxq7p4hv.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 21 Oct 2010 15:26:04 -0700
Kevin Hilman <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> wrote:

> Cyril Chemparathy <cyril-l0cyMroinI0@public.gmane.org> writes:
> 
> > TI's sequencer serial port (TI-SSP) is a jack-of-all-trades type of serial port
> > device.  It has a built-in programmable execution engine that can be programmed
> > to operate as almost any serial bus (I2C, SPI, EasyScale, and others).
> 
> Andrew, looking for some advice here...
> 
> This is a piece of davinci hardware, but introduces drivers in various
> subsystems.  I'm willing to merge this series via the davinci tree after
> getting acks from the various subsystem maintainers.  Is this an OK
> approach?  It seems best to me to merge this all together.

Yes, that's the best approach.

Some of the desired acks may not be forthcoming.  In which case the
best you can do is to review the code yourself, make the maintainer(s)
aware of what's going on and just go ahead and merge it.  If people are
too busy to look at the code then so be it - we can't really permit
that problem to permanently block new drivers.

> We already have acks for the regulator and gpio driver parts, and the
> backlight driver has a clear owner in MAINTAINERS.  However, who should
> be doing the final review/ack of the drivers/misc and drivers/gpio
> changes is less clear to me.  
> 

I'll go and have a look at drivers/misc/ti_ssp.c.

> 
> Thanks,
> 
> Kevin
> 
> >  arch/arm/mach-davinci/board-tnetv107x-evm.c    |  199 +++++++
> >  arch/arm/mach-davinci/devices-tnetv107x.c      |   25 +
> >  arch/arm/mach-davinci/include/mach/ti_ssp.h    |   98 ++++
> >  arch/arm/mach-davinci/include/mach/tnetv107x.h |    2 +
> >  arch/arm/mach-davinci/tnetv107x.c              |    2 +-
> >  drivers/gpio/Kconfig                           |   10 +
> >  drivers/gpio/Makefile                          |    1 +
> >  drivers/gpio/ti-ssp-gpio.c                     |  200 +++++++
> >  drivers/misc/Kconfig                           |   11 +
> >  drivers/misc/Makefile                          |    1 +
> >  drivers/misc/ti_ssp.c                          |  436 +++++++++++++++
> >  drivers/regulator/Kconfig                      |   10 +
> >  drivers/regulator/Makefile                     |    1 +
> >  drivers/regulator/tps6524x-regulator.c         |  692 ++++++++++++++++++++++++
> >  drivers/spi/Kconfig                            |    7 +
> >  drivers/spi/Makefile                           |    1 +
> >  drivers/spi/spi_ti_ssp.c                       |  397 ++++++++++++++
> >  drivers/video/backlight/Kconfig                |    7 +
> >  drivers/video/backlight/Makefile               |    2 +-
> >  drivers/video/backlight/tps6116x.c             |  340 ++++++++++++

------------------------------------------------------------------------------
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store 
http://p.sf.net/sfu/nokia-dev2dev
