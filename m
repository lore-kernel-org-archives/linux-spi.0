From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4 5/6] spi: slave: Add SPI slave handler reporting uptime
 at previous message
Date: Thu, 18 May 2017 19:01:59 +0300
Message-ID: <CAHp75VdphCGXYEMrF0eJ4WLe=wg_0o_xH833jJ1xjGynKV3jXA@mail.gmail.com>
References: <1495025272-23930-1-git-send-email-geert+renesas@glider.be> <1495025272-23930-6-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        Jiada Wang <jiada_wang@mentor.com>,
        Matt Porter <mporter@konsulko.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1495025272-23930-6-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, May 17, 2017 at 3:47 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> Add an example SPI slave handler responding with the uptime at the time
> of reception of the last SPI message.
>
> This can be used by an external microcontroller as a dead man's switch.

> +static int spi_slave_time_submit(struct spi_slave_time_priv *priv)
> +{
> +       u32 rem_ns;
> +       int ret;
> +       u64 ts;
> +
> +       ts = local_clock();
> +       rem_ns = do_div(ts, 1000000000) / 1000;

You divide ts by 10^9, which makes it seconds if it was nanoseconds.

But reminder is still in nanoseconds and you divide it by 10^3.

If I didn't miss anything it should be called like

rem_ns -> reminder_ms

> +
> +       priv->buf[0] = cpu_to_be32(ts);
> +       priv->buf[1] = cpu_to_be32(rem_ns);
> +
> +       spi_message_init_with_transfers(&priv->msg, &priv->xfer, 1);
> +
> +       priv->msg.complete = spi_slave_time_complete;
> +       priv->msg.context = priv;
> +
> +       ret = spi_async(priv->spi, &priv->msg);
> +       if (ret)
> +               pr_err("%s: spi_async() failed %d\n", __func__, ret);

Perhaps dev_err() ?

> +
> +       return ret;
> +}

> +static int spi_slave_time_probe(struct spi_device *spi)
> +{
> +       struct spi_slave_time_priv *priv;
> +       int ret;
> +
> +       /*
> +        * bits_per_word cannot be configured in platform data
> +        */
> +       spi->bits_per_word = 8;

Is it worth to define it? If so, can we use device properties for that?

-- 
With Best Regards,
Andy Shevchenko
