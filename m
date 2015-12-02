From: Han Xu <han.xu@freescale.com>
Subject: Re: [PATCH v6 03/10] mtd: fsl-quadspi: return amount of data
 read/written or error
Date: Wed, 2 Dec 2015 15:06:28 -0600
Message-ID: <20151202210626.GA21512@chopperman.am.freescale.net>
References: <cover.1449052427.git.hramrach@gmail.com>
 <ad10a42f8c502b9b91fcba05b3e46c42663e1141.1449052427.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Brian Norris <computersforpeace@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Boris Brezillon <boris.brezillon@free-electrons.com>,
	Javier Martinez Canillas <javier@osg.samsung.com>,
	Rafal Milecki <zajec5@gmail.com>,
	Jagan Teki <jteki@openedev.com>,
	"Andrew F. Davis" <afd@ti.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Gabor Juhos <juhosg@openwrt.org>,
	Bean Huo <beanhuo@micron.com>,
	Furquan Shaikh <furquan@google.com>,
	<linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-spi@vger.kernel.org>
To: Michal Suchanek <hramrach@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ad10a42f8c502b9b91fcba05b3e46c42663e1141.1449052427.git.hramrach@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Dec 02, 2015 at 10:38:19AM +0000, Michal Suchanek wrote:
> Return amount of data read/written or error as read(2)/write(2) does.
> 
> Signed-off-by: Michal Suchanek <hramrach@gmail.com>
> ---
>  drivers/mtd/spi-nor/fsl-quadspi.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/fsl-quadspi.c b/drivers/mtd/spi-nor/fsl-quadspi.c
> index 10d2b59..9beb739 100644
> --- a/drivers/mtd/spi-nor/fsl-quadspi.c
> +++ b/drivers/mtd/spi-nor/fsl-quadspi.c
> @@ -575,7 +575,7 @@ static inline void fsl_qspi_invalid(struct fsl_qspi *q)
>  	writel(reg, q->iobase + QUADSPI_MCR);
>  }
>  
> -static int fsl_qspi_nor_write(struct fsl_qspi *q, struct spi_nor *nor,
> +static ssize_t fsl_qspi_nor_write(struct fsl_qspi *q, struct spi_nor *nor,

conflict with the patch I acked.

https://patchwork.ozlabs.org/patch/545925/

I may change it and test on my side.

>  				u8 opcode, unsigned int to, u32 *txbuf,
>  				unsigned count, size_t *retlen)
>  {
> @@ -604,8 +604,11 @@ static int fsl_qspi_nor_write(struct fsl_qspi *q, struct spi_nor *nor,
>  	/* Trigger it */
>  	ret = fsl_qspi_runcmd(q, opcode, to, count);
>  
> -	if (ret == 0 && retlen)
> -		*retlen += count;
> +	if (ret == 0) {
> +		if (retlen)
> +			*retlen += count;
> +		return count;
> +	}
>  
>  	return ret;
>  }
> @@ -814,6 +817,8 @@ static int fsl_qspi_write_reg(struct spi_nor *nor, u8 opcode, u8 *buf, int len)
>  	} else if (len > 0) {
>  		ret = fsl_qspi_nor_write(q, nor, opcode, 0,
>  					(u32 *)buf, len, NULL);
> +		if (ret > 0)
> +			return 0;
>  	} else {
>  		dev_err(q->dev, "invalid cmd %d\n", opcode);
>  		ret = -EINVAL;
> @@ -827,12 +832,12 @@ static ssize_t fsl_qspi_write(struct spi_nor *nor, loff_t to,
>  {
>  	struct fsl_qspi *q = nor->priv;
>  
> -	fsl_qspi_nor_write(q, nor, nor->program_opcode, to,
> +	ssize_t ret = fsl_qspi_nor_write(q, nor, nor->program_opcode, to,
>  				(u32 *)buf, len, retlen);
>  
>  	/* invalid the data in the AHB buffer. */
>  	fsl_qspi_invalid(q);
> -	return 0;
> +	return ret;
>  }
>  
>  static ssize_t fsl_qspi_read(struct spi_nor *nor, loff_t from,
> @@ -878,8 +883,7 @@ static ssize_t fsl_qspi_read(struct spi_nor *nor, loff_t from,
>  	memcpy(buf, q->ahb_addr + q->chip_base_addr + from - q->memmap_offs,
>  		len);
>  
> -	*retlen += len;
> -	return 0;
> +	return len;
>  }
>  
>  static int fsl_qspi_erase(struct spi_nor *nor, loff_t offs)
> -- 
> 2.6.2
> 

-- 
Best Regards,

Han "Allen" Xu
