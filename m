From: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 2/3] spi/xtensa-xtfpga: add DT binding documentation
Date: Wed, 12 Mar 2014 16:21:04 +0400
Message-ID: <1394626865-15105-3-git-send-email-jcmvbkbc@gmail.com>
References: <1394626865-15105-1-git-send-email-jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, Marc Gauthier <marc-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1394626865-15105-1-git-send-email-jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/devicetree/bindings/spi/spi-xtensa-xtfpga.txt | 9 +++++++++
 1 file changed, 9 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-xtensa-xtfpga.txt

diff --git a/Documentation/devicetree/bindings/spi/spi-xtensa-xtfpga.txt b/Documentation/devicetree/bindings/spi/spi-xtensa-xtfpga.txt
new file mode 100644
index 0000000..b6ebe2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/spi/spi-xtensa-xtfpga.txt
@@ -0,0 +1,9 @@
+Cadence Xtensa XTFPGA platform SPI controller.
+
+This simple SPI master controller is built into xtfpga bitstreams and is used
+to control daughterboard audio codec.
+
+Required properties:
+- compatible: should be "cdns,xtfpga-spi".
+- reg: physical base address of the controller and length of memory mapped
+  region.
-- 
1.8.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
