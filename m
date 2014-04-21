From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: ARM: bcm2835: DMA driver + spi_optimize_message - some
 questions/info
Date: Mon, 21 Apr 2014 23:20:26 +0100
Message-ID: <20140421222026.GH12304@sirena.org.uk>
References: <43389276-E591-4E09-AB84-491C2CB2D9A7@martin.sperl.org>
 <20140402181547.GH2269@sirena.org.uk>
 <1AA37E97-BDD7-4B53-B092-18D5D7439F8B@martin.sperl.org>
 <20140403220232.GE14763@sirena.org.uk>
 <5AAD4FEA-2887-4A9D-9FE3-588210BFD1A6@martin.sperl.org>
 <20140410223531.GF6518@sirena.org.uk>
 <25BB67E3-2929-49D2-BDDE-2D6B3D43534E@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/lFFBEHT4+C4z/Jh"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
To: martin sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <25BB67E3-2929-49D2-BDDE-2D6B3D43534E-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--/lFFBEHT4+C4z/Jh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2014 at 02:40:07PM +0200, martin sperl wrote:
> On 11.04.2014 00:35, Mark Brown wrote:

> > The main thing I'd like to do is actually coalesce adjacent transfers w=
ithin
> > a message if they are compatible and we're doing DMA so we end up with =
fewer
> > hardware interactions overall. There's a fairly common pattern of writi=
ng
> > multiple registers (for firmware download or setting coefficients) wher=
e you
> > have a small transfer for a register then a larger one for a data block=
 which
> > would benefit.
>=20
> I just found out something similar just a few days ago:=20
> doing a write then read with 2+1 is more effort to handle than a read/wri=
te
> of 3 bytes and some moving of data arround. Also it actually saves memory,
> as an spi_transfer is bigger than those 3 extra bytes needed.
> With the DMA Driver this saved me 4us on overall transfer time -  It drop=
ped
> from 52us to 47us. For comparisson: the real data transfer for those 36=
=20
> bytes (without 7x CS) takes 35us - so we are pretty close to ideal...

It can be even nicer for drivers where there's some minimum limit on the
size of transfers (quite a lot of them), it can sometimes allow short
writes to be converted from being PIO to being combined with an adjacent
DMAs.  Possibly even two PIOs making a DMA, though that case is more on
the edge.

> There is not so much of a difference with the PIO drivers as they take 20=
0us
> for the same, but it sees a drop on the number of interrupts (typically=
=20
> 1 IRQ/transfer), which increases CPU availability for userspace...
> Redesigning the interrupt-handler to push bytes spanning multiple=20
> spi_transfers into the fifo together would help, but then it becomes much=
=20
> more complex - at least the spi-bcm2835 does call "complete(&bs->done);"
> when it has finished the transfer.

It's probably not worth doing unless it's factored out into the
framework and affects lots of drivers; it seems most likely to get done
as part of a general improvement in the ability to drive the queue from
interrupt context.  Most systems won't be able to do the fully DMAed
pipeline the Pi can.

> > Right, that's a peculiarity of your system (hopefully) which makes life
> > difficult for that. The Samsung controller has a vaugely similar thing
> > where the transmit interrupt goes off too early for what we want so we=
=20
> > need to ensure there's always a read if we're doing interrupts but that
> > is a lot easier to work around.

> Specs says to use 2 Interrupts one for feeding data to FIFO the other to
> read data from FIFO. Probably one could use multiple interleaved DMAs for
> reads and writes, but then you would be limited to 32 byte transfers and
> would have some "gaps" between the fifos filling/emptying - this way at=
=20
> least 65535 bytes can get sent with a single transfer...

Sure, that's standard though looking at the code in drivers it seems
there's a fairly common pattern of just ignoring one of the completions,
usually the transmit one, at the SPI level since we can guarantee that
the other will always come later.

> The interrupt DMA is more on the tricky side - if we had to have an=20
> interrupt every time an spi_message finished, it would be possible with
> 2 DMAs, but as we have the possibility of chaining multiple spi_messages
> together for higher thruput, then this "waiting" for interrupt is not
> possible (IRQ flag gets sometimes cleared by the next DMA controlblock),
> so we need to have another "stable" IRQ source and hence DMA3.
> (actually I was using the TX DMA for that, which gets started by the
> RX-DMA, so we have a race-time between DMA for IRQ and the interrupt
> handler on the CPU reading the registers quickly enough to find out the
> source of the IRQ)

I think it's worth implementing the three DMA solution as an
optimisation on the two DMA version partly to get the big part of the
win from the two DMAs integrated but also because that's going to be the
more generally useful pattern.  It also lets the tricky bit with the
extra DMA be considered separately.

> One of those found is the fact that an optimized message can only reliably
> get used with spi_async. For spi_sync use it has to have the complete
> function defined when optimizing, as it would otherwise not implement a
> callback IRQ in DMA. And then when spi_sync sets the complete function
> the DMA would still issue the optimized message without interrupts.

Hrm.  We could provide a flag saying this will be used synchronously, or
more likely given driver use patterns the other way around.  Doesn't
seem quite elegant though.  Or insert a dummy transfer (eg, some
register read) which does interrupt into the chain after the real one to
do the callback.

> > On the other hand you may find that what you've got already is enough
> > for people, or get a feel for the sort of things people are looking for
> > to show a win.  Sometimes you'll even get "oh, that's a really good idea
> > I'll just add the feature" (if you're very lucky).

> So who else should I involve as soon as I have presentable code?
> (coding standard issues I have already fixed - mostly...)

The dmaengine maintainers for the DMA stuff - Vinod Koul
<vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> and Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> - and
the GPIO maintainers for that - Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
and Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> (check MAINTAINERS).  Plus
anyone working on the drivers you modified.

> the same, but is specific to the PI...
> http://skpang.co.uk/catalog/pican-canbus-board-for-raspberry-pi-p-1196.ht=
ml

> And in both cases you probably will need a peer which accepts messages or
> sends them...

> It is a bit tricky - especially the setting up of the correct Baud rate
> on the CAN-Bus side - so people are complaining that it is hard to make
> it work...

Hrm, OK.  Might be too fiddly, dunno.  I do also keep thinking I should
get a FPGA board and impelement some test devices that way to let me
exercise the framework, it's not exactly realistic though.

--/lFFBEHT4+C4z/Jh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTVZmnAAoJELSic+t+oim9yREP/0lDF0ekoTasAtNoCNLw83f5
lcNomwLchejO7mpoqkNR1Z9VipWge41yHTOVl+8DeWcaJ7p+yT0c3gGGVkGCmlBM
T2n3pxKKvIqjEaxjsHEJbpP1yI05cQlijhxRkzXhOtpAaQ89xDxiNLojFHKKgrxD
J+HGqCkYMxc3uysuZPRQIszsiA6mfP3PeZp7fFmsJxJPHQzeEi6/xk2xMP2evkMX
YKFSD5mioJwPEAihJNd/5h0fReHe9fi1r1daGNFWb1sRbgEba0HUvsltJPYQrCP0
8GPY/mn182jCJ9tUH/2C8DYOGgTIAr/6Ynm7MdzspiN+JxAOSpgMy5HSGul9Xjj+
OQXvdtpl/BR69TVji8D586d6iFaKkZqzGz7GiT3hR2/Y+55soTnE/mfjXBF4/5Cj
JTXHCnmusmqugy+DCvEDDecdHKJwX/oShSjTbsA4J4Rnx1wJW7qEoUN5TttMM5mO
yNmNdXad0dW3ohthY6YjO6Ujc+vFsBKv5I7KTSYxp5+HMjMYMIlkV7VEgVBv8HLc
foTrG4NTvsGEkpm09hsheWHGWu5Z/dvy9AWqYSRJ/3G0KsN00Ueaqwl7+8alQ8qy
yhfVVsAba/AdzwXQiv3Qmlme7vJ/FuA2aUZIkrgQbhhgujm6P5ZzTM7xkRFlIOzM
CSk3Ak3sD+j7vjFaLJjw
=yt2i
-----END PGP SIGNATURE-----

--/lFFBEHT4+C4z/Jh--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
