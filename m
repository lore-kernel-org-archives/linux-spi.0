From: Yoshihiro Kaneko <ykaneko0929-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: sh-msiof: Add rcar fallback compatibility string
Date: Fri, 25 Dec 2015 02:52:19 +0900
Message-ID: <CAH1o70+gnN==SGnTQ2FH4WtneZTFgiu6N1W1G3nQv3XG=coPPg@mail.gmail.com>
References: <1450955807-22869-1-git-send-email-ykaneko0929@gmail.com>
	<1450955807-22869-2-git-send-email-ykaneko0929@gmail.com>
	<CAMuHMdXe8Jpz6aTJkLTcNkKpsoV7tDSjUwuaZY7LxfojA9z7cw@mail.gmail.com>
	<CAMuHMdWxP3LYpng199Y3Ppp9ci0BkaA5RbCStuT40iky81e6Ww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdWxP3LYpng199Y3Ppp9ci0BkaA5RbCStuT40iky81e6Ww-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert-san,

2015-12-25 0:01 GMT+09:00 Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>:
> Hi Kaneko-san,
>
> On Thu, Dec 24, 2015 at 3:58 PM, Geert Uytterhoeven
> <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> wrote:
>>> --- a/drivers/spi/spi-sh-msiof.c
>>> +++ b/drivers/spi/spi-sh-msiof.c
>>
>>> @@ -971,8 +972,8 @@ static const struct sh_msiof_chipdata r8a779x_data = {
>>>  };
>>>
>>>  static const struct of_device_id sh_msiof_match[] = {
>>> -       { .compatible = "renesas,sh-msiof",        .data = &sh_data },
>>> -       { .compatible = "renesas,sh-mobile-msiof", .data = &sh_data },
>>
>>  "renesas,sh-mobile-msiof" is in use.
>>
>>> +       { .compatible = "renesas,rcar-gen2-msiof", .data = &r8a779x_data },
>>> +       { .compatible = "renesas,rcar-gen3-msiof", .data = &r8a779x_data },
>
> Have you tested this?

I did compiled test only. I have no board.

> The current driver doesn't work well on r8a7795/salvator-x for me
> (e.g. the clock
> signal starts and stops too soon). Hence I think it's a bit premature to make
> this change.
>
> I'll look into the workarounds in the BSP soon...

Thanks a lot!

>
>>>         { .compatible = "renesas,msiof-r8a7790",   .data = &r8a779x_data },
>>>         { .compatible = "renesas,msiof-r8a7791",   .data = &r8a779x_data },
>>>         { .compatible = "renesas,msiof-r8a7792",   .data = &r8a779x_data },
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

Best regards,
kaneko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
