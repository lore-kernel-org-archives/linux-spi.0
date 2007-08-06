From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: [PATCH] [SPI][POWERPC] spi_mpc83xx: fix
	prescale modulus	calculation
Date: Mon, 6 Aug 2007 17:10:14 +0400
Message-ID: <20070806131014.GA6913@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
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
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Long ago I've noticed (but didn't pay much attention) that
spi_mpc83xx using PM calculations that differs from what
specs describe. I.e.

u8 pm = mpc83xx_spi->spibrg / (spi->max_speed_hz * 4);

While specs says: "The SPI baud rate generator clock source (either
system clock or system clock divided by 16, depending on DIV16 bit) is
divided by 4 * ([PM] + 1), a range from 4 to 64.".

Thus " - 1" is missing in the spi_mpc83xx's formula.

Why nobody noticed that bug? Probably because sysclk usually less then
user expects, e.g. you expect 200 MHz, but real clock is 198 MHz,
and integer rounding helps when this formula is used.

Suppose it's SPI in QE, SYSCLK at 198 MHz, thus SPIBRG at 99MHz, 25 MHz
requested.

PM = (99MHz / ( 25 MHz * 4 )), PM == 0, output SPICLK will be 24.75 MHz

At lower frequencies this bug is more noticeable, though.

And this bug shows itself in all its beauty if SYSCLK is equal or a bit
more than you expect (200 MHz SYSCLK, 100 MHz SPIBRG):
PM = (100MHz / ( 25 MHz * 4 )), PM == 1, output SPICLK will be 12.625 MHz!

Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
---
 drivers/spi/spi_mpc83xx.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index 446b624..042704b 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -170,7 +170,8 @@ static void mpc83xx_spi_chipselect(struct spi_device *spi, int value)
 		regval |= SPMODE_LEN(len);
 
 		if ((mpc83xx_spi->spibrg / spi->max_speed_hz) >= 64) {
-			u8 pm = mpc83xx_spi->spibrg / (spi->max_speed_hz * 64);
+			u8 pm = mpc83xx_spi->spibrg / (spi->max_speed_hz * 64) - 1;
+
 			if (pm > 0x0f) {
 				dev_warn(&spi->dev, "Requested speed is too "
 					"low: %d Hz. Will use %d Hz instead.\n",
@@ -180,6 +181,13 @@ static void mpc83xx_spi_chipselect(struct spi_device *spi, int value)
 			regval |= SPMODE_PM(pm) | SPMODE_DIV16;
 		} else {
 			u8 pm = mpc83xx_spi->spibrg / (spi->max_speed_hz * 4);
+
+			if (pm)
+				pm--;
+			else /* this floods dmesg if using mmc_spi, so dbg */
+				dev_dbg(&spi->dev, "Requested speed is too "
+					"high: %d Hz. Will use %d Hz instead.\n",
+					spi->max_speed_hz, mpc83xx_spi->spibrg / 4);
 			regval |= SPMODE_PM(pm);
 		}
 
-- 
1.5.0.6

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
