From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH V2 2/4] mtd: spi-nor: add the basic data structures
Date: Wed, 11 Dec 2013 14:24:31 +0800
Message-ID: <20131211062428.GA25147@shlinux2.ap.freescale.net>
References: <1386318764-15882-1-git-send-email-b32955@freescale.com>
 <1386318764-15882-3-git-send-email-b32955@freescale.com>
 <201312101407.59958.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	<angus.clark-qxv4g6HH51o@public.gmane.org>, <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, <pekon-l0cyMroinI0@public.gmane.org>,
	<sourav.poddar-l0cyMroinI0@public.gmane.org>, <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	<linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201312101407.59958.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Dec 10, 2013 at 02:07:59PM +0100, Marek Vasut wrote:
> On Friday, December 06, 2013 at 09:32:42 AM, Huang Shijie wrote:
> > The spi_nor{} is cloned from the m25p{}.
> > +	struct spi_nor_xfer_cfg	cfg;
> > +
> > +	/* for write_reg */
> > +	u8			cmd_buf[SPI_NOR_MAX_CMD_SIZE];
> > +
> > +	/* the two fundamental primitives */
> > +	int (*read_xfer)(struct spi_nor *nor, struct spi_nor_xfer_cfg *cfg,
> > +			 u8 *buf, size_t len);
> > +	int (*write_xfer)(struct spi_nor *nor, struct spi_nor_xfer_cfg *cfg,
> > +			  u8 *buf, size_t len);
> > +
> > +	int (*read_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len);
> > +	int (*write_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int len,
> > +			int write_enable);
> 
> Does the vybrid really support accelerated SPI NOR register IO or does it 
The vybrid does not support the accelerated SPI NOR register IO.
these hooks are for Lee's driver.
> emulate it with read/write or read_xfer/write_xfer accessors ? If the later, 
> just drop this stuff for now.

What is the "stuff" mean? the "write_enable" ?

> 
> > +	const struct spi_device_id *(*read_id)(struct spi_nor *nor);
> > +	int (*wait_till_ready)(struct spi_nor *nor);
> > +
> > +	/* write */
> > +	void (*write)(struct spi_nor *nor, loff_t to,
> > +			size_t len, size_t *retlen, const u_char *buf);
> > +	/* read */
> > +	int (*read)(struct spi_nor *nor, loff_t from,
> > +			size_t len, size_t *retlen, u_char *buf);
> > +	/* erase */
> > +	int (*erase)(struct spi_nor *nor, loff_t offs);
> 
> How do you specify what to erase (sub-sector, sector, whole chip) here ?
I use a write_reg(OPCODE_ERASE_CHIP) to erase the whole chip.
Please read the patch 3.

This hook is used to erase a sector.

Btw, what is the sub-sector mean? which opcodes for the sub-sector?

thanks
Huang Shijie



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
