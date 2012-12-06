From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] ARM: Kirkwood: Add SPI_CHPA and SPI_CPOL support to
	spi-orion
Date: Thu, 06 Dec 2012 14:25:21 +0000
Message-ID: <20121206142521.4185A3E0948@localhost>
References: <20121121192335.GA14868@obsidianresearch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
To: Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20121121192335.GA14868-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, 21 Nov 2012 12:23:35 -0700, Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org> wrote:
> Support these transfer modes from the SPI layer by setting
> the appropriate register bits before doing the transfer.
> 
> This was tested on the Marvell kirkwood SOC that uses this driver.

Woo! a note about how it was tested. I can't (and often don't) see
enough of these.  :-)

Applied, thanks.

g.

> 
> Reviewed-by: Jason Gunthorpe <jgunthorpe-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>
> Signed-off-by: Rolf Manderscheid <rvm-ePGOBjL8dl3ta4EC/59zMFaTQe2KTcn/@public.gmane.org>
> ---
>  drivers/spi/spi-orion.c |   25 ++++++++++++++++++++++++-
>  1 files changed, 24 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
> index b17c09c..011186d 100644
> --- a/drivers/spi/spi-orion.c
> +++ b/drivers/spi/spi-orion.c
> @@ -32,8 +32,12 @@
>  #define ORION_SPI_DATA_IN_REG		0x0c
>  #define ORION_SPI_INT_CAUSE_REG		0x10
>  
> +#define ORION_SPI_MODE_CPOL		(1 << 11)
> +#define ORION_SPI_MODE_CPHA		(1 << 12)
>  #define ORION_SPI_IF_8_16_BIT_MODE	(1 << 5)
>  #define ORION_SPI_CLK_PRESCALE_MASK	0x1F
> +#define ORION_SPI_MODE_MASK		(ORION_SPI_MODE_CPOL | \
> +					 ORION_SPI_MODE_CPHA)
>  
>  struct orion_spi {
>  	struct spi_master	*master;
> @@ -123,6 +127,23 @@ static int orion_spi_baudrate_set(struct spi_device *spi, unsigned int speed)
>  	return 0;
>  }
>  
> +static void
> +orion_spi_mode_set(struct spi_device *spi)
> +{
> +	u32 reg;
> +	struct orion_spi *orion_spi;
> +
> +	orion_spi = spi_master_get_devdata(spi->master);
> +
> +	reg = readl(spi_reg(orion_spi, ORION_SPI_IF_CONFIG_REG));
> +	reg &= ~ORION_SPI_MODE_MASK;
> +	if (spi->mode & SPI_CPOL)
> +		reg |= ORION_SPI_MODE_CPOL;
> +	if (spi->mode & SPI_CPHA)
> +		reg |= ORION_SPI_MODE_CPHA;
> +	writel(reg, spi_reg(orion_spi, ORION_SPI_IF_CONFIG_REG));
> +}
> +
>  /*
>   * called only when no transfer is active on the bus
>   */
> @@ -142,6 +163,8 @@ orion_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
>  	if ((t != NULL) && t->bits_per_word)
>  		bits_per_word = t->bits_per_word;
>  
> +	orion_spi_mode_set(spi);
> +
>  	rc = orion_spi_baudrate_set(spi, speed);
>  	if (rc)
>  		return rc;
> @@ -399,7 +422,7 @@ static int __init orion_spi_probe(struct platform_device *pdev)
>  	}
>  
>  	/* we support only mode 0, and no options */
> -	master->mode_bits = 0;
> +	master->mode_bits = SPI_CPHA | SPI_CPOL;
>  
>  	master->setup = orion_spi_setup;
>  	master->transfer_one_message = orion_spi_transfer_one_message;
> -- 
> 1.7.5.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
