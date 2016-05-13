From: Scott Wood <scott.wood-3arQi8VN3Tc@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: spi-fsl-dspi: replace regmap R/W with internal
 implementation
Date: Fri, 13 May 2016 03:08:55 +0000
Message-ID: <DB5PR0401MB192850FBCBE79EBBC61ACA3A91740@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1461744756-31481-1-git-send-email-yao.yuan@freescale.com>
 <1461744756-31481-2-git-send-email-yao.yuan@freescale.com>
 <20160427152532.GX3217@sirena.org.uk>
 <AM2PR04MB072250B43DE37A38E374679989700@AM2PR04MB0722.eurprd04.prod.outlook.com>
 <20160509102840.GB6292@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	"shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-devel-XDVM779Km55Y1YpKYGMr2+TW4wlIGRCZ@public.gmane.org" <linux-devel-XDVM779Km55Y1YpKYGMr2+TW4wlIGRCZ@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Yang-Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Yao Yuan <yao.yuan-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 05/09/2016 05:29 AM, Mark Brown wrote:
> On Mon, May 09, 2016 at 08:48:59AM +0000, Yao Yuan wrote:
>> 2, Sometimes regmap will generate some issues. Some regmap issues will cause the DSPI do not working.
>> At 2016.4 we find the DSPI was not work, then we found that the regmap R/W the controller register sometimes not right. 
>> The result is: DSPI can't working with REGMAP API.
>> Although the regmap issues was fast fixed by some giving person. But I'm still tend to use the reliable way.
> 
>> Regmap is nice and Maybe I should try to fix regmap instead of replacing regmap in my driver.
>> But regmap is really very large and complex for DSPI driver.
> 
> Yes, if you find bugs in generic frameworks you should fix them rather
> than just open coding something.  

That's often true, but using regmap to handle endianness is like
swatting flies with a sledgehammer.  Regmap's code is quite (over?)
complicated (e.g. the (user-visible!) difference between
reg_format_endian and val_format_endian is quite confusing) and ideally
people who aren't getting actual value from a buggy and/or awkward
subsystem shouldn't be forced to use/fix it.  We're not talking about
massive duplication here.  We're talking about a set of simple I/O
wrappers (something that many drivers do) with an if-statement.

That said, Yao Yuan, can you try linux-next to see if the regmap
problems have been fixed?  Looking at Linus's tree I don't see how
regmap-mmio would ever give you anything but little-endian if the driver
doesn't specify an endianness (the device tree is only looked at by
regmap_get_val_endian() which wasn't called for regmap-mmio), but that
appears to be fixed in linux-next.

-Scott

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
