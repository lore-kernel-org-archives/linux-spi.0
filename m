From: Harald Welte <laforge-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 7/12] neo1973: JBT6K74 LCM
	control	interface driver
Date: Wed, 19 Dec 2007 10:57:21 +0100
Message-ID: <20071219095721.GU29882@prithivi.gnumonks.org>
References: <20071218110800.GN29882@prithivi.gnumonks.org>
	<20071218235954.5351225EA51@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20071218235954.5351225EA51-ZcXrCSuhvln6VZ3dlLfH/g4gEjPzgfUyLrfjE7I9kuVHxeISYlDBzl6hYfS7NtTn@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi David,

thanks for your feedback.

On Tue, Dec 18, 2007 at 03:59:54PM -0800, David Brownell wrote:

> > +config SPI_SLAVE_JBT6K74
> > +	tristate "tpo JP6K74 LCM ASIC control interface"
> > +	depends on SPI_MASTER && SYSFS
> > +	help
> > +	  Driver for the tpo JP6K74-AS LCM SPI control interface.
> 
> It's not a slave-side driver though ... it's a master-side driver,
> depending on SPI_MASTER, and making bus master calls like spi_write().

I'm sorry, I must have misread/misinterpreted the terminology then. 

I thought master is the master controller driver, and 'slave driver' is
the driver for an SPI slave attached to that master.

However, you seem to intend the names as 'slave driver' == driver for an
SPI unit running in slave mode on the Linux-controlled CPU/SoC itself.
Correct?

> I think the Kconfig could stand to be more informative too.  "LCM" is
> as cryptic as "tpo", 

LCM == LCD Module.  I will expand that abbreviation in my patchset.

TPO == Name of the manufacturer. I think one of the biggest display
manufacturers in the hardware world (http://www.tpo.biz/) producing
about 17 Million LCD displays per month.  I can't rename or explain the
manufacturer.  What is your suggestion for this?

> there's no clue about what is controlled (SPI?),

I thought "LCM SPI control interface" is quite explicit.  Many modern
LCM's (especially the small-size models for embedded devices) have a SPI
control interface in addition to the actual RGB data interface.  The
control interface is used for power management, gamma calibration as
well as video timing configuration.

> and the symbols are internally inconsistent:  "JBT" != "JP", etc

That's my mistake, JBT is correct.

> So after I get you any technical comments, I'll want a new patch
> with Kconfig and Makefile updates going in the proper place.  (I'm
> not sure I'll have many technical comments.)

Ok, I'll wait for further comments before re-submitting.
-- 
- Harald Welte <laforge-4Bgg8jF3iZdg9hUCZPvPmw@public.gmane.org>          	        http://openmoko.org/
============================================================================
Software for the world's first truly open Free Software mobile phone

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
