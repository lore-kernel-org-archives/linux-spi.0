From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v3 4/6] spi: sun6i: use completion provided by SPI core
Date: Wed, 4 Apr 2018 08:53:02 +0200
Message-ID: <20180404065302.kq5uuybi4n4s3syr@flea>
References: <20180403154449.2443-1-ssuloev@orpaltech.com>
 <20180403154449.2443-5-ssuloev@orpaltech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4mcen6okihu6dx5e"
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To: Sergey Suloev <ssuloev@orpaltech.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180403154449.2443-5-ssuloev@orpaltech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--4mcen6okihu6dx5e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2018 at 06:44:47PM +0300, Sergey Suloev wrote:
> As long as the completion is already provided by the SPI core
> then there is no need to waste extra-memory on this.
> Also a waiting function was added to avoid code duplication.

This would need to be split in two patches, one to add the waiting
function, the other one to convert to the core struct completion

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--4mcen6okihu6dx5e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrEdk0ACgkQ0rTAlCFN
r3QRbA//WwutpY6L4PvCzTsynlQcfw2t+pguHr3e+iqcmvOf8hDJlwosdqH9dyEk
2TZRp9EL6wNHdIHF7lWDT66eyGKR1oDItwJqS7mbhZhNaFMVop8V3zvy1GHNNDDI
v80zjqCJnj6Fli3+8aKO53sWqpoCPbrM27kOyj5O3ozM1jeLvsZNlF5mJLxmSy6E
uGHTWjp00Fwox/qf4R73IF8AwRXtJjHjr+B5FVFl5gkkxCep2QbEdcOPIN/DTeqa
yLNCuZfV7INok/lMlhuSDAo0TjBFvtX8OCGWPQKFVjhbFc8xDmEyMmERIuO4BGDn
KAeo8YJmVb9LuHmLgCM2JWP2jo/Ej3/uyOLywiLk3Y0h+Bi0lgewDjiO7Wp7D+Wu
dP3WQ+WD8/2nvHWy+5q/wBrCLaj27PxFN4kepKKlczEVJHEhmFvM4/hE8a8XADkJ
e/bxwhOty+cflJFqbMmbvj9WgFjVJHF+RVpi4FjCSCVxz8TqPhjO8iK9XlnSGYVc
z+wuE9eKyzYcHG7qCd6FtqkcXrFRKU9uWAdKl1jbid89NzpvGPspfgml2EqRjOuJ
vTjqxIeqmZQZvCJGFDnVrjvCqkAVDmBtcVkIj47IaHeYPT/Layt3lKLLGNZRJc0v
nw1YyTLgVB8a9wCDiD+OtMnYwYRhM7eNl5OGfUoU8lZXR1FnIfA=
=pphr
-----END PGP SIGNATURE-----

--4mcen6okihu6dx5e--
