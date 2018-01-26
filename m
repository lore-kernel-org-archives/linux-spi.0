From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] spi: sprd: Use 'spi_master_put()' instead of 'spi_controller_put()'
Date: Fri, 26 Jan 2018 16:52:56 +0100
Message-ID: <20180126155256.25956-1-christophe.jaillet@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

'spi_alloc_master()' calls should be balanced by a 'spi_master_put()' call.

'spi_controller_put()' is equivalent (see include/linux/spi/spi.h) but it
is cleaner and more logical to use 'spi_master_put()'.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/spi/spi-sprd-adi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sprd-adi.c b/drivers/spi/spi-sprd-adi.c
index 5993bdbf79e4..55b9aada467e 100644
--- a/drivers/spi/spi-sprd-adi.c
+++ b/drivers/spi/spi-sprd-adi.c
@@ -382,7 +382,7 @@ static int sprd_adi_probe(struct platform_device *pdev)
 free_hwlock:
 	hwspin_lock_free(sadi->hwlock);
 put_ctlr:
-	spi_controller_put(ctlr);
+	spi_master_put(ctlr);
 	return ret;
 }
 
-- 
2.14.1


---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
