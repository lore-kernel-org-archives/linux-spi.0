From: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
Subject: [PATCH 3/3] spi_topcliff_pch: fix resource leak issue
Date: Mon, 27 Dec 2010 20:23:47 +0900
Message-ID: <1293449027-3219-3-git-send-email-tomoya-linux@dsn.okisemi.com>
References: <1293449027-3219-1-git-send-email-tomoya-linux@dsn.okisemi.com>
 <1293449027-3219-2-git-send-email-tomoya-linux@dsn.okisemi.com>
Cc: qi.wang@intel.com, yong.y.wang@intel.com, joel.clark@intel.com,
	kok.howg.ewe@intel.com,
	Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
To: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1293449027-3219-2-git-send-email-tomoya-linux@dsn.okisemi.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

In case spi_register_master fails in probe function,
pch_spi_free_resources is not called.

Signed-off-by: Tomoya MORINAGA <tomoya-linux@dsn.okisemi.com>
---
 drivers/spi/spi_topcliff_pch.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi_topcliff_pch.c b/drivers/spi/spi_topcliff_pch.c
index a796eaf..e806e31 100644
--- a/drivers/spi/spi_topcliff_pch.c
+++ b/drivers/spi/spi_topcliff_pch.c
@@ -1125,6 +1125,7 @@ static int pch_spi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 err_spi_reg_master:
 	for (j = 0; j < i; j++)
 		spi_unregister_master(master[j]);
+	pch_spi_free_resources(board_dat);
 err_spi_get_resources:
 err_spi_alloc_master:
 	for (j = 0; j < i; j++)
-- 
1.6.0.6
