From: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: omap-100k: Remove casting the return value which is a void pointer
Date: Mon, 09 Dec 2013 12:21:11 +0100
Message-ID: <8761qyuv6g.fsf@mina86.com>
References: <001801cef4ca$8c605e20$a5211a60$%han@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Cory Maccarrone' <darkstar6262-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <001801cef4ca$8c605e20$a5211a60$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09 2013, Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> Casting the return value which is a void pointer is redundant.
> The conversion from void pointer to any other pointer type is
> guaranteed by the C programming language.
>
> Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/spi/spi-omap-100k.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
> index 0d32054..35832a9 100644
> --- a/drivers/spi/spi-omap-100k.c
> +++ b/drivers/spi/spi-omap-100k.c
> @@ -441,7 +441,7 @@ static int omap1_spi100k_probe(struct platform_device=
 *pdev)
>  	 * You should allocate this with ioremap() before initializing
>  	 * the SPI.
>  	 */
> -	spi100k->base =3D (void __iomem *)dev_get_platdata(&pdev->dev);
> +	spi100k->base =3D dev_get_platdata(&pdev->dev);

I might be wrong, but I would assume that __iomem is the important bit
here and removing this cast will make linter unhappy.

>=20=20
>  	spi100k->ick =3D devm_clk_get(&pdev->dev, "ick");
>  	if (IS_ERR(spi100k->ick)) {
> --=20
> 1.7.10.4

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJSpaeoAAoJECBgQBJQdR/0XNgP/0h8ZlRv1yoPljB+bb5ycNJb
qoiWlBZPO8bZCIrhEdYyqcWHP/R7HZg7X7ryUocl2p8DtD2LNJXRFUsYH91xckzK
jHEFDVHgjIQRY8raN+qv9VO8Nvam6O4V/ZsuEpl1zQYkQpauAq7uPB/6So1c1TfL
E8J1GoTWGBOdTeS2IdCwDmFOXHPUZqVjobTMhCEfWNXkeh7cqUmUpZB+XRlBHUrA
GqlhjlVpFnGfT4xubOO8qwFiKUnUKXcezee4YB0ocxv2MQLsDZXERGhxmMUU0bql
IumjG/Koo+H3Ez/lZlqeP3q/ZxB7kOmVnSsI05XNMJ95t3t/JGEi7ty4NJPXPqNR
1U9+RqutaqtnxvXLdMbLOlzLiNoouNHbc1Q95mHZ2oLUMl3WeKdeIzsoM64hPEXC
2s9guq92SDEqvOrE4znDWjYGSaFeiQJgDKwarGIR0OI4jEOCjpku0hoTOKapNboM
1oBMyzVr4L8aN9/QEWkWAcSjqvR/Nx46UXNY4cWGnSqq0v1pEtqwc2uD5tZWH5JC
TDon4V5vmtFBpscXAdl7cVImxF2xzRNVVHhJ3EukNdqH7uGQ72CBUrPF/9b31fIB
fB2tDXIkOSD06u5SQ9a1Wzg20rQa2wCVbMhVYq8jWndBMKEg3Nw4/fyTfQQ5Dj7b
EKD/69sUOBF6xwGznHQp
=nWKA
-----END PGP SIGNATURE-----
--=-=-=--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
