From: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: Remove CONFIG_ prefix from Kconfig select
Date: Thu, 5 Mar 2020 15:53:57 +0000
Message-ID: <e265e7df-fd8c-691f-389a-c0e0e377ed9e@huawei.com>
References: <f8ac6b32a29b9a05b58a7e58ffe8b780642abbf1.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f8ac6b32a29b9a05b58a7e58ffe8b780642abbf1.camel-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 05/03/2020 15:15, Joe Perches wrote:
> commit a2ca53b52e00 ("spi: Add HiSilicon v3xx SPI NOR flash
> controller driver") likely inadvertently used a select statement
> with a CONFIG_ prefix, remove the prefix.
> 
> Signed-off-by: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>

It's a pity checkpatch can't pick this stuff up...

The select is just for enabling the driver of a slave driver, so should 
not cause any build issues when not enabled. thanks

FWIW,
Acked-by: John Garry <john.garry-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>

> ---
>   drivers/spi/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 82177d..2dc7bd 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -292,7 +292,7 @@ config SPI_HISI_SFC_V3XX
>   	tristate "HiSilicon SPI-NOR Flash Controller for Hi16XX chipsets"
>   	depends on (ARM64 && ACPI) || COMPILE_TEST
>   	depends on HAS_IOMEM
> -	select CONFIG_MTD_SPI_NOR
> +	select MTD_SPI_NOR
>   	help
>   	  This enables support for HiSilicon v3xx SPI-NOR flash controller
>   	  found in hi16xx chipsets.
> 
> 
> .
> 
