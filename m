From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 6/8] spi_mpc8xxx: Factor out SPI mode
 change steps into a call
Date: Mon, 12 Oct 2009 20:49:24 +0400
Message-ID: <20091012164924.GF4578@oksana.dev.rtsoft.ru>
References: <20091012164841.GA32214@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20091012164841.GA32214-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

We'll add more steps soon, so get rid of the duplication.

Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Acked-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
---
 drivers/spi/spi_mpc8xxx.c |   56 +++++++++++++++++++-------------------------
 1 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
index 518671b..4b119ea 100644
--- a/drivers/spi/spi_mpc8xxx.c
+++ b/drivers/spi/spi_mpc8xxx.c
@@ -155,6 +155,26 @@ MPC83XX_SPI_TX_BUF(u8)
 MPC83XX_SPI_TX_BUF(u16)
 MPC83XX_SPI_TX_BUF(u32)
 
+static void mpc8xxx_spi_change_mode(struct spi_device *spi)
+{
+	struct mpc8xxx_spi *mspi = spi_master_get_devdata(spi->master);
+	struct spi_mpc8xxx_cs *cs = spi->controller_state;
+	__be32 __iomem *mode = &mspi->base->mode;
+	unsigned long flags;
+
+	if (cs->hw_mode == mpc8xxx_spi_read_reg(mode))
+		return;
+
+	/* Turn off IRQs locally to minimize time that SPI is disabled. */
+	local_irq_save(flags);
+
+	/* Turn off SPI unit prior changing mode */
+	mpc8xxx_spi_write_reg(mode, cs->hw_mode & ~SPMODE_ENABLE);
+	mpc8xxx_spi_write_reg(mode, cs->hw_mode);
+
+	local_irq_restore(flags);
+}
+
 static void mpc8xxx_spi_chipselect(struct spi_device *spi, int value)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi = spi_master_get_devdata(spi->master);
@@ -168,27 +188,13 @@ static void mpc8xxx_spi_chipselect(struct spi_device *spi, int value)
 	}
 
 	if (value == BITBANG_CS_ACTIVE) {
-		u32 regval = mpc8xxx_spi_read_reg(&mpc8xxx_spi->base->mode);
-
 		mpc8xxx_spi->rx_shift = cs->rx_shift;
 		mpc8xxx_spi->tx_shift = cs->tx_shift;
 		mpc8xxx_spi->get_rx = cs->get_rx;
 		mpc8xxx_spi->get_tx = cs->get_tx;
 
-		if (cs->hw_mode != regval) {
-			unsigned long flags;
-			__be32 __iomem *mode = &mpc8xxx_spi->base->mode;
-
-			regval = cs->hw_mode;
-			/* Turn off IRQs locally to minimize time that
-			 * SPI is disabled
-			 */
-			local_irq_save(flags);
-			/* Turn off SPI unit prior changing mode */
-			mpc8xxx_spi_write_reg(mode, regval & ~SPMODE_ENABLE);
-			mpc8xxx_spi_write_reg(mode, regval);
-			local_irq_restore(flags);
-		}
+		mpc8xxx_spi_change_mode(spi);
+
 		if (pdata->cs_control)
 			pdata->cs_control(spi, pol);
 	}
@@ -198,7 +204,6 @@ static
 int mpc8xxx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct mpc8xxx_spi *mpc8xxx_spi;
-	u32 regval;
 	u8 bits_per_word, pm;
 	u32 hz;
 	struct spi_mpc8xxx_cs	*cs = spi->controller_state;
@@ -286,21 +291,8 @@ int mpc8xxx_spi_setup_transfer(struct spi_device *spi, struct spi_transfer *t)
 		pm--;
 
 	cs->hw_mode |= SPMODE_PM(pm);
-	regval =  mpc8xxx_spi_read_reg(&mpc8xxx_spi->base->mode);
-	if (cs->hw_mode != regval) {
-		unsigned long flags;
-		__be32 __iomem *mode = &mpc8xxx_spi->base->mode;
-
-		regval = cs->hw_mode;
-		/* Turn off IRQs locally to minimize time
-		 * that SPI is disabled
-		 */
-		local_irq_save(flags);
-		/* Turn off SPI unit prior changing mode */
-		mpc8xxx_spi_write_reg(mode, regval & ~SPMODE_ENABLE);
-		mpc8xxx_spi_write_reg(mode, regval);
-		local_irq_restore(flags);
-	}
+
+	mpc8xxx_spi_change_mode(spi);
 	return 0;
 }
 
-- 
1.6.3.3


------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
