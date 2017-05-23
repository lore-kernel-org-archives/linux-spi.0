From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 2/2] spi: use gpio_desc instead of numeric gpio
Date: Tue, 23 May 2017 21:28:22 +0300
Message-ID: <CAHp75VcHktwnXg26sq6x=EqM6TFAEc6yQrRFZQu1CCpYYfq6wQ@mail.gmail.com>
References: <20170523040322.10433-1-chris.packham@alliedtelesis.co.nz> <20170523040322.10433-2-chris.packham@alliedtelesis.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Chris Packham <chris.packham@alliedtelesis.co.nz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170523040322.10433-2-chris.packham@alliedtelesis.co.nz>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, May 23, 2017 at 7:03 AM, Chris Packham
<chris.packham@alliedtelesis.co.nz> wrote:
> By using a gpio_desc and gpiod_set_value() instead of a numeric gpio and
> gpio_set_value() the gpio flags are taken into account. This is useful
> when using a gpio chip-select to supplement a controllers native
> chip-select.

I think would be better to move everything in SPI core to GPIO descriptors.

>
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>
> Notes:
>     My specific use-case is I have a board that uses the spi-orion driver but
>     only has one CS pin available. In order to access two spi slave devices the
>     board has a 1-of-2 decoder/demultiplexer which is driven via a gpio.
>
>     The problem is that for one of the 2 slave devices the gpio level required
>     is opposite to the chip-select so I can't simply specify "spi-cs-high".
>     With this change I can flag the gpio as active low and the gpio subsystem
>     takes care of the additional inversion required.
>
>  drivers/spi/spi.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 6f87fec409b5..b39c0f9956dd 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -725,7 +725,10 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
>                 enable = !enable;
>
>         if (gpio_is_valid(spi->cs_gpio)) {
> -               gpio_set_value(spi->cs_gpio, !enable);
> +               struct gpio_desc *gpio = gpio_to_desc(spi->cs_gpio);
> +
> +               if (gpio)
> +                       gpiod_set_value(gpio, !enable);
>                 /* Some SPI masters need both GPIO CS & slave_select */
>                 if ((spi->master->flags & SPI_MASTER_GPIO_SS) &&
>                     spi->master->set_cs)
> --
> 2.13.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
With Best Regards,
Andy Shevchenko
