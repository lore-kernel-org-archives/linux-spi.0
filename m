From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] spi: Force the registration of the spidev devices
Date: Fri, 15 May 2015 10:09:14 +0200
Message-ID: <20150515080914.GU4004@lukather>
References: <1431462804-30467-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150513112604.GI3066@sirena.org.uk>
 <20150513153740.GC11677@kroah.com>
 <20150513175034.GC4004@lukather>
 <20150513181736.GC16811@kroah.com>
 <20150513192640.GF4004@lukather>
 <20150513223331.GA26748@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FoibaoN3dya3u5fy"
Cc: Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	linux-spi@vger.kernel.org, Martin Sperl <kernel@martin.sperl.org>,
	Michal Suchanek <hramrach@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150513223331.GA26748@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--FoibaoN3dya3u5fy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2015 at 03:33:31PM -0700, Greg Kroah-Hartman wrote:
> On Wed, May 13, 2015 at 09:26:40PM +0200, Maxime Ripard wrote:
> > On Wed, May 13, 2015 at 11:17:36AM -0700, Greg Kroah-Hartman wrote:
> > > On Wed, May 13, 2015 at 07:50:34PM +0200, Maxime Ripard wrote:
> > > > Hi Greg,
> > > >=20
> > > > On Wed, May 13, 2015 at 08:37:40AM -0700, Greg Kroah-Hartman wrote:
> > > > > On Wed, May 13, 2015 at 12:26:04PM +0100, Mark Brown wrote:
> > > > > > On Tue, May 12, 2015 at 10:33:24PM +0200, Maxime Ripard wrote:
> > > > > >=20
> > > > > > > While this is nicer than the DT solution because of its accur=
ate hardware
> > > > > > > representation, it's still not perfect because you might not =
have access to the
> > > > > > > DT, or you might be driving a completely generic device (such=
 as a
> > > > > > > microcontroller) that might be used for something else in a d=
ifferent
> > > > > > > context/board.
> > > > > >=20
> > > > > > Greg, you're copied on this because this seems to be a generic =
problem
> > > > > > that should perhaps be solved at a driver model level - having =
a way to
> > > > > > bind userspace access to devices that we don't otherwise have a=
 driver
> > > > > > for.  The subsystem could specify the UIO driver to use when no=
 other
> > > > > > driver is available.
> > > > >=20
> > > > > That doesn't really work.  I've been talking to the ACPI people a=
bout
> > > > > this, and the problem is "don't otherwise have a driver for" is an
> > > > > impossible thing to prove, as you never know when a driver is goi=
ng to
> > > > > be loaded from userspace.
> > > > >=20
> > > > > You can easily bind drivers to devices today from userspace, why =
not
> > > > > just use the built-in functionality you have today if you "know" =
that
> > > > > there is no driver for this hardware.
> > > >=20
> > > > What we're really after here is that we want to have an spidev
> > > > instance when we don't even have a device.
> > >=20
> > > That's crazy, just create a device, things do not work without one.
> >=20
> > Our use case is this one: we want to export spidev files so that "dev
> > boards" with a header that allows to plug virtually anything on it
> > (Raspberry Pi, Cubieboards, Xplained, and all the likes) without
> > having to change the kernel and / or device tree.
>=20
> You want to do that on a bus that is not self-describing or dynamic?
> I too want a pony.  Please go kick the hardware engineer who designed
> such a mess, we solved this problem 20+ years ago with "real" busses.

Well, we do have such ponies on some bus that don't have any kind of
enumeration. i2cdev allows to do just that already. That would seem
logical to have a similar behaviour for SPI.

> > That would mean that if we plug something to that port, no device will
> > be created because the DT itself won't have that device declared in
> > the first place.
>=20
> Because you can't dynamically determine that something was plugged in,
> of course.

Well.. Yeah.

>=20
> > This patch is actually doing this: creating a new device for all the
> > chipselects that are not in use that will be bound to the spidev
> > driver.
>=20
> I have yet to see a patch...

You were in Cc of that patch, which is the first message in this thread.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--FoibaoN3dya3u5fy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVVamqAAoJEBx+YmzsjxAgWOgP/iVKliVkr7kdOYLgXWwnILuj
QtTWavOb+f5fFKr0/AZZrfggEqr1gNbsOVDiaIriyLoIm34TPVEE91rapHVKrjrw
bdQCCMsZZAedQPXviDPBSCfNQi3dEq3aVAGhaTpWrpIDa7jYaK9jAhWFVp1o+zE2
ml2FGFZioXBzytab4IFDHDVeEJYIcM7CUkUlzpa+lsEdwbsGRaTIUBTyKB///4l1
Rpvj8eL7x4jsHLnqFrazePP5lTuWQih7ClEeyrB3KK96jZ7t2jklt1IPjLRKMyQ9
GAwHmQoCpJZGFENas9uzB9nMxcaPx13GfO4oMSTT9X3YXNVyrqnrnGet6i/3+1fJ
3SYxqljJFiLcfAw848W2XUOvd0fivTuDigQlHRyR6ebHD3eQ4mB7mM/iGR7XZo2v
TRAYGM87eAtKW6fPeSjEtTuuJCtaQDKafjjUIYVNpn1o/G37/wyCWdIE+SMwWlkI
ATVmQE6MwmwDbIoOZYxGezJNFphga3w8h1laNKC6EuryWVrNBQ9FQOdjaV69T52f
WPaFV7C+oXTRvQ+3XGj3Wvb8l98dkE6sGB3769+0hsz3tgpRwXT98k+oMdyvxk5T
IYefyDhPpmah65MLZcj1bf22n2FRs8aCuuT943sKDy6pQX8vCNhCV3U8tQR3tYj5
e+jk88QdBuONnSmga4tR
=eEs1
-----END PGP SIGNATURE-----

--FoibaoN3dya3u5fy--
