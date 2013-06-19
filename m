From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/3] spi: s3c64xx: added support for polling mode
Date: Wed, 19 Jun 2013 19:21:21 +0100
Message-ID: <20130619182121.GC1403@sirena.org.uk>
References: <1369032694-13183-1-git-send-email-ks.giri@samsung.com>
 <1369032694-13183-2-git-send-email-ks.giri@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bmO0DhbO8B5xO2aX"
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	grant.likely@secretlab.ca
To: Girish K S <girishks2000@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1369032694-13183-2-git-send-email-ks.giri@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--bmO0DhbO8B5xO2aX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 20, 2013 at 12:21:32PM +0530, Girish K S wrote:
> From: Girish K S <girishks2000@gmail.com>

> The 64xx spi driver supports partial polling mode.
> Only the last chunk of the transfer length is transferred
> or recieved in polling mode.

Applied, though I will send a followup since:

> +static u32 wait_for_timeout(struct s3c64xx_spi_driver_data *sdd,
> +					int timeout_ms)

...this function name is way too generic.

--bmO0DhbO8B5xO2aX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIbBAEBAgAGBQJRwfaeAAoJELSic+t+oim951IP+JEo+8Zqw/fhTNRCTOjM/y4a
9yuRc0Hm09jq3fUXm89ImE/XnckFdsYsHf/qiN/b4YRsl8sY+X8pMdocC+Jxf/5h
WTF7iwIxyvxQVrTrDw0z4mUw6RAUhHpOsyxje8KMlDnkrA0xKAX1wgwExHuSPK7f
7rwrZ211YRL4NHesbX6MlSzcE376PBxnoDLoHfAmijfF/R1y6kUnAcUseuZ81Tx0
Igy24nH1fOTU2PxwD++PlzIqOlgPZQqFbtGDychCSCFwz5smCrabJcYiOLrUFDvR
sJpQ/sshmndtYsBYlp3/jG0IelBI/UJTLu0i/2hDpN7d+G9QiqidRD1xgXfMUCbK
gz2GShUDyYCeSFZ+H7CR1Z1R/ftBUyMA1VOHAsDJCbI+bIzTbig/Mi4J0wWuBpon
OWupAhsrAR/uvFa9rIQSUIeGppttrZHnFFoEHOPXfL4anLFwQ4sIIiU41OHY9q/w
Bn1scm5p/gW0aT62wR+jHYgVNUl3iOSjb9TvCVIuw7G1x4LUp8OtEGUgDsKbAvfj
UyFqLqXZb6khHheWY67PGIMWFee5xlhpMs3Aw2CYF8GToAQ/NBn0Rf9fK+7+Mhtd
pL8zlEfx1VZp1wRKpjIUImZNNX95IKgXQ2XRiAMeEiT+S5L0/xMmdZlyenpN22Yr
IFvqF7iuw3OtL4DgqJk=
=/Frv
-----END PGP SIGNATURE-----

--bmO0DhbO8B5xO2aX--
