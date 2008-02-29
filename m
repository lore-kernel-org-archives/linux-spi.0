From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: SPI Framework chip select
Date: Fri, 29 Feb 2008 13:52:01 -0500
Message-ID: <47C85451.1030809@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Can someone explain to me how the SPI Framework chip select is
supposed to work?

My pxa2xx_spi device does not use a chip_select at all, hence I have
no cs_control routine defined in struct pxa2xx_spi_chip.cs_control.  I
have never understood how chip select is supposed to work in the SPI
framework, other than explicit code in the controller driver calling a
user defined function, as in pxa2xx_spi.c.  I gather there is a
mechanism involving the struct spi_board_info.chip_select which
selects an index for a chip select at a higher level of the SPI
framework.  I don't know where the connection is between this and a
physical GPIO line connected to an external chip.

Also, in connection with the Framework chip select mechanism, I have
never understood, even if a correspondence is made between a
spi_board_info.chip_select index and a physical IO line, how that CS
is supposed to know when to change state.  It is clear in pxa2xx_spi.c
that when a user supplied cs_control function is called, the
appropriate action defined in the function will take place.  However,
the null_cs_control routine in pxa2xx_spi.c, which is called if the
user does not specify a routine in struct pxa2xx_spi_chip.cs_control,
simply returns without calling any function defined in the SPI
framework.

Dave, can you shed light for me?

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
