From: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Subject: [PATCH] spi: mpc512x-psc: optionally keep PSC SS asserted across xfer
	segmensts
Date: Wed, 13 Mar 2013 14:57:43 +0100
Message-ID: <1363183063-24947-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Some SPI slave devices require asserted chip select signal across
multiple transfer segments of an SPI message. Currently the driver
always de-asserts the internal SS signal for every single transfer
segment of the message and ignores the 'cs_change' flag of the
transfer description. Disable the internal chip select (SS) only
if this is needed and indicated by the 'cs_change' flag.

Without this change, each partial transfer of a surrounding
multi-part SPI transaction might erroneously change the SS
signal, which might prevent slaves from answering the request
that was sent in a previous transfer segment because the
transaction could be considered aborted (SS was de-asserted
before reading the response).

Reported-by: Gerhard Sittig <gerhard.sittig-Jj5Fu8i2Z9Q@public.gmane.org>
Signed-off-by: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
---
 drivers/spi/spi-mpc512x-psc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 6b600a2..dfddf33 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -168,7 +168,7 @@ static int mpc512x_psc_spi_transfer_rxtx(struct spi_device *spi,
 
 		for (i = count; i > 0; i--) {
 			data = tx_buf ? *tx_buf++ : 0;
-			if (len == EOFBYTE)
+			if (len == EOFBYTE && t->cs_change)
 				setbits32(&fifo->txcmd, MPC512x_PSC_FIFO_EOF);
 			out_8(&fifo->txdata_8, data);
 			len--;
-- 
1.7.5.4


------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
