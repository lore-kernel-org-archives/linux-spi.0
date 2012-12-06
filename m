From: Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>
Subject: Re: [PATCH] ARM: Kirkwood: Add SPI_CHPA and SPI_CPOL support to
	spi-orion
Date: Thu, 6 Dec 2012 16:49:17 -0700
Message-ID: <20121206234917.GF25069@obsidianresearch.com>
References: <20121121192335.GA14868@obsidianresearch.com>
	<20121206142521.4185A3E0948@localhost>
	<20121206172504.GB9676@obsidianresearch.com>
	<20121206232305.719E23E0B24@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121206232305.719E23E0B24@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Dec 06, 2012 at 11:23:05PM +0000, Grant Likely wrote:

> > This will likely switch all current users from using 'whatever the
> > firmware left behind' to 'whatever the kernel default is' - which will
> > surely break something here and there??
> 
> Hmmm. Hard to say. Just the fact that existing users are depending on
> little more than dumb luck that firmware touched the SPI is worrysome.

It isn't entirely dumb luck, all the DT files I looked at were using
SPI to connect to FLASH, so the boot firmware will have to set the SPI
bus properly since it is executing out of the SPI boot flash.

At the very least, if it breaks it will be of the very obvious 'boot
from flash is completely broken' sort.

> For platform_data configuration, you might want to enable it with a
> flag. Whatever you decide send me a fixup patch against linux-next.

Okay, I think instead of the #ifdef a test for 'dev->ofdev == NULL'
would do the trick for now, then at least people can test the DT vs
the platform boot.

I am hoping to have time to revise patches on Friday, I will see.

Jason: Do you have any of these possibly affected boards with a SPI
flash to test linux-next? dove, dreamplug, ts219 and lsxl

Thanks,
Jason

------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
