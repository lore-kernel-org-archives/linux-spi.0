From: Michal Suchanek <hramrach@gmail.com>
Subject: [PATCH 1/2] spi: s3c64xx: print fifo size on probe.
Date: Fri, 24 Jul 2015 17:36:49 +0200
Message-ID: <f2e4f2351691d3060f15d239d6b0998d32950812.1438075797.git.hramrach@gmail.com>
References: <cover.1438075797.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Kukjin Kim <kgene@kernel.org>,
 Krzysztof Kozlowski <k.kozlowski@samsung.com>,
 Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org,
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1438075797.git.hramrach@gmail.com>
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

Printing the FIFO depth does not add much noise in the log and can be useful
for debugging transfer issues.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/spi/spi-s3c64xx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 2a8c513..cd1cfac 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1191,8 +1191,8 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 
 	dev_dbg(&pdev->dev, "Samsung SoC SPI Driver loaded for Bus SPI-%d with %d Slaves attached\n",
 					sdd->port_id, master->num_chipselect);
-	dev_dbg(&pdev->dev, "\tIOmem=[%pR]\tDMA=[Rx-%d, Tx-%d]\n",
-					mem_res,
+	dev_dbg(&pdev->dev, "\tIOmem=[%pR]\tFIFO %dbytes\tDMA=[Rx-%d, Tx-%d]\n",
+					mem_res, (FIFO_LVL_MASK(sdd) >> 1) + 1,
 					sdd->rx_dma.dmach, sdd->tx_dma.dmach);
 
 	return 0;
-- 
2.1.4
