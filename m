From: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: [PATCH V2] spi: dw: use "smp_mb()" to avoid sending spi data error
Date: Fri, 3 Jan 2020 10:52:10 +0800
Message-ID: <1578019930-55858-1-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linuxarm@huawei.com>, Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        fengsheng <fengsheng5@huawei.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Because of out-of-order execution about some CPU architecture,
In this debug stage we find Completing spi interrupt enable ->
prodrucing TXEI interrupt -> running "interrupt_transfer" function
will prior to set "dw->rx and dws->rx_end" data, so this patch add
memory barrier to enable dw->rx and dw->rx_end to be visible and
solve to send SPI data error.
eg:
it will fix to this following low possibility error in testing environment
which using SPI control to connect TPM Modules

kernel: tpm tpm0: Operation Timed out
kernel: tpm tpm0: tpm_relinquish_locality: : error -1

Signed-off-by: fengsheng <fengsheng5@huawei.com>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
---
 drivers/spi/spi-dw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index a92aa5c..9396eb5 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -288,6 +288,9 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	dws->rx_end = dws->rx + transfer->len;
 	dws->len = transfer->len;
 
+	/* Ensure dw->rx and dw->rx_end are visible */
+	smp_mb();
+
 	spi_enable_chip(dws, 0);
 
 	/* Handle per transfer options for bpw and speed */
-- 
2.7.4
