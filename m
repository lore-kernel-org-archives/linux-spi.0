From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 3/5] Blackfin SPI Driver: fix NULL pointer crash
Date: Thu,  5 Feb 2009 18:07:31 +0800
Message-ID: <1233828453-13311-4-git-send-email-cooloney@kernel.org>
References: <1233828453-13311-1-git-send-email-cooloney@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mike Frysinger <vapier.adi@gmail.com>,
	Bryan Wu <cooloney@kernel.org>
To: dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759675AbZBEKG4@vger.kernel.org>
In-Reply-To: <1233828453-13311-1-git-send-email-cooloney@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Mike Frysinger <vapier.adi@gmail.com>

fix NULL pointer crash when cleaning up from invalid platform resources

Signed-off-by: Mike Frysinger <vapier.adi@gmail.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 drivers/spi/spi_bfin5xx.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index ce24d5e..b6098b5 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -1240,6 +1240,9 @@ static void bfin_spi_cleanup(struct spi_device *spi)
 {
 	struct chip_data *chip = spi_get_ctldata(spi);
 
+	if (!chip)
+		return;
+
 	if ((chip->chip_select_num > 0)
 		&& (chip->chip_select_num <= spi->master->num_chipselect))
 		peripheral_free(ssel[spi->master->bus_num]
-- 
1.5.6.3
