From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH/RFC v2 3/7] spi: core: Add support for registering SPI
 slave controllers
Date: Sun, 18 Sep 2016 11:04:18 +0200
Message-ID: <CAMuHMdWhuqSg+qUnDUqad-SBJOY5rOuRGuG7oUfTXiQA_rUtoA@mail.gmail.com>
References: <1473713446-30366-1-git-send-email-geert+renesas@glider.be> <1473713446-30366-4-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fengguang Wu <fengguang.wu@intel.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1473713446-30366-4-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Sep 12, 2016 at 10:50 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1477,15 +1477,6 @@ static int of_spi_parse_dt(struct spi_master *master, struct spi_device *spi,

> @@ -1799,7 +1908,6 @@ struct spi_master *spi_alloc_master(struct device *dev, unsigned size)
>         device_initialize(&master->dev);
>         master->bus_num = -1;
>         master->num_chipselect = 1;
> -       master->dev.class = &spi_master_class;
>         master->dev.parent = dev;
>         pm_suspend_ignore_children(&master->dev, true);
>         spi_master_set_devdata(master, &master[1]);
> @@ -1882,9 +1990,18 @@ int spi_register_master(struct spi_master *master)
>         if (!dev)
>                 return -ENODEV;
>
> -       status = of_spi_register_master(master);
> -       if (status)
> -               return status;
> +       if (master->flags & SPI_CONTROLLER_IS_SLAVE) {
> +               if (!IS_ENABLED(CONFIG_SPI_SLAVE))
> +                       return -ENOSYS;
> +
> +               master->dev.class = &spi_slave_class;
> +       } else {
> +               master->dev.class = &spi_master_class;
> +
> +               status = of_spi_register_master(master);
> +               if (status)
> +                       return status;
> +       }
>
>         /* even if it's just one always-selected device, there must
>          * be at least one chipselect

0day reported a warning during boot:

    WARNING: CPU: 0 PID: 1 at drivers/base/core.c:251 device_release+0x7d/0x8a
    Device '(null)' does not have a release() function, it is broken
and must be fixed.

This is caused by moving the setup of master->dev.class.
To fix this, I can
  1) Introduce a separate spi_alloc_slave() function, which sets up
     spi_slave_class instead of spi_master class,
  OR
  2) Keep the setup of spi_master_class in spi_alloc_master(), and override it
     later. Both classes use the same dev_release method anyway.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
