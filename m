From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v2 1/2] mtd: spi-nor: Added spi-nor reset function
Date: Thu, 9 Feb 2017 16:13:03 +0100
Message-ID: <51e4e497-535f-fd1a-8a20-17183691799b@gmail.com>
References: <1486572781-28808-1-git-send-email-kdasu.kdev@gmail.com>
 <1486572781-28808-2-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-mtd@lists.infradead.org, f.fainelli@gmail.com,
 bcm-kernel-feedback-list@broadcom.com
To: Kamal Dasu <kdasu.kdev@gmail.com>, linux-spi@vger.kernel.org,
 cyrille.pitchen@atmel.com, marex@denx.de, broonie@kernel.org
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

On 02/08/2017 05:53 PM, Kamal Dasu wrote:
> Refactored spi_nor_scan() code to add spi_nor_reset() function that
> programs the nand device to:

nand device ?

> 1) remove flash protection if applicable
> 2) set read mode to quad mode if configured such
> 3) set the address width based on the flash size and vendor
> 
> On pm resume spi-nor flash may need to be reconfigured after power
> reset, there is no need to go through a full spi_nor_scan(), flash
> device driver needs to call spi_nor_reset() to reprogram the flash
> to its probed state.
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 62 ++++++++++++++++++++++++++++---------------
>  include/linux/mtd/spi-nor.h   | 21 ++++++++++++++-
>  2 files changed, 61 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index da7cd69..8e3d8bd 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1312,6 +1312,41 @@ static int spi_nor_check(struct spi_nor *nor)
>  	return 0;
>  }
>  
> +int spi_nor_reset(struct spi_nor *nor)
> +{
> +	int ret = 0;
> +	const struct flash_info *info = nor->info;
> +	struct device *dev = nor->dev;

Does this reset the SPI NOR (as in, really send a reset opcode) ? It
doesn't, so the naming is confusing. This should probably be something
like "spi_nor_init()" or "spi_nor_setup()" , no ?

> +	/*
> +	 * Atmel, SST, Intel/Numonyx, and others serial NOR tend to power up
> +	 * with the software protection bits set
> +	 */
> +
> +	if (JEDEC_MFR(info) == SNOR_MFR_ATMEL ||
> +	    JEDEC_MFR(info) == SNOR_MFR_INTEL ||
> +	    JEDEC_MFR(info) == SNOR_MFR_SST ||
> +	    info->flags & SPI_NOR_HAS_LOCK) {
> +		write_enable(nor);
> +		write_sr(nor, 0);
> +		spi_nor_wait_till_ready(nor);
> +	}
> +
> +	if (nor->flash_read == SPI_NOR_QUAD) {
> +		ret = set_quad_mode(nor, info);
> +		if (ret) {
> +			dev_err(dev, "quad mode not supported\n");
> +			return ret;
> +		}
> +	}
> +
> +	if (nor->addr_width == 4 && JEDEC_MFR(info) != SNOR_MFR_SPANSION)
> +		set_4byte(nor, info, 1);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(spi_nor_reset);
> +
>  int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>  {
>  	const struct flash_info *info = NULL;
> @@ -1357,22 +1392,9 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>  		}
>  	}
>  
> +	nor->info = info;
>  	mutex_init(&nor->lock);
>  
> -	/*
> -	 * Atmel, SST, Intel/Numonyx, and others serial NOR tend to power up
> -	 * with the software protection bits set
> -	 */
> -
> -	if (JEDEC_MFR(info) == SNOR_MFR_ATMEL ||
> -	    JEDEC_MFR(info) == SNOR_MFR_INTEL ||
> -	    JEDEC_MFR(info) == SNOR_MFR_SST ||
> -	    info->flags & SPI_NOR_HAS_LOCK) {
> -		write_enable(nor);
> -		write_sr(nor, 0);
> -		spi_nor_wait_till_ready(nor);
> -	}
> -
>  	if (!mtd->name)
>  		mtd->name = dev_name(dev);
>  	mtd->priv = nor;
> @@ -1447,11 +1469,6 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>  
>  	/* Quad/Dual-read mode takes precedence over fast/normal */
>  	if (mode == SPI_NOR_QUAD && info->flags & SPI_NOR_QUAD_READ) {
> -		ret = set_quad_mode(nor, info);
> -		if (ret) {
> -			dev_err(dev, "quad mode not supported\n");
> -			return ret;
> -		}
>  		nor->flash_read = SPI_NOR_QUAD;
>  	} else if (mode == SPI_NOR_DUAL && info->flags & SPI_NOR_DUAL_READ) {
>  		nor->flash_read = SPI_NOR_DUAL;
> @@ -1503,8 +1520,7 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>  			/* No small sector erase for 4-byte command set */
>  			nor->erase_opcode = SPINOR_OP_SE_4B;
>  			mtd->erasesize = info->sector_size;
> -		} else
> -			set_4byte(nor, info, 1);
> +		}
>  	} else {
>  		nor->addr_width = 3;
>  	}
> @@ -1517,6 +1533,10 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
>  
>  	nor->read_dummy = spi_nor_read_dummy_cycles(nor);
>  
> +	ret = spi_nor_reset(nor);
> +	if (ret)
> +		return ret;
> +
>  	dev_info(dev, "%s (%lld Kbytes)\n", info->name,
>  			(long long)mtd->size >> 10);
>  
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index c425c7b..4733c04 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -121,6 +121,8 @@ enum spi_nor_option_flags {
>  	SNOR_F_HAS_SR_TB	= BIT(1),
>  };
>  
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
> @@ -198,12 +201,28 @@ static inline struct device_node *spi_nor_get_flash_node(struct spi_nor *nor)
>  }
>  
>  /**
> + * spi_nor_reset() - reset scan the SPI NOR
> + * @nor:	the spi_nor structure
> + *
> + * The drivers uses this function to reset the SPI NOR flash device to
> + * its initial scanned state, it shall use all nor information set on poweron
> + * for the read mode, address width and enabling write mode for certain
> + * manufacturers. This would be needed to be called for flash devices that are
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
> 


-- 
Best regards,
Marek Vasut

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
