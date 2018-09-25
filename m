From: Hieu Tran Dang <dangtranhieu2012@gmail.com>
Subject: [PATCH 1/2] dt-bindings: spi: fsl-lpspi: Option to allow stalling
Date: Wed, 26 Sep 2018 03:37:00 +0700
Message-ID: <20180925203701.13605-2-dangtranhieu2012@gmail.com>
References: <20180925203701.13605-1-dangtranhieu2012@gmail.com>
Cc: Hieu Tran Dang <dangtranhieu2012@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Gao Pan <pandy.gao@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180925203701.13605-1-dangtranhieu2012@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch add fsl,allow-stalling property documentation for fsl-lpspi

Signed-off-by: Hieu Tran Dang <dangtranhieu2012@gmail.com>
---
 Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
index 4af132606b37..2b012b8cb05e 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-lpspi.txt
@@ -6,6 +6,8 @@ Required properties:
 - reg : address and length of the lpspi master registers
 - interrupts : lpspi interrupt
 - clocks : lpspi clock specifier
+- fsl,allow-stall : allow stalling of transfers when the transmit FIFO is empty
+  or when the receive FIFO is full
 
 Examples:
 
-- 
2.17.1
