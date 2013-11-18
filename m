From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-mxs: fix reference leak to master in
 mxs_spi_remove()
Date: Mon, 18 Nov 2013 11:30:02 +0000
Message-ID: <20131118113002.GA13117@sirena.org.uk>
References: <CAPgLHd9tKB5CFE-2hDUMH-XkEK7mn6oC4MOi_LP+qfDh3_XqPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FCuugMFkClbJLl1L"
Cc: grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org,
	jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd9tKB5CFE-2hDUMH-XkEK7mn6oC4MOi_LP+qfDh3_XqPg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2013 at 03:50:31PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> Once a spi_master_get() call succeeds, we need an additional
> spi_master_put() call to free the memory, otherwise we will

Applied, thanks.

--FCuugMFkClbJLl1L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSifoxAAoJELSic+t+oim9ciwP/RoIOojTXYuYDhnU3KT0wlCV
Ft1Me37DFKGJJVLOyjSZqYlUBroKjTKrtDIdl+Y4ZkItBHupC0xvNBqYr3znaNP3
4URbZmlbQigeZX+YaFdIqqO3dPQFR9HVEQcu2V5nYNSN0jr+xqaL9Wv8kLPxYKOg
/jkiVeh3U5Ymd+fnGtDekAB/rpQrCeJfMkCdRou62an8S6jeFOGhhfyC2wTt/OHu
Pt7oMl9dogPwmoSb1X4qVm667k6ym8igVR13SiYOrmeJrP/ZQzh6OTu8uw8YaHUI
fTBITl4ppsl6b1VeV6FQU6KYnWeGWLdha+6vjAIG+e5+0A3cuXCG7x5NPgIdEzDM
g7SiBYSaeOxLWi2guSA5Gf3/Cc9lgAdppjzp1Ji7fmU1DN6XrkZsQEObrAxMU2Fb
Ba7xol4iTTR/wFHBfFhwCeSztILO/Vf7mBF/I46db+Exk9to3i0fv03q0VOjveun
08HrWzNd4RIj4kdalIYq6UX1YPulaceLV35xyrQDZYB9Q3HsZoX9D5xq/NJ4U6UA
uk4Wx4z/Fp26baqcJ0wuLveN6XysGYlTBwgCfLfvCUdZq81BacwrpMSq0U7Dpd1n
5muLvG2Nl4mWu+HSEwG/S+BUIHxE2VfAKPUl4x8nrJ/ku28AMI4sfxSXu42Lseq6
DNRv0WWxyYqKhcmJe+Nd
=0PfF
-----END PGP SIGNATURE-----

--FCuugMFkClbJLl1L--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
