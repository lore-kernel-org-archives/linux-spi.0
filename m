From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 4/4] mtd: spi-nor: remove mtk-quadspi driver
Date: Mon, 9 Mar 2020 12:10:20 +0000
Message-ID: <20200309121020.GD4101@sirena.org.uk>
References: <20200306085052.28258-1-gch981213@gmail.com>
 <20200306085052.28258-5-gch981213@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mSxgbZZZvrAyzONB"
Cc: linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Miquel Raynal <miquel.raynal-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>,
        Richard Weinberger <richard-/L3Ra7n9ekc@public.gmane.org>,
        Vignesh Raghavendra <vigneshr-l0cyMroinI0@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Tudor Ambarus <tudor.ambarus-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
        "moderated list:ARM/Mediatek SoC support"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20200306085052.28258-5-gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--mSxgbZZZvrAyzONB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2020 at 04:50:52PM +0800, Chuanhong Guo wrote:
> This driver is superseded by the new spi-mtk-nor driver.
>=20
> Signed-off-by: Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Is this move OK from a MTD point of view - should I apply this when the
rest goes in?  The patch was in prior versions too and is obviously
straightforward.

--mSxgbZZZvrAyzONB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5mMisACgkQJNaLcl1U
h9AW8wf/ZiBUrxNc95s6m0g5fMy2/cs3/LsPrWZSb3N2E1e27ymrx83CSPad45sg
mGRE8ZNrAjJejZVzFdgOiQZQtKXKFVjY6HjAAatKDSNqcX+8k/VR6yCE/xQB36h/
V+fLMlrzLx1nNEF3umZAmtdkQIQN8OuSTUbLAgAVe3bZVXWMQAZfcJrCy/FuidfY
ZjU3+caJ3jC8rwDB6+1xVujEe3+eCz63rkOHoSGzqXBYI0OpQfOLd9M8fu77WW4U
6RV5Z5lUl26EOpzOO2+FJKEdguXeXDguoAjKlqcc+CzhGBVdnRetzqf+LEujpAOd
xU3eqFZzEBmUHpNr4i2GACoDY/MBSw==
=H8Zm
-----END PGP SIGNATURE-----

--mSxgbZZZvrAyzONB--
