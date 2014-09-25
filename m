From: Chao Fu <b44548@freescale.com>
Subject: [PATCH 3/3] Documentation:spi:fsl-dspi:add DSPI tcf transfer support
Date: Thu, 25 Sep 2014 18:24:25 +0800
Message-ID: <1411640665-20671-3-git-send-email-b44548@freescale.com>
References: <1411640665-20671-1-git-send-email-b44548@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: grant.likely@linaro.org, R64188@freescale.com, broonie@kernel.org,
 Chao Fu <b44548@freescale.com>
To: <linux-spi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <shawn.guo@linaro.org>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1411640665-20671-1-git-send-email-b44548@freescale.com>
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

From: Chao Fu <B44548@freescale.com>

Add bool value tcfq-mode or eoq-mode.
The bool will determine DSPI transfer data mode (tcfq or eoq)
in a platform.

Signed-off-by: Chao Fu      <b44548@freescale.com>
---
 Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
index cbbe16e..635387c 100644
--- a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
+++ b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
@@ -10,6 +10,8 @@ Required properties:
 - pinctrl-names: must contain a "default" entry.
 - spi-num-chipselects : the number of the chipselect signals.
 - bus-num : the slave chip chipselect signal number.
+- eoq-mode/tcfq-mode: enable EOQ/TCFQ interrupt to receive data
+	according to different platform.
 
 Optional property:
 - big-endian: If present the dspi device's registers are implemented
@@ -28,6 +30,7 @@ dspi0@4002c000 {
 	clock-names = "dspi";
 	spi-num-chipselects = <5>;
 	bus-num = <0>;
+	eoq-mode;
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_dspi0_1>;
 	big-endian;
-- 
1.8.4
