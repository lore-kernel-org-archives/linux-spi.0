From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: [PATCH] spi: pxa2xx_spi introduce chip
 select gpio to simplify the common cases
Date: Mon, 08 Sep 2008 21:22:54 -0400
Message-ID: <48C5CFEE.6070601@whoi.edu>
References: <f17812d70809040221y477ec4x5c05460650266be8@mail.gmail.com>
	<f17812d70809040403u4c33e376vd8b3a2c5f034081c@mail.gmail.com>
	<200809081704.43404.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200809081704.43404.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

David Brownell wrote:
> On Thursday 04 September 2008, Eric Miao wrote:
> ============
> From: "Eric Miao" <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Most SPI peripherals use GPIOs as their chip select, introduce .gpio_cs
> for this, to avoid 
> 
> Signed-off-by: Eric Miao <eric.miao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>

[snip]

> +static int setup_cs(struct spi_device *spi, struct chip_data *chip,
> +		    struct pxa2xx_spi_chip *chip_info)

My understanding is that it is legal to call setup without a defined
pointer to a struct pxa2xx_spi_chip in spi_dev->controller_data, if the
chip is happy with the defaults (only works for a single chip bus that
needs no CS, a degenerate case, but still legal).  Thus you should allow
for that by always checking for existence (chip_info not NULL) before use.

> +{
> +	int err = 0;
> +	
> +	if (chip_info == NULL)
> +		return 0;
> +
> +	/* NOTE: setup() can be called multiple times, possibly with
> +	 * different chip_info, previously requested GPIO shall be
> +	 * released, stumped :(
> +	 */

That is why the GPIO allocation function belongs in the controller
driver, and not in the master driver.  The master serves many
controllers, and only the controller drivers know when they are loaded
and unloaded, and thus when they need to allocate and initialize a GPIO
pin and when to release it.  Additionally, on a multi-chip bus (which
may have chips with CS assertion of differing polarity) it may be that
only the board init code can configure all the CS pins to an idle state
to get anything on the bus to work at all.  That is why cs_control
shifts the burden of configuring CS pins outside of the master driver.
I don't think that this function can work as written; perhaps this can
be converted to a non-static helper function to be called by either
board init or controller drivers.

> +	if (gpio_is_valid(chip->gpio_cs))
> +		gpio_free(chip->gpio_cs);
> +
> +	if (chip_info->cs_control) {
> +		chip->cs_control = chip_info->cs_control;
> +		return 0;
> +	}
> +
> +	if (gpio_is_valid(chip_info->gpio_cs)) {
> +		err = gpio_request(chip_info->gpio_cs, "SPI_CS");
> +		if (err) {
> +			dev_err(&spi->dev, "failed to request CS GPIO%d\n",
> +					chip_info->gpio_cs);

I do not agree that this is an error, though David may argue that it is.
 Feel free to reduce this to KERN_INFO and eliminate the following
return.  It is not illegal to omit the chip select on a one-chip bus,
when the chip does not use CS; there is no need to allocate and waste a
pin if it is not connected to anything.

> +			return err;
> +		}
> +
> +		chip->gpio_cs = chip_info->gpio_cs;
> +		chip->gpio_cs_inverted = spi->mode & SPI_CS_HIGH;
> +
> +		gpio_direction_output(chip->gpio_cs, !chip->gpio_cs_inverted);
> +	}
> +
> +	return err;
> +}
> +
>  static int setup(struct spi_device *spi)
>  {
>  	struct pxa2xx_spi_chip *chip_info = NULL;
> @@ -1141,7 +1203,7 @@ static int setup(struct spi_device *spi)
>  			return -ENOMEM;
>  		}
> 
> -		chip->cs_control = null_cs_control;

Based on cs_assert/cs_deassert, above, chip->cs_control needs to be
initialized to 0 here.  It's initialization should not be removed.

> +		chip->gpio_cs = -1;
>  		chip->enable_dma = 0;
>  		chip->timeout = 1000;
>  		chip->threshold = SSCR1_RxTresh(1) | SSCR1_TxTresh(1);
> @@ -1156,9 +1218,6 @@ static int setup(struct spi_device *spi)
>  	/* chip_info isn't always needed */
>  	chip->cr1 = 0;
>  	if (chip_info) {
> -		if (chip_info->cs_control)
> -			chip->cs_control = chip_info->cs_control;
> -

This should not be removed.  This is where legacy drivers establish the
pointer for a cs_control routine.

>  		chip->timeout = chip_info->timeout;
> 
>  		chip->threshold = (SSCR1_RxTresh(chip_info->rx_threshold) &
> @@ -1238,13 +1297,16 @@ static int setup(struct spi_device *spi)
> 
>  	spi_set_ctldata(spi, chip);
> 
> -	return 0;
> +	return setup_cs(spi, chip, chip_info);
>  }
> 
>  static void cleanup(struct spi_device *spi)
>  {
>  	struct chip_data *chip = spi_get_ctldata(spi);
> 
> +	if (gpio_is_valid(chip->gpio_cs))
> +		gpio_free(chip->gpio_cs);

Again, this does not belong in the master driver, IMHO; the resource
should have been allocated outside the master.

> +
>  	kfree(chip);
>  }
> 


-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
