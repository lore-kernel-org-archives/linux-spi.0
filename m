From: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: Re: [PATCH 1/2] spi/spi_s3c64xx: Make probe
 more robust against missing board config
Date: Mon, 23 Aug 2010 10:57:22 +0100
Message-ID: <20100823095722.GA6061@rakim.wolfsonmicro.main>
References: <1282321028-32196-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<AANLkTimggbZqgv=eKe+wx8YvUX5vOppDfmwpLwTgxJFM@mail.gmail.com>
	<20100821100855.GA5545@opensource.wolfsonmicro.com>
	<AANLkTikbGR4wWUEHjR74UFu8P-w9us3ZpKgmG+yDukfC@mail.gmail.com>
	<20100821193015.GA16455@opensource.wolfsonmicro.com>
	<AANLkTikDj7YsOQXnFGjZCNRYuQQbLRtKiWw5Sm=vkCuq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTikDj7YsOQXnFGjZCNRYuQQbLRtKiWw5Sm=vkCuq-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Aug 22, 2010 at 12:37:25PM +0900, Jassi Brar wrote:

> An immediate kernel crash ? :)
> I mean if the developer didn't even run-check the board init code, he oug=
ht
> to face a kernel crash.
> On a more lenient note, probably a check like yours or !sci->num_cs
> could be added.

I'd personally not actually be that upset with a BUG_ON(), my main
reason for changing the code was that it was non-obvious what the source
of the error was rather than the fact that things fell over.

> > It did occur to me that a nice way of dealing with this would be to have
> > the driver default to using the built in chip select (even if driven as
> > a GPIO for the sake of code simplicity) but leave the current method
> > there as an override. =A0That way if people are using the IP block in t=
he
> > "natural" manner they'd have less to set up.

> I thought about it but decided against it, for that would complicate the
> driver by having to switch between two mechanism in runtime and there
> are some peculiarities in the controller about clocking and CS'ing.

Yeah, that's why I suggested driving it as a GPIO for simplicity - from
the user point of view it doesn't matter if that's what the controller
does so long as the driver figures out the chip select without external
help.

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =
