From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/3] drivers: gpio: pcf857x: use subsys_spi_driver()
Date: Tue, 18 Jun 2019 15:48:19 +0200
Message-ID: <CAMuHMdVhW+5YVJWW8q59XKgXGbre0wH6pYDJKCY_2LWV6UEX5w@mail.gmail.com>
References: <1560796840-18207-1-git-send-email-info@metux.net> <1560796840-18207-2-git-send-email-info@metux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560796840-18207-2-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Enrico,

On Mon, Jun 17, 2019 at 8:41 PM Enrico Weigelt, metux IT consult
<info@metux.net> wrote:
> From: Enrico Weigelt <info@metux.net>
>
> Reduce driver init boilerplate by using the new
> subsys_spi_driver() macro.
>
> Signed-off-by: Enrico Weigelt <info@metux.net>

Thanks for your patch!

>  drivers/gpio/gpio-max7301.c | 13 +------------

s/pcf857x/max7301/ in subject.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
