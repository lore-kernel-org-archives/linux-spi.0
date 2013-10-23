From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH -next] spi: atmel: fix return value check in
 atmel_spi_probe()
Date: Wed, 23 Oct 2013 10:38:19 +0100
Message-ID: <20131023093819.GJ9388@sirena.org.uk>
References: <CAPgLHd86H42hU1On2J3hCV1resNQ-PVCGB3Q=icaLoDQLSOg_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ed/6oDxOLijJh8b0"
Cc: nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd86H42hU1On2J3hCV1resNQ-PVCGB3Q=icaLoDQLSOg_w-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--ed/6oDxOLijJh8b0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2013 at 11:12:02AM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> In case of error, the function devm_ioremap_resource() returns ERR_PTR()
> and never returns NULL. The NULL test in the return value check should be
> replaced with IS_ERR().

Applied, thanks.

--ed/6oDxOLijJh8b0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSZ5kHAAoJELSic+t+oim9lDMP/A8jxDWgInl/Dz6k3o2S1IyY
vWD8/DQecIri2R8T8lD7aGMoFmDlw05lgaYbgcSBMgEmz0BtU9dHgam3HfDn75Uz
LmLRIVtR1dWjPwBCmth2OVMPHTDG8+OfMb8APZyQoIyQ1seB3g4C6tUx5J9EjrnF
8VlDl0OhPzHjoqgT/6NAtL1ItQ6rqpQi/xu0c9U8aNuRcT9xeAkhOroEn7+9gr9v
alApKTFiX1PadIn2EssAJe2UOS4GGKEjGoGIlzCkGPpK9mxHXLbaWS1RM019D200
yZ0e+yDgBHZY+/mugQdMvTjNkfnP/0sFa2DzsZ2Yuo0yYTfzx56ZcorPwhJoHPn/
RCEa1GAm7a0BJeZ2RdNOFVQ1OweF5Vvg6ScrlWWSnwXwTcvNmRWyS1LDkF86MOJm
BRVNSukpb4ygvE1OwvSsnqQvfSv8kEOFiQIm0E0BXjsCgI4KrQeLXlChxod/vwRG
0myTPtCNyTKPNPV0hoZGd75y5fWIIEmQV+jCV6ykJf0OEXByfhHc+RKoXBETn0+U
Z20NVTAv/ABFzq2uzcWg5Wyw7vZFsj5aZ9TkdFc78/wTQBApfCHqFEWNkj3mgb+9
jozGMpn9Q00Oatt/dhjmiogKvNTOsweGcTOU1jVLTEWkhVlLjH5ly9hwgM5XQWEZ
beTVsZxqI7Ke2TB+TEzV
=TZ3Y
-----END PGP SIGNATURE-----

--ed/6oDxOLijJh8b0--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
