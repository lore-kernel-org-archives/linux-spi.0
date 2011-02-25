From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: [PATCH 10/21]drivers:spi:spi_topcliff_pch.c remove one to many l's in the word.
Date: Thu, 24 Feb 2011 22:12:50 -0800
Message-ID: <1298614370-3841-1-git-send-email-justinmattock@gmail.com>
Cc: dbrownell@users.sourceforge.net, grant.likely@secretlab.ca,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	"Justin P. Mattock" <justinmattock@gmail.com>
To: trivial@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch below removes an extra "l" in the word.

Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>

---
 drivers/spi/spi_topcliff_pch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi_topcliff_pch.c b/drivers/spi/spi_topcliff_pch.c
index 79e48d4..75f8f13 100644
--- a/drivers/spi/spi_topcliff_pch.c
+++ b/drivers/spi/spi_topcliff_pch.c
@@ -1022,7 +1022,7 @@ static int pch_spi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	board_dat->pdev = pdev;
 
-	/* alllocate memory for SPI master */
+	/* allocate memory for SPI master */
 	master = spi_alloc_master(&pdev->dev, sizeof(struct pch_spi_data));
 	if (master == NULL) {
 		retval = -ENOMEM;
-- 
1.7.4.1
