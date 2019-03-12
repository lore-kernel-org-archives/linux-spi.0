From: Volker Haspel <volker.haspel@linutronix.de>
Subject: Re: [PATCH] spi: spi-fsl-qspi: call spi_unregister_controller
Date: Tue, 12 Mar 2019 09:43:48 +0100
Message-ID: <20190312094348.177c5dd2@ares.tec.linutronix.de>
References: <20190307103008.19841-1-volker.haspel@linutronix.de>
        <20190311170334.GA14368@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/DpBpi6KJDq6E4j_vbdsovl."; protocol="application/pgp-signature"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        Han Xu <han.xu@nxp.com>, john.ogness@linutronix.de
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190311170334.GA14368@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

--Sig_/DpBpi6KJDq6E4j_vbdsovl.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 11 Mar 2019 17:03:34 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Thu, Mar 07, 2019 at 11:30:08AM +0100, Volker Haspel wrote:
> > The driver does not clearly unregister the spi controller.
> > Therefore calling an unbind and bind again will end up in a
> > Kernel crash.
> > Each driver who calls spi_register_controller() in the probe function
> > has to call spi_unregister_controller() too. =20
>=20
> Why not change it to use devm?

Hi Mark,

I agree, this is a much nicer solution! I will test it and send a v2.

Thanks

--Sig_/DpBpi6KJDq6E4j_vbdsovl.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEu6ObeCfmxsAHs47wMVbdr+4FyroFAlyHcUQACgkQMVbdr+4F
yrr4Aw/9EJaqrDWEpEQ6sFxo+K1cHC8kHEjxdwI7hzH4z3HiaG6+jNz0CN++cpOB
4MLzMc9gN0TumYHs9ryAxu7CjHLA84MDal8yknzmcg7ejH42NDM+3ZWbPY9QBeMZ
n7R3VXRy1mPzsYFQLaM0vnulau80Sn86AyCOnCCunU1k5swPdISGSqpwnxp880Y8
RzNR7tDepbUnslAPwxGJDOs160ZqbLvDlGlFWDrueS9s4Lw/jO5T6Dq70I1DsauZ
qSvpryTdhkQSLBdc21lmBtNAePrDpgn/n4GTWKqVSjQRbSN86PhfYo1OEb2yCftK
Z9wrptc7WklrVPPs57q/SOhNe0AsbQ44InSL6qa0J588YSuEfjxkkE0R76LvJPmU
FfUs9iV7lgDpzAv7E0oUpFKKF7K62kCObhGZAPPibk1l5tAHhJmaYC74Uljy+z9o
QvDO6NXqfS21Klqvb8Ut8UeVzkkjHBpwIvmRIqFyNI5XCxlyANSmxOTt23IW6iDX
SCiT5CCi2DsL7FW0W6Qux6zwuKDZy3K2XmZGjbTo2IDiuO3k/zcuuMLXfcNePptp
/QmgQ3Krmd4kYcaMEeO8uIfg3m+6HPfPIfPYa2CYM/UKTWY6NpSW2Ub9+x77gA41
n2DGLvRdPSHXH4z9Cj47n9q6lWuhyyxy+LEu+pFZwHd91sRHIRQ=
=CNXW
-----END PGP SIGNATURE-----

--Sig_/DpBpi6KJDq6E4j_vbdsovl.--
