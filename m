From: Mark Bishop <mark-Wri040CV1BU@public.gmane.org>
Subject: Incoming SPI data using spidev (reads only two
	bytes)
Date: Tue, 23 Jun 2009 18:10:18 -0400
Message-ID: <20090623181018.c2hiqtjlwgcw44ok@www.bish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

I am sending 15 bytes on the spi bus and when I go to read the spifd  
using ioctl I am only getting two bytes back.  I am loading up the  
spi_ioc_transfer struct for the receive parameters.

I'll put together an email with some code snippets tomorrow, but was  
wondering if anyone knew of something to look for off the top of their  
heads.

Ironically, when I do a transmit and then a receive it works (using  
SPI_IOC_MESSAGE(2)).  Just a receive fails.



------------------------------------------------------------------------------
