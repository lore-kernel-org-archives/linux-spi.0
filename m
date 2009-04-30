From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 7/9] spi_mpc83xx: Remove dead code
Date: Fri, 1 May 2009 03:48:30 +0400
Message-ID: <20090430234830.GG7901@oksana.dev.rtsoft.ru>
References: <20090430234739.GA27709@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Kumar Gala <galak-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090430234739.GA27709-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This patch removes #if 0'ed code, and spi_mpc83xx->busy variable that
is used by that dead snippet only.

Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
---
 drivers/spi/spi_mpc83xx.c |   16 ----------------
 1 files changed, 0 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/spi_mpc83xx.c b/drivers/spi/spi_mpc83xx.c
index 50112a5..4192ce4 100644
--- a/drivers/spi/spi_mpc83xx.c
+++ b/drivers/spi/spi_mpc83xx.c
@@ -98,8 +98,6 @@ struct mpc83xx_spi {
 
 	bool qe_mode;
 
-	u8 busy;
-
 	struct workqueue_struct *workqueue;
 	struct work_struct work;
 
@@ -411,7 +409,6 @@ static void mpc83xx_spi_work(struct work_struct *work)
 						       work);
 
 	spin_lock_irq(&mpc83xx_spi->lock);
-	mpc83xx_spi->busy = 1;
 	while (!list_empty(&mpc83xx_spi->queue)) {
 		struct spi_message *m = container_of(mpc83xx_spi->queue.next,
 						   struct spi_message, queue);
@@ -423,7 +420,6 @@ static void mpc83xx_spi_work(struct work_struct *work)
 
 		spin_lock_irq(&mpc83xx_spi->lock);
 	}
-	mpc83xx_spi->busy = 0;
 	spin_unlock_irq(&mpc83xx_spi->lock);
 }
 
@@ -482,18 +478,6 @@ static int mpc83xx_spi_setup(struct spi_device *spi)
 	dev_dbg(&spi->dev, "%s, mode %d, %u bits/w, %u Hz\n",
 		__func__, spi->mode & (SPI_CPOL | SPI_CPHA),
 		spi->bits_per_word, spi->max_speed_hz);
-#if 0 /* Don't think this is needed */
-	/* NOTE we _need_ to call chipselect() early, ideally with adapter
-	 * setup, unless the hardware defaults cooperate to avoid confusion
-	 * between normal (active low) and inverted chipselects.
-	 */
-
-	/* deselect chip (low or high) */
-	spin_lock(&mpc83xx_spi->lock);
-	if (!mpc83xx_spi->busy)
-		mpc83xx_spi_chipselect(spi, BITBANG_CS_INACTIVE);
-	spin_unlock(&mpc83xx_spi->lock);
-#endif
 	return 0;
 }
 
-- 
1.6.2.2


------------------------------------------------------------------------------
Register Now & Save for Velocity, the Web Performance & Operations 
Conference from O'Reilly Media. Velocity features a full day of 
expert-led, hands-on workshops and two days of sessions from industry 
leaders in dedicated Performance & Operations tracks. Use code vel09scf 
and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
