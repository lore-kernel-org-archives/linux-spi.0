From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] spi: bitbang: fix shift for getmosi
Date: Wed, 12 Mar 2014 16:24:18 +0000
Message-ID: <20140312162418.GU28112@sirena.org.uk>
References: <1394639617-26917-1-git-send-email-m.grzeschik@pengutronix.de>
 <1394639617-26917-2-git-send-email-m.grzeschik@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BgY/xPMXw0GQoUOb"
Cc: linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	kernel@pengutronix.de, stable@vger.kernel.org
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1394639617-26917-2-git-send-email-m.grzeschik@pengutronix.de>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--BgY/xPMXw0GQoUOb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 12, 2014 at 04:53:35PM +0100, Michael Grzeschik wrote:
> The driver needs to shift the word bit after reading the mosi bit.
> Otherwise the return word will have an Off-by-one bit value.

This isn't exactly new code...  do we understand why nobody has noticed
this before?

> @@ -61,10 +61,10 @@ bitbang_txrx_be_cpha0(struct spi_device *spi,
>  		spidelay(nsecs);
> =20
>  		/* sample MSB (from slave) on leading edge */
> -		word <<=3D 1;
>  		if ((flags & SPI_MASTER_NO_RX) =3D=3D 0)
>  			word |=3D getmiso(spi);
>  		setsck(spi, cpol);
> +		word <<=3D 1;
>  	}

Just looking at the context here it's not obvious to me that this is
helping - it means that the last bit we read is going to be shifted
which seems wrong, we ought to be reading into LSB.

--BgY/xPMXw0GQoUOb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIIovAAoJELSic+t+oim9LFEQAI20hQKYQy547CrcV9BpVmzk
CoIrRYwO8vlQCnLsJ7pk79W/Gaxh50wtQLHPDDT6A15PUsz8Rp61jpnh6TSJgqze
8KZICvBI75D3StnDVkz9ibDZIPKnPpA2a+p6xgM38FVhFRRzcB5mmK56KczNHt7M
Pt2wAmhILZioNqIiUeKJyhxw1CB09aatMdmDraasmpmdxwv+wDqxsRdqkEAJaUSH
7KbaY7CG8cfdlwbxctOMLAdmuwtM38DxP7qFtwusyBydZqufwcsfK7bTuAzloBsp
QeIfedMkg+LVc5H03ElcK9+XWuJwC7mkS9A5SmiGX2uIyrA740YrYQ0X9DCdrGzV
hzZg+Z0Jed1GqyOXBZm3mbdqewmpr7a2gZoNgsh296DxCwK/euJHG9fJlFvofwWc
k3vaHWCSUdQm7zTv0wbXQejccgkze2EjUXwWcnvm9MSG1n8KduLsUl8ActwErxvA
Mil1ZNYX40guhBGGBFk9hpWZ2xudh2GNHkJFnJ6jT3jPSu6hPmx9WQEuOFXdmtzG
DCRgx8FA6B+YJH4K9214AhOC/xQ20XMXun6+ZL/8tay2ZgSYp+2zwoV14fZVn467
WbVzdIAclykk2muQ7rXdrxNYYa4SZHOO8zRSorLZ4FYMXsf11OjOOzsOw5Ddly++
YWAsVc5RC0Sc08BnsHcz
=6TWd
-----END PGP SIGNATURE-----

--BgY/xPMXw0GQoUOb--
