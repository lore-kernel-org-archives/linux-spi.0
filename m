From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: mmc_spi issues
Date: Thu, 3 Jan 2008 09:49:55 -0800
Message-ID: <200801030949.55373.david-b@pacbell.net>
References: <b47ad75d0801030129p548151eeq78af47024e6f224b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <b47ad75d0801030129p548151eeq78af47024e6f224b-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Thursday 03 January 2008, Gernot Kvas wrote:
> Hello,
> 
> I have implemented a DMA/PIO driven SPI driver for the ARM based
> ns9xxx SoCs, largely based on the driver for the omap2. I'm using the
> mmc_spi stuff from the mm patches, currently 2.6.23-mm1.

ISTR some initial merge glitches, but maybe they were gone by then.
I'd still recommend using more current code; especially with the
2.6.24 release nearly upon us.  :)


>		 Apart from a 
> small patch to the UNSTUFF_BITS macro in drivers/mmc/core/mmc.c to
> resolve some endianess issues, it works like a charm (for reading).
> The card gets properly detected, I can mount it and read files from it
> at a decent speed.

That's good to know!


> However, when I try to write to it, it fails. I used a scope to
> monitor all 4 lines and discovered that after a CMD25 or CMD24, a

That is, after WRITE_MULTIPLE_BLOCK or WRITE_BLOCK ...


> subsequent CMD25 or CMD24 would fail. Both commands expect a R1
> response, 8-bits. However, prior to what looks like a 8-bit response,
> I read a couple of 0xFF (which is normal) and then suddenly a 0xFE. It
> seems as if the card goes low too early. Any ideas, hints?

That sounds a bit familiar.  Does that happen with all cards, or
just with ones from one particular vendor?  Is that driver version
using SPI_MODE_0 or SPI_MODE_3?

And is your SPI controller driver keeping chipselect low during
that whole period?

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
