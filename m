From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] spi: Use struct_size() helper
Date: Fri, 7 Jun 2019 13:48:45 -0500
Message-ID: <20190607184845.GA13401@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct spi_replaced_transfers {
	...
        struct spi_transfer inserted_transfers[];
};

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes.

So, replace the following form:

insert * sizeof(struct spi_transfer) + sizeof(struct spi_replaced_transfers)

with:

struct_size(rxfer, inserted_transfers, insert)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/spi/spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index e0cd8ccfe92d..69e492ed414a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2769,8 +2769,7 @@ struct spi_replaced_transfers *spi_replace_transfers(
 
 	/* allocate the structure using spi_res */
 	rxfer = spi_res_alloc(msg->spi, __spi_replace_transfers_release,
-			      insert * sizeof(struct spi_transfer)
-			      + sizeof(struct spi_replaced_transfers)
+			      struct_size(rxfer, inserted_transfers, insert)
 			      + extradatasize,
 			      gfp);
 	if (!rxfer)
-- 
2.21.0
