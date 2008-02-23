From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: 2006/1/28 patches to pxa2xx-spi in 2.6.25
	tree
Date: Fri, 22 Feb 2008 18:44:03 -0800
Message-ID: <200802221844.03971.david-b@pacbell.net>
References: <47B4B67B.3010601@whoi.edu>
	<E913911567467945BBEB9277E27868B0880975@msiexch01.marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, stephen-nl6u4wocdmy51APUEpUfAkEOCMrvLtNR@public.gmane.org
To: "Eric Miao" <ymiao3-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E913911567467945BBEB9277E27868B0880975-3TKN+kxLw8+HXkj8w7BxOhL4W9x8LtSr@public.gmane.org>
Content-Disposition: inline
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

On Thursday 14 February 2008, Eric Miao topquoted (sigh):

> 2. This patch is one of the series of patches refactoring PXA/ARM SSP
> code, and the other patches are tightly PXA/ARM related, and David
> reviewed part of the patch if not all.

I skimmed that bit.  Time to track all the details of the PXA overhaul
is lacking.


> And indeed yes, I will fire another patch correcting the doc, maybe
> after another round of SSP code clean-up.

That doc update should happen before 2.6.25-final ...


> > From: Ned Forrester [mailto:nforrester-/d+BM93fTQY@public.gmane.org]
> > 
> > I wonder if you have seen the two patches submitted by Eric Miao that
> > appeared in the 2.6.25 git tree on 1/26/08 for drivers/spi/pxa2xx-spi.c
> > and related files.  ...
> >
> > Are these changes compatible with the grand scheme of things?  I don't
> > have much visibility of the direction in which the kernel or the spi
> > core is heading, so I can't tell.

It's more "PXA overhaul" stuff.  The *SSP modules should become more
generally usable, not unlike what drivers/misc/atmel-ssc.c does, so
that they can easily be used for SPI, I2S, or whatever.  It'd probably
be good to have a dma-capable core, for example, that gets re-used.

- Dave


> > Eric:
> > 
> > It seems there should have been a related patch to
> > Documentation/spi/pxa2xx to change the examples for platform setup,
> > along the lines of what your patch calls for in
> > arch/arm/mach-pxa/lubbock.c, and to add information about struct ssp_device.
> > 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
