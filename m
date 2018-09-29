From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [RFC/RFT PATCH v1 9/9] mtd: spi: Skip reading the Serial Flash
 Discoverable Parameters
Date: Sat, 29 Sep 2018 22:57:16 +0200
Message-ID: <20180929225716.4da9790c@jawa>
References: <20180926220739.620-1-lukma@denx.de>
 <20180926220739.620-10-lukma@denx.de>
 <1a85becb-6cb0-ede4-be0a-2608e8532c9e@wedev4u.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4691108870317545770=="
Cc: Mark Rutland <mark.rutland@arm.com>, yogeshnarayan.gaur@nxp.com,
 richard@nod.at, prabhakar.kushwaha@nxp.com, linux-kernel@vger.kernel.org,
 Stefan Agner <stefan@agner.ch>, linux-spi@vger.kernel.org,
 albert.aribaud@3adev.fr, boris.brezillon@bootlin.com,
 Frieder Schrempf <frieder.schrempf@exceet.de>, broonie@kernel.org,
 linux-mtd@lists.infradead.org, han.xu@nxp.com,
 Fabio Estevam <fabio.estevam@nxp.com>, david.wolfe@nxp.com,
 computersforpeace@gmail.com, Fabio Estevam <festevam@gmail.com>,
 dwmw2@infradead.org
To: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1a85becb-6cb0-ede4-be0a-2608e8532c9e@wedev4u.fr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

--===============4691108870317545770==
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wLhr5klBZJk09xPzDXUVnEx"; protocol="application/pgp-signature"

--Sig_/wLhr5klBZJk09xPzDXUVnEx
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Cyrille,

> Hi Lukasz,
>=20
> Le 27/09/2018 =C3=A0 00:07, Lukasz Majewski a =C3=A9crit=C2=A0:
> > The fsl-quadspi.c driver is not supporting SPINOR_OP_RDSFDP (0x5a)
> > read opcode - in the legacy driver we do read some garbage
> > data from AHB mapped area and then return on the first check =20
>=20
> If your controller reads garbage then spi_nor_parse_sfdp() fails and
> exists on the very first check: signature of the SFDP header. Hence
> everything should already go on as if the SPI_NOR_SKIP_SFDP flag is
> set.

Yes, this is the observed behaviour.

>=20
> So this patch doesn't change anything for your controller but
> prevents other controller from using QSPI protocols like SPI 1-4-4.
>=20
> This patch introduces a regression for other chips.

As stated in the patch series cover letter - this is to explicitly show
problems with qspi on vf610.

Thanks for your review.

>=20
> Best regards,
>=20
> Cyrille
>=20
> > (L2376 @ ./mtd/spi-nor/spi-nor.c)
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  drivers/mtd/spi-nor/spi-nor.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c
> > b/drivers/mtd/spi-nor/spi-nor.c index 442102be174e..c79b8c33aeeb
> > 100644 --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -1103,7 +1103,7 @@ static const struct flash_info spi_nor_ids[]
> > =3D { { "n25q064",     INFO(0x20ba17, 0, 64 * 1024,  128, SECT_4K |
> > SPI_NOR_QUAD_READ) }, { "n25q064a",    INFO(0x20bb17, 0, 64 *
> > 1024,  128, SECT_4K | SPI_NOR_QUAD_READ) }, { "n25q128a11",
> > INFO(0x20bb18, 0, 64 * 1024,  256, SECT_4K | SPI_NOR_QUAD_READ) },
> > -	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256,
> > SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ) },
> > +	{ "n25q128a13",  INFO(0x20ba18, 0, 64 * 1024,  256,
> > SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ |
> > SPI_NOR_SKIP_SFDP) }, { "n25q256a",    INFO(0x20ba19, 0, 64 *
> > 1024,  512, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > { "n25q256ax1",  INFO(0x20bb19, 0, 64 * 1024,  512, SECT_4K |
> > SPI_NOR_QUAD_READ) }, { "n25q512a",    INFO(0x20bb20, 0, 64 * 1024,
> > 1024, SECT_4K | USE_FSR | SPI_NOR_QUAD_READ) },=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/wLhr5klBZJk09xPzDXUVnEx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAluv5ywACgkQAR8vZIA0
zr1CtQf/UFnXEMZgjoow6gqhGbLF42wN6RzpWO8FcqlDHCBbdo6AjyBvT7Gm994R
/jHnDYdgtIB7W14dLPB1w4ZBnuTvKMxpLEydAAv7Ev3b8yuxmCKm3wyWWDRuRmir
ZxhONRo2rdpfDyVoJfCJljU8pww5i1/IrC9q2hahHLJ7o/ggF4rKNme+siGaXHY/
LZuUFnPVT97uzYZy/AfDxADLZcoggLEYefaDL0SLsM/Oe/B38O5YkteUAsAO+FQc
iJ9+CyuW0CU16LDYmts+A49JRpA+SWOvyaurhzt2pdBnrY+FD+HemRP41MdbtXx5
sV2RvJ/8ZqgtptOpDNnE+SY6xG+LCg==
=Uocv
-----END PGP SIGNATURE-----

--Sig_/wLhr5klBZJk09xPzDXUVnEx--


--===============4691108870317545770==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============4691108870317545770==--
