From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH] [POWERPC] mpc5200: fix build error on
	mpc52xx_psc_spi device	driver
Date: Sat, 23 Feb 2008 22:49:55 -0700
Message-ID: <20080224054955.21886.79000.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dragos.carp-+ybMorV4k0dBDgjK7y7TUQ@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

Commit id 94f389485e27641348c1951ab8d65157122a8939 (Separate MPC52xx PSC
FIOF regsiters from the rest of PSC) split the PSC fifo registers away
from the core PSC regs.  Doing so broke the mpc52xx_psc_spi driver.

This patch teaches the mpc52xx_psc_spi driver about the new PSC fifo
register definitions.

Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

---
This is a build error bug fix which needs to go into .25
---

 drivers/spi/mpc52xx_psc_spi.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
index 253ed56..a86315a 100644
--- a/drivers/spi/mpc52xx_psc_spi.c
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -42,6 +42,7 @@ struct mpc52xx_psc_spi {
 
 	/* driver internal data */
 	struct mpc52xx_psc __iomem *psc;
+	struct mpc52xx_psc_fifo __iomem *fifo;
 	unsigned int irq;
 	u8 bits_per_word;
 	u8 busy;
@@ -139,6 +140,7 @@ static int mpc52xx_psc_spi_transfer_rxtx(struct spi_device *spi,
 {
 	struct mpc52xx_psc_spi *mps = spi_master_get_devdata(spi->master);
 	struct mpc52xx_psc __iomem *psc = mps->psc;
+	struct mpc52xx_psc_fifo __iomem *fifo = mps->fifo;
 	unsigned rb = 0;	/* number of bytes receieved */
 	unsigned sb = 0;	/* number of bytes sent */
 	unsigned char *rx_buf = (unsigned char *)t->rx_buf;
@@ -190,11 +192,11 @@ static int mpc52xx_psc_spi_transfer_rxtx(struct spi_device *spi,
 			out_8(&psc->mode, 0);
 		} else {
 			out_8(&psc->mode, MPC52xx_PSC_MODE_FFULL);
-			out_be16(&psc->rfalarm, rfalarm);
+			out_be16(&fifo->rfalarm, rfalarm);
 		}
 		out_be16(&psc->mpc52xx_psc_imr, MPC52xx_PSC_IMR_RXRDY);
 		wait_for_completion(&mps->done);
-		recv_at_once = in_be16(&psc->rfnum);
+		recv_at_once = in_be16(&fifo->rfnum);
 		dev_dbg(&spi->dev, "%d bytes received\n", recv_at_once);
 
 		send_at_once = recv_at_once;
@@ -331,6 +333,7 @@ static void mpc52xx_psc_spi_cleanup(struct spi_device *spi)
 static int mpc52xx_psc_spi_port_config(int psc_id, struct mpc52xx_psc_spi *mps)
 {
 	struct mpc52xx_psc __iomem *psc = mps->psc;
+	struct mpc52xx_psc_fifo __iomem *fifo = mps->fifo;
 	u32 mclken_div;
 	int ret = 0;
 
@@ -346,7 +349,7 @@ static int mpc52xx_psc_spi_port_config(int psc_id, struct mpc52xx_psc_spi *mps)
 	/* Disable interrupts, interrupts are based on alarm level */
 	out_be16(&psc->mpc52xx_psc_imr, 0);
 	out_8(&psc->command, MPC52xx_PSC_SEL_MODE_REG_1);
-	out_8(&psc->rfcntl, 0);
+	out_8(&fifo->rfcntl, 0);
 	out_8(&psc->mode, MPC52xx_PSC_MODE_FFULL);
 
 	/* Configure 8bit codec mode as a SPI master and use EOF flags */
@@ -419,6 +422,8 @@ static int __init mpc52xx_psc_spi_do_probe(struct device *dev, u32 regaddr,
 		ret = -EFAULT;
 		goto free_master;
 	}
+	/* On the 5200, fifo regs are immediately ajacent to the psc regs */
+	mps->fifo = ((void __iomem *)mps->psc) + sizeof(struct mpc52xx_psc);
 
 	ret = request_irq(mps->irq, mpc52xx_psc_spi_isr, 0, "mpc52xx-psc-spi",
 				mps);


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
