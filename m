From: Wang Haikun <Haikun.Wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v1 2/3] spi: spi-fsl-dspi: Change the way of increasing
 spi_message->actual_length
Date: Mon, 25 May 2015 10:18:42 +0000
Message-ID: <BN1PR0301MB06121FF3CC7327990BA402DAF8CD0@BN1PR0301MB0612.namprd03.prod.outlook.com>
References: <1431511921-19548-1-git-send-email-haikun.wang@freescale.com>
 <20150521205549.GJ21577@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 5/22/2015 4:55 AM, Mark Brown wrote:
> On Wed, May 13, 2015 at 06:12:01PM +0800, Haikun Wang wrote:
>> In current driver, we increase actual_length in the following way:
>> message->actual_length += dspi_xxx_transfer()
>
> This doesn't apply against current code, please check and resend.
>
I am sorry I didn't put in words, this patch depends on my another patch 
"spi: spi-fsl-dspi: Enable TCF interrupt mode support".
Please review this after we get some progress on the previous one.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
