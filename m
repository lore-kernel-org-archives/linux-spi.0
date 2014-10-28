From: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH spi 1/7] spi-tegra20-slink: remove duplicate check on
 resource
Date: Tue, 28 Oct 2014 10:29:52 +0530
Message-ID: <544F22C8.8040106@gmail.com>
References: <1413885950-24208-1-git-send-email-varkab@cdac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "varkab-If5XQcfNmg0@public.gmane.org" <varkab-If5XQcfNmg0@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1413885950-24208-1-git-send-email-varkab-If5XQcfNmg0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 10/21/2014 03:35 PM, Varka Bhadram wrote:
> Sanity check on resource happening with devm_ioremap_resource().
>
> Signed-off-by: Varka Bhadram <varkab-If5XQcfNmg0@public.gmane.org>
> ---
>   drivers/spi/spi-tegra20-slink.c |    8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
> index a829563..59a85cc 100644
> --- a/drivers/spi/spi-tegra20-slink.c
> +++ b/drivers/spi/spi-tegra20-slink.c
> @@ -1154,18 +1154,14 @@ static int tegra_slink_probe(struct platform_device *pdev)
>   	spin_lock_init(&tspi->lock);
>   
>   	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!r) {
> -		dev_err(&pdev->dev, "No IO memory resource\n");
> -		ret = -ENODEV;
> -		goto exit_free_master;
> -	}
> -	tspi->phys = r->start;
>   	tspi->base = devm_ioremap_resource(&pdev->dev, r);
>   	if (IS_ERR(tspi->base)) {
>   		ret = PTR_ERR(tspi->base);
>   		goto exit_free_master;
>   	}
>   
> +	tspi->phys = r->start;
> +
>   	spi_irq = platform_get_irq(pdev, 0);
>   	tspi->irq = spi_irq;
>   	ret = request_threaded_irq(tspi->irq, tegra_slink_isr,

Ping...

-- 
Regards,
Varka Bhadram.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
