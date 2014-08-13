From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] spi: xilinx: Remove .owner field for driver
Date: Wed, 13 Aug 2014 13:33:43 +0100
Message-ID: <20140813123343.GR17528@sirena.org.uk>
References: <d35c656e50eb7cc951499f13ef339d6aa1a23deb.1407930755.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FQUN4+YcNB5eWpmR"
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Michal Simek <michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d35c656e50eb7cc951499f13ef339d6aa1a23deb.1407930755.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--FQUN4+YcNB5eWpmR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2014 at 01:52:39PM +0200, Michal Simek wrote:
> There is no need to init .owner field.
>=20
> Based on the patch from Peter Griffin <peter.griffin@linaro.org>
> "mmc: remove .owner field for drivers using module_platform_driver"
>=20
> This patch removes the superflous .owner field for drivers which
> use the module_platform_driver API, as this is overriden in
> platform_driver_register anyway."

Would it not be better to do this as a tree wide or at least subsystem
wide sweep with something like cocinelle?

--FQUN4+YcNB5eWpmR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT61sjAAoJELSic+t+oim9NSAP/i6xKj+OBzIRU2NOebXsaWxQ
o+W2AgNeL7a1enJjM89p73b2ZWD92/52pHsGKeEAvQdeqOj9Y3GYEqzAYL/ds9fA
0eMpawOGBxtw/dSxM/L09Fi9gjD3UCF4MUdieF/k92DM0kXG9Z18snU38pbGdUkh
8RS/UfCaAEqVFoQSm3vOc5hVOuhW3ylZfh98j/RGA7CDJlLzRbC1nKdY4aQiuHQl
x3+8+UMUhIyvnj0BoGH4zD/btJLQR73AcCdZ8gLL6FW4WevGtQbC/y3kc3YEMAzN
YHSOmuqFeNTaGAsYUBDbZkI6YrdWK4224MEtZ2Nx7YyHrlmFdfy8r0TZIaOuhTd0
1RK+eJRfgcO1rz+oGNr9AczCc/0t8Eb+Uo2lXKCce6qTUK+0jtEzw8adNNrmIGJm
Z7VWUcb2lNAshpBpArYaGIRRjiYlB9UO4G3W9FY5dy3dpqkmM/iYcmMtzo2l7ICA
YLeWdXDaHnxWEjuDuGCW+oL3//ZwuO+Aa9RN7chEDXUwea4Sh0gi0n/W5pnqyC2C
r7BLXVg2TALIjUUCBlb+IMkvcBScmtsB4VshldW6liD+jPAbPibcj/7g4NI+DEvF
3fyXle16Y/ooMHa1ot5xDLFnl33NKMfUxMsgFiL7cvwCJBAGozLlvVEBI5XmoejH
tPpGAfDe/O1hDYRFjs6T
=TGiQ
-----END PGP SIGNATURE-----

--FQUN4+YcNB5eWpmR--
