From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: restore rx/tx_buf in case of unset CONFIG_HAS_DMA
Date: Tue, 2 Jun 2015 21:55:10 +0100
Message-ID: <20150602205510.GZ14071@sirena.org.uk>
References: <1432548790-2249-1-git-send-email-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RGWD7DVgroTnY8ja"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1432548790-2249-1-git-send-email-kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--RGWD7DVgroTnY8ja
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2015 at 10:13:10AM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
>=20
> The case where spi_master sets the flags SPI_MASTER_MUST_RX/TX while
> CONFIG_HAS_DMA is unset (which is unlikley) together with a driver
> that reuses spi_messages with rx/tx_buff set to NULL, can result in:

Applied, thanks.

--RGWD7DVgroTnY8ja
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVbhgtAAoJECTWi3JdVIfQ8RQH/jchJ2eFx4X9OpBUe5Lh6oIr
I1G4alNbgQOp//9Um/GysGgrQYoLayAWLyVgYd62IbrDLcLuF/WErjSnlrJUnIrJ
arTAWpfjsl15pGvAg+RBDPwfyQqB2Yuw7M85N1z9GNuMvSnXeW+fE9ciQhvkp4u8
nATuXDr7AGC2ZNk5hi4Zfb33q74Zoc4pCER6xg/X7dc+y24UAXDWwFuK8sMh3ebk
hqKqK2nA+OS9NDcyUUNJ4AbSiAz4KHc7MajePPTlNnwXsXb2k9Mr8U3KZ+2b0x8H
4x4KkZnvHuTzMkUiGRvlst3PLmDwScqVwnOOhJT6NHrudgHYOdGLnCgh0kw+1zo=
=cfQf
-----END PGP SIGNATURE-----

--RGWD7DVgroTnY8ja--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
