From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: Re: [PATCH] [SPI][POWERPC] spi_mpc83xx: in
	"QE	mode" spiclk is sysclk/2
Date: Mon, 6 Aug 2007 16:04:18 +0400
Message-ID: <20070806120418.GA24742@localhost.localdomain>
References: <20070802142641.GA6309@localhost.localdomain>
	<200708021447.22028.david-b@pacbell.net>
	<595EE3AF-CDD6-4260-83D9-A3FA3EA1DF95@kernel.crashing.org>
Reply-To: avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <595EE3AF-CDD6-4260-83D9-A3FA3EA1DF95-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
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

On Fri, Aug 03, 2007 at 04:29:48AM -0500, Kumar Gala wrote:
> 
> On Aug 2, 2007, at 4:47 PM, David Brownell wrote:
> 
> > On Thursday 02 August 2007, Anton Vorontsov wrote:
> >> Probably someday mpc83xx_spi->sysclk should be renamed to
> >> mpc83xx_spi->spiclk to be less confusing.
> >
> > Why not "today", with this patch?  That would fix some of
> > the root cause of this bug...
> 
> I'm fine with this as well.  I just called it sysclk to start with  
> since when I wrote the driver it was just for the MPC834x.

Ok, great.

Now I think that `spiclk' is the bad name either, because it's output
clock of the spi unit. `spibrg' should be the best name for this,
as it's input clock to the SPI unit. Patch below.

- - - -
From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: [PATCH] spi_mpc83xx: for SPI in QE spibrg's input is sysclk/2

For MPC8349E input to SPIBRG is SYSCLK, but it's SYSCLK/2 for
MPC8323E (SPI in QE).

Also mpc83xx_spi->sysclk renamed to mpc83xx_spi->spibrg.

Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
---
 drivers/spi/spi_mpc83xx.c |   20 ++++++++++++--------
 1 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index 0c16a2b..446b624 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -86,7 +86,7 @@ struct mpc83xx_spi {
 
 	unsigned nsecs;		/* (clock cycle time)/2 */
 
-	u32 sysclk;
+	u32 spibrg;		/* SPIBRG input clock */
 	u32 rx_shift;		/* RX data reg shift when in qe mode */
 	u32 tx_shift;		/* TX data reg shift when in qe mode */
 
@@ -169,17 +169,17 @@ static void mpc83xx_spi_chipselect(struct spi_device *spi, int value)
 
 		regval |= SPMODE_LEN(len);
 
-		if ((mpc83xx_spi->sysclk / spi->max_speed_hz) >= 64) {
-			u8 pm = mpc83xx_spi->sysclk / (spi->max_speed_hz * 64);
+		if ((mpc83xx_spi->spibrg / spi->max_speed_hz) >= 64) {
+			u8 pm = mpc83xx_spi->spibrg / (spi->max_speed_hz * 64);
 			if (pm > 0x0f) {
-				printk(KERN_WARNING "MPC83xx SPI: SPICLK can't be less then a SYSCLK/1024!\n"
-						"Requested SPICLK is %d Hz. Will use %d Hz instead.\n",
-						spi->max_speed_hz, mpc83xx_spi->sysclk / 1024);
+				dev_warn(&spi->dev, "Requested speed is too "
+					"low: %d Hz. Will use %d Hz instead.\n",
+					spi->max_speed_hz, mpc83xx_spi->spibrg / 1024);
 				pm = 0x0f;
 			}
 			regval |= SPMODE_PM(pm) | SPMODE_DIV16;
 		} else {
-			u8 pm = mpc83xx_spi->sysclk / (spi->max_speed_hz * 4);
+			u8 pm = mpc83xx_spi->spibrg / (spi->max_speed_hz * 4);
 			regval |= SPMODE_PM(pm);
 		}
 
@@ -429,13 +429,17 @@ static int __init mpc83xx_spi_probe(struct platform_device *dev)
 	mpc83xx_spi->bitbang.chipselect = mpc83xx_spi_chipselect;
 	mpc83xx_spi->bitbang.setup_transfer = mpc83xx_spi_setup_transfer;
 	mpc83xx_spi->bitbang.txrx_bufs = mpc83xx_spi_bufs;
-	mpc83xx_spi->sysclk = pdata->sysclk;
 	mpc83xx_spi->activate_cs = pdata->activate_cs;
 	mpc83xx_spi->deactivate_cs = pdata->deactivate_cs;
 	mpc83xx_spi->qe_mode = pdata->qe_mode;
 	mpc83xx_spi->get_rx = mpc83xx_spi_rx_buf_u8;
 	mpc83xx_spi->get_tx = mpc83xx_spi_tx_buf_u8;
 
+	if (mpc83xx_spi->qe_mode)
+		mpc83xx_spi->spibrg = pdata->sysclk / 2;
+	else
+		mpc83xx_spi->spibrg = pdata->sysclk;
+
 	mpc83xx_spi->rx_shift = 0;
 	mpc83xx_spi->tx_shift = 0;
 	if (mpc83xx_spi->qe_mode) {
-- 
1.5.0.6


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
