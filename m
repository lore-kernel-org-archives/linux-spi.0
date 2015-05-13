From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Wed, 13 May 2015 21:09:30 +0200
Message-ID: <20150513190930.GD4004@lukather>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150513112604.GI3066@sirena.org.uk>
 <20150513125102.GA2628@lukather>
 <20150513143610.GT2761@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4zI0WCX1RcnW9Hbu"
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
	linux-spi@vger.kernel.org, Martin Sperl <kernel@martin.sperl.org>,
	Michal Suchanek <hramrach@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150513143610.GT2761@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--4zI0WCX1RcnW9Hbu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2015 at 03:36:10PM +0100, Mark Brown wrote:
> On Wed, May 13, 2015 at 02:51:02PM +0200, Maxime Ripard wrote:
>=20
> > I'd say we're also ok because if we delegate the device driving logic
> > to userspace, we should expect it to know what it does to first drive
> > the device properly, but also to open the right device for this.
>=20
> > What's the worst that could happen in such a case? The data are output
> > without any chipselect line being driven by the controller? Isn't that
> > supposed to be ignored by the devices?
>=20
> I'm more worried about the chip select line being connected to the
> "make the board catch fire" signal or whatever (more realistically
> causing us to drive against some other external component) if the extra
> chip selects weren't pinmuxed away.

It seems we've had this discussion at lot lately ;)

That indeed might be problematic....

> > > > This also adds an i2cdev-like feeling, where you get all the
> > > > spidev devices all the time, without any modification.
>=20
> > > I2C is a bit safer here since it's a shared bus so you can't do
> > > anything to devices not connected to the bus by mistake.
>=20
> > I'm not sure to understand what you mean here. How is SPI different
> > from that aspect?
>=20
> Chip select signals.

Well, if it's not connected to the bus, it probably won't be connected
to the chip select either, will it?

> > > This still leaves us in the situation where if we do know the device
> > > that is connected we have to explicitly bind it in spidev which is
> > > apparently unreasonably difficult for people.
>=20
> > You can still do that, but the point is that you don't have to.
>=20
> Right, but that's not what I'd expect to happen (and seems to make it
> easier for people to not list things in the DT at all which doesn't seem
> great).  If we're going to make it available by default I'd expect to be
> able to use a userspace driver with anything that doesn't have a driver
> bound rather than with devices that explicitly don't have any
> identification.

The point is that if we don't have anything declared in the DT, we
won't even have a device. So we can't really expect that the device
will not be bound to a driver, because it won't even be there in the
first place.

> > > I'm also concerned about the interactions with DT overlays here -
> > > what happens if a DT overlay or other dynamic hardware instantiation
> > > comes along later and does bind something to this chip select?  It
> > > seems like we should be able to combine the two models, and the fact
> > > that we only create these devices with a Kconfig option is a bit of
> > > an interesting thing here.
>=20
> > I think the safe approach would be, just like I told in this thread,
> > to just check whether the modalias is spidev. If it is, destroy the
> > previous (spidev) device, create a new device as specified by the DT,
> > you're done.
>=20
> Sure, but I don't see code for that here.

No, of course. Remember that this code was written before the overlays
were posted.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--4zI0WCX1RcnW9Hbu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVU6FqAAoJEBx+YmzsjxAg29oP/3mTDVI+P17eRjXr3mLqy8NG
jc20RNWY8YVtdL5bYC3eV1ZjWUCPJnTwFRLgCbaoriiqJPBEWR00qUAJXWk8c7iY
d0XlhTCNVhrV37s8NPh8NXGlVuvEW6b9/TyUhFlZrWOG5okJ4wVSccPD1tcADvbV
NB9N43Z94kMrqC+PapfizZEUZi5kuwUtths6wevJfZTiumQs5qyq3W4Zq18/20i3
tq7eZxtO/YHxO0IhJnaLne3qN4ixcp2aqji1+AsStXQNavPTOO/5v0fhHeiVTCOF
bQ92yQpkxhmRltCqwEDZnSoKKRdxU/uEbzmSak7wbB5Ka4FDBVnled9zwcSNNYat
7a35+WreHi7b4ov1M/dDA7tGzGbsBrXa3YN2ynywtZsqnIJ8/N2d6AqCJ9qVD3uZ
8eL2WiRoCoNYd45eHRacjOHYUJF03FO5RupVn2KLeXCbndJVy7DNVRhtBgyxxXUs
PlEp4mU00zoSlrSJDzXPNlo4NOCpxzrFz85hqUPu2qG3lsm+Linkowt5jjbBAUgH
VdkVFykjtSY5gW4CF8SfiLbIyQ/QYI8PAfg7wYCakcP/CYPKgs5+k6/k8BSflBU2
Qe7F2SU4552ywGpcBh5i9LenLfIAMXaicTx2ABwoEhS7n59GO/47+af1GnXUMPBG
tu2L3XrOjVsXjPu7Xixg
=mZBk
-----END PGP SIGNATURE-----

--4zI0WCX1RcnW9Hbu--
