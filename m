From: Wang Haikun <Haikun.Wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v2 1/3] spi: spi-fsl-dspi: Enable TCF interrupt mode
 support
Date: Thu, 14 May 2015 02:26:53 +0000
Message-ID: <BN1PR0301MB0612557038FAE3C4ADE5EE80F8D80@BN1PR0301MB0612.namprd03.prod.outlook.com>
References: <1431511911-19376-1-git-send-email-haikun.wang@freescale.com>
 <20150513181701.GJ2761@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 5/14/2015 2:17 AM, Mark Brown wrote:
> On Wed, May 13, 2015 at 06:11:51PM +0800, Haikun Wang wrote:
>> DSPI module has two optional interrupts when complete data transfer.
>> One is EOQ interrupt, the other one is TCF interrupt.
>> EOQ indicates a queue of data frame has been transmitted.
>> TCF indicates a frame has been transmitted.
>> This patch enable support TCF mode.
>> User can configure expected mode in dts node.
>
> Same feedback as before: why make this user selectable?
"This is adding a DT binding without documenting it, all DT bindings need
to be documented.  I'm also not clear why this is something the user
would want to be able to select from DT - what is platform specific
about this?  Shouldn't the driver just ensure that the most appropriate
interrupt mode is used?"

Yes, you are right. Platforms are different about this. Some platform 
only can work in one of the interrupt mode due to silicon issue. So we 
need support both of the two modes and chose the correct one in the dts 
node.

I will send a patch updating the doc.
>


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
