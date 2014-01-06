From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH] spi: dw-pci: fix typo
Date: Mon,  6 Jan 2014 09:21:33 +0200
Message-ID: <397a6e6c794c4445150c823510187775b17e9c29.1388992893.git.baruch@tkos.co.il>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>,
	Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>,
	Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Commit 04f421e7b0b10 (spi: dw: use managed resources) introduced a typo in
struct field reference. Fix it.

Fixes build failure:

drivers/spi/spi-dw-pci.c: In function 'spi_pci_probe':
drivers/spi/spi-dw-pci.c:50:29: error: 'dev' undeclared (first use in this function)
  dwpci = devm_kzalloc(&pdev-dev, sizeof(struct dw_spi_pci), GFP_KERNEL);
                             ^

Cc: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reported-by: Stephen Rothwell <sfr-3FnU+UHB4dNDw9hX6IcOSA@public.gmane.org>
Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 drivers/spi/spi-dw-pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 760dc0017a33..9622e5ee1263 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -47,7 +47,8 @@ static int spi_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		return ret;
 
-	dwpci = devm_kzalloc(&pdev-dev, sizeof(struct dw_spi_pci), GFP_KERNEL);
+	dwpci = devm_kzalloc(&pdev->dev, sizeof(struct dw_spi_pci),
+			GFP_KERNEL);
 	if (!dwpci)
 		return -ENOMEM;
 
-- 
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
