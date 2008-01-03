From: "Gernot Kvas" <gernot.kvas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: mmc_spi issues
Date: Thu, 3 Jan 2008 20:42:27 +0100
Message-ID: <b47ad75d0801031142x5d550e43r77d19eafe8b92973@mail.gmail.com>
References: <b47ad75d0801030129p548151eeq78af47024e6f224b@mail.gmail.com>
	<200801030949.55373.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200801030949.55373.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

2008/1/3, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>:
> On Thursday 03 January 2008, Gernot Kvas wrote:
> > I have implemented a DMA/PIO driven SPI driver for the ARM based
> > ns9xxx SoCs, largely based on the driver for the omap2. I'm using the
> > mmc_spi stuff from the mm patches, currently 2.6.23-mm1.
>
> ISTR some initial merge glitches, but maybe they were gone by then.
> I'd still recommend using more current code; especially with the
> 2.6.24 release nearly upon us.  :)

I'm looking forward to 2.6.24. Anyone volunteered to implement the
spi-subsystem primitives to allowed mmc_spi on a shared bus?

> > subsequent CMD25 or CMD24 would fail. Both commands expect a R1
> > response, 8-bits. However, prior to what looks like a 8-bit response,
> > I read a couple of 0xFF (which is normal) and then suddenly a 0xFE. It
> > seems as if the card goes low too early. Any ideas, hints?
>
> That sounds a bit familiar.  Does that happen with all cards, or
> just with ones from one particular vendor?  Is that driver version
> using SPI_MODE_0 or SPI_MODE_3?

It should be using SPI_MODE_0. As far as I can remember on the scope
traces, that should be true.

> And is your SPI controller driver keeping chipselect low during
> that whole period?

I tried it both with a toggling chipselect (which would be the
default, as the ns9xxx toggles if you write bytewise and as I
suspected this, I manually changed the chipselect in a driver
callback. No change, even with the chipselect low over the entire
period.

I only have cards from that manufacturer to try out, however, I will
have access to an older card at the weekend to try that out.

Cheers,

Gernot

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
