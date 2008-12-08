From: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH] Race condition in mpc52xx_psc_spi
Date: Mon,  8 Dec 2008 12:59:37 +0100
Message-ID: <1228737577-8574-1-git-send-email-sbabic@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <>
References: <>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The RFNUM register is read only once to get the number of bytes
in the RXFIFO. If additional bytes are received during the for
loop that transfers data from the FIFO, the RFNUM register will not be
set to zero after the reading.
This causes that the RXFIFO interrupt remains pending, because
the interrupt is removed after all bytes are read from the RXFIFO
(with granularity set to 0 as set by the driver).

Signed-off-by: Stefano Babic <sbabic-ynQEQJNshbs@public.gmane.org>
---
 drivers/spi/mpc52xx_psc_spi.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/mpc52xx_psc_spi.c b/drivers/spi/mpc52xx_psc_spi.c
index 8bd39df..e91d91a 100644
--- a/drivers/spi/mpc52xx_psc_spi.c
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -191,17 +191,19 @@ static int mpc52xx_psc_spi_transfer_rxtx(struct spi_device *spi,
 		}
 		out_be16(&psc->mpc52xx_psc_imr, MPC52xx_PSC_IMR_RXRDY);
 		wait_for_completion(&mps->done);
-		recv_at_once = in_be16(&fifo->rfnum);
-		dev_dbg(&spi->dev, "%d bytes received\n", recv_at_once);
 
-		send_at_once = recv_at_once;
-		if (rx_buf) {
-			for (; recv_at_once; rb++, recv_at_once--)
-				rx_buf[rb] = in_8(&psc->mpc52xx_psc_buffer_8);
-		} else {
-			for (; recv_at_once; rb++, recv_at_once--)
+		recv_at_once = 0;
+		while (in_be16(&fifo->rfnum)) {
+			recv_at_once++;
+			if (rx_buf) {
+				rx_buf[rb++] = in_8(&psc->mpc52xx_psc_buffer_8);
+			} else {
 				in_8(&psc->mpc52xx_psc_buffer_8);
+				rb++;
+			}
 		}
+		dev_dbg(&spi->dev, "%d bytes received\n", recv_at_once);
+		send_at_once = recv_at_once;
 	}
 	/* disable transmiter/receiver */
 	out_8(&psc->command, MPC52xx_PSC_TX_DISABLE | MPC52xx_PSC_RX_DISABLE);
-- 
1.5.4.3


------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
