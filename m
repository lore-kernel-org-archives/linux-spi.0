From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: RE: [LINUX RFC v4 3/4] mtd: spi-nor: add stripe support
Date: Wed, 30 Nov 2016 09:17:14 +0000
Message-ID: <DA6901612C71B84D91459DE817C418AE26E0B5E2@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1480235616-34038-1-git-send-email-nagasure@xilinx.com>
 <68ca0f19-e534-3361-11f0-6566626380fe@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
To: Cyrille Pitchen <cyrille.pitchen@atmel.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        Soren Brinkmann <sorenb@xilinx.com>,
        Harini Katakam <harinik@xilinx.com>,
        Punnaiah Choudary Kalluri <punnaia@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <68ca0f19-e534-3361-11f0-6566626380fe@atmel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Cyrille,

> I have not finished to review the whole series yet but here some first
> comments:

Thanks for reviewing these patch series.

>=20
> Le 27/11/2016 =E0 09:33, Naga Sureshkumar Relli a =E9crit :
> > This patch adds stripe support and it is needed for GQSPI parallel
> > configuration mode by:
> >
> > - Adding required parameters like stripe and shift to spi_nor
> >   structure.
> > - Initializing all added parameters in spi_nor_scan()
> > - Updating read_sr() and read_fsr() for getting status from both
> >   flashes
> > - Increasing page_size, sector_size, erase_size and toatal flash
> >   size as and when required.
> > - Dividing address by 2
> > - Updating spi->master->flags for qspi driver to change CS
> >
> > Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
> > ---
> > Changes for v4:
> >  - rename isparallel to stripe
> > Changes for v3:
> >  - No change
> > Changes for v2:
> >  - Splitted to separate MTD layer changes from SPI core changes
> > ---
> >  drivers/mtd/spi-nor/spi-nor.c | 130
> ++++++++++++++++++++++++++++++++----------
> >  include/linux/mtd/spi-nor.h   |   2 +
> >  2 files changed, 103 insertions(+), 29 deletions(-)
> >
> > diff --git a/drivers/mtd/spi-nor/spi-nor.c
> > b/drivers/mtd/spi-nor/spi-nor.c index d0fc165..4252239 100644
> > --- a/drivers/mtd/spi-nor/spi-nor.c
> > +++ b/drivers/mtd/spi-nor/spi-nor.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/of_platform.h>
> >  #include <linux/spi/flash.h>
> >  #include <linux/mtd/spi-nor.h>
> > +#include <linux/spi/spi.h>
> >
> >  /* Define max times to check status register before we give up. */
> >
> > @@ -89,15 +90,24 @@ static const struct flash_info
> > *spi_nor_match_id(const char *name);  static int read_sr(struct
> > spi_nor *nor)  {
> >  	int ret;
> > -	u8 val;
> > +	u8 val[2];
> >
> > -	ret =3D nor->read_reg(nor, SPINOR_OP_RDSR, &val, 1);
> > -	if (ret < 0) {
> > -		pr_err("error %d reading SR\n", (int) ret);
> > -		return ret;
> > +	if (nor->stripe) {
> > +		ret =3D nor->read_reg(nor, SPINOR_OP_RDSR, &val[0], 2);
> > +		if (ret < 0) {
> > +			pr_err("error %d reading SR\n", (int) ret);
> > +			return ret;
> > +		}
> > +		val[0] |=3D val[1];
> Why '|' rather than '&' ?
> I guess because of the 'Write In Progress/Busy' bit: when called by
> spi_nor_sr_ready(), you want to be sure that this 'BUSY' bit is cleared o=
n
> both memories.
>=20
> But what about when the Status Register is read for purpose other than
> checking the state of the 'BUSY' bit?
>=20
Yes you are correct, I will change this.

> What about SPI controllers supporting more than 2 memories in parallel?
>=20
> This solution might fit the ZynqMP controller but doesn't look so generic=
.
>=20
> > +	} else {
> > +		ret =3D nor->read_reg(nor, SPINOR_OP_RDSR, &val[0], 1);
> > +		if (ret < 0) {
> > +			pr_err("error %d reading SR\n", (int) ret);
> > +			return ret;
> > +		}
> >  	}
> >
> > -	return val;
> > +	return val[0];
> >  }
> >
> >  /*
> > @@ -108,15 +118,24 @@ static int read_sr(struct spi_nor *nor)  static
> > int read_fsr(struct spi_nor *nor)  {
> >  	int ret;
> > -	u8 val;
> > +	u8 val[2];
> >
> > -	ret =3D nor->read_reg(nor, SPINOR_OP_RDFSR, &val, 1);
> > -	if (ret < 0) {
> > -		pr_err("error %d reading FSR\n", ret);
> > -		return ret;
> > +	if (nor->stripe) {
> > +		ret =3D nor->read_reg(nor, SPINOR_OP_RDFSR, &val[0], 2);
> > +		if (ret < 0) {
> > +			pr_err("error %d reading FSR\n", ret);
> > +			return ret;
> > +		}
> > +		val[0] &=3D val[1];
> Same comment here: why '&' rather than '|'?
> Surely because of the the 'READY' bit which should be set for both memori=
es.
I will update this also.
>=20
> > +	} else {
> > +		ret =3D nor->read_reg(nor, SPINOR_OP_RDFSR, &val[0], 1);
> > +		if (ret < 0) {
> > +			pr_err("error %d reading FSR\n", ret);
> > +			return ret;
> > +		}
> >  	}
> >
> > -	return val;
> > +	return val[0];
> >  }
> >
> >  /*
> > @@ -290,9 +309,16 @@ static int spi_nor_wait_till_ready(struct spi_nor
> *nor)
> >   */
> >  static int erase_chip(struct spi_nor *nor)  {
> > +	u32 ret;
> > +
> >  	dev_dbg(nor->dev, " %lldKiB\n", (long long)(nor->mtd.size >> 10));
> >
> > -	return nor->write_reg(nor, SPINOR_OP_CHIP_ERASE, NULL, 0);
> > +	ret =3D nor->write_reg(nor, SPINOR_OP_CHIP_ERASE, NULL, 0);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return ret;
> > +
>=20
> 	if (ret)
> 		return ret;
> 	else
> 		return ret;
>=20
> This chunk should be removed, it doesn't ease the patch review ;)
Ok, I will remove.
>=20
> >  }
> >
> >  static int spi_nor_lock_and_prep(struct spi_nor *nor, enum
> > spi_nor_ops ops) @@ -349,7 +375,7 @@ static int
> > spi_nor_erase_sector(struct spi_nor *nor, u32 addr)  static int
> > spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)  {
> >  	struct spi_nor *nor =3D mtd_to_spi_nor(mtd);
> > -	u32 addr, len;
> > +	u32 addr, len, offset;
> >  	uint32_t rem;
> >  	int ret;
> >
> > @@ -399,9 +425,13 @@ static int spi_nor_erase(struct mtd_info *mtd,
> struct erase_info *instr)
> >  	/* "sector"-at-a-time erase */
> >  	} else {
> >  		while (len) {
> > +
> >  			write_enable(nor);
> > +			offset =3D addr;
> > +			if (nor->stripe)
> > +				offset /=3D 2;
>=20
> I guess this should be /=3D 4 for controllers supporting 4 memories in pa=
rallel.
> Shouldn't you use nor->shift and define shift as an unsigned int instead =
of a
> bool?
> offset >>=3D nor->shift;
>=20
Yes we can use this shift, I will update

> Anyway, by tuning the address here in spi-nor.c rather than in the SPI
> controller driver, you impose a model to support parallel memories that
> might not be suited to other controllers.

For this ZynqMP GQSPI controller parallel configuration, globally spi-nor s=
hould know about this stripe feature
And based on that address has to change.
As I mentioned in cover letter, this controller in parallel configuration w=
ill work with even addresses only.
i.e. Before creating address format(m25p_addr2cmd) in mtd layer, spi-nor sh=
ould change that address based on stripe option.

I am updating this offset based on stripe option, and stripe option will up=
date by reading dt property in nor_scan().
So the controller which doesn't support, then the stripe will be zero.
Or Can you please suggest any other way?

>=20
> >
> > -			ret =3D spi_nor_erase_sector(nor, addr);
> > +			ret =3D spi_nor_erase_sector(nor, offset);
> >  			if (ret)
> >  				goto erase_err;
> >
> > @@ -525,6 +555,8 @@ static int stm_lock(struct spi_nor *nor, loff_t ofs=
,
> uint64_t len)
> >  	bool use_top;
> >  	int ret;
> >
> > +	ofs =3D ofs >> nor->shift;
> > +
> >  	status_old =3D read_sr(nor);
> >  	if (status_old < 0)
> >  		return status_old;
> > @@ -610,6 +642,8 @@ static int stm_unlock(struct spi_nor *nor, loff_t o=
fs,
> uint64_t len)
> >  	bool use_top;
> >  	int ret;
> >
> > +	ofs =3D ofs >> nor->shift;
> > +
> >  	status_old =3D read_sr(nor);
> >  	if (status_old < 0)
> >  		return status_old;
> > @@ -709,6 +743,8 @@ static int spi_nor_lock(struct mtd_info *mtd, loff_=
t
> ofs, uint64_t len)
> >  	if (ret)
> >  		return ret;
> >
> > +	ofs =3D ofs >> nor->shift;
> > +
> >  	ret =3D nor->flash_lock(nor, ofs, len);
> >
> >  	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_UNLOCK); @@ -
> 724,6 +760,8
> > @@ static int spi_nor_unlock(struct mtd_info *mtd, loff_t ofs, uint64_t
> len)
> >  	if (ret)
> >  		return ret;
> >
> > +	ofs =3D ofs >> nor->shift;
> > +
> >  	ret =3D nor->flash_unlock(nor, ofs, len);
> >
> >  	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_LOCK); @@ -
> 1018,6 +1056,9
> > @@ static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
> >  	u8			id[SPI_NOR_MAX_ID_LEN];
> >  	const struct flash_info	*info;
> >
> > +	nor->spi->master->flags &=3D ~(SPI_MASTER_BOTH_CS |
> > +					SPI_MASTER_DATA_STRIPE);
> > +
> >  	tmp =3D nor->read_reg(nor, SPINOR_OP_RDID, id,
> SPI_NOR_MAX_ID_LEN);
> >  	if (tmp < 0) {
> >  		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", tmp);
> @@ -1041,6
> > +1082,7 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from,
> > size_t len,  {
> >  	struct spi_nor *nor =3D mtd_to_spi_nor(mtd);
> >  	int ret;
> > +	u32 offset =3D from;
> >
> >  	dev_dbg(nor->dev, "from 0x%08x, len %zd\n", (u32)from, len);
> >
> > @@ -1049,7 +1091,13 @@ static int spi_nor_read(struct mtd_info *mtd,
> loff_t from, size_t len,
> >  		return ret;
> >
> >  	while (len) {
> > -		ret =3D nor->read(nor, from, len, buf);
> > +
> > +		offset =3D from;
> > +
> > +		if (nor->stripe)
> > +			offset /=3D 2;
> > +
> > +		ret =3D nor->read(nor, offset, len, buf);
> >  		if (ret =3D=3D 0) {
> >  			/* We shouldn't see 0-length reads */
> >  			ret =3D -EIO;
> > @@ -1161,6 +1209,7 @@ static int spi_nor_write(struct mtd_info *mtd,
> loff_t to, size_t len,
> >  	struct spi_nor *nor =3D mtd_to_spi_nor(mtd);
> >  	size_t page_offset, page_remain, i;
> >  	ssize_t ret;
> > +	u32 offset;
> >
> >  	dev_dbg(nor->dev, "to 0x%08x, len %zd\n", (u32)to, len);
> >
> > @@ -1178,9 +1227,13 @@ static int spi_nor_write(struct mtd_info *mtd,
> loff_t to, size_t len,
> >  		/* the size of data remaining on the first page */
> >  		page_remain =3D min_t(size_t,
> >  				    nor->page_size - page_offset, len - i);
> > +		offset =3D (to + i);
> > +
> > +		if (nor->stripe)
> > +			offset /=3D 2;
> >
> >  		write_enable(nor);
> > -		ret =3D nor->write(nor, to + i, page_remain, buf + i);
> > +		ret =3D nor->write(nor, (offset), page_remain, buf + i);
> >  		if (ret < 0)
> >  			goto write_err;
> >  		written =3D ret;
> > @@ -1302,22 +1355,22 @@ static int spi_nor_check(struct spi_nor *nor)
> >
> >  int spi_nor_scan(struct spi_nor *nor, const char *name, enum
> > read_mode mode)  {
> > -	const struct flash_info *info =3D NULL;
> > +	struct flash_info *info =3D NULL;
>=20
> You should not remove the const and should not try to modify members of
> *info.
>=20
> >  	struct device *dev =3D nor->dev;
> >  	struct mtd_info *mtd =3D &nor->mtd;
> >  	struct device_node *np =3D spi_nor_get_flash_node(nor);
> > -	int ret;
> > -	int i;
> > +	struct device_node *np_spi;
> > +	int ret, i, xlnx_qspi_mode;
> >
> >  	ret =3D spi_nor_check(nor);
> >  	if (ret)
> >  		return ret;
> >
> >  	if (name)
> > -		info =3D spi_nor_match_id(name);
> > +		info =3D (struct flash_info *)spi_nor_match_id(name);
> >  	/* Try to auto-detect if chip name wasn't specified or not found */
> >  	if (!info)
> > -		info =3D spi_nor_read_id(nor);
> > +		info =3D (struct flash_info *)spi_nor_read_id(nor);
> >  	if (IS_ERR_OR_NULL(info))
> >  		return -ENOENT;
> >
> Both spi_nor_match_id() and spi_nor_read_id(), when they succeed, return
> a pointer to an entry of the spi_nor_ids[] array, which is located in a r=
ead-
> only memory area.
>=20
> Since your patch doesn't remove the const attribute of the spi_nor_ids[],=
 I
> wonder whether it has been tested. I expect it not to work on most
> architecture.
>=20
> Anyway spi_nor_ids[] should remain const. Let's take the case of eXecutio=
n
> In Place (XIP) from an external memory: if spi_nor_ids[] is const, it can=
 be
> read directly from this external (read-only) memory and we never need to
> copy the array in RAM, so we save some KB of RAM.
> This is just an example but I guess we can find other reasons to keep thi=
s
> array const.
>=20
> > @@ -1341,7 +1394,7 @@ int spi_nor_scan(struct spi_nor *nor, const char
> *name, enum read_mode mode)
> >  			 */
> >  			dev_warn(dev, "found %s, expected %s\n",
> >  				 jinfo->name, info->name);
> > -			info =3D jinfo;
> > +			info =3D (struct flash_info *)jinfo;
> >  		}
> >  	}
> >
> > @@ -1370,6 +1423,27 @@ int spi_nor_scan(struct spi_nor *nor, const char
> *name, enum read_mode mode)
> >  	mtd->size =3D info->sector_size * info->n_sectors;
> >  	mtd->_erase =3D spi_nor_erase;
> >  	mtd->_read =3D spi_nor_read;
> > +#ifdef CONFIG_OF
> > +	np_spi =3D of_get_next_parent(np);
> > +
> > +	if (of_property_read_u32(np_spi, "xlnx,qspi-mode",
> > +				&xlnx_qspi_mode) < 0) {
> This really looks controller specific so should not be placed in the gene=
ric spi-
> nor.c file.

Const is removed in info struct, because to update info members based paral=
lel configuration.
As I mentioned above,  for this parallel configuration, mtd and spi-nor sho=
uld know the details like
mtd->size, info->sectors, sector_size and page_size.
So during spi_nor_scan only mtd will update all these details, that's why I=
 have added controller specific check to update those.

Can you please suggest, any other way to let mtd and spi-nor to know about =
this configuration without touching the core layers?

Please let me know, if I missed providing any required info.

>=20
> > +		nor->shift =3D 0;
> > +		nor->stripe =3D 0;
> > +	} else if (xlnx_qspi_mode =3D=3D 2) {
> > +		nor->shift =3D 1;
> > +		info->sector_size <<=3D nor->shift;
> > +		info->page_size <<=3D nor->shift;
> Just don't modify *info members! :)
>=20
>=20
> > +		mtd->size <<=3D nor->shift;
> > +		nor->stripe =3D 1;
> > +		nor->spi->master->flags |=3D (SPI_MASTER_BOTH_CS |
> > +						SPI_MASTER_DATA_STRIPE);
> > +	}
> > +#else
> > +	/* Default to single */
> > +	nor->shift =3D 0;
> > +	nor->stripe =3D 0;
> > +#endif
> Best regards,
>=20
> Cyrille

Thanks,
Naga Sureshkumar Relli
