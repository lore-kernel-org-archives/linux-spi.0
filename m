From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: [PATCH 1/4] spi: core: add spi_message_dump and spi_transfer_dump
Date: Fri, 18 Dec 2015 17:53:13 +0100
Message-ID: <407EFA5A-72AE-4609-8081-887CCA3C2944@martin.sperl.org>
References: <1450442668-2391-1-git-send-email-kernel@martin.sperl.org> <1450442668-2391-2-git-send-email-kernel@martin.sperl.org> <CAHp75VfYQf2nfxNxNhtwwbg2_OJdiU3RFgyoyZB-THCRtfJWBA@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VfYQf2nfxNxNhtwwbg2_OJdiU3RFgyoyZB-THCRtfJWBA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 18.12.2015, at 14:32, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 
> On Fri, Dec 18, 2015 at 2:44 PM,  <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org> wrote:
>> +static void __spi_transfer_dump_chunk(struct spi_device *spi, char *pre,
>> +                                     const void *ptr, size_t start,
>> +                                     size_t len)
...
all comments fixed in next patch (mostly by rewriting code to use %*ph)

> Documentation/printk-formats.txt is your friend. In particular a
> chapter about %*ph.
had to do a sprintf for the format itself as %*ph does not allow for
variable length - it still reduced the codesize...

> 
> roundup() / rounddown().
> 
> Magic.
> 
> Usually sentences are started with a capital letter and ended with a dot.
> 
all comments fixed in next patch
> 
> How many users do you have for the helpers? I suggest to add a helper
> whenever there are at least 2+ users present.
> 
As these are mostly convenience methods for use when debugging things
there are not typically that many users that would be needing those.
So I would prefer to keep them.

Thanks for the comments, Martin
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
