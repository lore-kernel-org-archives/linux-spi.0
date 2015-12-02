From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 3/4] spi: butterfly: correct alignment
Date: Wed,  2 Dec 2015 19:17:50 +0530
Message-ID: <1449064071-4915-3-git-send-email-sudipm.mukherjee@gmail.com>
References: <1449064071-4915-1-git-send-email-sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449064071-4915-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

checkpatch complains about the allignment with open parenthesis. 

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/spi/spi-butterfly.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-butterfly.c b/drivers/spi/spi-butterfly.c
index 8fc284d..f16ef7f 100644
--- a/drivers/spi/spi-butterfly.c
+++ b/drivers/spi/spi-butterfly.c
@@ -143,9 +143,8 @@ static void butterfly_chipselect(struct spi_device *spi, int value)
 #include "spi-bitbang-txrx.h"
 
 static u32
-butterfly_txrx_word_mode0(struct spi_device *spi,
-		unsigned nsecs,
-		u32 word, u8 bits)
+butterfly_txrx_word_mode0(struct spi_device *spi, unsigned nsecs, u32 word,
+			  u8 bits)
 {
 	return bitbang_txrx_be_cpha0(spi, nsecs, 0, 0, word, bits);
 }
@@ -223,8 +222,8 @@ static void butterfly_attach(struct parport *p)
 	 */
 	pp->port = p;
 	pd = parport_register_device(p, "spi_butterfly",
-			NULL, NULL, NULL,
-			0 /* FLAGS */, pp);
+				     NULL, NULL, NULL,
+				     0 /* FLAGS */, pp);
 	if (!pd) {
 		status = -ENOMEM;
 		goto clean0;
@@ -275,7 +274,7 @@ static void butterfly_attach(struct parport *p)
 	pp->dataflash = spi_new_device(pp->bitbang.master, &pp->info[0]);
 	if (pp->dataflash)
 		pr_debug("%s: dataflash at %s\n", p->name,
-				dev_name(&pp->dataflash->dev));
+			 dev_name(&pp->dataflash->dev));
 
 	pr_info("%s: AVR Butterfly\n", p->name);
 	butterfly = pp;
-- 
1.9.1
