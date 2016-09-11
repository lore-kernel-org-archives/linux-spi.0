From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 14/26] spi: dw-pci: constify local structures
Date: Sun, 11 Sep 2016 15:05:56 +0200
Message-ID: <1473599168-30561-15-git-send-email-Julia.Lawall@lip6.fr>
References: <1473599168-30561-1-git-send-email-Julia.Lawall@lip6.fr>
Cc: joe@perches.com, kernel-janitors@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1473599168-30561-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

For structure types defined in the same file or local header files, find
top-level static structure declarations that have the following
properties:
1. Never reassigned.
2. Address never taken
3. Not passed to a top-level macro call
4. No pointer or array-typed field passed to a function or stored in a
variable.
Declare structures having all of these properties as const.

Done using Coccinelle.
Based on a suggestion by Joe Perches <joe@perches.com>.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
The semantic patch seems too long for a commit log, but is in the cover
letter.

 drivers/spi/spi-dw-pci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index ef7db75..60198a3 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -29,13 +29,13 @@ struct spi_pci_desc {
 	u16	bus_num;
 };
 
-static struct spi_pci_desc spi_pci_mid_desc_1 = {
+static const struct spi_pci_desc spi_pci_mid_desc_1 = {
 	.setup = dw_spi_mid_init,
 	.num_cs = 5,
 	.bus_num = 0,
 };
 
-static struct spi_pci_desc spi_pci_mid_desc_2 = {
+static const struct spi_pci_desc spi_pci_mid_desc_2 = {
 	.setup = dw_spi_mid_init,
 	.num_cs = 2,
 	.bus_num = 1,
