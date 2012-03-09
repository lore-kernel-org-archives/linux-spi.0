From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: controller drivers don't need to depend on
	SPI_MASTER explicitly
Date: Fri, 09 Mar 2012 14:39:29 -0700
Message-ID: <20120309213929.70FAD3E0880@localhost>
References: <1329989875-11756-1-git-send-email-u.kleine-koenig@pengutronix.de>
Content-Type: multipart/mixed; boundary="===============5714791233101440447=="
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1329989875-11756-1-git-send-email-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--===============5714791233101440447==

On Thu, 23 Feb 2012 10:37:55 +0100, Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org> wrote:
> They are all defined in an if SPI_MASTER ... endif block.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>

Applied, thanks

g.

> ---
>  drivers/spi/Kconfig |   11 +++++------
>  1 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 8293658..c1fb568 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -126,7 +126,7 @@ config SPI_COLDFIRE_QSPI
>  
>  config SPI_DAVINCI
>  	tristate "Texas Instruments DaVinci/DA8x/OMAP-L/AM1x SoC SPI controller"
> -	depends on SPI_MASTER && ARCH_DAVINCI
> +	depends on ARCH_DAVINCI
>  	select SPI_BITBANG
>  	help
>  	  SPI master controller for DaVinci/DA8x/OMAP-L/AM1x SPI modules.
> @@ -188,7 +188,7 @@ config SPI_MPC52xx_PSC
>  
>  config SPI_MPC512x_PSC
>  	tristate "Freescale MPC512x PSC SPI controller"
> -	depends on SPI_MASTER && PPC_MPC512x
> +	depends on PPC_MPC512x
>  	help
>  	  This enables using the Freescale MPC5121 Programmable Serial
>  	  Controller in SPI master mode.
> @@ -238,7 +238,7 @@ config SPI_OMAP24XX
>  
>  config SPI_OMAP_100K
>  	tristate "OMAP SPI 100K"
> -	depends on SPI_MASTER && (ARCH_OMAP850 || ARCH_OMAP730)
> +	depends on ARCH_OMAP850 || ARCH_OMAP730
>  	help
>  	  OMAP SPI 100K master controller for omap7xx boards.
>  
> @@ -262,7 +262,7 @@ config SPI_PL022
>  
>  config SPI_PPC4xx
>  	tristate "PPC4xx SPI Controller"
> -	depends on PPC32 && 4xx && SPI_MASTER
> +	depends on PPC32 && 4xx
>  	select SPI_BITBANG
>  	help
>  	  This selects a driver for the PPC4xx SPI Controller.
> @@ -326,7 +326,7 @@ config SPI_SH_SCI
>  
>  config SPI_STMP3XXX
>  	tristate "Freescale STMP37xx/378x SPI/SSP controller"
> -	depends on ARCH_STMP3XXX && SPI_MASTER
> +	depends on ARCH_STMP3XXX
>  	help
>  	  SPI driver for Freescale STMP37xx/378x SoC SSP interface
>  
> @@ -384,7 +384,6 @@ config SPI_NUC900
>  
>  config SPI_DESIGNWARE
>  	tristate "DesignWare SPI controller core support"
> -	depends on SPI_MASTER
>  	help
>  	  general driver for SPI controller core from DesignWare
>  
> -- 
> 1.7.9
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.


--===============5714791233101440447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
--===============5714791233101440447==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============5714791233101440447==--
