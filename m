From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v2 1/2] spi: Add call to spi_slave_abort() function when
 spidev driver is released
Date: Wed, 25 Sep 2019 21:57:39 +0200
Message-ID: <20190925215739.6692ee89@jawa>
References: <20190924110547.14770-1-lukma@denx.de>
        <20190925091143.15468-1-lukma@denx.de>
        <20190925091143.15468-2-lukma@denx.de>
        <20190925164517.GI2036@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/CKOQSV_mYnHZAmlMvZlX5hf"; protocol="application/pgp-signature"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzk@kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190925164517.GI2036@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

--Sig_/CKOQSV_mYnHZAmlMvZlX5hf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

> On Wed, Sep 25, 2019 at 11:11:42AM +0200, Lukasz Majewski wrote:
> > This change is necessary for spidev devices (e.g. /dev/spidev3.0)
> > working in the slave mode (like NXP's dspi driver for Vybrid SoC). =20
>=20
> Please do not submit new versions of already applied patches, please
> submit incremental updates to the existing code.  Modifying existing
> commits creates problems for other users building on top of those
> commits so it's best practice to only change pubished git commits if
> absolutely essential.
>=20
> That said I'll handle this this one time.

Thanks for help (and patience).


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/CKOQSV_mYnHZAmlMvZlX5hf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl2LxrMACgkQAR8vZIA0
zr38owf+NfpYq4idAYaz+acP1zbwiI6XJ+N6XPIdsxu6mT8UYz0fEfStkeuiCr+J
YTYcu5Krtr7nWv12Dgh+kDTCDqp3Pn9I+mRwOxEz2O6Rr9GqcE17LX8sFeBWToRW
3MT0phpVUKPwO3jqke9uoSItQ66we4UjGArhgiq5c14GYWSJl0TTwRyDwpkXKB0X
TlkAE/8H5Hld5ioXglA056fnYcXXz7sPYXUMmw8cm0jGwjzLTAjWs/WzI8S89TQF
Y3S+QVnskhA+r+XoMFZo6wpelqZQD3RULU6K/4ryoUYyiN8Buo1XGrVZBOJvUpIY
db8l3hi11iraVVU2bFilUdc59nofBw==
=M3+b
-----END PGP SIGNATURE-----

--Sig_/CKOQSV_mYnHZAmlMvZlX5hf--
