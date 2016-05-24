From: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Subject: [PATCH 3/3] spi: xilinx: Update devicetree bindings for spi-xilinx
Date: Tue, 24 May 2016 14:34:54 +0530
Message-ID: <1464080694-25207-1-git-send-email-nagasure@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Naga
 Sureshkumar Relli <nagasure@xilinx.com>, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
To: <broonie@kernel.org>, <michal.simek@xilinx.com>, <punnaia@xilinx.com>,
 <harinik@xilinx.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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

Update bindings for spi-xilinx.
as per spi-bus.txt rename num-ss-bits to num-cs.
and add fifo-size and bits-per-word properties.

Signed-off-by: Naga Sureshkumar Relli <nagasure@xilinx.com>
---
 Documentation/devicetree/bindings/spi/spi-xilinx.txt | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/spi-xilinx.txt b/Documentation/devicetree/bindings/spi/spi-xilinx.txt
index c7b7856..539bbe9 100644
--- a/Documentation/devicetree/bindings/spi/spi-xilinx.txt
+++ b/Documentation/devicetree/bindings/spi/spi-xilinx.txt
@@ -7,9 +7,11 @@ Required properties:
 - interrupts		: Property with a value describing the interrupt
 			  number.
 - interrupt-parent	: Must be core interrupt controller
+- fifo-size		: Depth of TX/RX Fifos
 
 Optional properties:
-- xlnx,num-ss-bits	: Number of chip selects used.
+- num-cs		: Number of chip selects used.
+- bits-per-word		: Number of bits per word.
 
 Example:
 	axi_quad_spi@41e00000 {
@@ -17,6 +19,8 @@ Example:
 			interrupt-parent = <&intc>;
 			interrupts = <0 31 1>;
 			reg = <0x41e00000 0x10000>;
-			xlnx,num-ss-bits = <0x1>;
+			num-cs = <0x1>;
+			fifo-size = <256>;
+			bits-per-word = <8>;
 	};
 
-- 
2.1.1
