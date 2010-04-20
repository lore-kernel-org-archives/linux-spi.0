From: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: Re: [PATCH v4 1/2] spi: implemented driver for
 Cirrus EP93xx SPI controller
Date: Tue, 20 Apr 2010 12:24:26 -0500
Message-ID: <0D753D10438DA54287A00B0270842697636D7F4E7F@AUSP01VMBX24.collaborationhost.net>
References: <cover.1271774845.git.mika.westerberg@iki.fi>
	<e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <martinwguy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org" <ryan-7Wk5F4Od5/oYd5yxfr4S2w@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <e96939d18bcbfb7a28ba4a925d7788884566db8c.1271774845.git.mika.westerberg-X3B1VOXEql0@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tuesday, April 20, 2010 8:12 AM, Mika Westerberg wrote:
> This patch adds an SPI master driver for the Cirrus EP93xx SPI controller found
> in EP93xx chips (EP9301, EP9302, EP9307, EP9312 and EP9315).
> 
> Signed-off-by: Mika Westerberg <mika.westerberg-X3B1VOXEql0@public.gmane.org>

Mika,

I'm still looking this over but I have one quick comment.

> +/**
> + * ep93xx_spi_select_device() - select given SPI device
> + * @espi: ep93xx SPI controller struct
> + * @spi: SPI device to select
> + *
> + * Function asserts chipselect line as specified in @spi->chip_select in board
> + * specific manner.
> + *
> + * Note that this function is called from a thread context and can sleep.
> + */
> +static inline void ep93xx_spi_select_device(const struct ep93xx_spi *espi,
> +					    struct spi_device *spi)
> +{
> +	if (espi->cs_control)
> +		espi->cs_control(spi, !!(spi->mode & SPI_CS_HIGH));
> +}
> +
> +/**
> + * ep93xx_spi_deselect_device() - deselects given SPI device
> + * @espi: ep93xx SPI controller struct
> + * @spi: SPI device to deselect
> + *
> + * Function deasserts chipselect line as specified in @spi->chip_select in board
> + * specific manner.
> + *
> + * Note that this function is called from a thread context and can sleep.
> + */
> +static inline void ep93xx_spi_deselect_device(const struct ep93xx_spi *espi,
> +					      struct spi_device *spi)
> +{
> +	if (espi->cs_control)
> +		espi->cs_control(spi, !(spi->mode & SPI_CS_HIGH));
> +}

These two functions can be combined.

/**
 * ep93xx_spi_chip_select() - select/deselect a given SPI device
 * @espi: ep93xx SPI controller struct
 * @spi: SPI device to select
 * @assert: flag to assert the chip select line
 *
 * Note that this function is called from a thread context and can sleep.
 */
static void ep93xx_spi_chip_select(const struct ep93xx_spi *espi,
					     struct spi_device *spi, int assert)
{
	int value = (spi->mode & SPI_CS_HIGH) ? !!assert : !assert;

	if (espi->cs_control)
		espi->cs_control(spi, value);
}

Then just do:

ep93xx_spi_select_device(espi, msg->spi, 1);	/* assert the spi chip select */

ep93xx_spi_select_device(espi, msg->spi, 0);	/* deassert the spi chip select */

Regards,
Hartley
------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
