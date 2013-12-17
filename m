From: Huang Shijie <shijie8-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 7/7] mtd: spi-nor: Add Freescale QuadSpi driver
Date: Tue, 17 Dec 2013 22:24:20 +0800
Message-ID: <20131217142417.GB1168@gmail.com>
References: <1387184330-14448-1-git-send-email-b32955@freescale.com>
 <1387184330-14448-8-git-send-email-b32955@freescale.com>
 <201312171416.18560.marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, angus.clark-qxv4g6HH51o@public.gmane.org,
	shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, b44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org, broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, pekon-l0cyMroinI0@public.gmane.org, sourav.poddar-l0cyMroinI0@public.gmane.org,
	computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201312171416.18560.marex-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, Dec 17, 2013 at 02:16:18PM +0100, Marek Vasut wrote:
> On Monday, December 16, 2013 at 09:58:50 AM, Huang Shijie wrote:
> [...]
> 
> > +/* Macros for constructing the LUT register. */
> > +#define LUT0(ins, pad, opr)						\
> > +		(((opr) << OPRND0_SHIFT) | ((LUT_##pad) << PAD0_SHIFT) | \
> > +		((LUT_##ins) << INSTR0_SHIFT))
> > +
> > +#define LUT1(ins, pad, opr)	(LUT0(ins, pad, opr) << OPRND1_SHIFT)
> 
> Change this into an inline function, that way you'd get type-checking here.

Could an inline function do the name-link? such as LUT_##ins ?

> 
> [...]
> 
> > +enum fsl_qspi_devtype {
> > +	FSL_QUADSPI_VYBRID,
> > +	FSL_QUADSPI_IMX6SLX
> 
> Will the SLX be only a single-core chip?
yes.


> 
> > +};
> > +
> > +struct fsl_qspi_devtype_data {
> > +	enum fsl_qspi_devtype devtype;
> > +	u32 memmap_base;
> > +	int rxfifo;
> > +	int txfifo;
> > +};
> > +
> > +static struct fsl_qspi_devtype_data vybrid_data = {
> > +	.devtype = FSL_QUADSPI_VYBRID,
> > +	.memmap_base = 0x20000000,
> 
> This memmap_base should come from DT prop.
yes, i think it should be frome DT property.

> 
> > +	.rxfifo = 128,
> > +	.txfifo = 64
> 
these two depend on the IP, not board specific.
So they should not in the DT.

thanks
Huang Shijie
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
