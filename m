From: Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH v4 10/10] MAINTAINERS: Move the Freescale QSPI driver to the
 SPI framework
Date: Wed,  7 Nov 2018 15:43:27 +0100
Message-ID: <1541601809-16950-11-git-send-email-frieder.schrempf@kontron.de>
References: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: yogeshnarayan.gaur@nxp.com, Arnd Bergmann <arnd@arndb.de>,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, richard@nod.at,
 prabhakar.kushwaha@nxp.com, Frieder Schrempf <frieder.schrempf@exceet.de>,
 shawnguo@kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
 marek.vasut@gmail.com, han.xu@nxp.com, broonie@kernel.org,
 miquel.raynal@bootlin.com, fabio.estevam@nxp.com, david.wolfe@nxp.com,
 Andrew Morton <akpm@linux-foundation.org>, computersforpeace@gmail.com,
 dwmw2@infradead.org, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
To: linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
 linux-spi@vger.kernel.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1541601809-16950-1-git-send-email-frieder.schrempf@kontron.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@exceet.de>

The driver was ported to the SPI framework so it can be used as
a generic SPI memory driver and not only for SPI NOR.
Reflect this transition in the MAINTAINERS file.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f485597..1ff3c5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5932,9 +5932,9 @@ F:	Documentation/devicetree/bindings/ptp/ptp-qoriq.txt
 
 FREESCALE QUAD SPI DRIVER
 M:	Han Xu <han.xu@nxp.com>
-L:	linux-mtd@lists.infradead.org
+L:	linux-spi@vger.kernel.org
 S:	Maintained
-F:	drivers/mtd/spi-nor/fsl-quadspi.c
+F:	drivers/spi/spi-fsl-qspi.c
 
 FREESCALE QUICC ENGINE LIBRARY
 M:	Qiang Zhao <qiang.zhao@nxp.com>
-- 
2.7.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
