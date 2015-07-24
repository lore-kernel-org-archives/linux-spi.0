From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [PATCH] Revert "spi: bitbang: only toggle bitchanges"
Date: Fri, 24 Jul 2015 13:55:30 +0200
Message-ID: <55B227B2.9080205@metafoo.de>
References: <1437716236-12715-1-git-send-email-larper@axis.com>	 <20150724104419.GH11162@sirena.org.uk> <1437738480.31818.5.camel@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org" <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Lars Persson <lars.persson-VrBV9hrLPhE@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1437738480.31818.5.camel-VrBV9hrLPhE@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 07/24/2015 01:48 PM, Lars Persson wrote:
> On Fri, 2015-07-24 at 12:44 +0200, Mark Brown wrote:
>> On Fri, Jul 24, 2015 at 07:37:16AM +0200, Lars Persson wrote:
>>> This reverts commit 232a5adc5199 ("spi: bitbang: only toggle
>>> bitchanges") because it breaks bitbanged SPI on our MIPS system. I
>>> found two problems with the patch:
>>> - oldbit must initially be computed from bit position 7, 15 or 31 of
>>>    word depending on the value of bits.
>>
>> This might be a real issue but fixing it does not require a revert.
>>
>>> - The optimization also does not eliminate consecutive ones because
>>>    the compare of 1<<31 and 1 will be false (a bool only takes values 0
>>>    or 1).
>>
>> No, any non-zero value is true in C.  I assume you're talking about
>> this section of the diff:
>>
>>> -		if ((flags & SPI_MASTER_NO_TX) == 0) {
>>> -			if ((word & (1 << 31)) != oldbit) {
>>> -				setmosi(spi, word & (1 << 31));
>>> -				oldbit = word & (1 << 31);
>>
>> which looks fine - we see if the top bit is the same as the last top bit
>> we wrote, if it isn't we update the value output and record what we just
>> wrote.
>
> No this is a misunderstanding about the semantics of the bool type.
> When assigning to the bool any non-zero value becomes 1.
> When comparing an integer against the bool, the bool is promoted to an
> integer.

 From the patch context alone it is not clear that oldbit is of type bool. I 
think this is where the confusion came from. By just looking at the path 
fragment itself you'd think that oldbit is a unsigned int given its usage 
pattern. But it becomes obvious that the code wont work if you know oldbit 
is a bool.

- Lars

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
