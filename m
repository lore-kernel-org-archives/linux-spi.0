From: Cyrille Pitchen <cyrille.pitchen@atmel.com>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: Added spi-nor reset function
Date: Thu, 9 Feb 2017 18:49:56 +0100
Message-ID: <b749da59-587e-c2a6-b08b-5c60f4b57101@atmel.com>
References: <1486572781-28808-1-git-send-email-kdasu.kdev@gmail.com>
 <1486572781-28808-2-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Cc: bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com,
 linux-mtd@lists.infradead.org
To: Kamal Dasu <kdasu.kdev@gmail.com>, <linux-spi@vger.kernel.org>,
 <marex@denx.de>, <broonie@kernel.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1486572781-28808-2-git-send-email-kdasu.kdev@gmail.com>
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

Hi Kamal,

Le 08/02/2017 =E0 17:53, Kamal Dasu a =E9crit :
> Refactored spi_nor_scan() code to add spi_nor_reset() function that
> programs the nand device to:
> 1) remove flash protection if applicable
> 2) set read mode to quad mode if configured such
> 3) set the address width based on the flash size and vendor
> =

> On pm resume spi-nor flash may need to be reconfigured after power
> reset, there is no need to go through a full spi_nor_scan(), flash
> device driver needs to call spi_nor_reset() to reprogram the flash
> to its probed state.
> =

> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 62 ++++++++++++++++++++++++++++---------=
------
>  include/linux/mtd/spi-nor.h   | 21 ++++++++++++++-
>  2 files changed, 61 insertions(+), 22 deletions(-)
> =

> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index da7cd69..8e3d8bd 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1312,6 +1312,41 @@ static int spi_nor_check(struct spi_nor *nor)
>  	return 0;
>  }
>  =

> +int spi_nor_reset(struct spi_nor *nor)
> +{
> +	int ret =3D 0;
> +	const struct flash_info *info =3D nor->info;
> +	struct device *dev =3D nor->dev;
> +
> +	/*
> +	 * Atmel, SST, Intel/Numonyx, and others serial NOR tend to power up
> +	 * with the software protection bits set
> +	 */
> +
> +	if (JEDEC_MFR(info) =3D=3D SNOR_MFR_ATMEL ||
> +	    JEDEC_MFR(info) =3D=3D SNOR_MFR_INTEL ||
> +	    JEDEC_MFR(info) =3D=3D SNOR_MFR_SST ||
> +	    info->flags & SPI_NOR_HAS_LOCK) {
> +		write_enable(nor);
> +		write_sr(nor, 0);
> +		spi_nor_wait_till_ready(nor);
> +	}
> +
> +	if (nor->flash_read =3D=3D SPI_NOR_QUAD) {
> +		ret =3D set_quad_mode(nor, info);
> +		if (ret) {
> +			dev_err(dev, "quad mode not supported\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (nor->addr_width =3D=3D 4 && JEDEC_MFR(info) !=3D SNOR_MFR_SPANSION)
> +		set_4byte(nor, info, 1);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(spi_nor_reset);
> +
>  int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode m=
ode)
>  {
>  	const struct flash_info *info =3D NULL;
> @@ -1357,22 +1392,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *=
name, enum read_mode mode)
>  		}
>  	}
>  =

> +	nor->info =3D info;
>  	mutex_init(&nor->lock);
>  =

> -	/*
> -	 * Atmel, SST, Intel/Numonyx, and others serial NOR tend to power up
> -	 * with the software protection bits set
> -	 */
> -
> -	if (JEDEC_MFR(info) =3D=3D SNOR_MFR_ATMEL ||
> -	    JEDEC_MFR(info) =3D=3D SNOR_MFR_INTEL ||
> -	    JEDEC_MFR(info) =3D=3D SNOR_MFR_SST ||
> -	    info->flags & SPI_NOR_HAS_LOCK) {
> -		write_enable(nor);
> -		write_sr(nor, 0);
> -		spi_nor_wait_till_ready(nor);
> -	}
> -
>  	if (!mtd->name)
>  		mtd->name =3D dev_name(dev);
>  	mtd->priv =3D nor;
> @@ -1447,11 +1469,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *=
name, enum read_mode mode)
>  =

>  	/* Quad/Dual-read mode takes precedence over fast/normal */
>  	if (mode =3D=3D SPI_NOR_QUAD && info->flags & SPI_NOR_QUAD_READ) {
> -		ret =3D set_quad_mode(nor, info);
> -		if (ret) {
> -			dev_err(dev, "quad mode not supported\n");
> -			return ret;
> -		}
>  		nor->flash_read =3D SPI_NOR_QUAD;
>  	} else if (mode =3D=3D SPI_NOR_DUAL && info->flags & SPI_NOR_DUAL_READ)=
 {
>  		nor->flash_read =3D SPI_NOR_DUAL;
> @@ -1503,8 +1520,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *n=
ame, enum read_mode mode)
>  			/* No small sector erase for 4-byte command set */
>  			nor->erase_opcode =3D SPINOR_OP_SE_4B;
>  			mtd->erasesize =3D info->sector_size;

It seems that you didn't base your patch on the spi-nor tree. Before your
patch, you should have something like:

	else if (mtd->size > 0x1000000) {
		/* enable 4-byte addressing if the device exceeds 16MiB */
		nor->addr_width =3D 4;
		if (JEDEC_MFR(info) =3D=3D SNOR_MFR_SPANSION ||
		    info->flags & SPI_NOR_4B_OPCODES)
			spi_nor_set_4byte_opcodes(nor, info);
		else
			set_4byte(nor, info, 1);
	} else {
		nor->addr_width =3D 3;
	}

That's why in my comment of review 1, I was talking about handling the
case where spi_nor_set_4byte_opcodes() is called instead of set_4byte():
indeed when the manufacturer id is Spansion or when the SPI_NOR_4B_OPCODES
flag is set.

Hence in spi_nor_reset(), or whatever name you choose, set_4byte() must not
be called if the SPI_NOR_4B_OPCODES flag is set in info->flags.

Besides, for now I don't know that much about how power management is
handled by the Linux kernel, especially which events trigger the call of
.suspend() or .resume().
I've started to read documentation about that topic so please be patient
because I need some time to figure out the potential side effects this
series may introduce.
I know you test your patches before submitting them, so this is not a
question of trust but I'd rather understand what patches actually do
instead of blindly merge them! :)

Also maybe this patch can help you:
http://patchwork.ozlabs.org/patch/719777/

It's not related to power management but it also reworks spi_nor_scan()
so all settings (op codes, protocols, number of dummy cycles, ...) are
chosen once for all by spi_nor_init_params() then the actual memory device
is configured by spi_nor_setup().

I can rework spi_nor_setup() a little bit as the first part of its code is
needed to be done only once from spi_nor_scan() whereas the final part
almost matches what's your "spi_nor_reset()" function will do in term.

We should regroup {unlock sectors, enable_quad_io() and set_4byte() (if not
set_nor_set_4byte_opcodes)} codes. That is to say, the minimum set of SPI
commands we have to send to the memory at each power on.

Best regards,

Cyrille


> -		} else
> -			set_4byte(nor, info, 1);
> +		}
>  	} else {
>  		nor->addr_width =3D 3;
>  	}
> @@ -1517,6 +1533,10 @@ int spi_nor_scan(struct spi_nor *nor, const char *=
name, enum read_mode mode)
>  =

>  	nor->read_dummy =3D spi_nor_read_dummy_cycles(nor);
>  =

> +	ret =3D spi_nor_reset(nor);
> +	if (ret)
> +		return ret;
> +
>  	dev_info(dev, "%s (%lld Kbytes)\n", info->name,
>  			(long long)mtd->size >> 10);
>  =

> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index c425c7b..4733c04 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -121,6 +121,8 @@ enum spi_nor_option_flags {
>  	SNOR_F_HAS_SR_TB	=3D BIT(1),
>  };
>  =

> +struct flash_info;
> +
>  /**
>   * struct spi_nor - Structure for defining a the SPI NOR layer
>   * @mtd:		point to a mtd_info structure
> @@ -154,6 +156,7 @@ enum spi_nor_option_flags {
>   * @priv:		the private data
>   */
>  struct spi_nor {
> +	const struct flash_info *info;
>  	struct mtd_info		mtd;
>  	struct mutex		lock;
>  	struct device		*dev;
> @@ -198,12 +201,28 @@ static inline struct device_node *spi_nor_get_flash=
_node(struct spi_nor *nor)
>  }
>  =

>  /**
> + * spi_nor_reset() - reset scan the SPI NOR
> + * @nor:	the spi_nor structure
> + *
> + * The drivers uses this function to reset the SPI NOR flash device to
> + * its initial scanned state, it shall use all nor information set on po=
weron
> + * for the read mode, address width and enabling write mode for certain
> + * manufacturers. This would be needed to be called for flash devices th=
at are
> + * reset during power management.
> + *
> + * The chip type name can be provided through the @name parameter.
> + *
> + * Return: 0 for success, others for failure.
> + */
> +int spi_nor_reset(struct spi_nor *nor);
> +
> +/**
>   * spi_nor_scan() - scan the SPI NOR
>   * @nor:	the spi_nor structure
>   * @name:	the chip type name
>   * @mode:	the read mode supported by the driver
>   *
> - * The drivers can use this fuction to scan the SPI NOR.
> + * The drivers can use this function to scan the SPI NOR.
>   * In the scanning, it will try to get all the necessary information to
>   * fill the mtd_info{} and the spi_nor{}.
>   *
> =



______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
