From: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH 2/3] ep93xx: added chip revision
	reading function
Date: Tue, 16 Mar 2010 08:11:19 +0200
Message-ID: <20100316061119.GC12813@gw.healthdatacare.com>
References: <cover.1268669236.git.mika.westerberg@iki.fi>
	<774b9c08b6e9484a2ca5084b8b6019aa18dddd99.1268669236.git.mika.westerberg@iki.fi>
	<3d93e748eb068963a9378b454ba9cd117cbbc737.1268669236.git.mika.westerberg@iki.fi>
	<56d259a01003151244l352eeb50p95e97912b3df159a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Martin Guy <martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56d259a01003151244l352eeb50p95e97912b3df159a-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Mar 15, 2010 at 07:44:27PM +0000, Martin Guy wrote:
> Hi Mika, thanks, great work
> 
> On 3/15/10, Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org> wrote:
> > Added a new function: ep93xx_chip_revision() which reads chip revision from the
> >  sysconfig register.
> >
> >  + * %EP93XX_CHIP_REV_D0
> >  + * %EP93XX_CHIP_REV_D1
> >  + * %EP93XX_CHIP_REV_E0
> >  + * %EP93XX_CHIP_REV_E1
> >  + * %EP93XX_CHIP_REV_E2
> >  + *
> >  + * and in future maybe something else. See also <mach/platform.h>.
> 
> There will be no future revisions, if that's what you mean. Cirrus
> dropped out of the ARM business and discontinued development of this
> product line on 1st April 2008 so E2 is the last.

That's what I meant and I didn't know that :(

I will update the comment in next series.

Thanks,
MW

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
