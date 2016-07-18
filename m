From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] spi: sh-msiof: request and set cs-gpio direction to output
Date: Mon, 18 Jul 2016 14:09:03 +0200
Message-ID: <CAMuHMdWb4PngmRa+U=4x1Nq8s+ehWu_ZSTvSzovPs9ngeKhK-A@mail.gmail.com>
References: <1468832259-26476-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>,
	Magnus Damm <magnus.damm@gmail.com>
To: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1468832259-26476-1-git-send-email-ulrich.hecht+renesas@gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Ulrich,

On Mon, Jul 18, 2016 at 10:57 AM, Ulrich Hecht
<ulrich.hecht+renesas@gmail.com> wrote:
> Required for the CS signal to actually be visible to the device.
>
> Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Thanks, I can confirm this indeed makes cs-gpios work with MSIOF on
Koelsch, hence
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> ---
>  drivers/spi/spi-sh-msiof.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
> index a7934ab..d4b5772 100644
> --- a/drivers/spi/spi-sh-msiof.c
> +++ b/drivers/spi/spi-sh-msiof.c
> @@ -536,15 +536,35 @@ static int sh_msiof_spi_setup(struct spi_device *spi)

Is there any specific reason you don't do this in .probe(), like spi-efm32
does?

>                                   !!(spi->mode & SPI_LSB_FIRST),
>                                   !!(spi->mode & SPI_CS_HIGH));
>
> -       if (spi->cs_gpio >= 0)
> -               gpio_set_value(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
> +       if (spi->cs_gpio >= 0 && !spi_get_ctldata(spi)) {
> +               int status = gpio_request(spi->cs_gpio, dev_name(&spi->dev));

devm_gpio_request()...

> +
> +               if (status)
> +                       return status;
>
> +               status = gpio_direction_output(spi->cs_gpio,
> +                                              !(spi->mode & SPI_CS_HIGH));
> +               if (status) {
> +                       gpio_free(spi->cs_gpio);
> +                       return status;
> +               }

... or even better, devm_gpio_request_one(), as it allows configuring direction
and initial level in one go.

> +
> +               spi_set_ctldata(spi, (void *)spi->cs_gpio);
> +       }

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
