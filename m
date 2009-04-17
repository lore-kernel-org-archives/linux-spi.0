From: jassi brar <jassi_singh_brar-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: num_chipselect and number of Slaves
Date: Thu, 16 Apr 2009 22:38:28 -0700 (PDT)
Message-ID: <871778.82625.qm@web33201.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org


Hello,

  Nothing serious, just a minor point to bring to your notice.

I came across a minor but confusing discrepancy in the documentation of SPI-API 
while writing a SPI controller driver.

include/linux/spi/spi.h defines num_chipselect as:-
@num_chipselect: chipselects are used to distinguish individual
SPI slaves, and are numbered from __zero-to-num_chipselects__.

Whereas drivers/spi/spi.c take them from [0, num_chipselect-1]


Perhaps thats why a couple of drivers fell for it.

drivers/spi/atmel_spi.c writes:-
   "if (spi->chip_select > spi->master->num_chipselect)"
instead of 
   if (spi->chip_select >= spi->master->num_chipselect)

drivers/spi/spi_bfin5xx.c writes:-
    "(chip->chip_select_num <= spi->master->num_chipselect)"
instead of 
    (chip->chip_select_num < spi->master->num_chipselect)


Those concerned might like to make appropriate changes in the logic and documentation.

It's embarrassing to release a patch for such a trivial thing, or shud i? :)

Regards,
Jassi



      

------------------------------------------------------------------------------
Stay on top of everything new and different, both inside and 
around Java (TM) technology - register by April 22, and save
$200 on the JavaOne (SM) conference, June 2-5, 2009, San Francisco.
300 plus technical and hands-on sessions. Register today. 
Use priority code J9JMT32. http://p.sf.net/sfu/p
