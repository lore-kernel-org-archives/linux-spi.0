From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: atmel: Fix test unsigned var < 0
Date: Thu, 27 Mar 2014 08:46:12 +0800
Message-ID: <CAFRkauBh+4-NmneTh=io7grG4MpSZ98riybAOOpEff+KiPZUjg@mail.gmail.com>
References: <1395498809.16958.1.camel@phoenix>
	<20140326165145.GD14287@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140326165145.GD14287-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2014-03-27 0:51 GMT+08:00 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Sat, Mar 22, 2014 at 10:33:29PM +0800, Axel Lin wrote:
>> current_remaining_bytes is an unsigned long and cannot be below 0.
>
>> -     if (xfer->bits_per_word > 8) {
>> +
>> +     if (xfer->bits_per_word > 8)
>>               as->current_remaining_bytes -= 2;
>> -             if (as->current_remaining_bytes < 0)
>> -                     as->current_remaining_bytes = 0;
>> -     } else {
>> +     else
>>               as->current_remaining_bytes--;
>> -     }
>
> This removes an error check in the case that we set the remaining bytes
> to -1.  The length validation the core does should ensure that never
> happens but it seems wrong to just ignore that - we should at least note
> in the changelog that the analysis has been done.
I thought it never happen and there is no bug report for this so it's
safe with this patch.

>
> Are you sure that the best fix isn't to just use an int here?
Wenyou,
  Any comments for this?

Regards,
Axel
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
