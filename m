From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH RFC] spi: add flow controll support
Date: Mon, 29 Feb 2016 13:14:03 +0100
Message-ID: <CAMuHMdV9J65ab=yWht9i=oSJsCdBriTamFcjHPWLeL5ZyiYqEQ@mail.gmail.com>
References: <1456747459-8559-1-git-send-email-linux@rempel-privat.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "EXTERNAL Rempel Oleksij (Brunel, CM-AI/ECO3)"
	<fixed-term.Oleksij.Rempel-V5te9oGctAVWk0Htik3J/w@public.gmane.org>,
	Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456747459-8559-1-git-send-email-linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Oleksij,

On Mon, Feb 29, 2016 at 1:04 PM, Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org> wrote:
> Different HW implement different variants of SPI based flow control (FC).

Thanks for your patch!

> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c

> +/* spi_fc_probe should be called by spi_device driver. */
> +int spi_fc_probe(struct spi_device *spi)
> +{
> +       struct device_node *np = spi->dev.of_node;
> +       int ret;
> +
> +       if (!np)
> +               return 0;
> +
> +       if (!(spi->mode & SPI_FC_MASK) || spi->mode & SPI_FC_HW_ONLY)
> +               return 0;
> +
> +       spi->fc_gpio = devm_gpiod_get(&spi->dev, "fc", GPIOD_IN);
> +       if (IS_ERR(spi->fc_gpio)) {
> +               ret = PTR_ERR(spi->fc_gpio);
> +               dev_err(&spi->dev, "Failed to request FC GPIO: %d\n", ret);
> +               return ret;
> +       }
> +
> +       init_completion(&spi->fc_complete);
> +       snprintf(spi->fc_irq_name, sizeof(spi->fc_irq_name), "spi-fc-%s",
> +                dev_name(&spi->dev));
> +       ret = devm_request_irq(&spi->dev, gpiod_to_irq(spi->fc_gpio),

gpiod_to_irq() will return -ENXIO if the GPIO doesn't support interrupts.
Granted, devm_request_irq() will fail in that case, but you may want to support
polling.

> +                              spi_fc_rq,
> +                              IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +                              spi->fc_irq_name, spi);

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
