From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: sh-msiof: Fix limit maximum word transfer size of
 FIFO size
Date: Thu, 12 Mar 2015 11:37:15 +0000
Message-ID: <20150312113715.GN28806@sirena.org.uk>
References: <1426127476-18456-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sOL4abEY/Q7jo/xc"
Cc: linux-sh@vger.kernel.org, linux-spi@vger.kernel.org,
	yoshihiro.shimoda.uh@renesas.com
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj@renesas.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426127476-18456-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--sOL4abEY/Q7jo/xc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2015 at 11:31:16AM +0900, Nobuhiro Iwamatsu wrote:
> This driver is the case of tx_buf was set or SPI_MASTER_MUST_TX is set to
> master_flags, will be transmit mode. However, the current code, when
> transmit mode and buffer is NULL, will be set to value of receive mode
> size.

Applied, thanks.

--sOL4abEY/Q7jo/xc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVAXpqAAoJECTWi3JdVIfQhSMH/0YAXxNSu1Ij7vnw0aNpDs0r
NLYzBGRA4h+Z3ujtDJgANRo07OYHoIWCh8JOSDXq+07lAFErXSdRu4Y5q2sDCKH/
hgdq7UO8E05lqfKmIuFC2nv6yFhMKWBSzyr1tFHORNX/Hm4rA8WgLLfpjsap05Oz
ef2on8y46GgFHmsq8zCOFu3PPlyR/rzGg7y44iHA6bYcNJUh4hgMX65xX5v/MUih
XOguHKtRQWbTAzTZrnJTMRO0uYtVCob0ELmIyGe0l9xtJoLmlfYWkekO2rZ/F/B1
Ry1uQ+Jmg+F8+E9X2TCw7yjbtoWwiJfnhHY385B2pkN7FRUHxrrXS9/MaDU70yM=
=wg57
-----END PGP SIGNATURE-----

--sOL4abEY/Q7jo/xc--
