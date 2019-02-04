From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v5] ARM: dspi: Provide support for DSPI slave mode
 operation (Vybryd vf610)
Date: Mon, 4 Feb 2019 13:52:42 +0100
Message-ID: <20190204135242.7112d48c@jawa>
References: <20180927150709.17010-1-lukma@denx.de>
        <20190109082644.14941-1-lukma@denx.de>
        <20190204113001.77d59570@jawa>
        <20190204105737.GE23441@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/F.zUuRU1SQQ7HjrB2HRAYut"; protocol="application/pgp-signature"
Cc: Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>,
        Martin =?UTF-8?B?SHVuZGViw7hsbA==?= <martin@geanix.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190204105737.GE23441@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

--Sig_/F.zUuRU1SQQ7HjrB2HRAYut
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Mark,

> On Mon, Feb 04, 2019 at 11:30:01AM +0100, Lukasz Majewski wrote:
>=20
> > Is there any interest in adding new code (or fixes) to VF610 ?  =20
>=20
> You've been sending ARM: patches to me (the SPI maintainer) and one of
> the DT maintainers.=20
> You need to send patches for that platform to the
> relevant platform maintainers, I only maintain drivers/spi (and some
> other subsystems).  Similarly the DT maintainers only maintain the
> generic devicetree stuff (but apply relatively few patches directly).
>=20
> Please see submitting-patches.rst for details.

https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html
Point 5):

git format-patch -1 e26e01ac03aae6cf296e7b4de47354d3151b21e7
0001-ARM-dspi-Provide-support-for-DSPI-slave-mode-operati.patch

./scripts/get_maintainer.pl
0001-ARM-dspi-Provide-support-for-DSPI-slave-mode-operati.patch Mark
Brown <broonie@kernel.org> (maintainer:SPI SUBSYSTEM)
linux-spi@vger.kernel.org (open list:SPI SUBSYSTEM)
linux-kernel@vger.kernel.org (open list)

Moreover, I've CC'ed developers (Esben, Andrey, Martin) involved in the
changes for previous work done in this file/driver.

And those changes are solely related to SPI work in this driver, no ARM
Vybrid.

What else shall I do?


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/F.zUuRU1SQQ7HjrB2HRAYut
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlxYNZoACgkQAR8vZIA0
zr1NRgf8CH5Sc12KgowOsWlBhD7ixLeZAihKwP/LV7loEyTPoavCSahgCd9u6Au3
g2V9AHmew5s8j1eFmEixI7dXZHBBXL0j24DaH4dMJCBUQ5POfqz1cXOBgxo2/V+p
fc+QJkNlH5p8kmxDwmjO+yyvGVNpjAo6MZTvQU2UBiCVh793YqlodOQMajX5AYnK
uawizR9WcwIN9644Dj1RcRkYi5dF0NGWiRxl56cn1PdD5L6b3Fgp1l/evfy0c16Z
GbCXLUwl24RpUdsYxwVvdN9jPuXvytWXrl0ZRLfHl2TxNgT69PSvo8//H4GlHxA3
zc1zHhDy162j2S56jIq0B6M+VyDspg==
=oXFs
-----END PGP SIGNATURE-----

--Sig_/F.zUuRU1SQQ7HjrB2HRAYut--
