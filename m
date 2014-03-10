From: sourav <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] spi/qspi: Fix return from mmap path
Date: Mon, 10 Mar 2014 15:19:21 +0530
Message-ID: <531D8AA1.305@ti.com>
References: <1394443753-25773-1-git-send-email-sourav.poddar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>, <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	<linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1394443753-25773-1-git-send-email-sourav.poddar-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

+ Mark's kernel.org email
On Monday 10 March 2014 02:59 PM, Sourav Poddar wrote:
> mmap resource requirement is only for memory mapped operations.
> If the user does not populate mmap resource, dont call return,
> instead we go on for normal spi mode operations.
>
> Signed-off-by: Sourav Poddar<sourav.poddar-l0cyMroinI0@public.gmane.org>
> ---
>   drivers/spi/spi-ti-qspi.c |    1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> index 49ddfc7..6c211d1 100644
> --- a/drivers/spi/spi-ti-qspi.c
> +++ b/drivers/spi/spi-ti-qspi.c
> @@ -461,7 +461,6 @@ static int ti_qspi_probe(struct platform_device *pdev)
>   		if (res_mmap == NULL) {
>   			dev_err(&pdev->dev,
>   				"memory mapped resource not required\n");
> -			return -ENODEV;
>   		}
>   	}
>

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
