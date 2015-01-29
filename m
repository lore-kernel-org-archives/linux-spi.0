From: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Subject: Re: [PATCH 7/7] spi: spi-fsl-dspi: Add support for TCFQ transfer mode
Date: Thu, 29 Jan 2015 19:10:31 +0100
Message-ID: <1a28f3439386e1132ae0f3ab80666305@agner.ch>
References: <1422356608-15961-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <1422356608-15961-2-git-send-email-bhuvanchandra.dv@toradex.com>
 <20150128190342.GE21293@sirena.org.uk> <1422533049999.91114@toradex.com>
 <20150129121320.GI21293@sirena.org.uk> <1422536382672.21760@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, mark.rutland-5wv7dgnIgG8@public.gmane.org,
	shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, B44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "BhuvanChandra.DV" <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>,
	Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1422536382672.21760-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 2015-01-29 13:53, BhuvanChandra.DV wrote:
> On 01/29/2015 05:43 PM, Mark Brown wrote:
>> On Thu, Jan 29, 2015 at 11:58:25AM +0000, BhuvanChandra.DV wrote:
>>
>>> As far as i understood the major difference between the two modes are when
>>> the interrupt to trigger, as EOQ mode will trigger the interrupt at end of
>>> queue and TCF will trigger the interrupt at every frame transfer. Probably
>>> mode selection shouldn't be a device tree property, but i don't see any
>>> automatic way to choose between the modes.
>>> Maybe a config would be more appropriate?
>> Or if there's either no particular reason to choose one over the other
>> or one is always better then just pick one in the driver and don't worry
>> about implementing both.
> 
> Among the two, EOQ would be better since with TCF, interrupts are generated at
> every frame transfer, which could be a problem at higher frequencies.
> I think we can omit this patch then.

It would be interesting to know what the authors original motivation
implementing this feature was. Reading the email of the original
patchset indicates that there are platforms where only TCF is supported:

<quote>
For adopting of different platform, either of them is a way of DSPI
transfer data.
</quote>

However, I don't know which platform that would be. Also, it seems that
Chao Fu's email is not valid anymore. 

@Xiubo Li, maybe you can shed some light on this?

>From the platform I am concerned about, Vybrid, it seems not very
useful, so I'm fine with omitting that patch.

--
Stefan 
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
