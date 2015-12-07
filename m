From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v2 5/8] spi: lm70llp: remove space
Date: Mon,  7 Dec 2015 16:17:32 +0530
Message-ID: <1449485255-1103-5-git-send-email-sudipm.mukherjee@gmail.com>
References: <1449485255-1103-1-git-send-email-sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449485255-1103-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

checkpatch complains about space before closing brace.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/spi/spi-lm70llp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-lm70llp.c b/drivers/spi/spi-lm70llp.c
index 5f526ce..62d0f6d 100644
--- a/drivers/spi/spi-lm70llp.c
+++ b/drivers/spi/spi-lm70llp.c
@@ -166,7 +166,7 @@ static inline int getmiso(struct spi_device *s)
 {
 	struct spi_lm70llp *pp = spidev_to_pp(s);
 
-	return ((SIO == (parport_read_status(pp->port) & SIO)) ? 0 : 1 );
+	return ((SIO == (parport_read_status(pp->port) & SIO)) ? 0 : 1);
 }
 
 /*--------------------------------------------------------------------*/
-- 
1.9.1
