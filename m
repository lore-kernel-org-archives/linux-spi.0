From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v2 1/2] spi: fsl-spi: Fix parameter ram offset setup for
 CPM1
Date: Mon, 6 Oct 2014 19:15:53 -0500
Message-ID: <1412640953.13320.502.camel@snotra.buserror.net>
References: <20141003164916.DBD631AAFA2@localhost.localdomain>
	 <1412368198.13320.434.camel@snotra.buserror.net> <542FE1C4.7000403@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Mark Brown <broonie@kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
To: christophe leroy <christophe.leroy@c-s.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <542FE1C4.7000403@c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, 2014-10-04 at 14:02 +0200, christophe leroy wrote:
> Le 03/10/2014 22:29, Scott Wood a =C3=A9crit :
> > On Fri, 2014-10-03 at 18:49 +0200, Christophe Leroy wrote:
> >> On CPM1, the SPI parameter RAM has a default location. In fsl_spi_=
cpm_get_pram()
> >> there was a confusion between the SPI_BASE register and the base o=
f the SPI
> >> parameter RAM. Fortunatly, it was working properly with MPC866 and=
 MPC885
> >> because they do set SPI_BASE, but on MPC860 and other old MPC8xx t=
hat doesn't
> >> set SPI_BASE, pram_ofs was not properly set. This patch fixes this=
 confusion.
> >>
> >> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >>
> >> ---
> >> Changes from v1 to v2: none
> >>
> >>   drivers/spi/spi-fsl-cpm.c | 9 ++++-----
> >>   1 file changed, 4 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
> >> index 54b0637..0f3a912 100644
> >> --- a/drivers/spi/spi-fsl-cpm.c
> >> +++ b/drivers/spi/spi-fsl-cpm.c
> >> @@ -262,15 +262,14 @@ static unsigned long fsl_spi_cpm_get_pram(st=
ruct mpc8xxx_spi *mspi)
> >>   		pram_ofs =3D cpm_muram_alloc(SPI_PRAM_SIZE, 64);
> >>   		out_be16(spi_base, pram_ofs);
> >>   	} else {
> >> -		struct spi_pram __iomem *pram =3D spi_base;
> >> -		u16 rpbase =3D in_be16(&pram->rpbase);
> >> +		u16 rpbase =3D in_be16(spi_base);
> >>  =20
> >> -		/* Microcode relocation patch applied? */
> >> +		/* Microcode relocation patch applied | rpbase set by default *=
/
> >>   		if (rpbase) {
> >>   			pram_ofs =3D rpbase;
> >>   		} else {
> >> -			pram_ofs =3D cpm_muram_alloc(SPI_PRAM_SIZE, 64);
> >> -			out_be16(spi_base, pram_ofs);
> >> +			pram_ofs =3D offsetof(cpm8xx_t, cp_dparam[PROFF_SPI]) -
> >> +				   offsetof(cpm8xx_t, cp_dpmem[0]);
> >>   		}
> >>   	}
> > Why is PROFF_SPI not coming from the device tree?
> That's where it starts to become tricky.
>=20
> PROFF_SPI is defined in cpm1.h which is included by the driver alread=
y.=20

Yes, but those values shouldn't be used.  It's a leftover from the old
way of hardcoding things and describing the hardware with kconfig rathe=
r
than the device tree.

> It provides the default offset from the start of the parameter RAM.
> Previously I had the following in my device tree, and the last part o=
f=20
> the source above (the one for rpbase =3D=3D 0) could not work.
>=20
>              spi: spi@a80 {
>                  cell-index =3D <0>;
>                  compatible =3D "fsl,spi", "fsl,cpm1-spi";
>                  reg =3D <0xa80 0x30 0x3d80 0x30>;
>=20
> First reg area was the area for SPI registers. Second area was the=20
> parameter RAM zone, which was just mapped to get access to the SPI_BA=
SE=20
> pointer (rpbase)
>=20
> Now I have
>=20
>                  compatible =3D "fsl,spi", "fsl,cpm1-spi-reloc";
>                  reg =3D <0xa80 0x30 0x3dac 0x2>;
>=20
> First reg area is the area for SPI registers. Second area is the=20
> SPI_BASE, as for the CPM2.
>=20
> On recent 8xx (885 and 866 at least) it contains the offset (=3D0x1D8=
0) of=20
> the parameter RAM. But on old ones (860, ...) it contains 0. Therefor=
e=20
> we have to get the default index in another way.
> What I wanted was to keep something similar to what's done with CPM2.
>=20
> What should it look like if that offset had to be in the device tree =
?

If the offset is not relocatable or discoverable, it should stay in the
device tree.  If you have an old chip you wouldn't have
fsl,cpm1-spi-reloc and thus you'd still have "0x3d80 0x30" in reg.

> > Why don't I see any
> > cpm spi in any device tree nor any binding for it?
> There's one in mgcoge.dts:
>=20
>              spi@11aa0 {
>                  cell-index =3D <0>;
>                  compatible =3D "fsl,spi", "fsl,cpm2-spi";
>                  reg =3D <0x11a80 0x40 0x89fc 0x2>;

I'm not sure why I missed that, but this patch is for cpm1-spi, not
cpm2-spi...

Even if you insist on keeping your board dts out-of-tree, there should
at least be a binding in-tree.

BTW, more specific compatibles should come first.

-Scott
