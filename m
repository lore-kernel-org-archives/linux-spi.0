From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: [PATCH 11/11] MAINTAINERS: Move the Freescale QSPI driver to the SPI
 framework
Date: Wed, 30 May 2018 15:14:40 +0200
Message-ID: <1527686082-15142-12-git-send-email-frieder.schrempf@exceet.de>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: yogeshnarayan.gaur@nxp.com,
 Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, richard@nod.at,
 prabhakar.kushwaha@nxp.com, Frieder Schrempf <frieder.schrempf@exceet.de>,
 linux-kernel@vger.kernel.org, marek.vasut@gmail.com, han.xu@nxp.com,
 broonie@kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 miquel.raynal@bootlin.com, fabio.estevam@nxp.com, david.wolfe@nxp.com,
 Andrew Morton <akpm@linux-foundation.org>, computersforpeace@gmail.com,
 dwmw2@infradead.org, "David S. Miller" <davem@davemloft.net>
To: linux-mtd@lists.infradead.org, boris.brezillon@bootlin.com,
 linux-spi@vger.kernel.org
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
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

The driver was ported to the SPI framework so it can be used as
a generic SPI memory driver and not only for SPI NOR.
Reflect this transition in the MAINTAINERS file.

Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9051a9c..22cfc8d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5732,9 +5732,9 @@ F:	Documentation/devicetree/bindings/powerpc/fsl/fman.txt
 
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
