From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH 2/3] spi: core: Update the devm_spi_register_master
 documentation
Date: Fri, 31 Jan 2014 11:23:11 +0100
Message-ID: <1391163792-21819-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1391163792-21819-1-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1391163792-21819-1-git-send-email-maxime.ripard@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

If the devm_spi_register_master function is used together with the
spi_alloc_master as advertised in the documentation, it will either lead to a
memory leak if spi_put_master is removed, or we will try to access an already
freed memory area during the unregistration function.

Advertise that you want to use the devm_spi_alloc_master function in such case.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index eb728ec..dc577b7 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1444,7 +1444,7 @@ static void devm_spi_unregister(struct device *dev, void *res)
 /**
  * dev_spi_register_master - register managed SPI master controller
  * @dev:    device managing SPI master
- * @master: initialized master, originally from spi_alloc_master()
+ * @master: initialized master, originally from devm_spi_alloc_master()
  * Context: can sleep
  *
  * Register a SPI device as with spi_register_master() which will
-- 
1.8.4.2
