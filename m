From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 lora-next 1/4] net: lora: sx1301: convert burst spi
 functions to regmap raw
Date: Wed, 10 Oct 2018 11:19:54 +0100
Message-ID: <20181010101954.GB6294@sirena.org.uk>
References: <1539089532-2481-1-git-send-email-ben.whitten@lairdtech.com>
 <1539089532-2481-2-git-send-email-ben.whitten@lairdtech.com>
 <3959c93b-edb5-c6ff-ec36-57f84ab8623f@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Cc: Ben Whitten <ben.whitten@gmail.com>, starnight@g.ncu.edu.tw,
        hasnain.virk@arm.com, netdev@vger.kernel.org,
        liuxuenetmail@gmail.com, shess@hessware.de,
        Ben Whitten <ben.whitten@lairdtech.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        Stefan Popa <stefan.popa@analog.com>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3959c93b-edb5-c6ff-ec36-57f84ab8623f@suse.de>
Sender: netdev-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 10, 2018 at 09:59:29AM +0200, Andreas F=E4rber wrote:
> Am 09.10.18 um 14:52 schrieb Ben Whitten:

> > -	return spi_sync_transfer(priv->spi, xfr, 2);
> > +	return regmap_raw_write(priv->regmap, reg, val, len);

> ... Which would mean we are lacking a noinc API for write here!

> @Mark/Stefan, any reason noinc was not implemented symmetrically?

Nobody wanted it enough to do the work of implementing it, there's
nothing stopping someone doing that.

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu90kkACgkQJNaLcl1U
h9DHNgf/Xv17B2oWZrj1HsaHVphsjqdKNaklxC5zlucjYMYScg5zj92WQt7WA/ek
4RDss68Z3S/AhSdenHCwZ4P2fYfdnJcNcjNk5Ap1MXybBzH8wuwGG+QHU7gM01xF
j93vWfmS0c8gZbhlxl6CQ0uqhmTm6QzB1QwUzgmqAa8a2EmpeAc1qRYNxbIYi+6C
S7Ky2e1ALZDuyUwWznwtWu26BMVm9T+xgErpkvl+njyyXUSI/e0J4KyOcfVLy4zA
rNl8Cl5AhBfWiJI20HfUV/XUyXAN/PFLsBrzt4X6+zdQJIfEF9v6gSJjw3YYW0UE
3z/b8OZqf38PgROXX6/5psQaFz4m3A==
=v4f9
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
