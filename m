From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH 1/9] mtd: spi-nor: drop \t after #define
Date: Wed, 9 Apr 2014 19:40:14 +0200
Message-ID: <201404091940.14392.marex@denx.de>
References: <1397064774-31784-1-git-send-email-computersforpeace@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1397064774-31784-1-git-send-email-computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wednesday, April 09, 2014 at 07:32:46 PM, Brian Norris wrote:
> Spacing is a little non-standard here.
> 
> Signed-off-by: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> Series based on l2-mtd.git/spinor:
> 
>   http://git.infradead.org/l2-mtd.git
> 
>  include/linux/mtd/spi-nor.h | 68
> ++++++++++++++++++++++----------------------- 1 file changed, 34
> insertions(+), 34 deletions(-)
> 
> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
> index 41dae78fbd1d..558097e14932 100644
> --- a/include/linux/mtd/spi-nor.h
> +++ b/include/linux/mtd/spi-nor.h
> @@ -2,50 +2,50 @@
>  #define __LINUX_MTD_SPI_NOR_H
> 
>  /* Flash opcodes. */
> -#define	OPCODE_WREN		0x06	/* Write enable */
> -#define	OPCODE_RDSR		0x05	/* Read status register */
> -#define	OPCODE_WRSR		0x01	/* Write status register 1 byte 
*/
> -#define	OPCODE_NORM_READ	0x03	/* Read data bytes (low 
frequency) */
> -#define	OPCODE_FAST_READ	0x0b	/* Read data bytes (high 
frequency) */
> -#define	OPCODE_DUAL_READ        0x3b    /* Read data bytes (Dual SPI) */
> -#define	OPCODE_QUAD_READ        0x6b    /* Read data bytes (Quad SPI) */
> -#define	OPCODE_PP		0x02	/* Page program (up to 256 
bytes) */
> -#define	OPCODE_BE_4K		0x20	/* Erase 4KiB block */
> -#define	OPCODE_BE_4K_PMC	0xd7	/* Erase 4KiB block on PMC chips 
*/
> -#define	OPCODE_BE_32K		0x52	/* Erase 32KiB block */
> -#define	OPCODE_CHIP_ERASE	0xc7	/* Erase whole flash chip */
> -#define	OPCODE_SE		0xd8	/* Sector erase (usually 64KiB) 
*/
> -#define	OPCODE_RDID		0x9f	/* Read JEDEC ID */
> -#define	OPCODE_RDCR             0x35    /* Read configuration register 
*/
> +#define OPCODE_WREN		0x06	/* Write enable */
> +#define OPCODE_RDSR		0x05	/* Read status register */
> +#define OPCODE_WRSR		0x01	/* Write status register 1 byte */
> +#define OPCODE_NORM_READ	0x03	/* Read data bytes (low frequency) */
> +#define OPCODE_FAST_READ	0x0b	/* Read data bytes (high frequency) */
> +#define OPCODE_DUAL_READ        0x3b    /* Read data bytes (Dual SPI) */
> +#define OPCODE_QUAD_READ        0x6b    /* Read data bytes (Quad SPI) */

This is still a little non-standard -- or rather -- inconsistent here. You 
should use space after #define and \t after the name I'd say. I'd also say these 
two slipped your attention as the others do it just like that.

> +#define OPCODE_PP		0x02	/* Page program (up to 256 bytes) */
> +#define OPCODE_BE_4K		0x20	/* Erase 4KiB block */
> +#define OPCODE_BE_4K_PMC	0xd7	/* Erase 4KiB block on PMC chips */
> +#define OPCODE_BE_32K		0x52	/* Erase 32KiB block */
> +#define OPCODE_CHIP_ERASE	0xc7	/* Erase whole flash chip */
> +#define OPCODE_SE		0xd8	/* Sector erase (usually 64KiB) */
> +#define OPCODE_RDID		0x9f	/* Read JEDEC ID */
> +#define OPCODE_RDCR             0x35    /* Read configuration register */

DTTO here.

>  /* 4-byte address opcodes - used on Spansion and some Macronix flashes. */
> -#define	OPCODE_NORM_READ_4B	0x13	/* Read data bytes (low 
frequency) */
> -#define	OPCODE_FAST_READ_4B	0x0c	/* Read data bytes (high 
frequency) */
> -#define	OPCODE_DUAL_READ_4B	0x3c    /* Read data bytes (Dual SPI) */
> -#define	OPCODE_QUAD_READ_4B	0x6c    /* Read data bytes (Quad SPI) */
> -#define	OPCODE_PP_4B		0x12	/* Page program (up to 256 
bytes) */
> -#define	OPCODE_SE_4B		0xdc	/* Sector erase (usually 64KiB) 
*/
> +#define OPCODE_NORM_READ_4B	0x13	/* Read data bytes (low frequency) */
> +#define OPCODE_FAST_READ_4B	0x0c	/* Read data bytes (high frequency) */
> +#define OPCODE_DUAL_READ_4B	0x3c    /* Read data bytes (Dual SPI) */
> +#define OPCODE_QUAD_READ_4B	0x6c    /* Read data bytes (Quad SPI) */

This comment here is indented with spaces, while the other comments are indented 
with tabs ;-/
[...]
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
