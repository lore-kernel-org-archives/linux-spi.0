From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: atmel: Make current_remaining_bytes to be int
Date: Tue, 1 Apr 2014 13:25:39 +0100
Message-ID: <20140401122539.GT2269@sirena.org.uk>
References: <1395883598.14364.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0M9+YLHDVd0m18zA"
Cc: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395883598.14364.0.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--0M9+YLHDVd0m18zA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 27, 2014 at 09:26:38AM +0800, Axel Lin wrote:
> Don't use unsigned for current_remaining_bytes so we can check
> current_remaining_bytes < 0 case.
> Use int is enough for current_remaining_bytes.

Applied, thanks.

--0M9+YLHDVd0m18zA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIbBAEBAgAGBQJTOrBAAAoJELSic+t+oim9w5MP9jeW4ejJ5LxWYYaGRMVaNoad
ynEap9zwkKusciL87exarO6FMVlITR5ULY+MeYB08WILELLAVMtq+VMOyajhKJh3
ESsjEDUh7BYwZcn2Iium0M1dU5oW/HJrGPoPVWWUnhVUZNXiTWGhiGSFOGhhcBd2
x/67xUJQ/mwXKZ+5D5Mf8of7d2o+/VAb+3g4HE585brVWtos1oaMU74/F7VZTC1v
qiWD/FJdxIE9HOGvFEYX5UVcjTSdfU1ySWPf0CCyuM3ffCKrkektTk3/GDP7Rsq+
MU5iczJkvk9Jg61zZS3MkSi9Wnw3I5XNdHwfGDRmm1e3GFGlwEl9szD+q+sNXT6S
poeXTUUqJygbSID9WJcVNCZzf/YZBJ927O9R2IbxfuG9jazdSpjrV1nqQgY9/y3I
b2nGjVR17l1Q6Bv8FKE59GvZpBbIEYO3XmGkqXCchNN0fB9C3Wk8olC69btwvyJY
Th/uw0pIbsGx5Fh+Amve4QVIoO3c8B5p1i+X+oImgJYdbgbU9yDck320LZhOGDnA
eiMAnSecQWQCG/VjTsVTki7JY2Q7NsZKpBphb4m5fq76oWEahmDwSZOsjqrQk+22
PwVBsqPCT+1oKJRY5FDbd2Kzy9aC4Ob0H668mp9wDZuoPQZOba9byJ0Fpg4GyM2p
JlrdXd5AaAeOeP9SERE=
=Y+J1
-----END PGP SIGNATURE-----

--0M9+YLHDVd0m18zA--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
