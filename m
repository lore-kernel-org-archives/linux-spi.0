From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: s3c24xx SPI without Bitbang interface?
Date: Thu, 2 Jul 2009 18:43:22 -0700
Message-ID: <200907021843.22688.david-b@pacbell.net>
References: <1b68c6790906291827i1f7bce49q520e9950ba623e9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: jassi brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1b68c6790906291827i1f7bce49q520e9950ba623e9d-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Monday 29 June 2009, jassi brar wrote:
> Hello,
>   I see drivers/spi/spi_s3c24xx.c uses bitbang i/f eventhough 24xx has a
> dedicated SPI controller. Wasn't bitbang is supposed to be for SOCs which
> don't have a SPI controller.

Yes and no.  The framework is a bit more general than that;
have a look at the spi_bitbang.c code.  The lowest level
has various options for per-word I/O, with bitbanging as
the default; but you can use hardware shift registers too,
if you like.  And some folk *do* like.

It turns out to be handy to get a driver working quickly,
when "have it working yesterday" is more important than
just "have it working really fast".


>  I was wondering why cudn't we make it work without the Bitbang abstraction?
> Any potential issues that I am failing to fathom?
> And, s3c24xx.c doesn't make use of DMA. Any particular reason against it?

I don't know those s3c parts, but I'd presume the main
reasons boil down to nobody spending time to create a
speedy DMA-centric driver.

- Dave


------------------------------------------------------------------------------
