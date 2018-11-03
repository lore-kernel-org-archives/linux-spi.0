From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] spi: Gracefully handle power supplies with disabled PM
Date: Sat, 3 Nov 2018 20:12:00 +0100
Message-ID: <20181103191200.GE31179@amd>
References: <20180917121041.21084-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Oiv9uiLrevHtW1RS"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
To: Lubomir Rintel <lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180917121041.21084-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--Oiv9uiLrevHtW1RS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon 2018-09-17 14:10:41, Lubomir Rintel wrote:
> This allows use of SPI when power management is disables, such as on
> early boot;

disabled
boot.

> See also: commit 31eb74318054 ("PM / runtime: Fix handling of suppliers
> with disabled runtime PM")
>=20
> Cc: Mark Brown <broonie@kernel.org>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Plus.. I'm not sure.

I thought you'd cause imbalance between _put and _get, but that one is
probably ok.

On early boot, you probably need to proceed, but is ret =3D=3D -EACCESS
the right test?
									Pavel

> index ec395a6baf9c..6546564e41d0 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1212,7 +1212,7 @@ static void __spi_pump_messages(struct spi_controll=
er *ctlr, bool in_kthread)
> =20
>  	if (!was_busy && ctlr->auto_runtime_pm) {
>  		ret =3D pm_runtime_get_sync(ctlr->dev.parent);
> -		if (ret < 0) {
> +		if (ret < 0 && ret !=3D -EACCES) {
>  			pm_runtime_put_noidle(ctlr->dev.parent);
>  			dev_err(&ctlr->dev, "Failed to power device: %d\n",
>  				ret);

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Oiv9uiLrevHtW1RS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlvd8wAACgkQMOfwapXb+vKItgCfWcm4iN84KxRwQqZ0yJVpARNc
7KIAoK6qpoLBDhkD5veduIkcgxSH2fGs
=HGEW
-----END PGP SIGNATURE-----

--Oiv9uiLrevHtW1RS--
