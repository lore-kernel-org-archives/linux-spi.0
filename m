From: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: [PATCH V3 1/1] spi: bcm-qspi: Make BSPI default mode
Date: Fri, 30 Aug 2019 09:58:45 +0530
Message-ID: <1567139325-7912-1-git-send-email-rayagonda.kokatanur@broadcom.com>
Cc: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
To: Kamal Dasu <kdasu.kdev@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The spi-nor controller defaults to BSPI mode, hence switch back
to its default mode after MSPI operations (write or erase)
are completed.

Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Reviewed-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
changes from V2:
 - Address code review comment from Mark Brown about changelog.

Changes from V1:
 - Address code review comment from Mark Brown.

 drivers/spi/spi-bcm-qspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 902bdbf..46a811a 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -897,6 +897,7 @@ static int bcm_qspi_transfer_one(struct spi_master *master,
 
 		read_from_hw(qspi, slots);
 	}
+	bcm_qspi_enable_bspi(qspi);
 
 	return 0;
 }
-- 
1.9.1
