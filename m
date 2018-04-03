From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH 2/6] spi: sun4i: restrict transfer length in PIO-mode
Date: Tue, 3 Apr 2018 10:10:41 +0200
Message-ID: <20180403081041.3ully6bcyfwx2cx6@flea>
References: <20180329185907.27281-1-ssuloev@orpaltech.com>
 <20180329185907.27281-3-ssuloev@orpaltech.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="y5vlyrnrsygmeihf"
Cc: Mark Brown <broonie@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
To: Sergey Suloev <ssuloev@orpaltech.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180329185907.27281-3-ssuloev@orpaltech.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--y5vlyrnrsygmeihf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 29, 2018 at 09:59:03PM +0300, Sergey Suloev wrote:
> There is no need to handle 3/4 empty/full interrupts as the maximum
> supported transfer length in PIO mode is 64 bytes for sun4i-family
> SoCs.

That assumes that you'll be able to treat the FIFO full interrupt and
drain the FIFO before we have the next byte coming in. This would
require a real time system, and we're not in one of them.

Maxime

--=20
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com

--y5vlyrnrsygmeihf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlrDNwEACgkQ0rTAlCFN
r3SoEg//Vtl7Lp2S0SIivzzhSJ1GQAYY//I6QFMrnn08YIO7xi+v97nZMyVh40ZJ
8UUqlo84wa11VeXa674J6P2I2mF46sOl/Ujodx9A3CGz6irBQYSbboW0ZY9C22DG
E/H64+Ie9LBP6+/8qYPqHo4hG3E7TNvCWIIg6n+FMeNyUpquac3ME/my+R5mOoav
RdQ+24smy3RHVwMq/PHp4XG1+lc66XndC848nWxWf8igY8kBhHP6uNCb4o2WH1WN
bEHAMRR+6vnvty7kkA1fCl5xZ6bfKKU/C5giy/62qjB1Ag33tU3srTmHep8PjgFH
JQdKJcx+cCuGWgLa0FSl3bgIz3qlBjE200poL8bFNmERxXSkhKDOJmZPZPF79+ui
Z1FPb4jkJ3tIbADRxqse1qRUysAs4PT5lDN4QuRYeaMT/R4ufD0gdOOTwBBrSSou
BYVEGn22j2slUnk6NHf2L5XeDjHMqcMkOMvON5/h+2xRnDGoXj0yiuqGJ++esT84
Bdcruq3jarbxe1jE75ua641fSXlFtamMZZHYUBa/NDfrJyZP9uo639W6xIRnDQG0
lPMIygLi/dvEoOEPvivVTAuYWvhafrOa6BnyMvAYQ8dTdrpIae5MfMwinHYVZ1VO
P4Q7XA3AP2oEL6KyLUUjMptL5RcGrm3gFza2TF+OXV4Lc+aFGaI=
=pSkJ
-----END PGP SIGNATURE-----

--y5vlyrnrsygmeihf--
