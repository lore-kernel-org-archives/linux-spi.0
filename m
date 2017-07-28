From: Varadarajan Narayanan <varada@codeaurora.org>
Subject: [PATCH v6 05/14] spi: qup: Fix error handling in spi_qup_prep_sg
Date: Fri, 28 Jul 2017 12:22:52 +0530
Message-ID: <1501224781-19519-6-git-send-email-varada@codeaurora.org>
References: <1501224781-19519-1-git-send-email-varada@codeaurora.org>
Cc: Varadarajan Narayanan <varada@codeaurora.org>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        andy.gross@linaro.org, david.brown@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501224781-19519-1-git-send-email-varada@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Varadarajan Narayanan <varada@codeaurora.org>
---
 drivers/spi/spi-qup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index f1aa5c1..ef95294 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -311,8 +311,8 @@ static int spi_qup_prep_sg(struct spi_master *master, struct spi_transfer *xfer,
 	}
 
 	desc = dmaengine_prep_slave_sg(chan, sgl, nents, dir, flags);
-	if (!desc)
-		return -EINVAL;
+	if (IS_ERR_OR_NULL(desc))
+		return desc ? PTR_ERR(desc) : -EINVAL;
 
 	desc->callback = callback;
 	desc->callback_param = qup;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
