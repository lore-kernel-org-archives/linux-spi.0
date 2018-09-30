From: Chuanhua Han <chuanhua.han@nxp.com>
Subject: [PATCH v2 2/4] spi: spi-fsl-dspi: Fix delete the processing of undefined bitmask for rxdata
Date: Sun, 30 Sep 2018 17:25:33 +0800
Message-ID: <20180930092535.24544-2-chuanhua.han@nxp.com>
References: <20180930092535.24544-1-chuanhua.han@nxp.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        boris.brezillon@bootlin.com, eha@deif.com,
        Chuanhua Han <chuanhua.han@nxp.com>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180930092535.24544-1-chuanhua.han@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch fixes the problem of rxdata being equal to 0 during the XSPI
mode transfer of the dspi controller.
In XSPI mode, If it is not deleted, the value of rxdata will be equal
to 0, and the data received will not be received correctly, causing the
receiving transfer of the spi to fail.

Signed-off-by: Chuanhua Han <chuanhua.han@nxp.com>
---
Changes in v2:
 -The original patch is divided into multiple patches(the original
patch theme is "spi: spi-fsl-dspi: Fix support for XSPI transport
mode"),one of which is segmented.

 drivers/spi/spi-fsl-dspi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
index 3082e72e4f6c..4dc1064bf408 100644
--- a/drivers/spi/spi-fsl-dspi.c
+++ b/drivers/spi/spi-fsl-dspi.c
@@ -243,9 +243,6 @@ static void dspi_push_rx(struct fsl_dspi *dspi, u32 rxdata)
 	if (!dspi->rx)
 		return;
 
-	/* Mask of undefined bits */
-	rxdata &= (1 << dspi->bits_per_word) - 1;
-
 	if (dspi->bytes_per_word == 1)
 		*(u8 *)dspi->rx = rxdata;
 	else if (dspi->bytes_per_word == 2)
-- 
2.17.1
