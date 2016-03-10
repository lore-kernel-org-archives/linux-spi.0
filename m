From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH 1/2] spi: Fix htmldocs build error due struct spi_replaced_transfers
Date: Thu, 10 Mar 2016 15:01:13 -0300
Message-ID: <1457632874-11250-2-git-send-email-javier@osg.samsung.com>
References: <1457632874-11250-1-git-send-email-javier@osg.samsung.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	Javier Martinez Canillas <javier@osg.samsung.com>
To: linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1457632874-11250-1-git-send-email-javier@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The kernel-doc has to be just before the structure definition but the one
for struct spi_replaced_transfers was before a structure declaration and
that confuses kernel-doc which complains with the following build error:

.//include/linux/spi/spi.h:933: error: Cannot parse struct or union!

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

 include/linux/spi/spi.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 520a23d46df6..857a9a1d82b5 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -911,6 +911,10 @@ spi_max_transfer_size(struct spi_device *spi)
 
 /* SPI transfer replacement methods which make use of spi_res */
 
+struct spi_replaced_transfers;
+typedef void (*spi_replaced_release_t)(struct spi_master *master,
+				       struct spi_message *msg,
+				       struct spi_replaced_transfers *res);
 /**
  * struct spi_replaced_transfers - structure describing the spi_transfer
  *                                 replacements that have occurred
@@ -930,10 +934,6 @@ spi_max_transfer_size(struct spi_device *spi)
  * if some extra allocation is requested, so alignment will be the same
  * as for spi_transfers
  */
-struct spi_replaced_transfers;
-typedef void (*spi_replaced_release_t)(struct spi_master *master,
-				       struct spi_message *msg,
-				       struct spi_replaced_transfers *res);
 struct spi_replaced_transfers {
 	spi_replaced_release_t release;
 	void *extradata;
-- 
2.5.0
