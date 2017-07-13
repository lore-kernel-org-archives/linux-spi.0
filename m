From: Oleksij Rempel <ore-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v1] spi: loopback-test: provide loop request option.
Date: Thu, 13 Jul 2017 06:55:12 +0200
Message-ID: <e92fb0c9-cd6e-7cc8-fb7d-141cb8f2c0e7@pengutronix.de>
References: <20170712134020.17927-1-o.rempel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
To: Oleksij Rempel <o.rempel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170712134020.17927-1-o.rempel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



On 12.07.2017 15:40, Oleksij Rempel wrote:
> From: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
>
> Provide a module parameter to request internal
> loop by the SPI master controller.
> This should make loop testing easier without extra HW modification.
>
> Signed-off-by: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>
> ---
>  drivers/spi/spi-loopback-test.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/spi/spi-loopback-test.c b/drivers/spi/spi-loopback-test.c
> index f4875f177df0..34e1544d7d0e 100644
> --- a/drivers/spi/spi-loopback-test.c
> +++ b/drivers/spi/spi-loopback-test.c
> @@ -51,6 +51,14 @@ MODULE_PARM_DESC(loopback,
>  		 "is checked to match tx_buf after the spi_message "	\
>  		 "is executed");
>
> +/* the device is jumpered for loopback - enabling some rx_buf tests */
> +int loop_req;
> +module_param(loop_req, int, 0);
> +MODULE_PARM_DESC(loop_req,
> +		 "if set enable controller will be asked to enable "	\

i need to correct this ^^^.

And wait if there any other comments :)

> +		 "test loop mode. If supported, MISO and MOSI will be "  \
> +		 "jumpered by SPI controller");
> +
>  /* run only a specific test */
>  int run_only_test = -1;
>  module_param(run_only_test, int, 0);
> @@ -313,6 +321,16 @@ static int spi_loopback_test_probe(struct spi_device *spi)
>  {
>  	int ret;
>
> +	if (loop_req) {
> +		spi->mode = SPI_LOOP | spi->mode;
> +		ret = spi_setup(spi);
> +		if (ret) {
> +			dev_err(&spi->dev, "SPI setup wasn't successful %d\n", ret);
> +			dev_err(&spi->dev, "SPI_LOOP is not supported by SPI master.");
> +			return -ENODEV;
> +		}
> +	}
> +
>  	dev_info(&spi->dev, "Executing spi-loopback-tests\n");
>
>  	ret = spi_test_run_tests(spi, spi_tests);
>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
