From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH] mtd: atmel-quadspi: disallow building on ebsa110
Date: Mon, 10 Dec 2018 23:21:02 +0100
Message-ID: <20181210232102.13ab5178@bbrezillon>
References: <20181210203837.2118450-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie@kernel.org>, cyrille.pitchen@microchip.com,
        stable@vger.kernel.org, Piotr Bugalski <bugalski.piotr@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20181210203837.2118450-1-arnd@arndb.de>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Arnd,

Should be prefixed with "spi: atmel-quadspi: " now ;-).

On Mon, 10 Dec 2018 21:38:16 +0100
Arnd Bergmann <arnd@arndb.de> wrote:

> I ran into a link-time error with the atmel-quadspi driver on the
> EBSA110 platform:
> 
> drivers/mtd/built-in.o: In function `atmel_qspi_run_command':
> :(.text+0x1ee3c): undefined reference to `_memcpy_toio'
> :(.text+0x1ee48): undefined reference to `_memcpy_fromio'
> 
> The problem is that _memcpy_toio/_memcpy_fromio are not available on
> that platform, and we have to prevent building the driver there.
> 
> In case we want to backport this to older kernels: between linux-4.8
> and linux-4.20, the Kconfig entry was in drivers/mtd/spi-nor/Kconfig
> but had the same problem.
> 
> Link: https://lore.kernel.org/patchwork/patch/812860/
> Fixes: 161aaab8a067 ("mtd: atmel-quadspi: add driver for Atmel QSPI controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Boris Brezillon <boris.brezillon@bootlin.com>

> ---
>  drivers/spi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 55d5ffb50750..9f89cb134549 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -93,7 +93,7 @@ config SPI_AT91_USART
>  
>  config SPI_ATMEL_QUADSPI
>  	tristate "Atmel Quad SPI Controller"
> -	depends on ARCH_AT91 || (ARM && COMPILE_TEST)
> +	depends on ARCH_AT91 || (ARM && COMPILE_TEST && !ARCH_EBSA110)
>  	depends on OF && HAS_IOMEM
>  	help
>  	  This enables support for the Quad SPI controller in master mode.
