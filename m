From: Ivan Kuten <ivan.kuten-NihHnkIkDZhBDgjK7y7TUQ@public.gmane.org>
Subject: Re: problem with converting from at91_spi to
 atmel_spi (AT91RM9200)
Date: Thu, 24 May 2007 18:27:15 +0300
Message-ID: <20070524182715.47ff6cc8@newbox>
References: <20070523143456.15fc49ab@newbox>
	<200705230906.13353.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Ferre <nicolas.ferre-XEyKDsrmbOsS+FvcfC7Uqw@public.gmane.org>,
	Bill Gatliff <bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org>,
	Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Haavard-MRDXTZLjjMs8G+1z+Pypc6QD96bmaF075NbjCUgZEJk@public.gmane.org, andrew-eS41wJS13H5l57MIdRCFDg@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200705230906.13353.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On Wed, 23 May 2007 09:06:12 -0700
David Brownell wrote:
> 
> Chipselect zero ... I've had one report that this driver has some issues
> on that chipselect.  There seem to be two errata in conflict here:
> 
>   - One saying that when the controller manages chipselects, it
>     does so incorrectly ... releasing it before it's told to do so,
>     which prematurely terminates transactions.  ("NPCSx rises if
>     no data is to be transmitted")
> 
>   - Another saying that if it does *not* manage chipselects, then
>     broken mode fault detect logic kicks in; this could be what
>     you're seeing.  ("Mode Fault does not allow more than one
>     master on Chip Select 0")
> 

David, as I understood new atmel_spi driver enables CONFIG_SPI_AT91_MANUAL_CS
which in turn enables workaround for 1st errata item you mentioned

at91rm9200_devices.c
...
in at91_add_device_spi function:

#ifdef CONFIG_SPI_AT91_MANUAL_CS 
                at91_set_gpio_output(cs_pin, 1);
#else 
                at91_set_A_periph(cs_pin, 0);
#endif 

Regarding second errata item - I have a single device (dataflash - 8MB) on SPI chip select 0, 
so I do not think this is an issue here.

Best regards, Ivan


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
