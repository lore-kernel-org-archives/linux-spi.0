From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 1/2] spi: mark device nodes only in case of successful instantiation
Date: Mon, 17 Oct 2016 16:15:24 +0200
Message-ID: <CAMuHMdX=La=7i-2HLAoDUzRBSNs5r=gLroDrJBmUzpJJoP+fFw@mail.gmail.com>
References: <20161017135957.20297-1-ralf@ramses-pyramidenbau.de> <20161017135957.20297-2-ralf@ramses-pyramidenbau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
        Linux SPI <linux-spi@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
To: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161017135957.20297-2-ralf@ramses-pyramidenbau.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Oct 17, 2016 at 3:59 PM, Ralf Ramsauer
<ralf@ramses-pyramidenbau.de> wrote:
> Instantiated SPI device nodes are marked with OF_POPULATE. This was
> introduced in bd6c164. On unloading, loaded device nodes will of course
> be unmarked. The problem are nodes that fail during initialisation: If a
> node fails, it won't be unloaded and hence not be unmarked.
>
> If a SPI driver module is unloaded and reloaded, it will skip nodes that
> failed before.
>
> Skip device nodes that are already populated and mark them only in case
> of success.
>
> Note that the same issue exists for I2C.
>
> Fixes: bd6c164 ("spi: Mark instantiated device nodes with OF_POPULATE")
> Signed-off-by: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
