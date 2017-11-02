From: Colin King <colin.king@canonical.com>
Subject: [PATCH] spi: orion: remove redundant assignment of status to zero
Date: Thu,  2 Nov 2017 12:16:25 +0000
Message-ID: <20171102121625.20387-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <kernel-janitors-owner@vger.kernel.org>
Sender: kernel-janitors-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The assignment of status to zero is never read, status is either
updated in the next iteration of the of the loop or several
lines after the end of the loop.  Remove it, cleans up clang warning:

drivers/spi/spi-orion.c:674:4: warning: Value stored to 'status'
is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/spi/spi-orion.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 4b6dd73b80da..8974bb340b3a 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -671,7 +671,6 @@ static int orion_spi_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"%pOF has no valid 'reg' property (%d)\n",
 				np, status);
-			status = 0;
 			continue;
 		}
 
-- 
2.14.1

