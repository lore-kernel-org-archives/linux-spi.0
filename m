From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] spi: sifive: Remove spi_master_put in
 sifive_spi_remove()
Date: Fri, 22 Feb 2019 05:46:16 +0000
Message-ID: <20190222054616.4523-1-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: kernel-janitors@vger.kernel.org, linux-riscv@lists.infradead.org,
 Wei Yongjun <weiyongjun1@huawei.com>, linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Palmer Dabbelt <palmer@sifive.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>, Yash Shah <yash.shah@sifive.com>
Return-path: <linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-riscv/>
List-Post: <mailto:linux-riscv@lists.infradead.org>
List-Help: <mailto:linux-riscv-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-riscv>,
 <mailto:linux-riscv-request@lists.infradead.org?subject=subscribe>
Sender: "linux-riscv" <linux-riscv-bounces@lists.infradead.org>
Errors-To: linux-riscv-bounces+glpr-linux-riscv=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

The call to spi_master_put() in sifive_spi_remove() is redundant since
the master is registered using devm_spi_register_master() and no
reference hold by using spi_master_get() in sifive_spi_remove().

This is detected by Coccinelle semantic patch.

Fixes: 484a9a68d669 ("spi: sifive: Add driver for the SiFive SPI controller")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/spi/spi-sifive.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index 961307c4a613..ebca3fc4d345 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -424,7 +424,6 @@ static int sifive_spi_remove(struct platform_device *pdev)
 
 	/* Disable all the interrupts just in case */
 	sifive_spi_write(spi, SIFIVE_SPI_REG_IE, 0);
-	spi_master_put(master);
 
 	return 0;
 }
