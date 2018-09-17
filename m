From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: Gracefully handle power supplies with disabled PM
Date: Mon, 17 Sep 2018 17:27:32 +0100
Message-ID: <20180917162732.GA2471@sirena.org.uk>
References: <20180917121041.21084-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Lubomir Rintel <lkundrak@v3.sk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180917121041.21084-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 17, 2018 at 02:10:41PM +0200, Lubomir Rintel wrote:
> This allows use of SPI when power management is disables, such as on
> early boot;
>=20
> See also: commit 31eb74318054 ("PM / runtime: Fix handling of suppliers
> with disabled runtime PM")

>  	if (!was_busy && ctlr->auto_runtime_pm) {
>  		ret =3D pm_runtime_get_sync(ctlr->dev.parent);
> -		if (ret < 0) {
> +		if (ret < 0 && ret !=3D -EACCES) {

No, this is not at all clever.  If the device uses runtime PM and
doesn't get resumed then there is every likelyhood that the device won't
even be clocked.  If users want to disable power management it's going
to need rather more work than just setting a flag.

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluf1fEACgkQJNaLcl1U
h9BnAggAhCJvRzvP5akGwvZ8hcI7I9qnNqdd91sGNeEAKNCjDvOwu6Ctzdf2ijIN
uAYTMmflw9KO9sJm+4rVdDvrlYCKXZtriVrNiRFOEy4O2t2v1SAWTwXhVcqMM0Bc
Th5FLvjJjHZ+nKqbjx/WtNa2sQKBIqxbz143Ze4fZCa1eRlt4zR3IieeImGPiw4l
MUOE7gaNTsIxEeyYeipe/tVWElh8sqK4TrVcwdVaScl5IQAMtUWv6q8x+80jPv4i
o1IzggtxS+eyS1K6/Kf9iksxe34sbfVMGAY9tQsF7IOkJl0CAa53djV90LrTS/YY
/8zdIQBgvKjXYSvl/c8OCuNT/+vHSg==
=zyyw
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
