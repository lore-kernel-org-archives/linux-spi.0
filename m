From: Yao Yuan <yao.yuan-3arQi8VN3Tc@public.gmane.org>
Subject: RE: [PATCH 1/2] spi: spi-fsl-dspi: replace regmap R/W with internal
 implementation
Date: Mon, 9 May 2016 08:48:59 +0000
Message-ID: <AM2PR04MB072250B43DE37A38E374679989700@AM2PR04MB0722.eurprd04.prod.outlook.com>
References: <1461744756-31481-1-git-send-email-yao.yuan@freescale.com>
 <1461744756-31481-2-git-send-email-yao.yuan@freescale.com>
 <20160427152532.GX3217@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	"shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-devel-XDVM779Km55Y1YpKYGMr2+TW4wlIGRCZ@public.gmane.org" <linux-devel-XDVM779Km55Y1YpKYGMr2+TW4wlIGRCZ@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Yang-Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>,
	Scott Wood <scott.wood-3arQi8VN3Tc@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160427152532.GX3217-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Mark Brown,

There are two problems we have found for use regmap up to now.

1, Regmap will read device value depends on endian in .dtsi(DSPI in .dtsi file is big-endian) and readl()(readl() in arm64 is le32_to_cpu read) in system.  
That is the value read out is fixed regardless the kernel were compiled with CONFIG_CPU_BIG_ENDIAN yes or no. That makes the value(read from DSPI)can't be recognized in one endian mode(CONFIG_CPU_BIG_ENDIAN be set or not).
The result is: DSPI can't working with CONFIG_CPU_BIG_ENDIAN set.

2, Sometimes regmap will generate some issues. Some regmap issues will cause the DSPI do not working.
At 2016.4 we find the DSPI was not work, then we found that the regmap R/W the controller register sometimes not right. 
The result is: DSPI can't working with REGMAP API.
Although the regmap issues was fast fixed by some giving person. But I'm still tend to use the reliable way.

Regmap is nice and Maybe I should try to fix regmap instead of replacing regmap in my driver.
But regmap is really very large and complex for DSPI driver.

I think maybe the suitable way is the best way even the regmap is so good as everyone says.

So I strongly suggest to use the dspi_writel / dspi_readl  to instead of the regmap in DSPI driver.

Best Regards,
Yuan Yao


> -----Original Message-----
> From: Mark Brown [mailto:broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org]
> Sent: Wednesday, April 27, 2016 11:26 PM
> To: Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; pawel.moll-5wv7dgnIgG8@public.gmane.org; shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; linux-
> devel-XDVM779Km55Y1YpKYGMr2+TW4wlIGRCZ@public.gmane.org; linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org;
> devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Yao Yuan <yao.yuan-3arQi8VN3Tc@public.gmane.org>; Yang-Leo Li
> <leoyang.li-3arQi8VN3Tc@public.gmane.org>; Scott Wood <scott.wood-3arQi8VN3Tc@public.gmane.org>
> Subject: Re: [PATCH 1/2] spi: spi-fsl-dspi: replace regmap R/W with internal
> implementation
> 
> On Wed, Apr 27, 2016 at 04:12:35PM +0800, Yuan Yao wrote:
> 
> > At first we use regmap to cover this issue.
> > But the regmap is designed too large and complex.
> > The issue for regmap often effect the DSPI's stability.
> 
> I'm not convinced that open coding things is going to make life much easier
> here.  If there's problems in the underlying code then fixing those seems like a
> more generally useful approach to things.  What are the actual problems this is
> intended to fix?
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
