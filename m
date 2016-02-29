From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH RFC] spi: add flow controll support
Date: Mon, 29 Feb 2016 14:46:44 +0100
Message-ID: <CAMuHMdUYAOqA_dYsQmA18jrijGC3ShGEaT9MJoC9r_buqv_-Ew@mail.gmail.com>
References: <1456747459-8559-1-git-send-email-linux@rempel-privat.de>
	<CAMuHMdV9J65ab=yWht9i=oSJsCdBriTamFcjHPWLeL5ZyiYqEQ@mail.gmail.com>
	<56D448E1.6090006@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>,
	Dirk Behme <dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: "fixed-term.Oleksij.Rempel" <fixed-term.Oleksij.Rempel-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <56D448E1.6090006-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Oleksij,

On Mon, Feb 29, 2016 at 2:34 PM, fixed-term.Oleksij.Rempel
<fixed-term.Oleksij.Rempel-V5te9oGctAVWk0Htik3J/w@public.gmane.org> wrote:
> On 29.02.2016 13:14, Geert Uytterhoeven wrote:
>> On Mon, Feb 29, 2016 at 1:04 PM, Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org> wrote:
>>> --- a/drivers/spi/spi.c
>>> +++ b/drivers/spi/spi.c
>>
>>> +/* spi_fc_probe should be called by spi_device driver. */
>>> +int spi_fc_probe(struct spi_device *spi)
>>> +{
>>> +       struct device_node *np = spi->dev.of_node;
>>> +       int ret;
>>> +
>>> +       if (!np)
>>> +               return 0;
>>> +
>>> +       if (!(spi->mode & SPI_FC_MASK) || spi->mode & SPI_FC_HW_ONLY)
>>> +               return 0;
>>> +
>>> +       spi->fc_gpio = devm_gpiod_get(&spi->dev, "fc", GPIOD_IN);
>>> +       if (IS_ERR(spi->fc_gpio)) {
>>> +               ret = PTR_ERR(spi->fc_gpio);
>>> +               dev_err(&spi->dev, "Failed to request FC GPIO: %d\n", ret);
>>> +               return ret;
>>> +       }
>>> +
>>> +       init_completion(&spi->fc_complete);
>>> +       snprintf(spi->fc_irq_name, sizeof(spi->fc_irq_name), "spi-fc-%s",
>>> +                dev_name(&spi->dev));
>>> +       ret = devm_request_irq(&spi->dev, gpiod_to_irq(spi->fc_gpio),
>>
>> gpiod_to_irq() will return -ENXIO if the GPIO doesn't support interrupts.
>> Granted, devm_request_irq() will fail in that case, but you may want to support
>> polling.
>
> Do you mean IRQF_IRQPOLL or row gpio polling?

I don't mean IRQF_IRQPOLL.
I don't know what you mean by "row gpio polling".

I mean a GPIO without interrupt capability, where you have to read the GPIO
state from time to time to detect changes.

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
