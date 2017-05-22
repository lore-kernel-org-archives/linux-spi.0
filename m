From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v4 5/6] spi: slave: Add SPI slave handler reporting uptime
 at previous message
Date: Mon, 22 May 2017 12:13:29 +0200
Message-ID: <CAMuHMdV6nNNA8_GsjYNTni0-V+2rujSdbyJ89pf136rD7toqhQ@mail.gmail.com>
References: <1495025272-23930-1-git-send-email-geert+renesas@glider.be>
 <1495025272-23930-6-git-send-email-geert+renesas@glider.be> <CAHp75VdphCGXYEMrF0eJ4WLe=wg_0o_xH833jJ1xjGynKV3jXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
        Matt Porter <mporter-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Linux-Renesas <linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAHp75VdphCGXYEMrF0eJ4WLe=wg_0o_xH833jJ1xjGynKV3jXA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Andy,

On Thu, May 18, 2017 at 6:01 PM, Andy Shevchenko
<andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> On Wed, May 17, 2017 at 3:47 PM, Geert Uytterhoeven
> <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org> wrote:
>> Add an example SPI slave handler responding with the uptime at the time
>> of reception of the last SPI message.
>>
>> This can be used by an external microcontroller as a dead man's switch.
>
>> +static int spi_slave_time_submit(struct spi_slave_time_priv *priv)
>> +{
>> +       u32 rem_ns;
>> +       int ret;
>> +       u64 ts;
>> +
>> +       ts = local_clock();
>> +       rem_ns = do_div(ts, 1000000000) / 1000;
>
> You divide ts by 10^9, which makes it seconds if it was nanoseconds.
>
> But reminder is still in nanoseconds and you divide it by 10^3.

> If I didn't miss anything it should be called like
>
> rem_ns -> reminder_ms

Thanks, that must be a remainder from before I reworked the calculation.

Will change it to rem_us (it's in microseconds, not milliseconds).

>> +       priv->buf[0] = cpu_to_be32(ts);
>> +       priv->buf[1] = cpu_to_be32(rem_ns);
>> +
>> +       spi_message_init_with_transfers(&priv->msg, &priv->xfer, 1);
>> +
>> +       priv->msg.complete = spi_slave_time_complete;
>> +       priv->msg.context = priv;
>> +
>> +       ret = spi_async(priv->spi, &priv->msg);
>> +       if (ret)
>> +               pr_err("%s: spi_async() failed %d\n", __func__, ret);
>
> Perhaps dev_err() ?

OK, and after that the __func__ is no longer needed.

>> +static int spi_slave_time_probe(struct spi_device *spi)
>> +{
>> +       struct spi_slave_time_priv *priv;
>> +       int ret;
>> +
>> +       /*
>> +        * bits_per_word cannot be configured in platform data
>> +        */
>> +       spi->bits_per_word = 8;
>
> Is it worth to define it? If so, can we use device properties for that?

No, it can be removed, as 8 is the default.

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
