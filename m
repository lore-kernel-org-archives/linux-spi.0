From: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH v3 2/7] mtd: spi-nor: add the basic data structures
Date: Tue, 17 Dec 2013 16:16:56 +0100
Message-ID: <201312171616.57029.marex@denx.de>
References: <1387184330-14448-1-git-send-email-b32955@freescale.com> <201312171405.55964.marex@denx.de> <20131217134923.GA1220@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, angus.clark-qxv4g6HH51o@public.gmane.org,
	shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org, broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, pekon-l0cyMroinI0@public.gmane.org, sourav.poddar-l0cyMroinI0@public.gmane.org,
	computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131217134923.GA1220-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tuesday, December 17, 2013 at 02:49:25 PM, Huang Shijie wrote:
> On Tue, Dec 17, 2013 at 02:05:55PM +0100, Marek Vasut wrote:
> > On Monday, December 16, 2013 at 09:58:45 AM, Huang Shijie wrote:
> > > +struct spi_nor { > > +	struct mtd_info		*mtd;
> > > +	struct mutex		lock;
> > > +
> > > +	/* pointer to a spi device */
> > > +	struct device		*dev;
> > > +	u32			page_size;
> > > +	u8			addr_width;
> > > +	u8			erase_opcode;
> > > +	u8			read_opcode;
> > > +	u8			read_dummy;
> > > +	u8			program_opcode;
> > > +	enum read_mode		flash_read;
> > > +	bool			sst_write_second;
> > > +	struct spi_nor_xfer_cfg	cfg;
> > 
> > You do want to split the function pointers below and the device
> > configuration above into separate structures.
> 
> sorry, i prefer to keep them in one data structrue, just like the
> nand_chip{} does.

Can you explain why?

> > > +	/* for write_reg */
> > > +	u8			cmd_buf[SPI_NOR_MAX_CMD_SIZE];
> > > +
> > > +	/*
> > > +	 * Do some work before or after we run these operations:
> > > +	 *   read/write/erese/lock/unlock
> > 
> > Proper kernel-doc style comments for this structure would be nice.
> 
> Do you mean the style used by nand_chip{}?

Yes. See Documentation/kernel-doc-nano-HOWTO.txt

Best regards,
Marek Vasut
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
