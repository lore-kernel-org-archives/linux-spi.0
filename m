From: Leo Li <pku.leo-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: spi-fsl-dspi: replace regmap R/W with internal implementation
Date: Thu, 12 May 2016 18:55:38 -0500
Message-ID: <CADRPPNSA_2Wy+O1t0ggugp0eJL2q61s_m-rWzqNnLRB0fhF1Cw@mail.gmail.com>
References: <1461744756-31481-1-git-send-email-yao.yuan@freescale.com>
	<1461744756-31481-2-git-send-email-yao.yuan@freescale.com>
	<20160427152532.GX3217@sirena.org.uk>
	<AM2PR04MB072250B43DE37A38E374679989700@AM2PR04MB0722.eurprd04.prod.outlook.com>
	<20160509102840.GB6292@sirena.org.uk>
	<AM2PR04MB0722180ABF5DB9406F56162B89700@AM2PR04MB0722.eurprd04.prod.outlook.com>
	<20160512163131.GF6261@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Yao Yuan <yao.yuan-3arQi8VN3Tc@public.gmane.org>, Yuan Yao <yao.yuan-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	"robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"pawel.moll-5wv7dgnIgG8@public.gmane.org" <pawel.moll-5wv7dgnIgG8@public.gmane.org>,
	"shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-devel-XDVM779Km55Y1YpKYGMr2+TW4wlIGRCZ@public.gmane.org" <linux-devel-XDVM779Km55Y1YpKYGMr2+TW4wlIGRCZ@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Yang-Leo Li <leoyang.li-3arQi8VN3Tc@public.gmane.org>,
	Scott Wood <scott.wood-3arQi8VN3Tc@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160512163131.GF6261-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, May 12, 2016 at 11:31 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
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

So you do agree that the DSPI driver shouldn't use the regmap APIs?
It is still confusing to me on what is the intended behavior for the
endianness property in device tree.  Previously for regmap binding the
default endian is the native-endian if no endian property is not
present.  But for bindings of many devices including the
Documentation/devicetree/bindings/common-properties.txt file, the
default endian is the endian when the device is first used in the dts
binding.  For example, the FSL/NXP IFC device was first used as a
big-endian device for PowerPC SoCs.  The default endian should be
big-endian no matter if it is used on PowerPC or ARM later.  It
shouldn't be default to little-endian on an ARM SoC.

Regards,
Leo
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
