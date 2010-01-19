From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] spi0: dw_spi: add a missed
 dw_spi_remove_host() in exit sequence
Date: Tue, 19 Jan 2010 11:20:15 +0800
Message-ID: <20100119112015.23252e97@feng-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, David Brownell
	<dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

>From 476cd29cdde8764b8491128f15c7739547af514f Mon Sep 17 00:00:00 2001
From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Date: Mon, 28 Dec 2009 11:35:03 +0800
Subject: [PATCH 2/3] spi0: dw_spi: add a missed dw_spi_remove_host() in exit sequence

Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/dw_spi_pci.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/dw_spi_pci.c b/drivers/spi/dw_spi_pci.c
index 34ba691..7980f14 100644
--- a/drivers/spi/dw_spi_pci.c
+++ b/drivers/spi/dw_spi_pci.c
@@ -98,6 +98,7 @@ static void __devexit spi_pci_remove(struct pci_dev *pdev)
 	struct dw_spi_pci *dwpci = pci_get_drvdata(pdev);
 
 	pci_set_drvdata(pdev, NULL);
+	dw_spi_remove_host(&dwpci->dws);
 	iounmap(dwpci->dws.regs);
 	pci_release_region(pdev, 0);
 	kfree(dwpci);
-- 
1.6.0.4

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
