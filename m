From: <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH 1/4] spi: mips-lantiq: Use devm_spi_register_master()
Date: Wed, 4 Dec 2013 12:23:11 +0000
Message-ID: <593AEF6C47F46446852B067021A273D6D9AB22CD@MUCSE039.lantiq.com>
References: <002d01cef0af$5a21f140$0e65d3c0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <002d01cef0af$5a21f140$0e65d3c0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Jingoo Han wrote on=A02013-12-04:
> Use devm_spi_register_master() to make cleanup paths simpler,
> and remove unnecessary remove().
>=20
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Looks good, thanks.

Acked-by:  Thomas Langer <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>

> ---
>  drivers/spi/spi-falcon.c |   12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>=20
> diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
> index c7a74f0..dd5bd46 100644
> --- a/drivers/spi/spi-falcon.c
> +++ b/drivers/spi/spi-falcon.c
> @@ -433,21 +433,12 @@ static int falcon_sflash_probe(struct
> platform_device *pdev)
>=20
>  	platform_set_drvdata(pdev, priv);
>=20
> -	ret =3D spi_register_master(master);
> +	ret =3D devm_spi_register_master(&pdev->dev, master);
>  	if (ret)
>  		spi_master_put(master);
>  	return ret;
>  }
>=20
> -static int falcon_sflash_remove(struct platform_device *pdev)
> -{
> -	struct falcon_sflash *priv =3D platform_get_drvdata(pdev);
> -
> -	spi_unregister_master(priv->master);
> -
> -	return 0;
> -}
> -
>  static const struct of_device_id falcon_sflash_match[] =3D {
>  	{ .compatible =3D "lantiq,sflash-falcon" },
>  	{},
> @@ -456,7 +447,6 @@ MODULE_DEVICE_TABLE(of, falcon_sflash_match);
>=20
>  static struct platform_driver falcon_sflash_driver =3D {
>  	.probe	=3D falcon_sflash_probe,
> -	.remove	=3D falcon_sflash_remove,
>  	.driver =3D {
>  		.name	=3D DRV_NAME,
>  		.owner	=3D THIS_MODULE,

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
