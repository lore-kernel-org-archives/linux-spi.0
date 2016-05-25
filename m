From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Wed, 25 May 2016 13:33:37 +0100
Message-ID: <20160525123337.GW8206@sirena.org.uk>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se>
 <20160524172045.GN8206@sirena.org.uk>
 <57449784.4070108@weinigel.se>
 <20160524183256.GP8206@sirena.org.uk>
 <5744A402.8050409@weinigel.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="H/DU/KGSZaQxued3"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Christer Weinigel <christer-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5744A402.8050409-rKHMIqA5R6gwFerOooGFRg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--H/DU/KGSZaQxued3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 24, 2016 at 08:57:06PM +0200, Christer Weinigel wrote:
> On 05/24/2016 08:32 PM, Mark Brown wrote:

> > I'm not clear that we want to document this at all since I am not
> > clear that there is a sensible use case for doing it.  I did ask
> > for one but you've not articulated one in this reply.  I am much
> > less gung ho than Grant on this one, even as a Linux specific
> > interface it seems very legacy.

> It's bloody convenient.  I'm working with a Zync board right now where
> we have multiple SPI ports.  Being able to label the ports on the
> board spi1, spi2 and spi3 and having spidev devices show up as
> /dev/spidev1.0 instead of dynamic assignment makes things much easier.

So you're using it with spidev, probably directly at a guess rather than
with an explicitly enumerated device in there?  This is also something
we don't support in DT unless you've added an explicit compatible string
for the device you've got attached for it to bind to - it will print an
enormous warning if you try to instantiate it directly from DT since
unfortunately implementation details of how we match compatible strings
mean that any Linux device will match.

The DT should describe the hardware in the system, not the
implementation details of how a particular software release should
control that hardware.  If your software release is intending to expose
a SPI interface connected to nothing it's not clear that this is useful
hardware to describe and that we can't just optimise this by not doing
anything with the hardware at all but whatever happens we should be
explicitly exposing that, not doing global level hacks for it.  We're
talking about very limited test usage in a new system here as far as I
can tell.

> Yes, it's possible to iterate through all files /sys/class/spi_master
> and then have a table to map those names to device names and create
> symlinks to them, it's just painful.  It's much easier to do be able
> to do "cat data >/dev/spidev1.0" from busybox and not have to set up
> all that infrastructure.  And yes, this is on an embedded system using
> busybox without udev.

You're way off in the implementation detail weeds here.  What you're
looking for here is something very much specific to how spidev device
files happen to be named with the particular userspace you're using,
with the choice to use spidev to control the devices (if there are any)
itself being something that's not at all general.  It doesn't follow
=66rom this that assigning numbers to SPI buses is a good idea, it's
something that only has meaning in this very specific context, and there
is no guarantee that the chip select numbers will end up being stable
for that matter.

If this is something it makes sense to have in device trees at all it's
something that should be being done as part of describing the specific
thing you are trying to describe.

--H/DU/KGSZaQxued3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXRZugAAoJECTWi3JdVIfQYTEH/RQLu7EVscjJGRrf51P/tmfs
WuJJAN8G2Hp4CCkrQ0R6Lj+JkRCp6owX5sSGBvNauS50WkENryKmvSRJ1sHc+KfR
v4hkZLZ+9TmBQJHGB9rIzTKr2nOba0vdHXkVgQi/06KnmWM1J9eoHlaqrTqp8SZZ
n6G6ho2COzsLlf4ngVdS1LV1x1iX9ESZXNDkVmNJIWQbOx0YXuUlGzL6y6SnXySv
NYpCV+6F+fFaVzwcvkTS+WSHNwEooV44BGrJS64lbaKg+HVbkBAc7NGKRdujDEBw
xzfxkajwoK4j75g/frrrGAMh0cwYwY0bKnqxU7DEPj2SOvlC53K6sUZhg4w96QA=
=+K4x
-----END PGP SIGNATURE-----

--H/DU/KGSZaQxued3--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
