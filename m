From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: re: spi-gpio: allow operation without CS signal
Date: Wed, 3 Oct 2012 17:42:41 +0300
Message-ID: <20121003144241.GA18056@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: mb-fseUSCV1ubazQB+pC5nmwQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello Michael Buesch,

The patch bfb9bcdbda9a: "spi-gpio: allow operation without CS signal"
from Apr 2, 2009, leads to the following Clang warning:
drivers/spi/spi-gpio.c:229:9: warning: comparison of constant
18446744073709551615 with expression of type 'unsigned int' is always
true [-Wtautological-constant-out-of-range-compare]


#define SPI_GPIO_NO_CHIPSELECT          ((unsigned long)-1l)
                                         ^^^^^^^^^^^^^^^^^^

drivers/spi/spi-gpio.c
   223          unsigned int cs = spi_gpio->cs_gpios[spi->chip_select];
   224  
   225          /* set initial clock polarity */
   226          if (is_active)
   227                  setsck(spi, spi->mode & SPI_CPOL);
   228  
   229          if (cs != SPI_GPIO_NO_CHIPSELECT) {
                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This is always true.  SPI_GPIO_NO_CHIPSELECT is used like this through
out.  The comments say that it's supposed to be used as a void pointer
but that doesn't make a lot of sense either.

   230                  /* SPI is normally active-low */
   231                  gpio_set_value(cs, (spi->mode & SPI_CS_HIGH) ? is_active : !is_active);
   232          }

regards,
dan carpenter


------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
