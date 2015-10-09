From: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Subject: Re: [PATCH v2 4/4] spi: spi-coldfire-qspi: enable RuntimePM before
 registering to the core
Date: Fri, 9 Oct 2015 19:27:29 +0100
Message-ID: <20151009182729.GA1544@katana>
References: <1444383567-18113-1-git-send-email-wsa@the-dreams.de>
 <1444383567-18113-4-git-send-email-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1444383567-18113-4-git-send-email-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 09, 2015 at 10:39:27AM +0100, Wolfram Sang wrote:
> From: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
>=20
> The core may register clients attached to this master which may use
> funtionality from the master. So, RuntimePM must be enabled before, other=
wise
> this will fail.
>=20
> Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>

V2 adds disabling runtime_pm in the error path. There are no
dependencies. Patches 1-3 do the same for I2C drivers. I generated this
series from a branch and sent out as is; probably I should have sent the
SPI one individually.

Thanks,

   Wolfram

> ---
>  drivers/spi/spi-coldfire-qspi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-q=
spi.c
> index 688956ff5095c2..23f6fffd75e111 100644
> --- a/drivers/spi/spi-coldfire-qspi.c
> +++ b/drivers/spi/spi-coldfire-qspi.c
> @@ -420,19 +420,20 @@ static int mcfqspi_probe(struct platform_device *pd=
ev)
>  	master->auto_runtime_pm =3D true;
> =20
>  	platform_set_drvdata(pdev, master);
> +	pm_runtime_enable(&pdev->dev);
> =20
>  	status =3D devm_spi_register_master(&pdev->dev, master);
>  	if (status) {
>  		dev_dbg(&pdev->dev, "spi_register_master failed\n");
>  		goto fail2;
>  	}
> -	pm_runtime_enable(&pdev->dev);
> =20
>  	dev_info(&pdev->dev, "Coldfire QSPI bus driver\n");
> =20
>  	return 0;
> =20
>  fail2:
> +	pm_runtime_disable(&pdev->dev);
>  	mcfqspi_cs_teardown(mcfqspi);
>  fail1:
>  	clk_disable(mcfqspi->clk);
> --=20
> 2.1.4
>=20

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWGAcQAAoJEBQN5MwUoCm2MXIQAJCong40bv32EU0OI42lSCrL
8jpG2LE+p/ve5ABKEmsJkiwx22Uy46AAIqiyel0NqKb++uyIFdjNRldjd4iEAudg
QCql8R8iHQw/zOl8jwmL5ic7sNY36gteQnbqI3bfSTv+CEqstOLD2BMZYDYIbyhU
TOobxm8sLpywhRDk7bKRG2NqVj60DMFcBE6wH6nJ67iw6RNwloRiJmgYr4D+gS4V
2TL/rB9KV/GzX67mYuIw5tAA2wkTniC5h51t/Bvr88z7vSk4J0bo9okU3bCTK9yo
fRcE22rFu0uYaBrBL3w+WKZg6KiZ2wGHsoVIYh0zMFEQqhmCSZjzXMjCeuVzb7zw
p0gTJrLY2oOmTrtvvvpsk1gp/l1ylqCu19JLpkIC0lhPG6Qe4BB4cEF9gUFwat0T
IXIOI+gH84X7UzG2DeVGotgZdxelTcSnGm3RLtaeR/llvl7VZQm+BrXPrtXXcKhy
OqMsFvQ0YyYOKaWX915V+WCjTJ6wzQ9/JErFt0HTKNZ4D4oZ/8d2eKWtdWqWnW+l
bdPbDg+DOdJS/gM68TxvMcck8fZz+Qa+oNok28wNMijKdbXciwEtv/Vhwnwialr5
FgMjSviuueKLBW+73GK1PbpzLBnJvQFSp/yyO1GKwViAkqv3FaXQqtkzhbvGIzMm
+yWCZrrrM0hcRO+KMgTA
=2t4r
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
