From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: Re: [PATCH] Revert "spi: bitbang: only toggle bitchanges"
Date: Fri, 24 Jul 2015 13:55:03 +0200
Message-ID: <CAOiHx=nMEZGSC_S-7oWH9-v1gh-RF5WoOvL3Cj=O39BD0TKwKw@mail.gmail.com>
References: <1437716236-12715-1-git-send-email-larper@axis.com> <20150724104419.GH11162@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Lars Persson <lars.persson-VrBV9hrLPhE@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Lars Persson <larper-VrBV9hrLPhE@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150724104419.GH11162-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Jul 24, 2015 at 12:44 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Jul 24, 2015 at 07:37:16AM +0200, Lars Persson wrote:
>> This reverts commit 232a5adc5199 ("spi: bitbang: only toggle
>> bitchanges") because it breaks bitbanged SPI on our MIPS system. I
>> found two problems with the patch:
>> - oldbit must initially be computed from bit position 7, 15 or 31 of
>>   word depending on the value of bits.
>
> This might be a real issue but fixing it does not require a revert.
>
>> - The optimization also does not eliminate consecutive ones because
>>   the compare of 1<<31 and 1 will be false (a bool only takes values 0
>>   or 1).
>
> No, any non-zero value is true in C.  I assume you're talking about
> this section of the diff:

While any value will be treated as true, the inverse of a value (!)
can only ever be 0 or 1, so

>> -             bool oldbit = !(word & 1);

makes oldbit to be either 0 or 1, and here

>> -                     if ((word & (1 << 31)) != oldbit) {

we compare the bool with an unsigned integer, thus the bool gets
promoted to unsigned integer as well, and we compare
0 or 1 with 0 or (1 << 31), so if oldbit is 1 this condition will
always evaluate to true.

Feel free to verify with a compiler of your choice ;-)

The fix for this is to use !!(word & (1 << 31)).


Jonas
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
