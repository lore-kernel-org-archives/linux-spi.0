From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v1] spi: spi-fsl-dspi: remove clk reference when
 regmap_mmio initialize
Date: Fri, 24 Apr 2015 12:32:48 +0100
Message-ID: <20150424113248.GN22845@sirena.org.uk>
References: <1429872887-14438-1-git-send-email-haikun.wang@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7XnjLAzyvoZxtJoF"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Haikun Wang <haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1429872887-14438-1-git-send-email-haikun.wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--7XnjLAzyvoZxtJoF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 24, 2015 at 06:54:47PM +0800, Haikun Wang wrote:
> It is unnecessary for DSPI to enable/disable clk when access DSPI register.
> And it will reduce efficiency.

Applied, thanks.

--7XnjLAzyvoZxtJoF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOinfAAoJECTWi3JdVIfQ980H/jwy75ewnAy/k2y1FDxpCFhq
JwXBvW5Imm8ms4qI+ewUbfSBo3VSh7yyHNyOzNAm0CiN5QTIKGgbCGafjcshgj9U
nMB0YJpEc+dqgMShkHxS+w0BRGJ6vedCQqsfY4pYcCN1z3ujXxaMyrI6rtybg3nW
Vh03IX5QcGHSxKI6O/w/jn7Zmrtv/lvAwXH/3+z2yxtdYBmL/Ge3jclcOJ5zPli0
P7qW7i9KsuRLPo1BKlkd2yHWSYKZT4KEPA5FD3cdzn/aI7HX9VYpN9182H0TArg+
DVeG7ivcmrmdwFCoHE9EVR/bwPhjQP2EpkGm17+fMRUi7fZil6Ke/DJUEu5j1u4=
=LT/D
-----END PGP SIGNATURE-----

--7XnjLAzyvoZxtJoF--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
