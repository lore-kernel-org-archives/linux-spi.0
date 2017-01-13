From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 12/17] spi/topcliff-pch: Improve size determinations in
 pch_spi_probe()
Date: Fri, 13 Jan 2017 18:21:55 +0100
Message-ID: <d2471abf-1eca-037f-3d10-ba03d8e987af@users.sourceforge.net>
References: <1413e173-dbac-7a6e-09cb-2287300a335e@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
To: linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413e173-dbac-7a6e-09cb-2287300a335e@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 13 Jan 2017 15:46:35 +0100

Replace the specification of data structures by pointer dereferences
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/spi/spi-topcliff-pch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 0488b7c7cc19..4bba39e70c7b 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1541,11 +1541,11 @@ static int pch_spi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	int i;
 	struct pch_pd_dev_save *pd_dev_save;
 
-	pd_dev_save = kzalloc(sizeof(struct pch_pd_dev_save), GFP_KERNEL);
+	pd_dev_save = kzalloc(sizeof(*pd_dev_save), GFP_KERNEL);
 	if (!pd_dev_save)
 		return -ENOMEM;
 
-	board_dat = kzalloc(sizeof(struct pch_spi_board_data), GFP_KERNEL);
+	board_dat = kzalloc(sizeof(*board_dat), GFP_KERNEL);
 	if (!board_dat) {
 		retval = -ENOMEM;
 		goto err_no_mem;
-- 
2.11.0
