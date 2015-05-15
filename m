From: Wang Haikun <Haikun.Wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v2 1/3] spi: spi-fsl-dspi: Enable TCF interrupt mode
 support
Date: Fri, 15 May 2015 09:28:44 +0000
Message-ID: <BN1PR0301MB06125C2B6A856EDF63E3478EF8C70@BN1PR0301MB0612.namprd03.prod.outlook.com>
References: <1431511911-19376-1-git-send-email-haikun.wang@freescale.com>
 <20150513181701.GJ2761@sirena.org.uk>
 <BN1PR0301MB0612557038FAE3C4ADE5EE80F8D80@BN1PR0301MB0612.namprd03.prod.outlook.com>
 <20150514095618.GN2761@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 5/14/2015 5:56 PM, Mark Brown wrote:
> On Thu, May 14, 2015 at 02:26:53AM +0000, Wang Haikun wrote:
>
>> Yes, you are right. Platforms are different about this. Some platform
>> only can work in one of the interrupt mode due to silicon issue. So we
>> need support both of the two modes and chose the correct one in the dts
>> node.
>
> It is more normal to do this sort of selection by having different
> compatible strings for the different versions of the IP (often using the
> SoC name if the IP isn't versioned) - that way we don't need individual
> properties for every difference in the silicon and we only need to
> update the kernel and not the device tree if we discover some issue.
>
Fine, I will adopt your advice.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
