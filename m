From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Tue, 24 May 2016 18:20:45 +0100
Message-ID: <20160524172045.GN8206@sirena.org.uk>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S4drRqups3dkeHIl"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org
To: Christer Weinigel <christer@weinigel.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1464107960-10775-1-git-send-email-christer@weinigel.se>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--S4drRqups3dkeHIl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 24, 2016 at 06:39:20PM +0200, Christer Weinigel wrote:
> Document how to use devicetree aliases to assign a stable
> bus number to a spi bus.

Please submit patches using subject lines reflecting the style for the
subsystem.  This makes it easier for people to identify relevant
patches.

> Not having used devicetree that much it was surprisingly hard to
> figure out how to assign a stable bus number to a spi bus.  Add a
> simple example that shows how to do that.

I'm not sure this is something we want to support at all, I can't
immediately see anything that does this deliberately in the SPI code and
obviously the "bus number" is something of a Linux specific concept
which would need some explanation if we were going to document it.  It's
something I'm struggling a bit to see a robust use case for that isn't
better served by parsing sysfs, what's the goal here?

> Mark Cced as the SPI maintainer.  Or should trivial documentation
> fixes like this be addressed to someone else?

This is definitely *not* trivial but yes, in general you should CC
maintainers on things.

--S4drRqups3dkeHIl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXRI1sAAoJECTWi3JdVIfQJBEH/2azAjvdKjETWf7yGqvbp40P
ivEbqP236nOhIhBj8BvDOU9x68kIvL6evIHXk9tGvq6HYrwBd+7bZQrS/1XeAg6d
OFfE7Ia4mr9X4U2uVIE6fJggr8LQ/gGsdQsTg1ej2N3FfqC95l6Z9qB3BOptpxuj
1C7YixX3EiKjpzjCa/7jZo3BDQjtdkwphXnFPCgn/PNHfoGxZzPPpK4RU/ZZZ4yP
p6Tp43iqYgSowA2QbSjEbUU+TVPqmg1vXq3ylOS0aSnqPSS1ism+3hHm9xKUtSJe
krGuZBgjArKUGc+lugMLxGXs+E7xrMFPITN68E5DxEYihkPZSflutUtVeknU2Ws=
=dy/g
-----END PGP SIGNATURE-----

--S4drRqups3dkeHIl--
