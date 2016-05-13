From: Scott Wood <scott.wood-3arQi8VN3Tc@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: spi-fsl-dspi: replace regmap R/W with internal
 implementation
Date: Fri, 13 May 2016 02:29:03 +0000
Message-ID: <DB5PR0401MB1928FE8EC4E862B1FF2F9BAE91740@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1461744756-31481-1-git-send-email-yao.yuan@freescale.com>
 <1461744756-31481-2-git-send-email-yao.yuan@freescale.com>
 <20160427152532.GX3217@sirena.org.uk>
 <AM2PR04MB072250B43DE37A38E374679989700@AM2PR04MB0722.eurprd04.prod.outlook.com>
 <20160509102840.GB6292@sirena.org.uk>
 <AM2PR04MB0722180ABF5DB9406F56162B89700@AM2PR04MB0722.eurprd04.prod.outlook.com>
 <20160512163131.GF6261@sirena.org.uk>
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
	Yang-Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Yao Yuan <yao.yuan-3arQi8VN3Tc@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 05/12/2016 11:31 AM, Mark Brown wrote:
> On Mon, May 09, 2016 at 10:58:08AM +0000, Yao Yuan wrote:
> 
>> For example, if DSPI controller register is BE, so I set big-endian in DT.
>> That means we should R/W the DSPI controller register with big-endian.
>> Then I can think all of the value we R/W to/from DSPI controller register, we can
>> Think they are the BE.
>> So that we can understand it easy.
> 
>> That means no matter core is LE or BE, we both need get the value from DSPI register
>> with big endian.
> 
> That's not how regmap is intended to be used, the intention is that the
> driver will interact with native endian values and regmap will hide the
> endianness changes.  You could mask this with some cpu_to_be() and
> be_to_cpu() usage but I'm not sure it's a great idea or what it's buying
> you.

I don't think that's what Yao Yuan meant.  The driver wants the I/O
accessor to return native-endian values, just like any other driver.

-Scott

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
