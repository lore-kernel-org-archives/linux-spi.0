From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: mmc_spi issues
Date: Mon, 7 Jan 2008 01:35:02 -0800
Message-ID: <200801070135.02953.david-b@pacbell.net>
References: <b47ad75d0801030129p548151eeq78af47024e6f224b@mail.gmail.com>
	<200801030949.55373.david-b@pacbell.net>
	<b47ad75d0801031142x5d550e43r77d19eafe8b92973@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <b47ad75d0801031142x5d550e43r77d19eafe8b92973-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
> > I'd still recommend using more current code; especially with the
> > 2.6.24 release nearly upon us. =A0:)
> =

> I'm looking forward to 2.6.24.

Get your RC7 while it's hot!  :)


> Anyone volunteered to implement the =

> spi-subsystem primitives to allowed mmc_spi on a shared bus?

My old spi_get_exclusive() and spi_put_exclusive() patch still
applies, for what it's worth ... not unlike mmc_claim_host()
and friends.

I have a prototype patch from Imre Deak that I seem to not yet
have found time to really investigate, which attaches the
exclusivity to a given spi_message.

The downside of those is they both require changes at the level
of the SPI master controller driver's queue handling.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
