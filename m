From: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH v6 2/2] ep93xx: SPI driver platform
	support code
Date: Tue, 11 May 2010 09:13:02 +0300
Message-ID: <20100511061302.GW26418@gw.healthdatacare.com>
References: <cover.1272805161.git.mika.westerberg@iki.fi>
	<865b5d7ca0fae1977a1fadcdabdb715e3ea1604d.1272805161.git.mika.westerberg@iki.fi>
	<0D753D10438DA54287A00B0270842697636EB838E1@AUSP01VMBX24.collaborationhost.net>
	<20100505142625.GB2606@n2100.arm.linux.org.uk>
	<0D753D10438DA54287A00B0270842697636EE74B65@AUSP01VMBX24.collaborationhost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	"martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org" <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <0D753D10438DA54287A00B0270842697636EE74B65-gaq956PjLg32KbjnnMDalRurcAul1UnsRrxOEX5GOmysTnJN9+BGXg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, May 10, 2010 at 07:24:24PM -0500, H Hartley Sweeten wrote:
> On Wednesday, May 05, 2010 7:26 AM, Russell King wrote:
> > On Tue, May 04, 2010 at 12:21:36PM -0500, H Hartley Sweeten wrote:
> >> That patch is already present in linux-next.  If Russell think there might
> >> be an issue you could rebase this patch on the linux-next tree.
> >
> > If this patch depends on 5998/1, then I'll take it via the ep93xx branch
> > (which has 5998/1 on.)  It's only touching files in arch/arm so there
> > shouldn't be any problem with that.
> 
> 
> Mika,
> 
> Any word from the spi group on PATCH v6 1/2?

Nothing yet.

> Russell wants this patch (v6 2/2) to go through his tree, please add it to
> his patch system.  It will not be a problem if this patch goes in before the
> actual driver since nothing "breaks".  If the driver goes in first it will
> not work due to the missing clock resource, even if a user were to hack in the
> platform init code.

OK, will do that later on today.

Regards,
MW

------------------------------------------------------------------------------
