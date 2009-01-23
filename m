From: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Subject: [PATCH 4/6] powerpc: Add mmc-spi-slot bindings
Date: Fri, 23 Jan 2009 22:50:37 +0300
Message-ID: <20090123195037.GD21237@oksana.dev.rtsoft.ru>
References: <20090123194958.GA17355@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20090123194958.GA17355-wnGakbxT3iijyJ0x5qLZdcN33GVbZNy3@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The bindings describes a case where MMC/SD/SDIO slot directly connected
to a SPI bus. Such setups are widely used on embedded PowerPC boards.

The patch also adds the mmc-spi-slot entry to the OpenFirmware modalias
table.

Signed-off-by: Anton Vorontsov <avorontsov-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
---
 .../powerpc/dts-bindings/mmc-spi-slot.txt          |   23 ++++++++++++++++++++
 drivers/of/base.c                                  |    1 +
 2 files changed, 24 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/mmc-spi-slot.txt

diff --git a/Documentation/powerpc/dts-bindings/mmc-spi-slot.txt b/Documentation/powerpc/dts-bindings/mmc-spi-slot.txt
new file mode 100644
index 0000000..c39ac28
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/mmc-spi-slot.txt
@@ -0,0 +1,23 @@
+MMC/SD/SDIO slot directly connected to a SPI bus
+
+Required properties:
+- compatible : should be "mmc-spi-slot".
+- reg : should specify SPI address (chip-select number).
+- spi-max-frequency : maximum frequency for this device (Hz).
+- voltage-ranges : two cells are required, first cell specifies minimum
+  slot voltage (mV), second cell specifies maximum slot voltage (mV).
+  Several ranges could be specified.
+- gpios : (optional) may specify GPIOs in this order: Card-Detect GPIO,
+  Write-Protect GPIO.
+
+Example:
+
+	mmc-slot@0 {
+		compatible = "fsl,mpc8323rdb-mmc-slot",
+			     "mmc-spi-slot";
+		reg = <0>;
+		gpios = <&qe_pio_d 14 1
+			 &qe_pio_d 15 0>;
+		voltage-ranges = <3300 3300>;
+		spi-max-frequency = <50000000>;
+	};
diff --git a/drivers/of/base.c b/drivers/of/base.c
index cd17092..41c5dfd 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -446,6 +446,7 @@ struct of_modalias_table {
 };
 static struct of_modalias_table of_modalias_table[] = {
 	{ "fsl,mcu-mpc8349emitx", "mcu-mpc8349emitx" },
+	{ "mmc-spi-slot", "mmc_spi" },
 };
 
 /**
-- 
1.5.6.5


------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
