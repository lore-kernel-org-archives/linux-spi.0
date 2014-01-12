From: sourav <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC][PATCH] spi: ti-qspi: Fixup driver name
Date: Sun, 12 Jan 2014 13:56:22 +0530
Message-ID: <52D251AE.6080007@ti.com>
References: <1389510152.13361.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1389510152.13361.4.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Sunday 12 January 2014 12:32 PM, Axel Lin wrote:
> The driver name in current code looks like a compatible string which is not
> the naming convention for platform drivers.
> Fix it and also add modalias since this driver can be built as a module.
>
> Signed-off-by: Axel Lin<axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/spi/spi-ti-qspi.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> index 2a1ab49..3d09265 100644
> --- a/drivers/spi/spi-ti-qspi.c
> +++ b/drivers/spi/spi-ti-qspi.c
> @@ -567,7 +567,7 @@ static struct platform_driver ti_qspi_driver = {
>   	.probe	= ti_qspi_probe,
>   	.remove = ti_qspi_remove,
>   	.driver = {
> -		.name	= "ti,dra7xxx-qspi",
> +		.name	= "ti-qspi",
>   		.owner	= THIS_MODULE,
>   		.pm =&ti_qspi_pm_ops,
>   		.of_match_table = ti_qspi_match,
> @@ -579,3 +579,4 @@ module_platform_driver(ti_qspi_driver);
>   MODULE_AUTHOR("Sourav Poddar<sourav.poddar-l0cyMroinI0@public.gmane.org>");
>   MODULE_LICENSE("GPL v2");
>   MODULE_DESCRIPTION("TI QSPI controller driver");
> +MODULE_ALIAS("platform:ti-qspi");

Acked-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
