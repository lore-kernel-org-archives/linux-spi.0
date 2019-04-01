From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V1 05/26] spi: tegra114: use unpacked mode for below 4
 byte transfers
Date: Mon, 1 Apr 2019 15:26:52 +0700
Message-ID: <20190401082652.GO2059@sirena.org.uk>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-5-git-send-email-skomatineni@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="R+Rs1qz93vBJxC1z"
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        robh+dt@kernel.org, mark.rutland@arm.com, kyarlagadda@nvidia.com,
        ldewangan@nvidia.com, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org
To: Sowjanya Komatineni <skomatineni@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1553666207-11414-5-git-send-email-skomatineni@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--R+Rs1qz93vBJxC1z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2019 at 10:56:26PM -0700, Sowjanya Komatineni wrote:
> Fixes: use unpacked mode when transfer length is less than 4 bytes.
>=20
> Packed mode expects minimum transfer length of 4 bytes.

This doesn't apply against current code, please check and resend.

Applying: spi: tegra114: use unpacked mode for below 4 byte transfers
error: sha1 information is lacking or useless (drivers/spi/spi-tegra114.c).
error: could not build fake ancestor

--R+Rs1qz93vBJxC1z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhy0sACgkQJNaLcl1U
h9BhDAf/YzC68CrCyTEHb0zYa6sYLWL4GsIiNvJeg+VaT2fxEqki1YlIGVaWux99
unPjxHCA29RjgY/n9HSV7LUquaEa9ewtfF6j8XFNHeseSJHqNpjP6mX0ULNHa6mJ
OqMDD0ylTHEDFsd2thdgLTd2+sz+/bAIY+46otC/OqsM3r1CI1iiPHKAuD7l0eOF
WDfPcAemcwTPOjZObqUBIblIThEZ8yF0r4PKFsIktFdXDWJxJJastthlsCLJiLg7
x8R1wAYUqpLUNwtjlO9pmYfupGw2y1TOtU/Ke5lR44dtwijcfrRbr86nL95PYV54
3pTsoGn6AL1iLQfbsxsvFUgQAeSHaA==
=yHR5
-----END PGP SIGNATURE-----

--R+Rs1qz93vBJxC1z--
