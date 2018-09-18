From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH 0/3] ARM: dspi: Provide slave mode support for Vybryd
 vf610
Date: Tue, 18 Sep 2018 11:42:33 +0200
Message-ID: <20180918114233.0622399c@jawa>
References: <20180918093437.26799-1-lukma@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/vk1mDwG/8QNvqvfmzq9ddah"; protocol="application/pgp-signature"
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Esben Haabendal <eha@deif.com>,
        Martin =?UTF-8?B?SHVuZGViw7hsbA==?= <martin@geanix.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918093437.26799-1-lukma@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

--Sig_/vk1mDwG/8QNvqvfmzq9ddah
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Dear All,

By a mistake I've forgotten to add (to CC/TO) some developers who worked
on this driver before (they were not generated from get_maintainers.py
script).

I'm sending the notification now.

> This patch series provides support for DSPI slave mode operation.
> It tries to maximally reuse current DMA driver (including its
> limitations).
>=20
> For testing the spidev_test program has been used.
> Test script for this patch can be found here:
> https://github.com/lmajewski/tests-spi/blob/master/tests/spi/spi_tests.sh
>=20
> Lukasz Majewski (3):
>   dt-bindings: spi: Provide bindings for fsl dspi working in slave
> mode ARM: dspi: Provide per DSPI instance of the MCR register (SLAVE
> mode) ARM: dspi: Provide support for DSPI slave more operation (Vybryd
>     vf610)
>=20
>  .../devicetree/bindings/spi/spi-fsl-dspi.txt       |  8 ++++
>  drivers/spi/spi-fsl-dspi.c                         | 54
> ++++++++++++++++------ 2 files changed, 49 insertions(+), 13
> deletions(-)
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/vk1mDwG/8QNvqvfmzq9ddah
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlugyIoACgkQAR8vZIA0
zr2iwwf+JDDXKnvZjSt3h5f4uCKBZ1g48uQLvdPZUdxvlryuUL9ZaXCjaxJ1nQMs
StKx8nZAQZlAV92Bgr7FdJXX+R7RDb9rRBRUUfKT5Fh1jZHAgMHUTibnyAC43UQO
0TAUMf1OTFuHUMLmfcgsoOTx3S2MnGGgOJP0vyrn8jkItEk5SVsQuBUAINbzQlNy
WKI24AQ3PP7NLv63JaGKMwNt049i66On8/RHyzL6uLvIGFMOi3lFGNKxy4FdvsAR
uG7iXfiHaHxv8kyqnVZL39bXqmzrK7xPKK78sSOAolHmbqq8BZTMdLd9Hawx2ohN
u+xZSjpW3uLA4VWGFlBbCq4yhhZypg==
=T+bD
-----END PGP SIGNATURE-----

--Sig_/vk1mDwG/8QNvqvfmzq9ddah--
