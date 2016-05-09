From: Yao Yuan <yao.yuan-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH 1/2] spi: spi-fsl-dspi: replace regmap R/W with internal
 implementation
Date: Mon, 9 May 2016 10:58:08 +0000
Message-ID: <AM2PR04MB0722180ABF5DB9406F56162B89700@AM2PR04MB0722.eurprd04.prod.outlook.com>
References: <1461744756-31481-1-git-send-email-yao.yuan@freescale.com>
 <1461744756-31481-2-git-send-email-yao.yuan@freescale.com>
 <20160427152532.GX3217@sirena.org.uk>
 <AM2PR04MB072250B43DE37A38E374679989700@AM2PR04MB0722.eurprd04.prod.outlook.com>
 <20160509102840.GB6292@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	"robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	"shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-devel-XDVM779Km55Y1YpKYGMr2+TW4wlIGRCZ@public.gmane.org" <linux-devel-XDVM779Km55Y1YpKYGMr2+TW4wlIGRCZ@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Yang-Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>,
	Scott Wood <scott.wood-3arQi8VN3Tc@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160509102840.GB6292-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, May 09, 2016 at 06:29:59AM +0800, Mark Brown wrote:
> On Mon, May 09, 2016 at 08:48:59AM +0000, Yao Yuan wrote:
> > Hi Mark Brown,
> 
> Please don't top post, reply in line with needed context.  This allows readers to
> readily follow the flow of conversation and understand what you are talking
> about and also helps ensure that everything in the discussion is being
> addressed.
> 
> Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages much
> easier to read and reply to.
> 

Ok, Thanks.

> > There are two problems we have found for use regmap up to now.
> 
> > 1, Regmap will read device value depends on endian in .dtsi(DSPI in .dtsi file is
> big-endian) and readl()(readl() in arm64 is le32_to_cpu read) in system.
> > That is the value read out is fixed regardless the kernel were compiled with
> CONFIG_CPU_BIG_ENDIAN yes or no. That makes the value(read from
> DSPI)can't be recognized in one endian mode(CONFIG_CPU_BIG_ENDIAN be
> set or not).
> > The result is: DSPI can't working with CONFIG_CPU_BIG_ENDIAN set.
> 
> This doesn't make sense.  If the endianness of the device is specified in DT then
> the endianness of the CPU won't make a difference.
> 

For example, if DSPI controller register is BE, so I set big-endian in DT.
That means we should R/W the DSPI controller register with big-endian.
Then I can think all of the value we R/W to/from DSPI controller register, we can
Think they are the BE.
So that we can understand it easy.

That means no matter core is LE or BE, we both need get the value from DSPI register
with big endian.

But from regmap is not.
When the core is little endian, I can get the big endian value form register like:0xaabbccdd.
Then we can analysis and process this value.
But once config the core to big endian, I get the value like:0xddccbbaa. It's the little endian.
That's terrible for my driver to understand the value.

> > 2, Sometimes regmap will generate some issues. Some regmap issues will
> cause the DSPI do not working.
> > At 2016.4 we find the DSPI was not work, then we found that the regmap
> R/W the controller register sometimes not right.
> > The result is: DSPI can't working with REGMAP API.
> > Although the regmap issues was fast fixed by some giving person. But I'm still
> tend to use the reliable way.
> 
> > Regmap is nice and Maybe I should try to fix regmap instead of replacing
> regmap in my driver.
> > But regmap is really very large and complex for DSPI driver.
> 
> Yes, if you find bugs in generic frameworks you should fix them rather than just
> open coding something. 
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
