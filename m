From: Bastian Hecht <hechtb-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Subject: [PATCH 4/4] devicetree: Add Renesas SH Mobile MSIOF spi controller
	binding doc
Date: Fri, 21 Sep 2012 13:00:49 +0200
Message-ID: <1348225249-1294-4-git-send-email-hechtb@gmail.com>
References: <1348225249-1294-1-git-send-email-hechtb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1348225249-1294-1-git-send-email-hechtb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Add binding documentation for Renesas' MSIOF SPI controller.

Signed-off-by: Bastian Hecht <hechtb-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/sh-msiof.txt |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/sh-msiof.txt

diff --git a/Documentation/devicetree/bindings/spi/sh-msiof.txt b/Documentation/devicetree/bindings/spi/sh-msiof.txt
new file mode 100644
index 0000000..0d60e04
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/sh-msiof.txt
@@ -0,0 +1,12 @@
+Renesas MSIOF spi controller
+
+Required properties:
+- compatible : 	"renesas,sh-msiof" for SuperH or
+		"renesas,sh-mobile-msiof" for SH Mobile series
+- reg : Offset and length of the register set for the device
+- interrupts : interrupt line used by MSIOF
+
+Optional properties:
+- chip_select  : Chip select, needed if not 0
+- tx_fifo_size : Overrides the default tx fifo size given in words
+- rx_fifo_size : Overrides the default rx fifo size given in words
-- 
1.7.5.4


------------------------------------------------------------------------------
Got visibility?
Most devs has no idea what their production app looks like.
Find out how fast your code is with AppDynamics Lite.
http://ad.doubleclick.net/clk;262219671;13503038;y?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
