From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/4] spi: Use of_property_read_u32
Date: Thu, 26 Sep 2013 11:42:58 +0530
Message-ID: <5243D06A.7050402@ti.com>
References: <CA+7tXigzKW8sydfnktr4F5uY-SKk0JAMjaxFn74XLbw_NTYVXg@mail.gmail.com>
	<20130925235205.22061.2228.stgit@Graphine>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	yuhang wang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130925235205.22061.2228.stgit@Graphine>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thursday 26 September 2013 05:22 AM, Trent Piepho wrote:
> Instead of getting the raw property, checking the length, and doing
> endian conversion each time, use the OF function
> of_property_read_u32() that does all that.
>
> Error messages are slightly improved with error codes from
> of_property_read_u32() for different ways the property may be invalid
> (missing, too short, etc.)
>
> Signed-off-by: Trent Piepho<tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/spi/spi.c |   49 +++++++++++++++++++++++--------------------------
>   1 file changed, 23 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 9e039c6..8fcffe0 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -838,10 +838,9 @@ static void of_register_spi_devices(struct spi_master *master)
>   {
>   	struct spi_device *spi;
>   	struct device_node *nc;
> -	const __be32 *prop;
>   	char modalias[SPI_NAME_SIZE + 4];
>   	int rc;
> -	int len;
> +	u32 value;
>
>   	if (!master->dev.of_node)
>   		return;
> @@ -866,14 +865,14 @@ static void of_register_spi_devices(struct spi_master *master)
>   		}
>
>   		/* Device address */
> -		prop = of_get_property(nc, "reg",&len);
> -		if (!prop || len<  sizeof(*prop)) {
> -			dev_err(&master->dev, "%s has no 'reg' property\n",
> -				nc->full_name);
> +		rc = of_property_read_u32(nc, "reg",&value);
> +		if (rc) {
> +			dev_err(&master->dev, "%s has no valid 'reg' property (%d)\n",
> +				nc->full_name, rc);
>   			spi_dev_put(spi);
>   			continue;
>   		}
> -		spi->chip_select = be32_to_cpup(prop);
> +		spi->chip_select = value;
>
>   		/* Mode (clock phase/polarity/etc.) */
>   		if (of_find_property(nc, "spi-cpha", NULL))
> @@ -886,55 +885,53 @@ static void of_register_spi_devices(struct spi_master *master)
>   			spi->mode |= SPI_3WIRE;
>
>   		/* Device DUAL/QUAD mode */
> -		prop = of_get_property(nc, "spi-tx-bus-width",&len);
> -		if (prop&&  len == sizeof(*prop)) {
> -			switch (be32_to_cpup(prop)) {
> -			case SPI_NBITS_SINGLE:
> +		if (!of_property_read_u32(nc, "spi-tx-bus-width",&value)) {
> +			switch (value) {
> +			case 1:
>   				break;
> -			case SPI_NBITS_DUAL:
> +			case 2:
>   				spi->mode |= SPI_TX_DUAL;
>   				break;
> -			case SPI_NBITS_QUAD:
> +			case 4:
>   				spi->mode |= SPI_TX_QUAD;
>   				break;
>   			default:
>   				dev_err(&master->dev,
>   					"spi-tx-bus-width %d not supported\n",
> -					be32_to_cpup(prop));
> +					value);
>   				spi_dev_put(spi);
>   				continue;
>   			}
>   		}
>
> -		prop = of_get_property(nc, "spi-rx-bus-width",&len);
> -		if (prop&&  len == sizeof(*prop)) {
> -			switch (be32_to_cpup(prop)) {
> -			case SPI_NBITS_SINGLE:
> +		if (!of_property_read_u32(nc, "spi-rx-bus-width",&value)) {
> +			switch (value) {
> +			case 1:
>   				break;
> -			case SPI_NBITS_DUAL:
> +			case 2:
>   				spi->mode |= SPI_RX_DUAL;
>   				break;
> -			case SPI_NBITS_QUAD:
> +			case 4:
>   				spi->mode |= SPI_RX_QUAD;
>   				break;
>   			default:
>   				dev_err(&master->dev,
>   					"spi-rx-bus-width %d not supported\n",
> -					be32_to_cpup(prop));
> +					value);
>   				spi_dev_put(spi);
>   				continue;
>   			}
>   		}
>
>   		/* Device speed */
> -		prop = of_get_property(nc, "spi-max-frequency",&len);
> -		if (!prop || len<  sizeof(*prop)) {
> -			dev_err(&master->dev, "%s has no 'spi-max-frequency' property\n",
> -				nc->full_name);
> +		rc = of_property_read_u32(nc, "spi-max-frequency",&value);
> +		if (rc) {
> +			dev_err(&master->dev, "%s has no valid 'spi-max-frequency' property (%d)\n",
> +				nc->full_name, rc);
>   			spi_dev_put(spi);
>   			continue;
>   		}
> -		spi->max_speed_hz = be32_to_cpup(prop);
> +		spi->max_speed_hz = value;
>
>   		/* IRQ */
>   		spi->irq = irq_of_parse_and_map(nc, 0);
>
Reviewed-by: Sourav Poddar<sourav.poddar-l0cyMroinI0@public.gmane.org>
Tested-by: Sourav Poddar<sourav.poddar-l0cyMroinI0@public.gmane.org>

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
