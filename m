From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH 3/9] mtd: spi-nor: unify read opcode variants with ST
 SPI FSM
Date: Thu, 10 Apr 2014 15:43:06 +0800
Message-ID: <20140410074305.GF24100@localhost>
References: <1397064774-31784-1-git-send-email-computersforpeace@gmail.com>
 <1397064774-31784-3-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1397064774-31784-3-git-send-email-computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Apr 09, 2014 at 10:32:48AM -0700, Brian Norris wrote:
> serial_flash_cmds.h defines our opcodes a little differently. Let's
> borrow its naming, since it's borrowed from the SFDP standard, and it's
> more extensible.
> 
> This prepares us for merging serial_flash_cmds.h and spi-nor.h opcode
> listing.
> 
> Signed-off-by: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/mtd/spi-nor/spi-nor.c | 16 ++++++++--------
>  include/linux/mtd/spi-nor.h   | 24 ++++++++++++++++--------
>  2 files changed, 24 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index 462f1c8c3a7d..de04d6e2cf02 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1010,16 +1010,16 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
>  	/* Default commands */
>  	switch (nor->flash_read) {
>  	case SPI_NOR_QUAD:
> -		nor->read_opcode = SPINOR_OP_QUAD_READ;
> +		nor->read_opcode = SPINOR_OP_READ_1_1_4;
>  		break;
>  	case SPI_NOR_DUAL:
> -		nor->read_opcode = SPINOR_OP_DUAL_READ;
> +		nor->read_opcode = SPINOR_OP_READ_1_1_2;
>  		break;
>  	case SPI_NOR_FAST:
> -		nor->read_opcode = SPINOR_OP_FAST_READ;
> +		nor->read_opcode = SPINOR_OP_READ_FAST;
>  		break;
>  	case SPI_NOR_NORMAL:
> -		nor->read_opcode = SPINOR_OP_NORM_READ;
> +		nor->read_opcode = SPINOR_OP_READ;
>  		break;
>  	default:
>  		dev_err(dev, "No Read opcode defined\n");
> @@ -1037,16 +1037,16 @@ int spi_nor_scan(struct spi_nor *nor, const struct spi_device_id *id,
>  			/* Dedicated 4-byte command set */
>  			switch (nor->flash_read) {
>  			case SPI_NOR_QUAD:
> -				nor->read_opcode = SPINOR_OP_QUAD_READ_4B;
> +				nor->read_opcode = SPINOR_OP_READ4_1_1_4;
>  				break;
>  			case SPI_NOR_DUAL:
> -				nor->read_opcode = SPINOR_OP_DUAL_READ_4B;
> +				nor->read_opcode = SPINOR_OP_READ4_1_1_2;
>  				break;
>  			case SPI_NOR_FAST:
> -				nor->read_opcode = SPINOR_OP_FAST_READ_4B;
> +				nor->read_opcode = SPINOR_OP_READ4_FAST;
>  				break;
>  			case SPI_NOR_NORMAL:
> -				nor->read_opcode = SPINOR_OP_NORM_READ_4B;
> +				nor->read_opcode = SPINOR_OP_READ4;
>  				break;
>  			}
>  			nor->program_opcode = SPINOR_OP_PP_4B;
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 2c827b5bf773..2a5c30196749 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -1,14 +1,22 @@
>  #ifndef __LINUX_MTD_SPI_NOR_H
>  #define __LINUX_MTD_SPI_NOR_H
>  
> +/*
> + * Note on opcode nomenclature: some opcodes have a format like
> + * SPINOR_OP_FUNCTION{4,}_x_y_z. The numbers x, y, and z stand for the number
> + * of I/O lines used for the opcode, address, and data (respectively). The
I like this naming.

Acked-by: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
