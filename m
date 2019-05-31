From: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Subject: [PATCH] spi: qup: remove unnecessary goto
Date: Fri, 31 May 2019 16:46:36 +0200
Message-ID: <20190531144636.27843-1-jorge.ramirez-ortiz@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: jorge.ramirez-ortiz@linaro.org, agross@kernel.org,
        david.brown@linaro.org, broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Remove unnecessary condition check and associated goto.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
---
 drivers/spi/spi-qup.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 974a8ce58b68..314d91b95a16 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -842,10 +842,6 @@ static int spi_qup_transfer_one(struct spi_master *master,
 	else
 		ret = spi_qup_do_pio(spi, xfer, timeout);
 
-	if (ret)
-		goto exit;
-
-exit:
 	spi_qup_set_state(controller, QUP_STATE_RESET);
 	spin_lock_irqsave(&controller->lock, flags);
 	if (!ret)
-- 
2.21.0
