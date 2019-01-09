From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v6 0/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Date: Wed, 9 Jan 2019 15:56:30 +0100
Message-ID: <20190109155630.3ec34c60@jawa>
References: <1546939346-20181-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <7188c406-3dd2-88a6-b6ed-d5e8bf678df8@kontron.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/qfV7IP6UbfJ_zClhLB+efu+"; protocol="application/pgp-signature"
Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
To: Schrempf Frieder <frieder.schrempf@kontron.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7188c406-3dd2-88a6-b6ed-d5e8bf678df8@kontron.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

--Sig_/qfV7IP6UbfJ_zClhLB+efu+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Schrempf,

> On 08.01.19 10:24, Yogesh Narayan Gaur wrote:
> > - Add driver for NXP FlexSPI host controller
> >=20
> >   FlexSPI is a flexsible SPI host controller [1], Chapter 30 page
> > 1475, which supports two SPI channels and up to 4 external devices.
> >   Each channel supports Single/Dual/Quad/Octal mode data transfer
> > (1/2/4/8 bidirectional data lines) i.e. FlexSPI acts as an
> > interface to external devices, maximum 4, each with up to 8
> > bidirectional data lines.
> >=20
> > - Tested this driver with mtd_debug(Erase/Write/Read) utility and
> > JFFS2 filesystem mounting and booting on NXP LX2160ARDB[2] and
> > LX2160AQDS targets. LX2160ARDB is having two NOR slave device
> > connected on single bus A i.e. A0 and A1 (CS0 and CS1).
> >   LX2160AQDS is having two NOR slave device connected on separate
> > buses one flash on A0 and second on B1 i.e. (CS0 and CS3).
> >   Verified this driver on following SPI NOR flashes:
> >     Micron, mt35xu512aba, [Read - 1 bit mode]
> >     Cypress, s25fl512s, [Read - 1/2/4 bit mode]
> >=20
> > [1] https://www.nxp.com/docs/en/reference-manual/IMXRT1050RM.pdf
> > [2]
> > https://patchwork.kernel.org/project/linux-arm-kernel/list/?submitter=
=3D182097
> >=20
> > Yogesh Narayan Gaur (5):
> >    spi: spi-mem: Add driver for NXP FlexSPI controller
> >    dt-bindings: spi: add binding file for NXP FlexSPI controller
> >    arm64: dts: lx2160a: add FlexSPI node property
> >    arm64: defconfig: enable NXP FlexSPI driver
> >    MAINTAINERS: add maintainers for the NXP FlexSPI driver
> >=20
> > Changes for v6:
> > - Rebase on top of v5.0-rc1. =20
>=20
> Your patches don't apply to v5.0-rc1. It seems like you have instead=20
> rebased onto the for-5.1 or for-next branch of the SPI tree. I guess=20
> this is okay, but you should have pointed that out correctly here.

If I may ask for a few (1-2) days, so I can test this code on vf610 NXP
SoC.

As fair as I remember there were some issues when I tested it a few
months back.

>=20
> > - Incorporated review comments for
> >    patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> > - Updated s-b tag in all patches.
> > Changes for v5:
> > - Rebase on top of v4.20-rc2
> > - Incorporated review comments for
> >    patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> > Changes for v4:
> > - Incorporated review comments for
> >    patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> > - Incorporated binding file review comments.
> > Changes for v3:
> > - Incorporated review comments for
> >    patch 'spi: spi-mem: Add driver for NXP FlexSPI controller'.
> > Changes for v2:
> > - Incorporated Boris review comments and drop below patches as per
> > the comments.
> >   - Patch 'spi: add slave device size in spi_device struct'
> >   - Patch 'spi: add flags for octal I/O data transfer'
> > - Incorporated DTS and Binding file review comments of Shawn Guo
> > and Rob Herring.
> >=20
> >   .../devicetree/bindings/spi/spi-nxp-fspi.txt  |   39 +
> >   MAINTAINERS                                   |    7 +
> >   .../boot/dts/freescale/fsl-lx2160a-rdb.dts    |   22 +
> >   .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |   13 +
> >   arch/arm64/configs/defconfig                  |    1 +
> >   drivers/spi/Kconfig                           |   10 +
> >   drivers/spi/Makefile                          |    1 +
> >   drivers/spi/spi-nxp-fspi.c                    | 1095
> > +++++++++++++++++ 8 files changed, 1188 insertions(+)
> >   create mode 100644
> > Documentation/devicetree/bindings/spi/spi-nxp-fspi.txt create mode
> > 100644 drivers/spi/spi-nxp-fspi.c=20
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/qfV7IP6UbfJ_zClhLB+efu+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlw2C54ACgkQAR8vZIA0
zr0Bygf8CIJkJt1rC2YiQntRmvFJk7rlDUHSGzV+pRjNWOGCzkv9Q8wBs7GUjXeC
XcOe+RXQgzwhAH3ByyxMBmtdC55PqceJDb30NQyExXCVhMpuqdmU2G0R7l9g6H8D
odGNDv6IC47oMzaq8zT6dC2f1iddFpfuQ4qvyDjBmEpyqTKPFFSH8KNTRa6Kjoph
Opg8/CjSvxaPQMtBQkl0MqKI5lr9iSAMPrL6Gk3FnU0hqMtEZmgbBflieJoIZo77
5mvs1nWSWAs8yEvVqH1VN9HqBLvZSi8RvMgCzvQB4kt/gh3ehGPN9hLbELeMDp24
xasMUxYP8WrDjPZtm5kwEWX9gcvbxQ==
=S3Bd
-----END PGP SIGNATURE-----

--Sig_/qfV7IP6UbfJ_zClhLB+efu+--
