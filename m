From: xiao jin <jin.xiao@intel.com>
Subject: [PATCH] [RFC] spi: pxa2xx: Do cs if restart the SSP during pxa2xx_spi_transfer_one()
Date: Thu,  7 Mar 2019 15:24:24 +0800
Message-ID: <20190307072424.18820-1-jin.xiao@intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: xiao jin <jin.xiao@intel.com>, he@vger.kernel.org,
        bo <bo.he@intel.com>
To: jarkko.nikula@linux.intel.com, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanmin.zhang@intel.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The spi-pxa2xx can't read and write data correctly on our board.
The pxa_ssp_type is LPSS_BXT_SSP in our case.

With more debug we find that it's related to restart the SPP
during pxa2xx_spi_transfer_one().

In the normal case the spi_transfer_one_message() calls spi-pxa2xx
cs_assert before transferring one message. After completing the
transfer it calls spi-pxa2xx cs_deassert. The spi-pxa2xx works
well.

But in some other case pxa2xx_spi_unprepare_transfer() is called
that clears SSCR0_SSE bit before the next transfer. In the next
transfer the spi-pxa2xx driver will restart the SSP as the SSE
bit is cleared. The cs_assert before the SSP restart can't ensure
spi-pxa2xx work well.

The patch is to do cs again if spi-pxa2xx restar the SSP during
pxa2xx_spi_transfer_one()

Signed-off-by: xiao jin <jin.xiao@intel.com>
Signed-off-by: he, bo <bo.he@intel.com>
---
 drivers/spi/spi-pxa2xx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 14f4ea59caff..1a2ea46858d9 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -928,6 +928,7 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
 	u32 cr1;
 	int err;
 	int dma_mapped;
+	bool need_cs_change = false;
 
 	/* Check if we can DMA this transfer */
 	if (transfer->len > MAX_DMA_LEN && chip->enable_dma) {
@@ -1056,6 +1057,11 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
 	if ((pxa2xx_spi_read(drv_data, SSCR0) != cr0)
 	    || (pxa2xx_spi_read(drv_data, SSCR1) & change_mask)
 	    != (cr1 & change_mask)) {
+		/* It needs to deassert the chip selection
+		 * firstly before restart the SPP */
+		need_cs_change = true;
+		cs_deassert(spi);
+
 		/* stop the SSP, and update the other bits */
 		pxa2xx_spi_write(drv_data, SSCR0, cr0 & ~SSCR0_SSE);
 		if (!pxa25x_ssp_comp(drv_data))
@@ -1070,6 +1076,8 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
 			pxa2xx_spi_write(drv_data, SSTO, chip->timeout);
 	}
 
+	if (need_cs_change)
+		cs_assert(spi);
 	/*
 	 * Release the data by enabling service requests and interrupts,
 	 * without changing any mode bits
-- 
2.21.0
