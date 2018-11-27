From: Schrempf Frieder <frieder.schrempf@kontron.de>
Subject: [PATCH v6 9/9] MAINTAINERS: Move the Freescale QSPI driver to the SPI
 framework
Date: Tue, 27 Nov 2018 10:24:50 +0000
Message-ID: <1543314174-28580-10-git-send-email-frieder.schrempf@kontron.de>
References: <1543314174-28580-1-git-send-email-frieder.schrempf@kontron.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "david.wolfe@nxp.com" <david.wolfe@nxp.com>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "prabhakar.kushwaha@nxp.com" <prabhakar.kushwaha@nxp.com>,
        "yogeshnarayan.gaur@nxp.com" <yogeshnarayan.gaur@nxp.com>,
        "han.xu@nxp.com" <han.xu@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Schrempf Frieder <frieder.schrempf@kontron.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
To: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1543314174-28580-1-git-send-email-frieder.schrempf@kontron.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The driver was ported to the SPI framework so it can be used as
a generic SPI memory driver and not only for SPI NOR.
Reflect this transition in the MAINTAINERS file.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
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
