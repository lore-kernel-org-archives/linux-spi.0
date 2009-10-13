From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/3 v3] spi: controller driver for
 Designware SPI core and PCI interface
Date: Tue, 13 Oct 2009 10:04:20 +0800
Message-ID: <20091013100420.71adb1f1@feng-desktop>
References: <20091012141716.1179d496@feng-desktop>
	<20091012152553.c95d8055.akpm@linux-foundation.org>
	<20091013093649.512a0939@feng-desktop>
	<20091012185327.db69d78e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20091012185327.db69d78e.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, 13 Oct 2009 09:53:27 +0800
Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org> wrote:

> > > > 
> > > > 0003 is RFC only, as it has dependency over DMA controller
> > > > driver's acceptance to mainline.
> > > 
> > > What is "DMA controller driver"?  Some other patch?  What is the
> > > status of that patch and where is it?
> > > 
> > Yes, it's another driver patch for DMA controller of Moorestown,
> > which is developed by another guy. I don't know if he has submitted
> > the patch to community (I guess not), though we did test the
> > SPIC+DMAC+3G-Modem.
> 
> So am I correct in believing that your "0003: add DMA support" doesn't
> actually work?  That it depends on some other patch which is
> unavailable to testers and reviewers and patch integrators?

Yes, it's fair enough to not trust the 0003 patch and remove it from mm
tree :) That's why I added a [RFC] for it.

Also many thanks for reviewing the patches, they have been not receiving
any comments for a while.

Thanks,
Feng

> 
> Strange.

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
