From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: coldfire-qspi: Fix bits per word setting when
 t->bits_per_word is not set
Date: Sun, 2 Mar 2014 22:20:30 +0800
Message-ID: <CAFRkauACMhi6eyDC4Q421wLmhKz1VgM3FMeDBUkdwMFWbvmGiw@mail.gmail.com>
References: <1393463102.12945.3.camel@phoenix>
	<530F7167.7000307@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Steven King <sfking-xS0NTnu2YfYAvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <530F7167.7000307-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2014-02-28 1:09 GMT+08:00 Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>:
> On 02/26/2014 06:05 PM, Axel Lin wrote:
>> This ensures to use spi_device's bits_per_word setting when t->bits_per_word is
>> not set. This looks like a bug introduced by commit 24778be20f8
>> "spi: convert drivers to use bits_per_word_mask".
>
> I thought the SPI core already contained this kind of logic, so that
> drivers could rely on t->bits_per_word always being set up? Yes, this:
Hi Stephen,
Yes, you are right and thanks for the review.

Regards,
Axel
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
