From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Linux, AT91RM9200 and SPI
Date: Thu, 31 Jan 2008 15:41:04 -0800
Message-ID: <200801311541.04933.david-b@pacbell.net>
References: <85a5c2010801311409l437bdd4fla276a295e5c0bfc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <85a5c2010801311409l437bdd4fla276a295e5c0bfc4-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Thursday 31 January 2008, Matt Gessner wrote:
> Hello,
> 
> I last worked with 2.6.20 with patches from maxim for this processor.
> At the time, user space access to the SPI bus (like /dev/spi-0) wasn't
> working.  Does it work now?  I'm asking because I didn't want to have
> to go through the 30 or so Changelogs; I thought someone might know
> off the top of their head.

See Documentation/spi/spidev ... but be aware that even the latest
code probably still has issues with nCS0 because of hardware errata
on the rm9200 chips.

There are some SPI patches due to move upstream that should help that
a bit, but I don't think there's a complete solution yet ... short of
using the bitbang code I reposted to the ARM list within the last
month or so.

(ALSO:  don't cross-post to the ARM list.)

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
