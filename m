From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: altera: Remove unneeded NULL checking for
 hw->bitbang.master
Date: Mon, 13 Jan 2014 10:13:05 +0000
Message-ID: <20140113101305.GX29039@sirena.org.uk>
References: <1389508694.13361.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QHp3Wr1K3N9pKO2V"
Cc: Thomas Chou <thomas-SDxUXYEhEBiCuPEqFHbRBg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389508694.13361.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--QHp3Wr1K3N9pKO2V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 12, 2014 at 02:38:14PM +0800, Axel Lin wrote:
> We already has NULL test for master after calling spi_alloc_master().

Applied, thanks,

--QHp3Wr1K3N9pKO2V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS07wuAAoJELSic+t+oim9kG0QAI06wLOehj4uKOKS2i1ouopC
dsTmWpCTz2h/cfWm1GOyG73vfm0/M4xDWXuZCPhjF+/mjzjHpsvotqSDZOwIsGoD
6+lQUVAy1xOHZC3TP+yb7gfbiYVRbFXx03jXuqscv3In8A5jaxEbiUMfdX4VtbfX
YxWvoswphVPHBixnBmhqgZgZJflqDQ682jzZALHomDv/S1SlOQrvVTaGunauk0mc
xgJsY3nATDOQxAmy95hESbOWpG1A3vUUPMO3+04+X1vbXmg6fknLDRKHi19SPqsp
gt9BOlZQKXZgVhPCme+5qk8JyTW4Zm4MM71pZDu8dz/JhJSZ+jlS4tfXpf5xqIJK
QLxJ4ChnLRkUin2gAn6mc+7cVqukHrsbaGlwHeIt1QQnMUj9uP1ZisYMNNpqzGdj
4KqPjAjn0StSd0h/FhNVy+wkhYn/z+f141Wmi8xDjvGextEV5A5UGKRMp+VnBkD1
8v98yxuk8svPom1tOXXwvO34lXxuYk9LS+w6v47TY16unIRCNraikVUJvK0eprCw
Lhb1JBJae/nu6PSmgo0W5wobuTX9QN+DL8z2cgSo3j6FUJknp35xYZpZ/S/FBGPG
GH0IwdDk8UzOuHFRZ5kK5qFr0aJ31pE8/8URScxvOYc9l9G8xjhfw7Vv2sO2m6FA
ZSRxCivQQJUn15uUAAO1
=TCtb
-----END PGP SIGNATURE-----

--QHp3Wr1K3N9pKO2V--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
