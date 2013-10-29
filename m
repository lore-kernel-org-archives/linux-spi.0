From: David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: [PATCH 2/2] MAINTAINERS: add Intel MID SSP SPI maintainers
Date: Tue, 29 Oct 2013 11:05:50 -0700
Message-ID: <1383069950-27754-2-git-send-email-david.a.cohen@linux.intel.com>
References: <1383069950-27754-1-git-send-email-david.a.cohen@linux.intel.com>
Cc: ning.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1383069950-27754-1-git-send-email-david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2f60504..8574aa2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1916,6 +1916,14 @@ L:	linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
 S:	Maintained
 F:	drivers/gpio/gpio-intel-mid.c
 
+INTEL-MID SSP SPI DRIVER
+M:	Ning Li <ning.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
+M:	David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
+L:	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
+S:	Maintained
+F:	drivers/spi/spi-intel-mid-ssp.c
+F:	include/linux/spi/intel_mid_ssp_spi.h
+
 BTRFS FILE SYSTEM
 M:	Chris Mason <chris.mason-5c4llco8/ftWk0Htik3J/w@public.gmane.org>
 L:	linux-btrfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
-- 
1.8.4.rc3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
