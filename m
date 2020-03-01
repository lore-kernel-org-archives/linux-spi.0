From: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH RFC 1/3] spi: Allow SPI controller override device
 buswidth
Date: Sun, 1 Mar 2020 13:04:07 +0300
Message-ID: <52ecb988-d842-c04b-a0e8-93e8850009c4@cogentembedded.com>
References: <1582903131-160033-1-git-send-email-john.garry@huawei.com>
 <1582903131-160033-2-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1582903131-160033-2-git-send-email-john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello!

On 28.02.2020 18:18, John Garry wrote:

> Currently ACPI firmware description for a SPI device does not have any
> method to describe the data buswidth on the board.
> 
> So even through the controller and device may support higher modes than
           ^^^^^^^
    Though?

> standard SPI, it cannot be assumed that the board does - as such, that
> device is limited to standard SPI in such a circumstance.
> 
> As a workaround, allow the controller driver supply buswidth override bits,
> which are used inform the core code that the controller driver knows the
> buswidth supported on that board for that device.
> 
> A host controller driver might know this info from DMI tables, for example.
> 
> Signed-off-by: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
> ---
>   drivers/spi/spi.c       | 4 +++-
>   include/linux/spi/spi.h | 3 +++
>   2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 38b4c78df506..292f26807b41 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -510,6 +510,7 @@ struct spi_device *spi_alloc_device(struct spi_controller *ctlr)
>   	spi->dev.bus = &spi_bus_type;
>   	spi->dev.release = spidev_release;
>   	spi->cs_gpio = -ENOENT;
> +	spi->mode = ctlr->buswidth_override_bits;
>   
>   	spin_lock_init(&spi->statistics.lock);
>   
> @@ -2181,9 +2182,10 @@ static acpi_status acpi_register_spi_device(struct spi_controller *ctlr,
>   		return AE_NO_MEMORY;
>   	}
>   
> +

    What for?

>   	ACPI_COMPANION_SET(&spi->dev, adev);
>   	spi->max_speed_hz	= lookup.max_speed_hz;
> -	spi->mode		= lookup.mode;
> +	spi->mode		|= lookup.mode;
>   	spi->irq		= lookup.irq;
>   	spi->bits_per_word	= lookup.bits_per_word;
>   	spi->chip_select	= lookup.chip_select;
[...]

MBR, Sergei
