From: "Manjunathappa, Prakash" <prakash.pm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v5 2/5] spi/davinci: add DT binding documentation
Date: Wed, 3 Apr 2013 19:39:07 +0530
Message-ID: <1364998150-5980-3-git-send-email-prakash.pm@ti.com>
References: <1364998150-5980-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
        <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, <hs-ynQEQJNshbs@public.gmane.org>,
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>,
        <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1364998150-5980-1-git-send-email-prakash.pm-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>

Add binding documentation for spi-davinci module.

[prakash.pm-l0cyMroinI0@public.gmane.org: Follow DT naming convention for compatible property]
Signed-off-by: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Reviewed-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Reviewed-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Signed-off-by: Manjunathappa, Prakash <prakash.pm-l0cyMroinI0@public.gmane.org>
---
Since v3:
Changed the commit message and fixed alignment issues.

 .../devicetree/bindings/spi/spi-davinci.txt        |   51 ++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-davinci.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-davinci.txt b/Documentation/devicetree/bindings/spi/spi-davinci.txt
new file mode 100644
index 0000000..6d0ac8d
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-davinci.txt
@@ -0,0 +1,51 @@
+Davinci SPI controller device bindings
+
+Required properties:
+- #address-cells: number of cells required to define a chip select
+	address on the SPI bus. Should be set to 1.
+- #size-cells: should be zero.
+- compatible:
+	- "ti,dm6441-spi" for SPI used similar to that on DM644x SoC family
+	- "ti,da830-spi" for SPI used similar to that on DA8xx SoC family
+- reg: Offset and length of SPI controller register space
+- num-cs: Number of chip selects
+- ti,davinci-spi-intr-line: interrupt line used to connect the SPI
+	IP to the interrupt controller within the SoC. Possible values
+	are 0 and 1. Manual says one of the two possible interrupt
+	lines can be tied to the interrupt controller. Set this
+	based on a specifc SoC configuration.
+- interrupts: interrupt number mapped to CPU.
+- clocks: spi clk phandle
+
+Example of a NOR flash slave device (n25q032) connected to DaVinci
+SPI controller device over the SPI bus.
+
+spi0:spi@20BF0000 {
+	#address-cells			= <1>;
+	#size-cells			= <0>;
+	compatible			= "ti,dm6446-spi";
+	reg				= <0x20BF0000 0x1000>;
+	num-cs				= <4>;
+	ti,davinci-spi-intr-line	= <0>;
+	interrupts			= <338>;
+	clocks				= <&clkspi>;
+
+	flash: n25q032@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "st,m25p32";
+		spi-max-frequency = <25000000>;
+		reg = <0>;
+
+		partition@0 {
+			label = "u-boot-spl";
+			reg = <0x0 0x80000>;
+			read-only;
+		};
+
+		partition@1 {
+			label = "test";
+			reg = <0x80000 0x380000>;
+		};
+	};
+};
-- 
1.7.4.1
