From: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Subject: Re: [PATCH -next v2] spi: tegra: slink: make local symbols static
Date: Fri, 5 Apr 2013 15:54:13 +0200
Message-ID: <20130405135413.GA4737@avionic-0098.mockup.avionic-design.de>
References: <CAPgLHd-sTt5eKoiLb13dWHipT6Q46qCbG=b9mCYNq=Q7YLmGVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7241476359587938398=="
Cc: devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org,
 rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org,
 linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <CAPgLHd-sTt5eKoiLb13dWHipT6Q46qCbG=b9mCYNq=Q7YLmGVA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Id: linux-spi.vger.kernel.org


--===============7241476359587938398==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OgqxwSJOaUobr8KG"
Content-Disposition: inline


--OgqxwSJOaUobr8KG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2013 at 09:45:36PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> Neither tegra20_spi_cdata nor tegra30_spi_cdata are used outside this
> file so they can, and should, be static.
>=20
> Signed-off-by: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
> ---
>  drivers/spi/spi-tegra20-slink.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-sl=
ink.c
> index 4e58b53..b224a82 100644
> --- a/drivers/spi/spi-tegra20-slink.c
> +++ b/drivers/spi/spi-tegra20-slink.c
> @@ -1087,11 +1087,11 @@ static struct tegra_spi_platform_data *tegra_slin=
k_parse_dt(
>  	return pdata;
>  }
> =20
> -const struct tegra_slink_chip_data tegra30_spi_cdata =3D {
> +static const struct tegra_slink_chip_data tegra30_spi_cdata =3D {
>  	.cs_hold_time =3D true,
>  };
> =20
> -const struct tegra_slink_chip_data tegra20_spi_cdata =3D {
> +static const struct tegra_slink_chip_data tegra20_spi_cdata =3D {
>  	.cs_hold_time =3D false,
>  };
> =20

Reviewed-by: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>

--OgqxwSJOaUobr8KG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRXteFAAoJEN0jrNd/PrOh4koP+waJdwDHbKXJZXCn/dhPDk+w
WaPuTfLJAWnhtiGXR98dHy0uJxnOpoHGamQeeo3I1v0lXfbMbQw3a3Sy0i8TvIKE
bZFAb+UKzvL9pxBSsUUXnuOa2WeHJE8mH1lRK6SzfB1ShMs4R+BGE1CMPK/Hj7MX
dUXHb7vnOkFhdywICjjLfWlixoTQffz4+IE+FStBPguvpqJB4g985cY+chLkTY3c
gz3AKtlr0jwI69L4QPcFFsPewyyvac/SdIR/Hgg3s8c1c/IwCfHrgJrqAF9zWIUZ
RRlzyqQDr/MXOwHstoNG0azWCo0TbOUAMKgjuYHyb9516fE6YYim4dQckHMw8N1R
lpN1jm4Cn5xHNy8IQ5JIX038agH2oUN/VeXiYIfmssE7KWDgfeRf3d5EfMRwb9iq
blmtWcQEobY31SzKBi76SSX910Iy/pCjo5Y+pThqiCKIjr5HG45cyTuHn6DPzilQ
1+euaTc95QctrUFNJoSi41G9VbOx7Ln8xVw1p0LWaCrMADtL5TRMrvSk7SvJJxW0
YXE8aQy+B+y7R+0fqRXsMmFx5547yCO0tjYe/806V0HZ2AzAUWaGtBG73erqbZzC
THMLZl45TwXRK5Ds3Vczsz1N+HuGKgE3uGgtO+QysOrvJPJX4/RwzhCFBk/97mQ9
8j7dPikXap2MoJt6VnW0
=/DEn
-----END PGP SIGNATURE-----

--OgqxwSJOaUobr8KG--

--===============7241476359587938398==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devicetree-discuss mailing list
devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
https://lists.ozlabs.org/listinfo/devicetree-discuss

--===============7241476359587938398==--
