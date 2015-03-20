From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: Add SPI driver for Mikrotik RB4xx series boards
Date: Fri, 20 Mar 2015 12:56:27 +0000
Message-ID: <20150320125627.GK2869@sirena.org.uk>
References: <1426853793-24454-1-git-send-email-bert@biot.com>
 <1426853793-24454-2-git-send-email-bert@biot.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="09CsGkDdkTpDWDy8"
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Bert Vermeulen <bert@biot.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426853793-24454-2-git-send-email-bert@biot.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--09CsGkDdkTpDWDy8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2015 at 01:16:32PM +0100, Bert Vermeulen wrote:

> index 856d34d..0d55661 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -616,6 +616,7 @@ struct spi_transfer {
>  	struct sg_table rx_sg;
> =20
>  	unsigned	cs_change:1;
> +	unsigned	fast_write:1;
>  	unsigned	tx_nbits:3;
>  	unsigned	rx_nbits:3;
>  #define	SPI_NBITS_SINGLE	0x01 /* 1bit transfer */

One other thing I just noticed: this is extending the core with no
documentation or other comment on what it's supposed to do (there's no
commit message at all).  Any changes to the core should be a separate
patch which makes it clear what the changes are supposed to do.

--09CsGkDdkTpDWDy8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDBj6AAoJECTWi3JdVIfQ+0gH/3CSDV+t3aCoq0dmjFaFmxke
VI4J7E7lmrMLkzIUonknHHNr0ZBevgB+qVAVb2+D13cn9T3pdCC8rmrVyeP8AkbY
Zwt4TihTAw7KKUJGTFWRTOHguWRLQFSuTM8pQqqX+2Rj/AS1Ez7vW1P03pQkJviV
kTI3iiomN+iA9sdkcHHPINeRijtIVQh++cgJKYfRHLXxwuwNcBRox5c5AzDzEyKg
K9B3QRZupeyUVNZWRGiWSNSGLUxEF7qz/6fpC+i9131j6ybSr+Atg2x4D3nWJgFS
ph9LVVavMtkzDUgQRIzf+kGrfQA9FvC/XRhVZihMsTFDIn+dp8xmKlk5fyfhizM=
=4K//
-----END PGP SIGNATURE-----

--09CsGkDdkTpDWDy8--
