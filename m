From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi:fix IDR collision on systems with both fixed and
 dynamic SPI bus numbers
Date: Tue, 14 Aug 2018 15:18:59 +0100
Message-ID: <20180814141859.GC5810@sirena.org.uk>
References: <20180813164810.16769-1-kirill.kapranov@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        l.stach@pengutronix.de
To: Kirill Kapranov <kirill.kapranov@compulab.co.il>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180813164810.16769-1-kirill.kapranov@compulab.co.il>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 13, 2018 at 07:48:10PM +0300, Kirill Kapranov wrote:
> On systems where some controllers get a dynamic ID assigned and some have
> a fixed number (e.g. from ACPI tables), the current implementation might
> run into an IDR collision: in case of a fixed bus number is gotten by a
> driver (but not marked busy in IDR tree) and a driver with dynamic bus
> number gets the same ID and predictably fails.

Is this something that's actually happened for you?

> +	} else {
> +	/* devices with a fixed bus num must check-in with the num */
> +		mutex_lock(&board_lock);

The indentation here is weird, the comment isn't aligned with the code
it's commenting on.

--IpbVkmxF4tDyP/Kb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlty5NIACgkQJNaLcl1U
h9Cltgf6AoHkyc03ShpCTDuvl+u2bjgiiUx+V3abGWb0pEZkU0ZVVIj4+3v+dIZI
Rv6pP6cY1bb2q9KYxbxJSP0h9d1ywrec1ynGvxbWswLQJrXH5KDV8s2AJhOmNoOr
bOQJESJBEpfC7msE6yqYKcI7HGBNT3Vsf8T3PVIRea+mJL8690mhsopehWwUKoiy
6B2IZcwYmS+3fCitHQEMZ8z6G9pXYaVNWCoVe1PVDihW2NE3qI474nbqnM5KNmnx
CfORtA1toS+a56QCR4baEWAyNAHbr/anRlnoqOic/qJQJflx1ZD5h1RoEmL3RgOV
6TmZUGdgvfbj2HeWgoN8HQ51zySPBw==
=EdRp
-----END PGP SIGNATURE-----

--IpbVkmxF4tDyP/Kb--
