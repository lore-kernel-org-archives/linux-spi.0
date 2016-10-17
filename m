From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/2] i2c: mark device nodes only in case of successful instantiation
Date: Mon, 17 Oct 2016 16:16:45 +0200
Message-ID: <CAMuHMdXsGXV-udnNXmrUet6rDgiW5dYYam5vXg7450POALXkVQ@mail.gmail.com>
References: <20161017135957.20297-1-ralf@ramses-pyramidenbau.de> <20161017135957.20297-3-ralf@ramses-pyramidenbau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>,
        Linux SPI <linux-spi@vger.kernel.org>,
        Linux I2C <linux-i2c@vger.kernel.org>,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>,
        Pantelis Antoniou <pantelis.antoniou@konsulko.com>
To: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20161017135957.20297-3-ralf@ramses-pyramidenbau.de>
Sender: linux-i2c-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Oct 17, 2016 at 3:59 PM, Ralf Ramsauer
<ralf@ramses-pyramidenbau.de> wrote:
> Instantiated I2C device nodes are marked with OF_POPULATE. This was
> introduced in 4f001fd. On unloading, loaded device nodes will of course
> be unmarked. The problem are nodes that fail during initialisation: If a
> node fails, it won't be unloaded and hence not be unmarked.
>
> If a I2C driver module is unloaded and reloaded, it will skip nodes that
> failed before.
>
> Skip device nodes that are already populated and mark them only in case
> of success.
>
> Note that the same issue exists for SPI.
>
> Fixes: 4f001fd ("i2c: Mark instantiated device nodes with OF_POPULATE")
> Signed-off-by: Ralf Ramsauer <ralf@ramses-pyramidenbau.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/i2c/i2c-core.c
> +++ b/drivers/i2c/i2c-core.c

> @@ -1695,7 +1696,14 @@ static void of_i2c_register_devices(struct i2c_adapter *adap)
>         for_each_available_child_of_node(bus, node) {
>                 if (of_node_test_and_set_flag(node, OF_POPULATED))
>                         continue;
> -               of_i2c_register_device(adap, node);
> +
> +               client = of_i2c_register_device(adap, node);
> +               if (IS_ERR(client)) {
> +                       dev_warn(&adap->dev,
> +                                "Failed to create I2C device for %s\n",
> +                                node->full_name);

I don't think there's a need to add this warning, as of_i2c_register_device()
already prints messages in all failure paths.

> +                       of_node_clear_flag(node, OF_POPULATED);
> +               }
>         }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
