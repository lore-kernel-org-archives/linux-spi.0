From: Colin King <colin.king@canonical.com>
Subject: [PATCH] spi/bcm63xx: fix build warning on printk format specifier
Date: Wed,  2 Dec 2015 14:33:57 +0000
Message-ID: <1449066837-15773-1-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

=46rom: Colin Ian King <colin.king@canonical.com>

=46ix the following build warning when building with clang:

drivers/spi/spi-bcm63xx.c:565:16: warning: format =E2=80=98%x=E2=80=99 =
expects
  argument of type =E2=80=98unsigned int=E2=80=99, but argument 3 has t=
ype
  =E2=80=98resource_size_t {aka long long unsigned int}=E2=80=99 [-Wfor=
mat=3D]
  dev_info(dev, "at 0x%08x (irq %d, FIFOs size %d)\n",

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/spi/spi-bcm63xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 06858e0..8209b60 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -562,8 +562,8 @@ static int bcm63xx_spi_probe(struct platform_device=
 *pdev)
 		goto out_clk_disable;
 	}
=20
-	dev_info(dev, "at 0x%08x (irq %d, FIFOs size %d)\n",
-		 r->start, irq, bs->fifo_size);
+	dev_info(dev, "at %pa (irq %d, FIFOs size %d)\n",
+		 (void *)r->start, irq, bs->fifo_size);
=20
 	return 0;
=20
--=20
2.6.2
