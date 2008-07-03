From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: [PATCH v2 3/5] of-bindings: Add binding
	documentation for SPI busses	and devices
Date: Wed, 02 Jul 2008 19:03:08 -0600
Message-ID: <20080703010308.26187.23037.stgit@trillian.secretlab.ca>
References: <20080703005749.26187.71719.stgit@trillian.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, fabrizio.garetto-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: linuxppc-dev-mnsaURCQ41sdnm+yROfE0A@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080703005749.26187.71719.stgit-8FIgwK2HfyId2tlXD8uQ6/kpB+XfMlBf@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

Add documentation about how to describe SPI busses in the device tree.

Signed-off-by: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
---

 Documentation/powerpc/booting-without-of.txt |   60 ++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index 1d2a772..7d3564f 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -58,6 +58,7 @@ Table of Contents
       o) Xilinx IP cores
       p) Freescale Synchronous Serial Interface
 	  q) USB EHCI controllers
+      t) SPI busses
 
   VII - Marvell Discovery mv64[345]6x System Controller chips
     1) The /system-controller node
@@ -2870,6 +2871,65 @@ platforms are moved over to use the flattened-device-tree model.
 		reg = <0xe8000000 32>;
 	};
 
+    t) SPI (Serial Peripheral Interface) busses
+
+    SPI busses can be described with a node for the SPI master device
+    and a set of child nodes for each SPI slave on the bus.  For this
+    discussion, it is assumed that the system's SPI controller is in
+    SPI master mode.  This binding does not describe SPI controllers
+    in slave mode.
+
+    The SPI master node requires the following properties:
+    - #address-cells  - number of cells required to define a chip select
+			address on the SPI bus.
+    - #size-cells     - should be zero.
+    - compatible      - name of SPI bus controller following generic names
+			recommended practice.
+    No other properties are required in the SPI bus node.  It is assumed
+    that a driver for an SPI bus device will understand that it is an SPI bus.
+    However, the binding does not attempt to define the specific method for
+    assigning chip select numbers.  Since SPI chip select configuration is
+    flexible and non-standardized, it is left out of this binding with the
+    assumption that board specific platform code will be used to manage
+    chip selects.  Individual drivers can define additional properties to
+    support describing the chip select layout.
+
+    SPI slave nodes must be children of the SPI master node and can
+    contain the following properties.
+    - reg             - (required) chip select address of device.
+    - compatible      - (required) name of SPI device following generic names
+			recommended practice
+    - max-speed       - (required) Maximum SPI clocking speed of device in Hz
+    - spi,cpol        - (optional) Device requires inverse clock polarity
+    - spi,cpha        - (optional) Device requires shifted clock phase
+    - linux,modalias  - (optional, Linux specific) Force binding of SPI device
+			to a particular spi_device driver.  Useful for changing
+			driver binding between spidev and a kernel SPI driver.
+
+    SPI example for an MPC5200 SPI bus:
+		spi@f00 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,mpc5200b-spi","fsl,mpc5200-spi";
+			reg = <0xf00 0x20>;
+			interrupts = <2 13 0 2 14 0>;
+			interrupt-parent = <&mpc5200_pic>;
+
+			ethernet-switch@0 {
+				compatible = "micrel,ks8995m";
+				linux,modalias = "ks8995";
+				max-speed = <1000000>;
+				reg = <0>;
+			};
+
+			codec@1 {
+				compatible = "ti,tlv320aic26";
+				max-speed = <100000>;
+				reg = <1>;
+			};
+		};
+
+
 VII - Marvell Discovery mv64[345]6x System Controller chips
 ===========================================================
 


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
