From: Xinwei Kong <kong.kongxinwei@hisilicon.com>
Subject: [PATCH] spi: dw: use "smp_mb()" to avoid sending spi data error
Date: Thu, 26 Dec 2019 17:21:28 +0800
Message-ID: <1577352088-35856-1-git-send-email-kong.kongxinwei@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linuxarm@huawei.com>, Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        fengsheng <fengsheng5@huawei.com>
To: <broonie@kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

this patch will add memory barrier to ensure this "struct dw_spi *dws"
to complete data setting before enabling this SPI hardware interrupt.
eg:
it will fix to this following low possibility error in testing environment
which using SPI control to connect TPM Modules

kernel: tpm tpm0: Operation Timed out
kernel: tpm tpm0: tpm_relinquish_locality: : error -1

Signed-off-by: fengsheng <fengsheng5@huawei.com>
Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
---
 drivers/spi/spi-dw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index a92aa5c..d0d77a2 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -288,6 +288,8 @@ static int dw_spi_transfer_one(struct spi_controller *master,
 	dws->rx_end = dws->rx + transfer->len;
 	dws->len = transfer->len;
 
+	smp_mb();
+
 	spi_enable_chip(dws, 0);
 
 	/* Handle per transfer options for bpw and speed */
-- 
2.7.4
