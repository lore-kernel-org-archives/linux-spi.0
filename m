From: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/3] spidev: Add DT binding example.
Date: Tue, 24 Mar 2015 11:50:53 +0100
Message-ID: <bb069283a5c2ccfbc05177f1ed41cabb1485796e.1430034797.git.hramrach@gmail.com>
References: <cover.1430034797.git.hramrach@gmail.com>
Reply-To: hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
  Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
  linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
Return-path: <linux-sunxi+bncBCQMLUOX54MBBGF56KUQKGQEBHR2RIY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
In-Reply-To: <cover.1430034797.git.hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Signed-off-by: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/spi/spidev | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/spi/spidev b/Documentation/spi/spidev
index 3d14035..1fcd42a 100644
--- a/Documentation/spi/spidev
+++ b/Documentation/spi/spidev
@@ -30,6 +30,22 @@ Set up the other device characteristics (bits per word, SPI clocking,
 chipselect polarity, etc) as usual, so you won't always need to override
 them later.
 
+A spidev example for devicetree binding in a board dts file
+&spi2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi2_pins_a>;
+	status = "okay";
+	spi2_0 {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		compatible = "spidev";
+
+		reg = <0>;
+		spi-max-frequency = <50000000>;
+	};
+}
+
 (Sysfs also supports userspace driven binding/unbinding of drivers to
 devices.  That mechanism might be supported here in the future.)
 
-- 
2.1.4
