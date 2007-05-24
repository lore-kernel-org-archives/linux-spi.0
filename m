From: Bill Gatliff <bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org>
Subject: Re: problem with converting from at91_spi to
 atmel_spi (AT91RM9200)
Date: Thu, 24 May 2007 13:43:54 -0500
Message-ID: <4655DCEA.2020507@billgatliff.com>
References: <20070523143456.15fc49ab@newbox>	<200705230906.13353.david-b@pacbell.net>	<20070524133646.62bbc386@dhcp-255-175.norway.atmel.com>	<200705240931.43663.david-b@pacbell.net>	<4655C956.8080300@billgatliff.com>
	<20070524212409.7ee555d8@newbox>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Nicolas Ferre <nicolas.ferre-XEyKDsrmbOsS+FvcfC7Uqw@public.gmane.org>,
	Haavard Skinnemoen <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, andrew-eS41wJS13H5l57MIdRCFDg@public.gmane.org
To: Ivan Kuten <ivan.kuten-NihHnkIkDZhBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070524212409.7ee555d8@newbox>
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

Ivan:

Ivan Kuten wrote:
> So I assume AT91RM9200 boards such as: 
>
> static struct spi_board_info ek_spi_devices[] = {
>         {       /* DataFlash chip */
>                 .modalias       = "mtd_dataflash",
>                 .chip_select    = 0,
>                 .max_speed_hz   = 15 * 1000 * 1000,
>         },
>
> static struct spi_board_info carmeva_spi_devices[] = {
>         { /* DataFlash chip */
>                 .modalias = "mtd_dataflash",
>                 .chip_select  = 0,
>                 .max_speed_hz = 10 * 1000 * 1000,
>         },
>
> static struct spi_board_info dk_spi_devices[] = {
>         {       /* DataFlash chip */
>                 .modalias       = "mtd_dataflash",
>                 .chip_select    = 0,
>                 .max_speed_hz   = 15 * 1000 * 1000,
>         },
>
> are broken cause all of them have chip_select = 0 ?
>   

Dunno.  The problem might be confined to a particular stepping of the 
chip.  It could also be that I'm wrong.  :)


b.g.

-- 
Bill Gatliff
bgat-uPd5UNENI//N9NzbbXoYwQ@public.gmane.org


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
