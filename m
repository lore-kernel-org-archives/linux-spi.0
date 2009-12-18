From: James Getzendanner <James.Getzendanner-9geRo0GdX4k6efY3Smnssodd74u8MsAO@public.gmane.org>
Subject: [PATCH] Clear control bits in
	drivers/spi/spi_bfin5xx.c as necessary
Date: Fri, 18 Dec 2009 02:29:53 -0500
Message-ID: <DA80C3E6C10BE94E8FCACEB239C2FEE46645317E77@EXVS01.olin.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: "uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org"
	<uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Andy Getzendanner <james.getzendanner-9geRo0GdX4k6efY3Smnssodd74u8MsAO@public.gmane.org>

This patch corrects the behavior of bfin_spi_setup() to clear bits LSBF,
CPHA, and CPOL in the SPI control register when required by the desired
SPI configuration.  The patch also modifies bfin_spi_setup() to
set/clear the SIZE bit as appropriate.
Signed-off-by: Andy Getzendanner <james.getzendanner-9geRo0GdX4k6efY3Smnssodd74u8MsAO@public.gmane.org>
---
The control bits LSBF, CPHA, and CPOL are set by bfin_spi_setup() when
appropriate, but the function appears to assume they are clear at entry
and leaves them untouched when the desired configuration calls for them
to be clear.  The SIZE bit is never set or cleared.
bfin_spi_setup() is triggered in response to an ioctl which calls for
the SPI configuration to be changed, but the settings controlled by
LSBF, CPHA, and CPOL cannot be changed away from the setting implied by
the value 1.  Additionally, the word length setting (controlled by SIZE)
is not set correctly.
The patch has been tested against 2.6.30.4 (it applies against 2.6.32.1)
and observed to correct the behavior of the affected ioctl.
Please CC me at james.getzendanner-9geRo0GdX4k6efY3Smnssodd74u8MsAO@public.gmane.org in any replies as I
am not on the list.
--- linux-2.6.32.1/drivers/spi/spi_bfin5xx.c.orig	2009-12-14 12:47:25.000000000 -0500
+++ linux-2.6.32.1/drivers/spi/spi_bfin5xx.c	2009-12-18 00:27:10.000000000 -0500
@@ -1051,10 +1051,16 @@ static int bfin_spi_setup(struct spi_dev
 	/* translate common spi framework into our register */
 	if (spi->mode & SPI_CPOL)
 		chip->ctl_reg |= CPOL;
+	else
+		chip->ctl_reg &= ~CPOL;
 	if (spi->mode & SPI_CPHA)
 		chip->ctl_reg |= CPHA;
+	else
+		chip->ctl_reg &= ~CPHA;
 	if (spi->mode & SPI_LSB_FIRST)
 		chip->ctl_reg |= LSBF;
+	else
+		chip->ctl_reg &= ~LSBF;
 	/* we dont support running in slave mode (yet?) */
 	chip->ctl_reg |= MSTR;
 
@@ -1106,6 +1112,7 @@ static int bfin_spi_setup(struct spi_dev
 			bfin_spi_u8_cs_chg_writer : bfin_spi_u8_writer;
 		chip->duplex = chip->cs_change_per_word ?
 			bfin_spi_u8_cs_chg_duplex : bfin_spi_u8_duplex;
+		chip->ctl_reg &= ~SIZE;
 		break;
 
 	case 16:
@@ -1117,6 +1124,7 @@ static int bfin_spi_setup(struct spi_dev
 			bfin_spi_u16_cs_chg_writer : bfin_spi_u16_writer;
 		chip->duplex = chip->cs_change_per_word ?
 			bfin_spi_u16_cs_chg_duplex : bfin_spi_u16_duplex;
+		chip->ctl_reg |= SIZE;
 		break;
 
 	default:

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
