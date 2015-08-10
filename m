From: "Franklin S Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org>
Subject: Re: [RESEND][PATCH 3/4] ARM: davinci: Set proper SPI prescale limit
 value
Date: Mon, 10 Aug 2015 18:47:25 -0500
Message-ID: <55C9380D.1060802@ti.com>
References: <1437568344-18889-1-git-send-email-fcooper@ti.com> <1437568344-18889-4-git-send-email-fcooper@ti.com> <55B22681.3060000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <khilman-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>,
	<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	<ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
	<pawel.moll-5wv7dgnIgG8@public.gmane.org>, <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<linux-arm-kernel-xBCQruHUn5ppWr+L1FloEB2eb7JE58TQ@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	<ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <55B22681.3060000-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 07/24/2015 06:50 AM, Sekhar Nori wrote:
> On Wednesday 22 July 2015 06:02 PM, Franklin S Cooper Jr wrote:
>> SPI Davinci driver has been updated to allow SOCs to specify their minimum
>> prescale value. Update the various SOCs board files that use this driver with
>> their proper prescaler limit.
>>
>> Signed-off-by: Franklin S Cooper Jr <fcooper-l0cyMroinI0@public.gmane.org>
> Acked-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
>
> in case Mark is okay to take it through his tree. It does not clash with
> anything else I have for mach-davinci.
>
> Thanks,
> Sekhar
>
ping. Patches 1 and 2 have already been pulled into Mark's spi tree and are currently in in linux-next.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
