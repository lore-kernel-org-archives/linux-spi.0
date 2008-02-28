From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [Uclinux-dist-devel] spi_mmc bus
	concurrency fix
Date: Wed, 27 Feb 2008 22:04:18 -0800
Message-ID: <200802272204.18856.david-b@pacbell.net>
References: <47C42D50.7020204@rubico.se>
	<200802270159.33231.david-b@pacbell.net>
	<386072610802272023o71b99c2bn4d28547bd8783c9c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org,
	Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "Bryan Wu" <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <386072610802272023o71b99c2bn4d28547bd8783c9c-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Wednesday 27 February 2008, Bryan Wu wrote:
> On Wed, Feb 27, 2008 at 5:59 PM, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wro=
te:
> > > >  To speak my mind, i feel i am imposed a troublesome messaging sche=
me
> >  > >  from the SPI framework. Maybe it has to do with buggy controller,
> >  > >  controller driver, buggy chips with erratas longer than the refer=
ence
> >  > >  manual. Well, wont rant about that right now. Need to solve this =
problem
> >  > >  instead.
> >
> >  We sort of lack a testing framework for SPI master drivers.  The best
> >  solution for now seems to be to make sure several existing drivers
> >  work with it ...
>  =

> I remember some LTP guys are developing bus driver testing case such
> as i2c, spi ,etc, but don't know the detail.

When I did it for USB, I essentially defined a "golden device" that could
be the target of such testing.  Easy to do with various microcontrollers
with I2C; a bit less so with SPI, because you'd also want to test higher
data rates than most micros like.


> For the testing of Blackfin, we tested SPI touchscreen, SPI
> joystick, SPI flash and a SPI MMC driver over SPI framework.

Better coverage than many systems.  :)


> >  > >  I hope to make the block writing  working this
> >  > >  weekend. I need to make it work since we want to use the inexpens=
ive
> >  > >  BF532 chip + SPI ethernet + MMC/SD for storage in a product.
> >  > >
> >  > >  I=B4ll commit my result to the drivers/mmc/spi_mmc, even though i=
ts
> >  > >  obsolete maybe the mainline driver developers can make use of my =
progress.
> >  >
> >  > sounds great !
> >
> >  The spi-devel list archives have at least one patch providing a
> >  mutual exclusion mechanism at the bus level.  One problem is that
> >  all such mechanisms evidently need controller driver changes,
> >  since they involve changing the I/O queue managemnt policy.
> >
> =

> So how about move the controller driver queue management stuff to spi-cor=
e?
> controller driver just send out data and receive data.

That can be *part* of the solution, although I'd rather see the
controller drivers talking in terms of messages:  "get me the
next message", with the core knowing how to handle things like
this exclusive-access policy.

The rest of the solution involves implementation and interface
details, including just how to gracefully migrate to that model.

The original notion was not to have any kind of mid-layer ... in
my experience they're magnets for code bloat.  But in this case
I'm not sure I see a really good solution other than that.

- Dave


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
