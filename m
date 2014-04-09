From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH v5 5/8 fix] mtd: m25p80: use the SPI nor framework
Date: Wed, 9 Apr 2014 14:37:49 -0700
Message-ID: <20140409213749.GH32070@ld-irv-0074>
References: <1393238262-8622-6-git-send-email-b32955@freescale.com>
 <1393574142-17234-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dwmw2@infradead.org, angus.clark@st.com, lee.jones@linaro.org,
	pekon@ti.com, sourav.poddar@ti.com, broonie@linaro.org,
	linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	devicetree@vger.kernel.org, shawn.guo@linaro.org,
	Russel King <linux@arm.linux.org.uk>
To: Huang Shijie <b32955@freescale.com>
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1393574142-17234-1-git-send-email-b32955@freescale.com>
Sender: linux-doc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

+ Russell

On Fri, Feb 28, 2014 at 03:55:42PM +0800, Huang Shijie wrote:
> add back the dependency information in the Kconfig. 
> 
> ---
>  drivers/mtd/devices/Kconfig  |    2 +-
>  drivers/mtd/devices/m25p80.c | 1302 ++++--------------------------------------
>  2 files changed, 106 insertions(+), 1198 deletions(-)
> 
> diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
> index 0128138..004b17b 100644
> --- a/drivers/mtd/devices/Kconfig
> +++ b/drivers/mtd/devices/Kconfig
> @@ -80,7 +80,7 @@ config MTD_DATAFLASH_OTP
>  
>  config MTD_M25P80
>  	tristate "Support most SPI Flash chips (AT26DF, M25P, W25X, ...)"
> -	depends on SPI_MASTER
> +	depends on SPI_MASTER && MTD_SPI_NOR_BASE
>  	help
>  	  This enables access to most modern SPI flash chips, used for
>  	  program and data storage.   Series supported include Atmel AT26DF,

Now that M25P80 depends on MTD_SPI_NOR_BASE (which I proposed to rename
to MTD_SPI_NOR a few hours ago), shouldn't we be updating everybody's
defconfigs? As it stands, the defconfigs that use M25P80 will just drop
it silently when built.

And if so, I'm not sure how this should be handled. Should defconfig
patches be sent to their respective arch maintainers?

Also, I think m25p80.c is no longer a "self-contained MTD device driver"
and should be moved under drivers/mtd/spi-nor/.

(Once these questions are settled, did you want to handle cooking the
patches, Huang, or should I?)

Brian
