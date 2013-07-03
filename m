From: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
Subject: Re: [PATCH v2 11/11] spi: spi-ep93xx: use master->cur_msg for
	in-flight message
Date: Wed, 3 Jul 2013 21:15:19 +0300
Message-ID: <20130703181519.GG26568@mwesterb-mobl.lan>
References: <201307021011.34369.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org,
	broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mtd <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <201307021011.34369.hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jul 02, 2013 at 10:11:33AM -0700, H Hartley Sweeten wrote:
> Instead of carrying the in-flight message in the driver private
> data, use the cur_msg pointer that is already setup by the core.
> 
> Signed-off-by: H Hartley Sweeten <hsweeten-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
> Cc: Ryan Mallon <rmallon-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Cc: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>
> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/spi/spi-ep93xx.c | 88 ++++++++++++++++++++++++++----------------------
>  1 file changed, 48 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
> index 4c9a50c..e85834d 100644
> --- a/drivers/spi/spi-ep93xx.c
> +++ b/drivers/spi/spi-ep93xx.c
> @@ -76,7 +76,6 @@
>   * @min_rate: minimum clock rate (in Hz) supported by the controller
>   * @max_rate: maximum clock rate (in Hz) supported by the controller
>   * @wait: wait here until given transfer is completed
> - * @current_msg: message that is currently processed (or %NULL if none)
>   * @tx: current byte in transfer to transmit
>   * @rx: current byte in transfer to receive
>   * @fifo_level: how full is FIFO (%0..%SPI_FIFO_SIZE - %1). Receiving one
> @@ -98,7 +97,6 @@ struct ep93xx_spi {
>  	unsigned long			min_rate;
>  	unsigned long			max_rate;
>  	struct completion		wait;
> -	struct spi_message		*current_msg;
>  	size_t				tx;
>  	size_t				rx;
>  	size_t				fifo_level;
> @@ -378,7 +376,7 @@ static void ep93xx_do_read(struct ep93xx_spi *espi, struct spi_transfer *t)
>  
>  /**
>   * ep93xx_spi_read_write() - perform next RX/TX transfer
> - * @espi: ep93xx SPI controller struct
> + * @master: spi_master struct
>   *
>   * This function transfers next bytes (or half-words) to/from RX/TX FIFOs. If
>   * called several times, the whole transfer will be completed. Returns
> @@ -387,9 +385,10 @@ static void ep93xx_do_read(struct ep93xx_spi *espi, struct spi_transfer *t)
>   * When this function is finished, RX FIFO should be empty and TX FIFO should be
>   * full.
>   */
> -static int ep93xx_spi_read_write(struct ep93xx_spi *espi)
> +static int ep93xx_spi_read_write(struct spi_master *master)
>  {
> -	struct spi_message *msg = espi->current_msg;
> +	struct ep93xx_spi *espi = spi_master_get_devdata(master);
> +	struct spi_message *msg = master->cur_msg;

Is there no way to get the master from espi?

This patch changes lots of places to use master just to be able to access
master->cur_msg which looks overkill to me.

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
