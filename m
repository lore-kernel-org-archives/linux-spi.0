From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH 07/18] spi/xilinx: Use cached value of register
Date: Fri, 23 Jan 2015 17:08:39 +0100
Message-ID: <1422029330-10971-8-git-send-email-ricardo.ribalda@gmail.com>
References: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
Cc: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@xilinx.com>,
	=?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
	linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422029330-10971-1-git-send-email-ricardo.ribalda@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The control register has not changed since the previous access.
Therefore we can use the cached value and safe one bus access.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---
 drivers/spi/spi-xilinx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 978fbdd..3f8450d 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -271,7 +271,6 @@ static int xilinx_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
 		 * transmitter while the Isr refills the transmit register/FIFO,
 		 * or make sure it is stopped if we're done.
 		 */
-		cr = xspi->read_fn(xspi->regs + XSPI_CR_OFFSET);
 		xspi->write_fn(cr | XSPI_CR_TRANS_INHIBIT,
 			       xspi->regs + XSPI_CR_OFFSET);
 
-- 
2.1.4
