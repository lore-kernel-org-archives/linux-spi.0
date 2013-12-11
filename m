From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 2/4] mtd: spi-nor: add the basic data structures
Date: Wed, 11 Dec 2013 11:53:45 +0000
Message-ID: <20131211115345.GL16780@lee--X1>
References: <1386318764-15882-1-git-send-email-b32955@freescale.com>
 <201312101407.59958.marex@denx.de>
 <20131211062428.GA25147@shlinux2.ap.freescale.net>
 <201312111102.18554.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org,
	computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, angus.clark-qxv4g6HH51o@public.gmane.org, pekon-l0cyMroinI0@public.gmane.org,
	sourav.poddar-l0cyMroinI0@public.gmane.org, broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201312111102.18554.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

> > > > The spi_nor{} is cloned from the m25p{}.
> > > > +	struct spi_nor_xfer_cfg	cfg;
> > > > +
> > > > +	/* for write_reg */
> > > > +	u8			cmd_buf[SPI_NOR_MAX_CMD_SIZE];
> > > > +
> > > > +	/* the two fundamental primitives */
> > > > +	int (*read_xfer)(struct spi_nor *nor, struct spi_nor_xfer_cfg=
 *cfg,
> > > > +			 u8 *buf, size_t len);
> > > > +	int (*write_xfer)(struct spi_nor *nor, struct spi_nor_xfer_cf=
g *cfg,
> > > > +			  u8 *buf, size_t len);
> > > > +
> > > > +	int (*read_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int =
len);
> > > > +	int (*write_reg)(struct spi_nor *nor, u8 opcode, u8 *buf, int=
 len,
> > > > +			int write_enable);
> > >=20
> > > Does the vybrid really support accelerated SPI NOR register IO or=
 does it
> >=20
> > The vybrid does not support the accelerated SPI NOR register IO.
> > these hooks are for Lee's driver.
>=20
> Which one please?

It's not in Mainline yet, but the patches are on the list.

If you search for st_spi_fsm, you'll find them.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
