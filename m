From: Andrew Victor <andrew-eS41wJS13H5l57MIdRCFDg@public.gmane.org>
Subject: Re: problem with converting from at91_spi
	to	atmel_spi (AT91RM9200)
Date: 25 May 2007 16:41:46 +0200
Message-ID: <1180104106.23793.33.camel@fuzzie.sanpeople.com>
References: <20070523143456.15fc49ab@newbox>
	<200705230906.13353.david-b@pacbell.net>
	<20070524133646.62bbc386@dhcp-255-175.norway.atmel.com>
	<200705240931.43663.david-b@pacbell.net>
	<4655C956.8080300@billgatliff.com> <20070524212409.7ee555d8@newbox>
	<1180076844.23793.6.camel@fuzzie.sanpeople.com>
	<20070525171936.7668283d@newbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Bill Gatliff <bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org>,
	Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-XEyKDsrmbOsS+FvcfC7Uqw@public.gmane.org>
To: Ivan Kuten <ivan.kuten-NihHnkIkDZhBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070525171936.7668283d@newbox>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

hi Ivan,

> In such a case it should have
> 
> static struct spi_board_info dk_spi_devices[] = {
>          {       /* DataFlash chip */
> //                 .modalias       = "mtd_dataflash",
>                  .modalias       = "at91_dataflash",
>                  .chip_select    = 0,
>                  .max_speed_hz   = 15 * 1000 * 1000,
>          },

Makes no difference for the legacy SPI drivers.  If they are used, the
only field in this structure which is checked is "chip_select" so
at91_add_device_spi() can configure the pin  (GPIO vs A_periph).

What is important is what SPI_DEVNAME is set to in at91rm9200_devices.c.

#if defined(CONFIG_AT91_SPI) || defined(CONFIG_AT91_SPI_MODULE)        
/* legacy SPI driver */
#define SPI_DEVNAME     "at91_spi"

#elif defined(CONFIG_SPI_AT91) || defined(CONFIG_SPI_AT91_MODULE)      
/* SPI bitbanging driver */
#define SPI_DEVNAME     "at91_spi"

#elif defined(CONFIG_SPI_ATMEL) || defined(CONFIG_SPI_ATMEL_MODULE)    
/* new SPI driver */
#define SPI_DEVNAME     "atmel_spi"

And that depends on what SPI driver(s) you have enabled in the
configuration.


Changes since 2.6.19.....

at91_dataflash.c:
-       device->flags = MTD_CAP_NORFLASH;
+       device->flags = MTD_WRITEABLE;

at91_spi.c:
  asm/arch/at91rm9200_pdc.h replaced with linux/atmel_pdc.h
  AT91_PDC_* definitions replaced with ATMEL_PDC_*


Regards,
  Andrew Victor



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
