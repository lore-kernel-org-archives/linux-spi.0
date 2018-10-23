From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH v3 1/2] mtd: spi-nor: add macros related to MICRON flash
Date: Tue, 23 Oct 2018 09:39:25 +0000
Message-ID: <VI1PR04MB1038969FFFCC16DD6094031599F50@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1539310881-17438-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1539310881-17438-2-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181012080753.2a59b75c@bbrezillon>
 <VI1PR04MB1038A3680E02FC107367E5FF99E20@VI1PR04MB1038.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "cyrille.pitchen@wedev4u.fr" <cyrille.pitchen@wedev4u.fr>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>,
        Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <VI1PR04MB1038A3680E02FC107367E5FF99E20@VI1PR04MB1038.eurprd04.prod.outlook.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

Did we have have any comments or remarks about this patch-series,  if not p=
lease apply.

Both patches in the series been reviewed by Tudor.

--
Regards
Yogesh Gaur

> -----Original Message-----
> From: Yogesh Narayan Gaur
> Sent: Friday, October 12, 2018 12:02 PM
> To: 'Boris Brezillon' <boris.brezillon@bootlin.com>
> Cc: linux-mtd@lists.infradead.org; linux-spi@vger.kernel.org;
> tudor.ambarus@microchip.com; marek.vasut@gmail.com;
> cyrille.pitchen@wedev4u.fr; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH v3 1/2] mtd: spi-nor: add macros related to MICRON fl=
ash
>=20
> Hi Boris,
>=20
> > -----Original Message-----
> > From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> > Sent: Friday, October 12, 2018 11:38 AM
> > To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> > Cc: linux-mtd@lists.infradead.org; linux-spi@vger.kernel.org;
> > tudor.ambarus@microchip.com; marek.vasut@gmail.com;
> > cyrille.pitchen@wedev4u.fr; computersforpeace@gmail.com;
> > frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v3 1/2] mtd: spi-nor: add macros related to MICRON
> > flash
> >
> > On Fri, 12 Oct 2018 02:23:08 +0000
> > Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> >
> > > Some MICRON related macros in spi-nor domain were ST.
> > > Rename entries related to STMicroelectronics under macro SNOR_MFR_ST.
> > >
> > > Added entry of MFR Id for Micron flashes, 0x002C.
> > >
> > > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > > Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> > > ---
> > > Changes for v3:
> > > - None
> > > Changes for v2:
> > > - None
> > >
> > >  drivers/mtd/spi-nor/spi-nor.c | 9 ++++++---
> > >  include/linux/mtd/cfi.h       | 1 +
> > >  include/linux/mtd/spi-nor.h   | 3 ++-
> > >  3 files changed, 9 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/mtd/spi-nor/spi-nor.c
> > > b/drivers/mtd/spi-nor/spi-nor.c index 9407ca5..b8b494f 100644
> > > --- a/drivers/mtd/spi-nor/spi-nor.c
> > > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > > @@ -284,6 +284,7 @@ static inline int set_4byte(struct spi_nor *nor,
> > > const
> > struct flash_info *info,
> > >  	u8 cmd;
> > >
> > >  	switch (JEDEC_MFR(info)) {
> > > +	case SNOR_MFR_ST:
> > >  	case SNOR_MFR_MICRON:
> > >  		/* Some Micron need WREN command; all will accept it */
> > >  		need_wren =3D true;
> > > @@ -1388,7 +1389,7 @@ static int spi_nor_is_locked(struct mtd_info
> > > *mtd,
> > loff_t ofs, uint64_t len)
> > >  	{ "mx66l1g45g",  INFO(0xc2201b, 0, 64 * 1024, 2048, SECT_4K |
> > SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
> > >  	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048,
> > > SPI_NOR_QUAD_READ) },
> > >
> > > -	/* Micron */
> > > +	/* Micron <--> ST Micro */
> > >  	{ "n25q016a",	 INFO(0x20bb15, 0, 64 * 1024,   32, SECT_4K |
> > SPI_NOR_QUAD_READ) },
> > >  	{ "n25q032",	 INFO(0x20ba16, 0, 64 * 1024,   64,
> > SPI_NOR_QUAD_READ) },
> > >  	{ "n25q032a",	 INFO(0x20bb16, 0, 64 * 1024,   64,
> > SPI_NOR_QUAD_READ) },
> > > @@ -3223,6 +3224,7 @@ static int spi_nor_init_params(struct spi_nor *=
nor,
> > >  			params->quad_enable =3D macronix_quad_enable;
> > >  			break;
> > >
> > > +		case SNOR_MFR_ST:
> > >  		case SNOR_MFR_MICRON:
> > >  			break;
> > >
> > > @@ -3671,8 +3673,9 @@ int spi_nor_scan(struct spi_nor *nor, const
> > > char
> > *name,
> > >  	mtd->_resume =3D spi_nor_resume;
> > >
> > >  	/* NOR protection support for STmicro/Micron chips and similar */
> > > -	if (JEDEC_MFR(info) =3D=3D SNOR_MFR_MICRON ||
> > > -			info->flags & SPI_NOR_HAS_LOCK) {
> > > +	if (JEDEC_MFR(info) =3D=3D SNOR_MFR_ST ||
> > > +	    JEDEC_MFR(info) =3D=3D SNOR_MFR_MICRON ||
> > > +	    info->flags & SPI_NOR_HAS_LOCK) {
> > >  		nor->flash_lock =3D stm_lock;
> > >  		nor->flash_unlock =3D stm_unlock;
> > >  		nor->flash_is_locked =3D stm_is_locked;
> >
> > Are you sure ST and Micron NORs work the same way WRT locking, 4-byte
> > addressing mode and Quad enable?
>=20
> Have checked for the Micron flash, MT35x wrt locking, 4-byte addressing m=
ode.
> For Macronix and Spansion flash there is special handling required for qu=
ad
> mode but not needed for ST flash.
> This flash didn't support quad mode and have checked that other Micron fl=
ash
> also didn't need special handling for quad mode.
> --
> Regards
> Yogesh Gaur.
> >
> > > diff --git a/include/linux/mtd/cfi.h b/include/linux/mtd/cfi.h index
> > > 9b57a9b..cbf7716 100644
> > > --- a/include/linux/mtd/cfi.h
> > > +++ b/include/linux/mtd/cfi.h
> > > @@ -377,6 +377,7 @@ struct cfi_fixup {
> > >  #define CFI_MFR_SHARP		0x00B0
> > >  #define CFI_MFR_SST		0x00BF
> > >  #define CFI_MFR_ST		0x0020 /* STMicroelectronics */
> > > +#define CFI_MFR_MICRON		0x002C /* Micron */
> > >  #define CFI_MFR_TOSHIBA		0x0098
> > >  #define CFI_MFR_WINBOND		0x00DA
> > >
> > > diff --git a/include/linux/mtd/spi-nor.h
> > > b/include/linux/mtd/spi-nor.h index 7f0c730..8b1acf6 100644
> > > --- a/include/linux/mtd/spi-nor.h
> > > +++ b/include/linux/mtd/spi-nor.h
> > > @@ -23,7 +23,8 @@
> > >  #define SNOR_MFR_ATMEL		CFI_MFR_ATMEL
> > >  #define SNOR_MFR_GIGADEVICE	0xc8
> > >  #define SNOR_MFR_INTEL		CFI_MFR_INTEL
> > > -#define SNOR_MFR_MICRON		CFI_MFR_ST /* ST Micro <-->
> Micron
> > */
> > > +#define SNOR_MFR_ST		CFI_MFR_ST	/* ST Micro */
> > > +#define SNOR_MFR_MICRON		CFI_MFR_MICRON	/*
> Micron */
> > >  #define SNOR_MFR_MACRONIX	CFI_MFR_MACRONIX
> > >  #define SNOR_MFR_SPANSION	CFI_MFR_AMD
> > >  #define SNOR_MFR_SST		CFI_MFR_SST
