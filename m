From: Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH 2/2] spi: pxa2xx: use a module softdep for dw_dmac
Date: Wed, 10 Apr 2019 14:51:36 +0200
Message-ID: <1554900696-28858-2-git-send-email-f.suligoi@asem.it>
References: <1554900696-28858-1-git-send-email-f.suligoi@asem.it>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Flavio Suligoi <f.suligoi@asem.it>
To: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554900696-28858-1-git-send-email-f.suligoi@asem.it>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

With dw_dmac, sometimes the request of a DMA channel fails because
the DMA driver is not ready, so an explicit dependency request
is necessary.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/spi/spi-pxa2xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index c9560a1..e8ac26b 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1962,3 +1962,5 @@ static void __exit pxa2xx_spi_exit(void)
 	platform_driver_unregister(&driver);
 }
 module_exit(pxa2xx_spi_exit);
+
+MODULE_SOFTDEP("pre: dw_dmac");
-- 
2.7.4
