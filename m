From: Mingkai Hu <Mingkai.hu@freescale.com>
Subject: [PATCH v3 7/7] DTS: add fsl,spi-quirk-trans-len-limit property
Date: Thu, 30 Sep 2010 16:00:46 +0800
Message-ID: <1285833646-12006-8-git-send-email-Mingkai.hu@freescale.com>
References: <1285833646-12006-1-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-2-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-3-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-4-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-5-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-6-git-send-email-Mingkai.hu@freescale.com>
	<1285833646-12006-7-git-send-email-Mingkai.hu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: grant.likely@secretlab.ca, kumar.gala@freescale.com,
	tie-fei.zang@freescale.com, Mingkai Hu <Mingkai.hu@freescale.com>
To: <linuxppc-dev@ozlabs.org>, <spi-devel-general@lists.sourceforge.net>,
	<linux-mtd@lists.infradead.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1285833646-12006-7-git-send-email-Mingkai.hu@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Mingkai Hu <Mingkai.hu@freescale.com>
---
v3:
 - Add "spi-quirk-trans-len-limit" property to the board's dts.

 Documentation/powerpc/dts-bindings/fsl/spi.txt |    3 +++
 arch/powerpc/boot/dts/mpc8536ds.dts            |    1 +
 arch/powerpc/boot/dts/p4080ds.dts              |    1 +
 3 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/dts-bindings/fsl/spi.txt b/Documentation/powerpc/dts-bindings/fsl/spi.txt
index 777abd7..e1cb84e 100644
--- a/Documentation/powerpc/dts-bindings/fsl/spi.txt
+++ b/Documentation/powerpc/dts-bindings/fsl/spi.txt
@@ -41,6 +41,9 @@ Required properties:
 - interrupts : should contain eSPI interrupt, the device has one interrupt.
 - fsl,espi-num-chipselects : the number of the chipselect signals.
 
+Optional properties:
+- fsl,spi-quirk-trans-len-limit : the max trans length is limited to 0xFFFF.
+
 Example:
 	spi@110000 {
 		#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts b/arch/powerpc/boot/dts/mpc8536ds.dts
index a75c10e..6911c76 100644
--- a/arch/powerpc/boot/dts/mpc8536ds.dts
+++ b/arch/powerpc/boot/dts/mpc8536ds.dts
@@ -116,6 +116,7 @@
 			interrupts = <59 0x2>;
 			interrupt-parent = <&mpic>;
 			fsl,espi-num-chipselects = <4>;
+			fsl,spi-quirk-trans-len-limit;
 
 			flash@0 {
 				#address-cells = <1>;
diff --git a/arch/powerpc/boot/dts/p4080ds.dts b/arch/powerpc/boot/dts/p4080ds.dts
index 5b7fc29..060fc45 100644
--- a/arch/powerpc/boot/dts/p4080ds.dts
+++ b/arch/powerpc/boot/dts/p4080ds.dts
@@ -243,6 +243,7 @@
 			interrupts = <53 0x2>;
 			interrupt-parent = <&mpic>;
 			fsl,espi-num-chipselects = <4>;
+			fsl,spi-quirk-trans-len-limit;
 
 			flash@0 {
 				#address-cells = <1>;
-- 
1.6.4



______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
