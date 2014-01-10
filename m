From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH v2 1/2] spi:fsl-dspi:add support of DSPI IP in big
	endian
Date: Fri, 10 Jan 2014 12:53:59 +0000
Message-ID: <20140110125359.GB15937@n2100.arm.linux.org.uk>
References: <1389161655-21856-1-git-send-email-b44548@freescale.com> <20140109175208.GK12858@sirena.org.uk> <e9c8019df2cf4d76ae2b77c5d1420050@BL2PR03MB163.namprd03.prod.outlook.com> <20140110124014.GI29039@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chao Fu <B44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	"grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Jingchang Lu <jingchang.lu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140110124014.GI29039-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Jan 10, 2014 at 12:40:14PM +0000, Mark Brown wrote:
> On Fri, Jan 10, 2014 at 08:11:33AM +0000, Chao Fu wrote:
> 
> > [Chao Fu] Our CPUs are working on only ARM architecture. But DSPI have two endianness 
> > In different series CPU, so we use __raw_read that do not take of endianness.
> > We need observe ARM io methods  make sure avoid instructions executing reorder .
> > ARM IO methods :
> > #define readb(c)                ({ u8  __v = readb_relaxed(c); __iormb(); __v; })
> > #define readw(c)                ({ u16 __v = readw_relaxed(c); __iormb(); __v; })
> > #define readl(c)                ({ u32 __v = readl_relaxed(c); __iormb(); __v; })
> > 
> > #define writeb(v,c)             ({ __iowmb(); writeb_relaxed(v,c); })
> > #define writew(v,c)             ({ __iowmb(); writew_relaxed(v,c); })
> > #define writel(v,c)             ({ __iowmb(); writel_relaxed(v,c); })
> > 
> > So add barrier here. Could you give some suggestions? Many thanks!
> 
> OK that makes sense, please add comments explaining that this is due to
> the endinaness translation.  Given that people are starting to use big
> endian more it might be sensible to have these factored out into generic
> code but that can wait.

Accesses to device memory are guaranteed by the architecture to be in
program order when they're within the same 1K block of memory.  Larger
blocks are permissible, and depends on the SoC.  (The ARM ARM is a little
unclear on this statement, and I believe the statement is/has been fixed.)

The barriers above are not about ensuring correct program order (we have
that anyway), they're about ensuring the visibility externally given the
ARM ARM mess-up, and _primerily_ ensuring proper order between DMA
coherent memory and a DMA agent being enabled, or the DMA agent status
being read vs DMA coherent memory.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
