From: Girish Mahadevan <girishm@codeaurora.org>
Subject: [PATCH 1/2] dt-bindings: spi: Qualcomm Quad SPI(QSPI) documentation
Date: Thu,  5 Jul 2018 15:46:41 -0600
Message-ID: <1530827202-9997-1-git-send-email-girishm@codeaurora.org>
Cc: Girish Mahadevan <girishm@codeaurora.org>, dianders@chromium.org,
        swboyd@chromium.org, sdharia@codeaurora.org,
        kramasub@codeaurora.org, linux-arm-msm@vger.kernel.org
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Girish Mahadevan <girishm@codeaurora.org>
---
 .../devicetree/bindings/spi/qcom,spi-qcom-qspi.txt | 36 ++++++++++++++++++++++
 err.txt                                            | 27 ----------------
 2 files changed, 36 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
 delete mode 100644 err.txt

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
new file mode 100644
index 0000000..3baa893
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qcom-qspi.txt
@@ -0,0 +1,36 @@
+QTI [Qualcomm Technologies Inc] Quad Serial Peripheral Interface (QSPI)
+
+QSPI [Quad Serial Peripheral Interface] allows single dual and quad read/write
+access to slaves. QTI's QSPI controller implements the QSPI protocol to interface
+with slaves like NOR Flash devices.
+
+Required properties:
+- compatible:	Should contain:
+		"qcom,qspi-v1"
+- reg:		Contains the base register location and length
+- interrupts:	Interrupt number used by the controller.
+- clocks:	Contains the core and AHB clock names.
+- clock-names:	"core" for core clock and "iface" for AHB clock.
+- spi-max-frequency:	Maximum SPI core clock frequency in Hz.
+
+SPI slave nodes must be children of the SPI master node and can contain
+properties described in Documentation/devicetree/bindings/spi/spi-bus.txt
+
+Example:
+
+	qspi: qspi@7418000 {
+		compatible = "qcom,qspi-v1";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		reg = <0x7418000 0x600>;
+		interrupts = <0 459 0>;
+		clock-names = "iface", "core";
+		clocks = <&clock_gcc clk_gcc_qspi_ahb_clk>,
+			 <&clock_gcc clk_gcc_qspi_ser_clk>;
+
+		device@0 {
+			compatible = "dummy_device";
+			reg = <x>; /* CS for the device */
+			spi-max-frequency = <f>; /* Max supported frequency of the slave (Hz) */
+		};
+	};
diff --git a/err.txt b/err.txt
deleted file mode 100644
index 09000e4..0000000
--- a/err.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-Skipping hidl generation
-arch/arm64/Makefile:23: ld does not support --fix-cortex-a53-843419; kernel may be susceptible to erratum
-arch/arm64/Makefile:44: Detected assembler with broken .inst; disassembly will be unreliable
-  CHK     include/config/kernel.release
-  CHK     include/generated/uapi/linux/version.h
-  CHK     include/generated/utsrelease.h
-  CHK     include/generated/bounds.h
-  CHK     include/generated/timeconst.h
-  CHK     include/generated/asm-offsets.h
-  CALL    scripts/checksyscalls.sh
-  CHK     scripts/mod/devicetable-offsets.h
-  CHK     include/generated/compile.h
-  CHK     kernel/config_data.h
-  CC      drivers/mtd/devices/m25p80.o
-  AR      drivers/mtd/devices/built-in.o
-  AR      drivers/mtd/built-in.o
-  CC      drivers/spi/spi-mem.o
-drivers/spi/spi-mem.c:12:23: fatal error: internals.h: No such file or directory
- #include "internals.h"
-                       ^
-compilation terminated.
-make[2]: *** [drivers/spi/spi-mem.o] Error 1
-make[1]: *** [drivers/spi] Error 2
-make: *** [drivers] Error 2
-
-[0;31m#### failed to build some targets (12 seconds) ####[00m
-
-- 
1.9.1
