From: Ivan Kuten <ivan.kuten-NihHnkIkDZhBDgjK7y7TUQ@public.gmane.org>
Subject: Re: problem with converting from at91_spi to
 atmel_spi (AT91RM9200)
Date: Fri, 25 May 2007 17:19:36 +0300
Message-ID: <20070525171936.7668283d@newbox>
References: <20070523143456.15fc49ab@newbox>
	<200705230906.13353.david-b@pacbell.net>
	<20070524133646.62bbc386@dhcp-255-175.norway.atmel.com>
	<200705240931.43663.david-b@pacbell.net>
	<4655C956.8080300@billgatliff.com> <20070524212409.7ee555d8@newbox>
	<1180076844.23793.6.camel@fuzzie.sanpeople.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Bill Gatliff <bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org>,
	Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Nicolas Ferre <nicolas.ferre-XEyKDsrmbOsS+FvcfC7Uqw@public.gmane.org>
To: Andrew Victor <andrew-eS41wJS13H5l57MIdRCFDg@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1180076844.23793.6.camel-WDSYOcD6Br5jTuWFell1NFaTQe2KTcn/@public.gmane.org>
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

On 25 May 2007 09:07:24 +0200
Andrew Victor wrote:

> hi,
> 
> > static struct spi_board_info dk_spi_devices[] = {
> >         {       /* DataFlash chip */
> >                 .modalias       = "mtd_dataflash",
> >                 .chip_select    = 0,
> >                 .max_speed_hz   = 15 * 1000 * 1000,
> >         },
> > 
> > are broken cause all of them have chip_select = 0 ?
> 
> I doubt it.
> 
> The DK board definitely works.
> All SAN People's RM9200-based products have DataFlash on CS0 - boot from
> CS0, mount root filesystem (cramfs) on CS0, writable JFFS2 partition on
> CS0.
> 
> That's with legacy SPI and at91_dataflash.c. (ie, CS0 under SPI
> control).
> 

In such a case it should have

static struct spi_board_info dk_spi_devices[] = {
         {       /* DataFlash chip */
//                 .modalias       = "mtd_dataflash",
                 .modalias       = "at91_dataflash",
                 .chip_select    = 0,
                 .max_speed_hz   = 15 * 1000 * 1000,
         },

Cause from my understanding "mtd_dataflash" triggers usage of new SPI framework (driver/spi/atmel_spi.c).

What I currently have:
at91_dataflash.c + 2.6.20+maxim + legacy SPI - working
at91_dataflash.c + 2.6.22rc1+maxim + legacy SPI - not working
mtd_dataflash.c + 2.6.20+maxim + atmel_spi.c - not working
mtd_dataflash.c + 2.6.22rc1+maxim + atmel_spi.c - not working

Now I'm trying understand what was changed between 2.6.20+maxim and 2.6.22rc1+maxim

Best regards, Ivan




-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
