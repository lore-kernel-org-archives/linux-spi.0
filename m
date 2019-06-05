From: Mark Brown <broonie@kernel.org>
Subject: Re: Applied "spi: rockchip: turn down tx dma bursts" to the spi tree
Date: Wed, 5 Jun 2019 20:55:11 +0100
Message-ID: <20190605195511.GX2456@sirena.org.uk>
References: <20190412105320.2924-1-kernel@esmil.dk>
 <20190508103358.5C7EB440010@finisterre.sirena.org.uk>
 <CANBLGcxiXR7KqKn4U-2PgefuxpBFX=yR06cw6A5GEALuqa54FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dkgfGZfPp4OU3Le7"
Cc: Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-spi@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
        Vicente Bergas <vicencb@gmail.com>
To: Emil Renner Berthing <kernel@esmil.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CANBLGcxiXR7KqKn4U-2PgefuxpBFX=yR06cw6A5GEALuqa54FA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--dkgfGZfPp4OU3Le7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 05, 2019 at 09:36:44PM +0200, Emil Renner Berthing wrote:
> On Wed, 8 May 2019 at 12:34, Mark Brown <broonie@kernel.org> wrote:

> >    spi: rockchip: turn down tx dma bursts

> I've tried looking in the for-next and for-5.x branches here, and I
> can't seem to find this patch.
> Am I missing something?

> It fixes a problem introduced in 4.19, so it'd be nice if it could
> make it to stable trees eventually.

47300728fb213486a830565d2af49da967c9d16a is in my tree.  When it reaches
Linus' tree send a request to Greg for it to be backported if none of
the stable automation picks it up.

--dkgfGZfPp4OU3Le7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlz4Hh4ACgkQJNaLcl1U
h9BxQgf+Ljplf8ZxX4pzMeNgr9s/Oik21N9dYZN14eGepFYn3eC2JAJ66qWR5ZDX
q18JwvA6GyMsvntlko2y2HjEIJltQ06YGplOfVLtKkwtDWSbiBlV1nkkxpZGjmJd
AC7LI2yRkoD35/DXj4r2x8ZatFl1W+i3isANRYtSFHUeKElyYCQ+fV4YTm8xUHjP
zpRYGv65CG88hJmzygheI3viO+zlwsUxaJaz/jcNkoyZ4etUpz8FEYjtMeBV3SXX
MxUncjiMX3d7HlRU4CY03FyMkUJ4d+8Pfw7YMyNbF2SMDqEbApXGhBG4XS1RcE6x
ujRznnS4Wk9Lc6MdQbWFBAMoYrCUcw==
=Y9+I
-----END PGP SIGNATURE-----

--dkgfGZfPp4OU3Le7--
