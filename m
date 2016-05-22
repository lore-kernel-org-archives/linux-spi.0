From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 44/54] MAINTAINERS: Add file patterns for spi device tree bindings
Date: Sun, 22 May 2016 11:06:21 +0200
Message-ID: <1463907991-7916-45-git-send-email-geert@linux-m68k.org>
References: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1463907991-7916-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Submitters of device tree binding documentation may forget to CC
the subsystem maintainer if this is missing.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org
---
Please apply this patch directly if you want to be involved in device
tree binding documentation for your subsystem.
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d81eff6577ff886..f11355314880838b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10804,6 +10804,7 @@ L:	linux-spi@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git
 Q:	http://patchwork.kernel.org/project/spi-devel-general/list/
 S:	Maintained
+F:	Documentation/devicetree/bindings/spi/
 F:	Documentation/spi/
 F:	drivers/spi/
 F:	include/linux/spi/
-- 
1.9.1
