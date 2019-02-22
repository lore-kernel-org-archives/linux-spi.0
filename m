From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] spi: sifive: Remove redundant dev_err call in
 sifive_spi_probe()
Date: Fri, 22 Feb 2019 05:46:32 +0000
Message-ID: <20190222054632.4610-1-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: kernel-janitors@vger.kernel.org, linux-riscv@lists.infradead.org,
 Wei Yongjun <weiyongjun1@huawei.com>, linux-spi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Palmer Dabbelt <palmer@sifive.com>,
 "Paul Walmsley" <paul.walmsley@sifive.com>
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

There is a error message within devm_ioremap_resource
already, so remove the dev_err call to avoid redundant
error message.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/spi/spi-sifive.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index 961307c4a613..81c5a0363073 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -310,7 +310,6 @@ static int sifive_spi_probe(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	spi->regs = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(spi->regs)) {
-		dev_err(&pdev->dev, "Unable to map IO resources\n");
 		ret = PTR_ERR(spi->regs);
 		goto put_master;
 	}
