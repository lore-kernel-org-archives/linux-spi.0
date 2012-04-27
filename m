From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 1/6] spi: rename config macro name for bfin5xx spi
	controller driver
Date: Fri, 27 Apr 2012 12:20:58 -0600
Message-ID: <20120427182059.094BC3E171B@localhost>
References: <1335219493-24184-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1335219493-24184-1-git-send-email-scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, 23 Apr 2012 18:18:08 -0400, Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> This controller is only for blackfin 5xx soc, so rename it to BFIN5XX
> 
> Signed-off-by: Scott Jiang <scott.jiang.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/Kconfig  |    2 +-
>  drivers/spi/Makefile |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 3f9a47e..7a07b02 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -74,7 +74,7 @@ config SPI_ATMEL
>  	  This selects a driver for the Atmel SPI Controller, present on
>  	  many AT32 (AVR32) and AT91 (ARM) chips.
>  
> -config SPI_BFIN
> +config SPI_BFIN5XX
>  	tristate "SPI controller driver for ADI Blackfin5xx"
>  	depends on BLACKFIN
>  	help
> diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
> index 61c3261..e391be8 100644
> --- a/drivers/spi/Makefile
> +++ b/drivers/spi/Makefile
> @@ -14,7 +14,7 @@ obj-$(CONFIG_SPI_ALTERA)		+= spi-altera.o
>  obj-$(CONFIG_SPI_ATMEL)			+= spi-atmel.o
>  obj-$(CONFIG_SPI_ATH79)			+= spi-ath79.o
>  obj-$(CONFIG_SPI_AU1550)		+= spi-au1550.o
> -obj-$(CONFIG_SPI_BFIN)			+= spi-bfin5xx.o
> +obj-$(CONFIG_SPI_BFIN5XX)		+= spi-bfin5xx.o
>  obj-$(CONFIG_SPI_BFIN_SPORT)		+= spi-bfin-sport.o
>  obj-$(CONFIG_SPI_BITBANG)		+= spi-bitbang.o
>  obj-$(CONFIG_SPI_BUTTERFLY)		+= spi-butterfly.o
> -- 
> 1.7.0.4
> 
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
