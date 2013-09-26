From: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 4/4] spi: Simplify bit width checking code
Date: Thu, 26 Sep 2013 11:44:55 +0530
Message-ID: <5243D0DF.60703@ti.com>
References: <CA+7tXigzKW8sydfnktr4F5uY-SKk0JAMjaxFn74XLbw_NTYVXg@mail.gmail.com>
	<20130925235230.22061.63402.stgit@Graphine>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	yuhang wang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Trent Piepho <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130925235230.22061.63402.stgit@Graphine>
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
> The code that checks [tr]x_nbits for every transfer is more complex than it
> needs to be.
>
> Checking for SPI_3WIRE isn't needed.  spi_config() already prevents 3WIRE
> mode from being combined with DUAL or QUAD mode support.  So there is no
> need to differentiate between a single bit device with SPI_3WIRE set and one
> with without.  It doesn't change the allowed bit widths.
>
> By using the sensible rule that the width codes should be sequential, it's
> possible to avoid checking for every single valid code individually and
> instead use a single comparison to check for codes greater than the largest
> valid code.
>
> Signed-off-by: Trent Piepho<tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>   drivers/spi/spi.c       |   49 +++++++++++++++++++----------------------------
>   include/linux/spi/spi.h |    2 ++
>   2 files changed, 22 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 0e8e5e8..fd79767 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1447,6 +1447,8 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
>   	 * it is not set for this transfer.
>   	 */
>   	list_for_each_entry(xfer,&message->transfers, transfer_list) {
> +		int max_width;
> +
>   		message->frame_length += xfer->len;
>   		if (!xfer->bits_per_word)
>   			xfer->bits_per_word = spi->bits_per_word;
> @@ -1473,40 +1475,29 @@ static int __spi_async(struct spi_device *spi, struct spi_message *message)
>   		    xfer->speed_hz>  master->max_speed_hz)
>   			return -EINVAL;
>
> -		/* check transfer tx/rx_nbits:
> -		 * 1. keep the value is not out of single, dual and quad
> -		 * 2. keep tx/rx_nbits is contained by mode in spi_device
> -		 * 3. if SPI_3WIRE, tx/rx_nbits should be in single
> +		/* Check transfer's tx/rx_nbits.  Do not allow a width greater
> +		 * than the max the device supports.  As the width codes are
> +		 * assigned sequentially, a non-existent width code will also be
> +		 * greater than the largest allowed value.
>   		 */
>   		if (xfer->tx_buf) {
> -			if (xfer->tx_nbits != SPI_NBITS_SINGLE&&
> -				xfer->tx_nbits != SPI_NBITS_DUAL&&
> -				xfer->tx_nbits != SPI_NBITS_QUAD)
> -				return -EINVAL;
> -			if ((xfer->tx_nbits == SPI_NBITS_DUAL)&&
> -				!(spi->mode&  (SPI_TX_DUAL | SPI_TX_QUAD)))
> -				return -EINVAL;
> -			if ((xfer->tx_nbits == SPI_NBITS_QUAD)&&
> -				!(spi->mode&  SPI_TX_QUAD))
> -				return -EINVAL;
> -			if ((spi->mode&  SPI_3WIRE)&&
> -				(xfer->tx_nbits != SPI_NBITS_SINGLE))
> +			if (spi->mode&  SPI_TX_QUAD)
> +				max_width = SPI_NBITS_QUAD;
> +			else if (spi->mode&  SPI_TX_DUAL)
> +				max_width = SPI_NBITS_DUAL;
> +			else
> +				max_width = SPI_NBITS_SINGLE;
> +			if (xfer->tx_nbits>  max_width)
>   				return -EINVAL;
>   		}
> -		/* check transfer rx_nbits */
>   		if (xfer->rx_buf) {
> -			if (xfer->rx_nbits != SPI_NBITS_SINGLE&&
> -				xfer->rx_nbits != SPI_NBITS_DUAL&&
> -				xfer->rx_nbits != SPI_NBITS_QUAD)
> -				return -EINVAL;
> -			if ((xfer->rx_nbits == SPI_NBITS_DUAL)&&
> -				!(spi->mode&  (SPI_RX_DUAL | SPI_RX_QUAD)))
> -				return -EINVAL;
> -			if ((xfer->rx_nbits == SPI_NBITS_QUAD)&&
> -				!(spi->mode&  SPI_RX_QUAD))
> -				return -EINVAL;
> -			if ((spi->mode&  SPI_3WIRE)&&
> -				(xfer->rx_nbits != SPI_NBITS_SINGLE))
> +			if (spi->mode&  SPI_RX_QUAD)
> +				max_width = SPI_NBITS_QUAD;
> +			else if (spi->mode&  SPI_RX_DUAL)
> +				max_width = SPI_NBITS_DUAL;
> +			else
> +				max_width = SPI_NBITS_SINGLE;
> +			if (xfer->rx_nbits>  max_width)
>   				return -EINVAL;
>   		}
>   	}
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 4dbf40e..ffccfdd 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -549,6 +549,8 @@ struct spi_transfer {
>   	unsigned	cs_change:1;
>   	unsigned	tx_nbits:2;
>   	unsigned	rx_nbits:2;
> +/* These should be assigned sequentially, so that numeric comparisons produce
> + * the correct result, e.g. SPI_NBITS_DUAL<  SPI_NBITS_QUAD.  */
>   #define	SPI_NBITS_SINGLE	0x00 /* 1x wide transfer */
>   #define	SPI_NBITS_DUAL		0x01 /* 2x wide transfer */
>   #define	SPI_NBITS_QUAD		0x02 /* 4x wide transfer */
>
Reviewed-by: Sourav Poddar<sourav.poddar-l0cyMroinI0@public.gmane.org>
Tested-by: Sourav Poddar<sourav.poddar-l0cyMroinI0@public.gmane.org>

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk
