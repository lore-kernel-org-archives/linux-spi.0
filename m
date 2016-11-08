From: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Subject: Re: [PATCH] ARM: spi: rewrites the name of the function.
Date: Tue, 08 Nov 2016 09:17:12 +0900
Message-ID: <58211988.2070801@jinso.co.jp>
References: <1478480410-6320-1-git-send-email-cm-hiep@jinso.co.jp> <CAMuHMdVMgsBO6ou4wYSp3pmBWDy_ZCoWaZFN+Zpq9dryRsSANw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Ryusuke Sakato <ryusuke.sakato.bx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        =?UTF-8?B?RHVuZ++8muS6ug==?= =?UTF-8?B?44K9?=
        <nv-dung-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>,
        =?UTF-8?B?56iy5ZCJ?= <h-inayoshi-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdVMgsBO6ou4wYSp3pmBWDy_ZCoWaZFN+Zpq9dryRsSANw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert,

Thanks for your comment.

On 11/07/2016 07:25 PM, Geert Uytterhoeven wrote:
> Hi Hiep,
>
> On Mon, Nov 7, 2016 at 2:00 AM, Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org> wrote:
>> From: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
>>
>> This patch rewrites the name of rspi_pio_transfer_in_or_out
>> function.
>>
>> Signed-off-by: Hiep Cao Minh <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
> Acked-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
>
> But you want to use proper prefixes matching the style of the subsystem,
> to avoid Mark's canned message reply system.
>
> Always use e.g. "git log --oneline drivers/spi/spi-rspi.c" to find out...
Thanks, I will make matching the style of the subsystem.

Jinzai Solution.
Hiep.

> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
>

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
