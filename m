From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 06/17] spi/mpc52xx: Use kmalloc_array() in mpc52xx_spi_probe()
Date: Fri, 13 Jan 2017 18:14:45 +0100
Message-ID: <eb433c31-35b0-14a6-8ded-6b14ba8752c2@users.sourceforge.net>
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
Date: Fri, 13 Jan 2017 14:06:10 +0100

* A multiplication for the size determination of a memory allocation
  indicated that an array data structure should be processed.
  Thus use the corresponding function "kmalloc_array".

  This issue was detected by using the Coccinelle software.

* Replace the specification of a data type by a pointer dereference
  to make the corresponding size determination a bit safer according to
  the Linux coding style convention.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/spi/spi-mpc52xx.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mpc52xx.c b/drivers/spi/spi-mpc52xx.c
index c36002110c30..8cc129efe7ba 100644
--- a/drivers/spi/spi-mpc52xx.c
+++ b/drivers/spi/spi-mpc52xx.c
@@ -437,8 +437,9 @@ static int mpc52xx_spi_probe(struct platform_device *op)
 	ms->gpio_cs_count = of_gpio_count(op->dev.of_node);
 	if (ms->gpio_cs_count > 0) {
 		master->num_chipselect = ms->gpio_cs_count;
-		ms->gpio_cs = kmalloc(ms->gpio_cs_count * sizeof(unsigned int),
-				GFP_KERNEL);
+		ms->gpio_cs = kmalloc_array(ms->gpio_cs_count,
+					    sizeof(*ms->gpio_cs),
+					    GFP_KERNEL);
 		if (!ms->gpio_cs) {
 			rc = -ENOMEM;
 			goto err_alloc_gpio;
-- 
2.11.0
