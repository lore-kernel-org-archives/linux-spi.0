From: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] MAINTAINERS: add xtfpga platform section
Date: Tue, 11 Mar 2014 16:44:51 +0400
Message-ID: <1394541891-26469-4-git-send-email-jcmvbkbc@gmail.com>
References: <1394541891-26469-1-git-send-email-jcmvbkbc@gmail.com>
Cc: Chris Zankel <chris-YvXeqwSYzG2sTnJN9+BGXg@public.gmane.org>, Marc Gauthier <marc-vna1KIf7WgpBDgjK7y7TUQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1394541891-26469-1-git-send-email-jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org

This section will list xtfpga platform-specific drivers.

Signed-off-by: Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c6d0e93..9f75849 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9768,6 +9768,12 @@ L:	linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 S:	Maintained
 F:	drivers/tty/serial/uartlite.c
 
+XTENSA XTFPGA PLATFORM SUPPORT
+M:	Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
+L:	linux-xtensa-PjhNF2WwrV/0Sa2dR60CXw@public.gmane.org
+S:	Maintained
+F:	drivers/spi/spi-xtensa-xtfpga.c
+
 YAM DRIVER FOR AX.25
 M:	Jean-Paul Roubelat <jpr-3OwtVqItl4LYtjvyW6yDsg@public.gmane.org>
 L:	linux-hams-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
-- 
1.8.1.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
