From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: img-spfi: fix kbuild test robot warning
Date: Thu, 6 Aug 2015 13:42:12 +0200
Message-ID: <CAMuHMdWPKrqh+VHFQu3mTODYzBmZ5Hh_eJyWwCPKRdiR3uGQYg@mail.gmail.com>
References: <1438853581-17154-1-git-send-email-sifan.naeem@imgtec.com>
	<20150806112828.GU20873@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150806112828.GU20873-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Aug 6, 2015 at 1:28 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, Aug 06, 2015 at 10:33:01AM +0100, Sifan Naeem wrote:
>> drivers/spi/spi-img-spfi.c: In function 'img_spfi_setup':
>> drivers/spi/spi-img-spfi.c:446: warning: 'ret' may be used
>> uninitialized in this function.
>>
>> Fixes: commit b03ba9e314c1 ("spi: img-spfi: fix multiple calls to request gpio")
>> Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
>
> This isn't a good commit message:
>
>>  static int img_spfi_setup(struct spi_device *spi)
>>  {
>> -     int ret;
>> +     int ret = -EINVAL;
>
> You're just assigning a return value so that the compiler can't tell if
> we've missed anything, that's often a sign of just papering over the
> cracks without understanding the problem - for example there may be a
> missing else case in some error path that the compiler was trying to
> tell you about where other cleanup is needed.  The changelog should say
> what the problem was and why the change solves it sensibly.

I'll bite...

It's not 100% clear to me -EINVAL is the right value.
Perhaps it should be 0?
Or the check for gpio_is_valid() should be removed?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
