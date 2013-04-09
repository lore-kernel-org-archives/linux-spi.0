From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH] spi-gpio: init CS before spi_bitbang_setup()
Date: Tue, 09 Apr 2013 19:06:32 +0200
Message-ID: <51644A98.1070904@gmail.com>
References: <1365525613-27198-1-git-send-email-josef.ahmad@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Josef Ahmad <josef.ahmad@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1365525613-27198-1-git-send-email-josef.ahmad@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Cc: Mark

On 09.04.2013 18:40, Josef Ahmad wrote:
> spi_bitbang_setup() deasserts the chip select line to initialise
> the device. The chip select GPIO line is obtained from
> spi_gpio->cs_gpios[] private data.
> Currently, devices that are not registered under devicetree
> environment will call into spi_bitbang_setup() with stale
> cs_gpios[].
> 
> This patch ensures spi_gpio->cs_gpios[] is always initialised prior
> to calling spi_bitbang_setup().
> 
> Reviewed-by: Daniel Mack <zonque@gmail.com>
> Signed-off-by: Josef Ahmad <josef.ahmad@intel.com>
> ---
>  drivers/spi/spi-gpio.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
> index c7cf0b7..0fa345c 100644
> --- a/drivers/spi/spi-gpio.c
> +++ b/drivers/spi/spi-gpio.c
> @@ -265,9 +265,9 @@ static int spi_gpio_setup(struct spi_device *spi)
>  		}
>  	}
>  	if (!status) {
> -		status = spi_bitbang_setup(spi);
>  		/* in case it was initialized from static board data */
>  		spi_gpio->cs_gpios[spi->chip_select] = cs;
> +		status = spi_bitbang_setup(spi);
>  	}
>  
>  	if (status) {
> 
