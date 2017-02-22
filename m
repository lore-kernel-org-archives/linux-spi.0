From: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Subject: Re: [PATCH v5 1/2] mtd: spi-nor: Added spi-nor init function
Date: Wed, 22 Feb 2017 21:56:57 +0100
Message-ID: <96a6c1a1-984b-ecdf-047c-4ed6feb7283a@wedev4u.fr>
References: <1487791173-22159-1-git-send-email-kdasu.kdev@gmail.com>
 <1487791173-22159-2-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Cc: linux-mtd@lists.infradead.org, f.fainelli@gmail.com,
 bcm-kernel-feedback-list@broadcom.com
To: Kamal Dasu <kdasu.kdev@gmail.com>, linux-spi@vger.kernel.org,
 cyrille.pitchen@atmel.com, marex@denx.de, broonie@kernel.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1487791173-22159-2-git-send-email-kdasu.kdev@gmail.com>
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

just few comments, maybe not a full review, sorry!

First, about the subject line, I know this a small detail but according
to Documentation/SubmittingPatches, it should be "mtd: spi-nor: add ..."

"""
Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour.
"""

Le 22/02/2017 =E0 20:19, Kamal Dasu a =E9crit :
> Refactored spi_nor_scan() code to add spi_nor_init() function that
> programs the spi-nor flash to:
> 1) remove flash protection if applicable
> 2) set read mode to quad mode if configured such
> 3) set the address width based on the flash size and vendor
> =

> spi_nor_scan() now calls spi_nor_init() to setup nor flash.
> The init function can also be called by flash device driver
> to reinitialize spi-nor flash.
> =

> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 77 ++++++++++++++++++++++++++++---------=
------
>  include/linux/mtd/spi-nor.h   | 18 +++++++++-
>  2 files changed, 67 insertions(+), 28 deletions(-)
> =

> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 70e52ff..8b71c11 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1526,6 +1526,44 @@ static int s3an_nor_scan(const struct flash_info *=
info, struct spi_nor *nor)
>  	return 0;
>  }
>  =

> +int spi_nor_init(struct spi_nor *nor)
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
> +	if (JEDEC_MFR(info) =3D=3D SNOR_MFR_SPANSION ||
> +	    info->flags & SPI_NOR_4B_OPCODES)
> +		spi_nor_set_4byte_opcodes(nor, info);
> +	else
> +		set_4byte(nor, info, 1);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(spi_nor_init);
> +

When this code was called only from spi_nor_scan(), the nor->mtd object
has not been registered yet into the MTD sub-system. There was no need
to lock the 'nor->lock' mutex because spi_nor_scan() can't compete with
spi_nor_read(), spi_nor_write(), and so on...

However, now you plan to call this new spi_nor_init() function from the
resume() handler in m25p80: the MTD device has already been registered
so spi_nor_init() can now compete with spi_nor_read() and other
nor->mtd.<handlers>. I guess locking the mutex might be needed now
unless we have another mechanism to guarantee nor->mtd._<handlers> could
never be called by the MTD sub-system when the SPI device is suspended.
So, as said in my comment of patch 2 of this series, synchronization of
their power states is needed between the SPI and MTD devices.


>  int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode m=
ode)
>  {
>  	const struct flash_info *info =3D NULL;
> @@ -1571,6 +1609,8 @@ int spi_nor_scan(struct spi_nor *nor, const char *n=
ame, enum read_mode mode)
>  		}
>  	}
>  =

> +	/* update pointer to flash_info in the nor structure */
> +	nor->info =3D info;
>  	mutex_init(&nor->lock);
>  =

>  	/*
> @@ -1581,20 +1621,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *=
name, enum read_mode mode)
>  	if (info->flags & SPI_S3AN)
>  		nor->flags |=3D  SNOR_F_READY_XSR_RDY;
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
> @@ -1669,11 +1695,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *=
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
> @@ -1702,17 +1723,11 @@ int spi_nor_scan(struct spi_nor *nor, const char =
*name, enum read_mode mode)
>  =

>  	if (info->addr_width)
>  		nor->addr_width =3D info->addr_width;
> -	else if (mtd->size > 0x1000000) {
> +	else if (mtd->size > 0x1000000)
>  		/* enable 4-byte addressing if the device exceeds 16MiB */
>  		nor->addr_width =3D 4;
> -		if (JEDEC_MFR(info) =3D=3D SNOR_MFR_SPANSION ||
> -		    info->flags & SPI_NOR_4B_OPCODES)
> -			spi_nor_set_4byte_opcodes(nor, info);
> -		else
> -			set_4byte(nor, info, 1);
> -	} else {
> +	else
>  		nor->addr_width =3D 3;
> -	}
>  =

>  	if (nor->addr_width > SPI_NOR_MAX_ADDR_WIDTH) {
>  		dev_err(dev, "address width is too large: %u\n",
> @@ -1728,6 +1743,14 @@ int spi_nor_scan(struct spi_nor *nor, const char *=
name, enum read_mode mode)
>  			return ret;
>  	}
>  =

> +	/*
> +	 * call init function to send necessary spi-nor read/write config
> +	 * commands to nor flash based on above nor settings
> +	 */
> +	ret =3D spi_nor_init(nor);
> +	if (ret)
> +		return ret;
> +
>  	dev_info(dev, "%s (%lld Kbytes)\n", info->name,
>  			(long long)mtd->size >> 10);
>  =

> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index f2a7180..29a8283 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -143,6 +143,8 @@ enum spi_nor_option_flags {
>  	SNOR_F_READY_XSR_RDY	=3D BIT(4),
>  };
>  =

> +struct flash_info;
> +
>  /**
>   * struct spi_nor - Structure for defining a the SPI NOR layer
>   * @mtd:		point to a mtd_info structure
> @@ -174,6 +176,7 @@ enum spi_nor_option_flags {
>   * @flash_is_locked:	[FLASH-SPECIFIC] check if a region of the SPI NOR is
>   *			completely locked
>   * @priv:		the private data
> + * @info:		points to the flash_info structure
>   */
>  struct spi_nor {
>  	struct mtd_info		mtd;
> @@ -206,6 +209,7 @@ struct spi_nor {
>  	int (*flash_is_locked)(struct spi_nor *nor, loff_t ofs, uint64_t len);
>  =

>  	void *priv;
> +	const struct flash_info *info;
>  };
>  =

>  static inline void spi_nor_set_flash_node(struct spi_nor *nor,
> @@ -220,12 +224,24 @@ static inline struct device_node *spi_nor_get_flash=
_node(struct spi_nor *nor)
>  }
>  =

>  /**
> + * spi_nor_init() - initialize SPI NOR
> + * @nor:	the spi_nor structure
> + *
> + * The drivers uses this function to initialize the SPI NOR flash device=
 to
> + * settings in spi_nor structure. The functions sets read mode, address =
width
> + * and removes protection on the flash device based on those settings.
> + *
> + * Return: 0 for success, others for failure.
> + */
> +int spi_nor_init(struct spi_nor *nor);
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
