From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 1/2] spi: sh-msiof: Add rcar fallback compatibility string
Date: Thu, 24 Dec 2015 16:01:00 +0100
Message-ID: <CAMuHMdWxP3LYpng199Y3Ppp9ci0BkaA5RbCStuT40iky81e6Ww@mail.gmail.com>
References: <1450955807-22869-1-git-send-email-ykaneko0929@gmail.com>
	<1450955807-22869-2-git-send-email-ykaneko0929@gmail.com>
	<CAMuHMdXe8Jpz6aTJkLTcNkKpsoV7tDSjUwuaZY7LxfojA9z7cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi <linux-spi@vger.kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Linux-sh list <linux-sh@vger.kernel.org>
To: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdXe8Jpz6aTJkLTcNkKpsoV7tDSjUwuaZY7LxfojA9z7cw@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Kaneko-san,

On Thu, Dec 24, 2015 at 3:58 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>> --- a/drivers/spi/spi-sh-msiof.c
>> +++ b/drivers/spi/spi-sh-msiof.c
>
>> @@ -971,8 +972,8 @@ static const struct sh_msiof_chipdata r8a779x_data = {
>>  };
>>
>>  static const struct of_device_id sh_msiof_match[] = {
>> -       { .compatible = "renesas,sh-msiof",        .data = &sh_data },
>> -       { .compatible = "renesas,sh-mobile-msiof", .data = &sh_data },
>
>  "renesas,sh-mobile-msiof" is in use.
>
>> +       { .compatible = "renesas,rcar-gen2-msiof", .data = &r8a779x_data },
>> +       { .compatible = "renesas,rcar-gen3-msiof", .data = &r8a779x_data },

Have you tested this?
The current driver doesn't work well on r8a7795/salvator-x for me
(e.g. the clock
signal starts and stops too soon). Hence I think it's a bit premature to make
this change.

I'll look into the workarounds in the BSP soon...

>>         { .compatible = "renesas,msiof-r8a7790",   .data = &r8a779x_data },
>>         { .compatible = "renesas,msiof-r8a7791",   .data = &r8a779x_data },
>>         { .compatible = "renesas,msiof-r8a7792",   .data = &r8a779x_data },

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
