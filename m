From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [RFC/RFT PATCH v1 0/9] mtd: fsl: quadspi: Fixes for
 fsl-quadspi.c driver (vybrid HW)
Date: Sat, 29 Sep 2018 23:02:40 +0200
Message-ID: <20180929230240.1c8d844d@jawa>
References: <20180926220739.620-1-lukma@denx.de>
        <20180929000359.34fe18ae@bbrezillon>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/a+5Md_GOwEt4zKecGlK.e2J"; protocol="application/pgp-signature"
Cc: Frieder Schrempf <frieder.schrempf@exceet.de>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, yogeshnarayan.gaur@nxp.com,
        richard@nod.at, Stefan Agner <stefan@agner.ch>,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        prabhakar.kushwaha@nxp.com, han.xu@nxp.com, broonie@kernel.org,
        david.wolfe@nxp.com, computersforpeace@gmail.com,
        dwmw2@infradead.org, albert.aribaud@3adev.fr
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180929000359.34fe18ae@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

--Sig_/a+5Md_GOwEt4zKecGlK.e2J
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 29 Sep 2018 00:03:59 +0200
Boris Brezillon <boris.brezillon@bootlin.com> wrote:

> Hi Lukasz,
>=20
> On Thu, 27 Sep 2018 00:07:30 +0200
> Lukasz Majewski <lukma@denx.de> wrote:
>=20
> > Please find following set of patches, which provide improved
> > behaviour of the fsl-quadspi.c driver on Vybrid vf610 HW.
> >=20
> > Below code is based on previous work done by Albert ARIBAUD:
> > https://patchwork.ozlabs.org/patch/675401/
> >=20
> > I've cleaned up the code a bit, make separate patches, exclude not
> > needed parts and port it to v4.19-rc3.
> >=20
> > After applying those patches, the quadspi controller on vf610 works
> > with UBI/UBIFS.
> > The problem is with some corner case writes to raw MTD device
> > (like writing 1023B with single byte writes). Those fail sometimes.
> >=20
> > Regression tests can be found in the following repository:
> > https://github.com/lmajewski/tests-spi/tree/master/tests
> >=20
> > (Please read README.txt).
> >=20
> > The NXP's community thread regarding HW issues in this block on
> > the vf610:
> > https://community.nxp.com/thread/485139
> >=20
> > Maybe those patches will be helpful with the new, work in progress
> > driver for spi-fsl-qspi.c =20
>=20
> Talking about that, can you try to port your fixes on top of Frieder's
> patchset? I'm pretty sure some bug fixes are irrelevant after the
> migration to spi-mem (patch 1, 3, 4, 5, 6, 7 and 9 should be dropped I
> think).

The problem is that Frieder's patch is using IP command mode for
transfers smaller than AHB RX fifo size.
This according to the comment in the current driver is broken in HW for
Vybrid (so this is a regression).

I'm also wondering if other users of vf610 based boards experience
issues with QSPI?

In my case, after running the UBI/UBIFS tests (on the original and
new driver without those "fixes") I cannot mount the volume after
creation as the header is wrongly read.

>=20
> >=20
> > Lukasz Majewski (9):
> >   Revert "mtd: fsl-quadspi: Rename SEQID_QUAD_READ to SEQID_READ"
> >   mtd: qspi: Provide quirk to read only half of RX buffer (NXP's
> > vybrid) mtd: spi: Do not setup the default seqid as we got it set
> > for DUAL and QUAD
> >   mtd: spi: Modify the HW capability mask according to supported RX
> >     lanes
> >   mtd: spi: Provide LUT entry to perform DUAL read
> >   mtd: spi: Enhance the fsl_qspi_read() method to support DUAL and
> > QUAD mtd: spi: Add SPI_NOR_DUAL_READ property for the 'n25q128a13'
> > Micron memory
> >   mtd: spi: Allocate memory corresponding to maximal fsl-quadspi.c
> >     controller area
> >   mtd: spi: Skip reading the Serial Flash Discoverable Parameters =20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/a+5Md_GOwEt4zKecGlK.e2J
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAluv6HAACgkQAR8vZIA0
zr3DSQf+MEplYTdDBoHPVllbuUN0dKuaja0gdqV9dqFT+C/V5Jj55UP2zTvgUjff
nBqk9jHlSOnhQMJ+kz7ghxlE1gUvsX0OpnnOA3NHJB4rGQDH5BQzbo2v/ETDhZSl
XkIM1O0s9c4993R5fyGe03cEVfXrUq9ptOUIZfUHrq9TCmq61uUATDskYAGNhTOB
MTODnTLqenhOLIHhTr/plWtDNgOpiUmwIukcnBfLT4SHdOIONenSufiOyEF5wkJh
ZJJyNdM5pQdPgD2+Pv/wgV1KLyxNSqVfoeNFIp3PZcj0Rov8pnUEdpGhk5ojMJEZ
M3qJzSvBSdVrJIayVboPyFpVrFPNVw==
=zRab
-----END PGP SIGNATURE-----

--Sig_/a+5Md_GOwEt4zKecGlK.e2J--
