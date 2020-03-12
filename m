From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] spi: acpi: remove superfluous parameter check
Date: Thu, 12 Mar 2020 15:14:47 +0100
Message-ID: <CAMuHMdWxOa9Fo+oipWOS2DEXsJP6fiCV--0GDmDnd=1PoSg66Q@mail.gmail.com>
References: <20200312134507.10000-1-wsa@the-dreams.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Wolfram Sang <wsa@the-dreams.de>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20200312134507.10000-1-wsa@the-dreams.de>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Mar 12, 2020 at 2:46 PM Wolfram Sang <wsa@the-dreams.de> wrote:
> From: Wolfram Sang <wsa+renesas@sang-engineering.com>
>
> to_spi_device() already checks 'dev'. No need to do it before calling
> it.
>
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
