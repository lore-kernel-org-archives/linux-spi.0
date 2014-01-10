From: Chao Fu <B44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH v2 1/2] spi:fsl-dspi:add support of DSPI IP in big endian
Date: Fri, 10 Jan 2014 08:11:33 +0000
Message-ID: <e9c8019df2cf4d76ae2b77c5d1420050@BL2PR03MB163.namprd03.prod.outlook.com>
References: <1389161655-21856-1-git-send-email-b44548@freescale.com>,<20140109175208.GK12858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Jingchang Lu <jingchang.lu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140109175208.GK12858-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

> This looks a lot nicer - a few things below though.
> 
> > +#define DSPI_BITWISE16(d, v)	(d->big_endian ? cpu_to_be16(v) :
> cpu_to_le16(v))
> > +#define DSPI_BITWISE32(d, v)	(d->big_endian ? cpu_to_be32(v) :
> cpu_to_le32(v))
> 
> These should probably be inline for the same reason as the I/O functions,
> perhaps even being done as part of the I/O functions.
> 
[Chao Fu] Thank you, Mark! I wiil put them into inline functions.

> > +static inline u16 dspi_readw(void __iomem *addr) {
> > +	u16 __v = (__force u16) __raw_readw(addr);
> > +	__iormb();
> > +
> > +	return __v;
> > +}
> 
> Why does this need a barrier and why does it not take care of the
> endianness translation?  A quick glance through shows most if not all of
> the callers doing the translation.
>
[Chao Fu] Our CPUs are working on only ARM architecture. But DSPI have two endianness 
In different series CPU, so we use __raw_read that do not take of endianness.
We need observe ARM io methods  make sure avoid instructions executing reorder .
ARM IO methods :
#define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(); __v; })
#define readw(c)                ({ u16 __v = readw_relaxed(c); __iormb(); __v; })
#define readl(c)                ({ u32 __v = readl_relaxed(c); __iormb(); __v; })

#define writeb(v,c)             ({ __iowmb(); writeb_relaxed(v,c); })
#define writew(v,c)             ({ __iowmb(); writew_relaxed(v,c); })
#define writel(v,c)             ({ __iowmb(); writel_relaxed(v,c); })

So add barrier here. Could you give some suggestions? Many thanks!
 
> > +static inline void dspi_writew(u16 val, void __iomem *addr) {
> > +	__iowmb();
> > +	__raw_writew((__force u16) val, addr); }
> 
> Again the memory barrier seems odd, especially the barrier *before* doing
> the write.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
