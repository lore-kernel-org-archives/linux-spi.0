From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V3] spi: Enable SPI driver for S5P6440 and S5P6450
Date: Fri, 14 Jan 2011 01:02:49 -0700
Message-ID: <20110114080249.GB21832@angua.secretlab.ca>
References: <1294812023-32697-1-git-send-email-kgene.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-samsung-soc@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net, ben-linux@fluff.org,
	dbrownell@users.courceforge.net,
	Abhilash Kesavan <a.kesavan@samsung.com>,
	Sangbeom Kim <sbkim73@samsung.com>,
	Jassi Brar <jassi.brar@samsung.com>
To: Kukjin Kim <kgene.kim@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1294812023-32697-1-git-send-email-kgene.kim@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jan 12, 2011 at 03:00:23PM +0900, Kukjin Kim wrote:
> From: Abhilash Kesavan <a.kesavan@samsung.com>
> 
> This patch enables the existing S3C64XX series SPI driver for S5P64X0
> and removed dependency on EXPERIMENTAL because we don't need it now.
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
> Signed-off-by: Sangbeom Kim <sbkim73@samsung.com>
> Cc: Jassi Brar <jassi.brar@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

Merged, thanks.

g.

> ---
> Changes since v2:
> - Changed dependency of S3C64XX_DMA
> 
> Changes since v1:
> - Removed dependency on EXPERIMENTAL
> 
> (Following is same with previous patch v2)
> 
> Hi David and Grant,
> 
> I missed that send to you when I have got this via Linux Samsung SoC mailing list.
> Hmm...I know, it's 38 merge winodw...so I'm not sure can be handled now.
> 
> Anyway if any problems, please let me know.
> 
> Thanks and Happy New year :)
> 
> Best regards,
> Kgene.
> 
>  drivers/spi/Kconfig |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 1906840..37aec5e 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -310,8 +310,8 @@ config SPI_S3C24XX_GPIO
>  
>  config SPI_S3C64XX
>  	tristate "Samsung S3C64XX series type SPI"
> -	depends on ARCH_S3C64XX && EXPERIMENTAL
> -	select S3C64XX_DMA
> +	depends on (ARCH_S3C64XX || ARCH_S5P64X0)
> +	select S3C64XX_DMA if ARCH_S3C64XX
>  	help
>  	  SPI driver for Samsung S3C64XX and newer SoCs.
>  
> -- 
> 1.6.2.5
> 
