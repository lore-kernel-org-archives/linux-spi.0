From: Mingkai Hu <Mingkai.hu@freescale.com>
Subject: [PATCH] eSPI: change the read behavior of the SPIRF
Date: Wed, 1 Dec 2010 17:29:18 +0800
Message-ID: <1291195758-12322-1-git-send-email-Mingkai.hu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: kumar.gala@freescale.com, Mingkai Hu <Mingkai.hu@freescale.com>
To: <linuxppc-dev@ozlabs.org>, <spi-devel-general@lists.sourceforge.net>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
List-Id: linux-spi.vger.kernel.org

The user must read N bytes of SPIRF (1 <= N <= 4) that do not exceed the
amount of data in the receive FIFO, so read the SPIRF byte by byte when
the data in receive FIFO is less than 4 bytes.

On Simics, when read N bytes that exceed the amout of data in receive
FIFO, we can't read the data out, that is we can't clear the rx FIFO,
then the CPU will loop on the espi rx interrupt.

Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
---
 drivers/spi/spi_fsl_espi.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi_fsl_espi.c b/drivers/spi/spi_fsl_espi.c
index e3b4f64..ae78926 100644
--- a/drivers/spi/spi_fsl_espi.c
+++ b/drivers/spi/spi_fsl_espi.c
@@ -507,16 +507,29 @@ void fsl_espi_cpu_irq(struct mpc8xxx_spi *mspi, u32 events)
 
 	/* We need handle RX first */
 	if (events & SPIE_NE) {
-		u32 rx_data;
+		u32 rx_data, tmp;
+		u8 rx_data_8;
 
 		/* Spin until RX is done */
 		while (SPIE_RXCNT(events) < min(4, mspi->len)) {
 			cpu_relax();
 			events = mpc8xxx_spi_read_reg(&reg_base->event);
 		}
-		mspi->len -= 4;
 
-		rx_data = mpc8xxx_spi_read_reg(&reg_base->receive);
+		if (mspi->len >= 4) {
+			rx_data = mpc8xxx_spi_read_reg(&reg_base->receive);
+		} else {
+			tmp = mspi->len;
+			rx_data = 0;
+			while (tmp--) {
+				rx_data_8 = in_8((u8 *)&reg_base->receive);
+				rx_data |= (rx_data_8 << (tmp * 8));
+			}
+
+			rx_data <<= (4 - mspi->len) * 8;
+		}
+
+		mspi->len -= 4;
 
 		if (mspi->rx)
 			mspi->get_rx(rx_data, mspi);
-- 
1.7.0.4
