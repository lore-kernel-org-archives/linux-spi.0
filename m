From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] [drivers] [SPI] SPI_GPIO: add support for controllers with missing MISO pin
Date: Tue, 23 Jun 2009 11:55:15 -0700
Message-ID: <200906231155.15339.david-b@pacbell.net>
References: <E4D3F24EA6C9E54F817833EAE0D912AC0228288531@bssrvexch01.BS.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>,
	"kyungmin.park@samsung.com" <kyungmin.park@samsung.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755897AbZFWSz1@vger.kernel.org>
In-Reply-To: <E4D3F24EA6C9E54F817833EAE0D912AC0228288531@bssrvexch01.BS.local>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tuesday 23 June 2009, Marek Szyprowski wrote:
> There are some boards that do not strictly follow SPI standard and use only 3 wires
> (SCLK, MOSI, SS) for connecting some simple auxiliary chips and controls them with GPIO
> based 'spi controller'. In this configuration the MISO line is missing (it is not
> required if the chip does not transfer any data back to host). The example of such
> board is a NCP ARM S3C64XX based machine. This patch adds support for such non-standard
> configuration in GPIO-based SPI controller.
> 
> Reviewed-by: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>

This is missing one integrity feature:  it should reject all
requests that provide a read buffer, since obviously it can't
satisfy any such requests.

Also, please add a comment in spi_gpio_request() explaining
this point:  that output-only configs exist, and you're
supporting them by letting MISO be invalid.

Address those two points and this will be almost OK.


Thing is, this raises two related issues:  (a) there's the
analagous input-only case where MOSI isn't used, e.g. for
some kinds of sensor; and (b) there's also "real 3-wire SPI"
(spi->mode & SPI_3WIRE) where interactions are limited to
half duplex and one pin switches roles between MOSI and MISO.

Clearly this "output-only" case is a subset of SPI_3WIRE (the
MOMI/SISO pin can't switch direction) so one more change I
want to see is requiring that spi->mode flag be set in all
SPI devices registered when this mode is used.

If you have time, it would be good to generaize this patch
to cover all of those 3-wire modes ... accept all half
duplex calls, use gpio_direction_*() to switch direction.

If not -- e.g. nothing to test that with! -- then I can
understand, but please make your changes with that model
in mind, and leave an appropriate FIXME in place.

- Dave

p.s. I'll CC you on one more related patch.  Briefly,
     there's a new spi_master->flags field that should
     set SPI_MASTER_HALF_DUPLEX.  Arguably, this specific
     case should also advertise something like NO_RX.


> 
> --- 
> 
> diff --git a/drivers/spi/spi_gpio.c b/drivers/spi/spi_gpio.c
> index 26bd03e..16f74fd 100644
> --- a/drivers/spi/spi_gpio.c
> +++ b/drivers/spi/spi_gpio.c
> @@ -114,7 +114,10 @@ static inline void setmosi(const struct spi_device *spi, int is_on)
>  
>  static inline int getmiso(const struct spi_device *spi)
>  {
> -	return !!gpio_get_value(SPI_MISO_GPIO);
> +	if (gpio_is_valid(SPI_MISO_GPIO))
> +		return !!gpio_get_value(SPI_MISO_GPIO);
> +	else
> +		return 0;
>  }
>  
>  #undef pdata
> @@ -243,9 +246,11 @@ spi_gpio_request(struct spi_gpio_platform_data *pdata, const char *label)
>  	if (value)
>  		goto done;
>  
> -	value = spi_gpio_alloc(SPI_MISO_GPIO, label, true);
> -	if (value)
> -		goto free_mosi;
> +	if (gpio_is_valid(SPI_MISO_GPIO)) {
> +		value = spi_gpio_alloc(SPI_MISO_GPIO, label, true);
> +		if (value)
> +			goto free_mosi;
> +	}
>  
>  	value = spi_gpio_alloc(SPI_SCK_GPIO, label, false);
>  	if (value)
> @@ -254,7 +259,8 @@ spi_gpio_request(struct spi_gpio_platform_data *pdata, const char *label)
>  	goto done;
>  
>  free_miso:
> -	gpio_free(SPI_MISO_GPIO);
> +	if (gpio_is_valid(SPI_MISO_GPIO))
> +		gpio_free(SPI_MISO_GPIO);
>  free_mosi:
>  	gpio_free(SPI_MOSI_GPIO);
>  done:
> @@ -308,7 +314,8 @@ static int __init spi_gpio_probe(struct platform_device *pdev)
>  	if (status < 0) {
>  		spi_master_put(spi_gpio->bitbang.master);
>  gpio_free:
> -		gpio_free(SPI_MISO_GPIO);
> +		if (gpio_is_valid(SPI_MISO_GPIO))
> +			gpio_free(SPI_MISO_GPIO);
>  		gpio_free(SPI_MOSI_GPIO);
>  		gpio_free(SPI_SCK_GPIO);
>  		spi_master_put(master);
> @@ -332,7 +339,8 @@ static int __exit spi_gpio_remove(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, NULL);
>  
> -	gpio_free(SPI_MISO_GPIO);
> +	if (gpio_is_valid(SPI_MISO_GPIO))
> +		gpio_free(SPI_MISO_GPIO);
>  	gpio_free(SPI_MOSI_GPIO);
>  	gpio_free(SPI_SCK_GPIO);
> 
> 
> 
