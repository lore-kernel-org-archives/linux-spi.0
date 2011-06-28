From: Peter Korsgaard <jacmet@sunsite.dk>
Subject: [PATCH 3/5] mach-gta2: remove unused spi-gpio.h include
Date: Tue, 28 Jun 2011 14:49:15 +0200
Message-ID: <1309265357-15879-4-git-send-email-jacmet@sunsite.dk>
References: <1309265357-15879-1-git-send-email-jacmet@sunsite.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Peter Korsgaard <jacmet@sunsite.dk>
To: ben-linux@fluff.org, grant.likely@secretlab.ca,
	linux-arm-kernel@lists.infradead.org,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1309265357-15879-1-git-send-email-jacmet@sunsite.dk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Not needed, and the file is going away.

Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
---
 arch/arm/mach-s3c2440/mach-gta02.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c2440/mach-gta02.c b/arch/arm/mach-s3c2440/mach-gta02.c
index 7166620..c10ddf4 100644
--- a/arch/arm/mach-s3c2440/mach-gta02.c
+++ b/arch/arm/mach-s3c2440/mach-gta02.c
@@ -74,7 +74,6 @@
 #include <mach/fb.h>
 
 #include <mach/spi.h>
-#include <mach/spi-gpio.h>
 #include <plat/usb-control.h>
 #include <mach/regs-mem.h>
 #include <mach/hardware.h>
-- 
1.7.5.4
