From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Wed, 25 May 2016 13:50:46 +0100
Message-ID: <20160525125046.GX8206@sirena.org.uk>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se>
 <20160524172045.GN8206@sirena.org.uk>
 <57449784.4070108@weinigel.se>
 <20160524183256.GP8206@sirena.org.uk>
 <5744A402.8050409@weinigel.se>
 <20160525121923.GK1337@leverpostej>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2EejY7RDPU7h6CFd"
Cc: Christer Weinigel <christer@weinigel.se>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160525121923.GK1337@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--2EejY7RDPU7h6CFd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, May 25, 2016 at 01:19:24PM +0100, Mark Rutland wrote:
> On Tue, May 24, 2016 at 08:57:06PM +0200, Christer Weinigel wrote:

> > It's bloody convenient.  I'm working with a Zync board right now where
> > we have multiple SPI ports.  Being able to label the ports on the
> > board spi1, spi2 and spi3 and having spidev devices show up as
> > /dev/spidev1.0 instead of dynamic assignment makes things much easier.

> Do these numbers match anything, or have you assigned them artificially?

> i.e. are the labels for those well defined for the board? Are they in a
> manul, or printed on the board itself?

> If these are well-defined and the ports are accessible to, and under the
> control of, the end-user, then this would be largely similar to what we
> do for serial ports and other user-accessible physical connectors.

It's not a physical connector on the board that this is covering, it's
for the SPI bus which isn't a meaningful thing since there's no overall
connection standard and to do anything useful you'd need to handle the
chip selects which numbering the buses does nothing to help with.
Anything that's actually exposed at the SPI level would be a particular
device or set of devices on one or more buses, if the goal is to label
bare pins on boards then we're looking at the individual device level
rather than the bus level.

Really such a connector is the equivalent of a BeagleBone cape connector
or whatever.

--2EejY7RDPU7h6CFd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXRZ+lAAoJECTWi3JdVIfQwFkH/3yFC2vx6m9F2Je84fy5ltGz
6Kx4nwbiTfL54+Uy6iCGkjSRDwcdN8ntUg8hsyKKmY70FtsRzpLXUqQ6q4szc12X
4abxBkP5M2CAQUGRSOGwdC3dJU0I4DSTmeeMjiGmf9j3q6C36QFoatpu8c7cq/gv
dtHYqFlXcIgo88IMXLj/6t7EVywr6Jcp4GKN6M911JnVLDnmTHHLdRUuqExWrsyP
mofZ7thwM5IhpyCcqtV1ClPEtxzNxqmKGuDFzHBGU92u+png5IAiOa68tj8GW2vA
v8ROSCPCSAMM+23PDjC7o4dwt40ISWLcwAuEbGnJG8eYkk4o5qSiAetbYyghOHY=
=04EY
-----END PGP SIGNATURE-----

--2EejY7RDPU7h6CFd--
