From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/atmel: fix simple_return.cocci warnings
Date: Fri, 17 Oct 2014 10:58:20 +0200
Message-ID: <20141017085820.GD3771@sirena.org.uk>
References: <543feff0.QhS1UtLsJt/o5948%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UfEAyuTBtIjiZzX6"
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: Fengguang Wu <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <543feff0.QhS1UtLsJt/o5948%fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 17, 2014 at 12:18:56AM +0800, Fengguang Wu wrote:
> drivers/spi/spi-atmel.c:1518:1-4: WARNING: end returns can be simpified and declaration on line 1514 can be dropped

Applied, thanks.

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUQNorAAoJECTWi3JdVIfQoOUH/RZWWUb1j56WILiSzVPqOMnR
rHX0RDbOPBu8Jwl3jx5f+kMcjjh4kr3P3M70wzMk/locGk1H3cgAd2RJhznKpfhK
IcqzUMYpahJSjJr6tq96apRLOWeoznRHRSUxDENUqU87gDbaFiYH1WGRDTsVFeDn
r+qWj2Q/JkUGsxwEG3/R6HbpDx7kxJU5MmTYQkJq6s/9iaISvx89hTkuSfqHFgU9
Tmp/ekie+UZcO2VykTsP3+B3CyP5gVJO90xz47yyCaBQaQjvYJ5eruAVOYZEvydE
LRqE6h96Zs7g5olMqhdsaKduvcAFiJkIB9BCoNMlEAEQqwWVIFSHvAgY/G68RRA=
=2khw
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
