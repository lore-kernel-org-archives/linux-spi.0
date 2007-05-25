From: Jason Mcmullan <jason.mcmullan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: AT91 SPI Slave - Anyone get it to work?
Date: Fri, 25 May 2007 10:06:56 -0400
Message-ID: <1180102016.23577.25.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

I'm working on an AT91SAM9260EK board, and am trying to use the
SPI1 bus in slave mode under Linux.

I have an interrupt handler, and am doing byte-at-time transactions
using SPI_TDR and SPI_RDR (and SPI_TDRE and SPI_RDRF interrupts)

I can receive bytes fine, but my transmitted bytes seem garbled.

My scoped lines looks like clean data and clock, just *wrong* data.

I am running at 100Khz, so it shouldn't be a speed issue.

I'm using 8-bit data buffers.

I've been working on this for about a week, and I'm ready to tear my
hair out in frustration.

Has *anyone* gotten their AT91 SPI to work in slave mode in any fashion?

Thanks.
-- 
Jason Mcmullan <jason.mcmullan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Evil Labs


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
