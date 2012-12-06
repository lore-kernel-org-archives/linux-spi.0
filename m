From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] ARM: Kirkwood: Add SPI_CHPA and SPI_CPOL support to
	spi-orion
Date: Thu, 06 Dec 2012 23:23:05 +0000
Message-ID: <20121206232305.719E23E0B24@localhost>
References: <20121121192335.GA14868@obsidianresearch.com>
	<20121206142521.4185A3E0948@localhost>
	<20121206172504.GB9676@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20121206172504.GB9676-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 6 Dec 2012 10:25:04 -0700, Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org> wrote:
> On Thu, Dec 06, 2012 at 02:25:21PM +0000, Grant Likely wrote:
> > On Wed, 21 Nov 2012 12:23:35 -0700, Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org> wrote:
> > > Support these transfer modes from the SPI layer by setting
> > > the appropriate register bits before doing the transfer.
> > > 
> > > This was tested on the Marvell kirkwood SOC that uses this driver.
> > 
> > Woo! a note about how it was tested. I can't (and often don't) see
> > enough of these.  :-)
> 
> Thanks for looking at this Grant,
> 
> But I think that Jason's comment (see
> https://patchwork.kernel.org/patch/1782061/) is valid.
> 
> This will likely switch all current users from using 'whatever the
> firmware left behind' to 'whatever the kernel default is' - which will
> surely break something here and there??

Hmmm. Hard to say. Just the fact that existing users are depending on
little more than dumb luck that firmware touched the SPI is worrysome.

> I was thinking of a transitory patch that did:
> 
> reg = readl(spi_reg(orion_spi, ORION_SPI_IF_CONFIG_REG));
> nreg = reg & ~ORION_SPI_MODE_MASK;
> if (spi->mode & SPI_CPOL)
> 	nreg |= ORION_SPI_MODE_CPOL;
> if (spi->mode & SPI_CPHA)
> 	nreg |= ORION_SPI_MODE_CPHA;
> #ifdef TRANSITION
>  if (nreg != reg)
>         dev_error(..,"Not allowing a SPI mode change away from firmware
>  defaults. Board support needs to be updated!");
> #else
>  writel(nreg, spi_reg(orion_spi, ORION_SPI_IF_CONFIG_REG));
> #endif

Don't make this a #ifdef. Instead, you could add a property to the
device tree to enable the new behaviour... although DT support is brand
new, so you don't need to worry about the legacy scenario for DT users.
Just turn it on.

For platform_data configuration, you might want to enable it with a
flag. Whatever you decide send me a fixup patch against linux-next.

g.

------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
