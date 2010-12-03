From: Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH] SPI: S5P64X0: Enable SPI driver for S5P6440 and S5P6450
Date: Fri, 03 Dec 2010 18:59:41 +0900
Message-ID: <015201cb92d0$d03777a0$70a666e0$%kim@samsung.com>
References: <1291338253-16461-1-git-send-email-sbkim73@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: 'Abhilash Kesavan' <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org
To: 'Sangbeom Kim' <sbkim73-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <1291338253-16461-1-git-send-email-sbkim73-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Sangbeom Kim wrote:
> 
> From: Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> 
> This patch enable the existing S3C64XX series SPI driver for S5P64X0
> 
> Signed-off-by: Abhilash Kesavan <a.kesavan-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> Signed-off-by: Sangbeom Kim <sbkim73-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  drivers/spi/Kconfig |    4 ++--

Added following mailing list and maintainers.
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
David Brownell and Grant Likely (SPI Subsystem's maintainer)

>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 78f9fd0..56e6249 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -304,8 +304,8 @@ config SPI_S3C24XX_GPIO
> 
>  config SPI_S3C64XX
>  	tristate "Samsung S3C64XX series type SPI"
> -	depends on ARCH_S3C64XX && EXPERIMENTAL
> -	select S3C64XX_DMA
> +	depends on (ARCH_S3C64XX || ARCH_S5P64X0) && EXPERIMENTAL

Do we really still need CONFIG_EXPERIMENTAL here?

> +	select S3C64XX_DMA if !ARCH_S5P64X0
>  	help
>  	  SPI driver for Samsung S3C64XX and newer SoCs.

SPI driver for Samsung S3C64XX, S5P64X0 and newer Socs.


One more, did you test this on S5P64X0's board with just adding this?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.


------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
