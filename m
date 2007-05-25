From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: problem with converting from at91_spi to
	atmel_spi (AT91RM9200)
Date: Fri, 25 May 2007 09:51:01 -0700
Message-ID: <200705250951.06614.david-b@pacbell.net>
References: <20070523143456.15fc49ab@newbox>
	<1180076844.23793.6.camel@fuzzie.sanpeople.com>
	<20070525171936.7668283d@newbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andrew Victor <andrew-eS41wJS13H5l57MIdRCFDg@public.gmane.org>,
	Bill Gatliff <bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org>,
	Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-XEyKDsrmbOsS+FvcfC7Uqw@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070525171936.7668283d@newbox>
Content-Disposition: inline
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

On Friday 25 May 2007, Ivan Kuten wrote:
> On 25 May 2007 09:07:24 +0200
> Andrew Victor wrote:
> 
> > hi,
> > 
> > > static struct spi_board_info dk_spi_devices[] = {
> > >         ...
> > > 
> > > are broken cause all of them have chip_select = 0 ?
> > 
> > I doubt it.
> > 
> > The DK board definitely works.
> > All SAN People's RM9200-based products have DataFlash on CS0 - boot from
> > CS0, mount root filesystem (cramfs) on CS0, writable JFFS2 partition on
> > CS0.
> > 
> > That's with legacy SPI and at91_dataflash.c. (ie, CS0 under SPI
> > control).

It'd be good if someone with some rm9200 board that can boot
from DataFlash tried a version of the atmel_spi config that
leaves CS0 under control of the SPI controller ... updating
the setup code would suffice, ISTR.

Because we know that both atmel_spi and mtd_datflash behave on
other hardware, even for CS0.  And ISTR hearing they work OK
on rm9200, for other chipselects...

- Dave

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
