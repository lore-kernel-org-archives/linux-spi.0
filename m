From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: mediatek: revise mtk_spi_probe() failure flow
Date: Sat, 21 Nov 2015 13:39:49 +0000
Message-ID: <20151121133949.GH26072@sirena.org.uk>
References: <1447986080-31410-1-git-send-email-leilk.liu@mediatek.com>
 <1447986080-31410-4-git-send-email-leilk.liu@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3339503988778986794=="
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
 Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
 linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1447986080-31410-4-git-send-email-leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--===============3339503988778986794==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wj9ZLJVQDRFjGSdK"
Content-Disposition: inline


--wj9ZLJVQDRFjGSdK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2015 at 10:21:19AM +0800, Leilk Liu wrote:
> This patch revises failure flow while pm_runtime_enable().

Why?  This also doesn't apply against current code, please check and
resend.

>=20
> Signed-off-by: Leilk Liu <leilk.liu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> ---
>  drivers/spi/spi-mt65xx.c |   15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
> index 6c1a96e..00a36da 100644
> --- a/drivers/spi/spi-mt65xx.c
> +++ b/drivers/spi/spi-mt65xx.c
> @@ -607,7 +607,8 @@ static int mtk_spi_probe(struct platform_device *pdev)
>  	ret =3D clk_set_parent(mdata->sel_clk, mdata->parent_clk);
>  	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to clk_set_parent (%d)\n", ret);
> -		goto err_disable_clk;
> +		clk_disable_unprepare(mdata->spi_clk);
> +		goto err_put_master;
>  	}
> =20
>  	clk_disable_unprepare(mdata->spi_clk);
> @@ -617,7 +618,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
>  	ret =3D devm_spi_register_master(&pdev->dev, master);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to register master (%d)\n", ret);
> -		goto err_put_master;
> +		goto err_disable_runtime_pm;
>  	}
> =20
>  	if (mdata->dev_comp->need_pad_sel) {
> @@ -626,14 +627,14 @@ static int mtk_spi_probe(struct platform_device *pd=
ev)
>  				"pad_num does not match num_chipselect(%d !=3D %d)\n",
>  				mdata->pad_num, master->num_chipselect);
>  			ret =3D -EINVAL;
> -			goto err_put_master;
> +			goto err_disable_runtime_pm;
>  		}
> =20
>  		if (!master->cs_gpios && master->num_chipselect > 1) {
>  			dev_err(&pdev->dev,
>  				"cs_gpios not specified and num_chipselect > 1\n");
>  			ret =3D -EINVAL;
> -			goto err_put_master;
> +			goto err_disable_runtime_pm;
>  		}
> =20
>  		if (master->cs_gpios) {
> @@ -644,7 +645,7 @@ static int mtk_spi_probe(struct platform_device *pdev)
>  				if (ret) {
>  					dev_err(&pdev->dev,
>  						"can't get CS GPIO %i\n", i);
> -					goto err_put_master;
> +					goto err_disable_runtime_pm;
>  				}
>  			}
>  		}
> @@ -652,8 +653,8 @@ static int mtk_spi_probe(struct platform_device *pdev)
> =20
>  	return 0;
> =20
> -err_disable_clk:
> -	clk_disable_unprepare(mdata->spi_clk);
> +err_disable_runtime_pm:
> +	pm_runtime_disable(&pdev->dev);
>  err_put_master:
>  	spi_master_put(master);
> =20
> --=20
> 1.7.9.5
>=20
>=20

--wj9ZLJVQDRFjGSdK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWUHQkAAoJECTWi3JdVIfQSsUH/AnNrjAk7MIE5hqdC45N4xlv
UOL601EK5SBi7xIDZDwzE8BQXcfneUIU33QB7rHlq2gLhBpRcHO3Z6pe7j7y1RbP
hniqeHCzepC+dsJnZSfNvIQYyC1fgJS2DgKdOCWk51Z4LZqMnrujihptvKhgSRJu
qG9XyahXjcbTlFqrrLLMQXWw2tGeOAQC036ZtTNKrijMDA+5ZAAG1SzIWbsv05KK
lJcVoT+5ThbQIPdL0YQcT/96fWJSftMXC094NknvGn7zmodCSn8U4gSJd9G80Oaw
h3P1/5mt/5AmPb1obt0CDWEfrfsyoAjeY/NxiPwnm75UVyJ1YsGHjEjT1a9Rqv4=
=9yNe
-----END PGP SIGNATURE-----

--wj9ZLJVQDRFjGSdK--


--===============3339503988778986794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-mediatek mailing list
Linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/linux-mediatek

--===============3339503988778986794==--
