From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH RFC] spi-pl022.c: Make the suspend functions depend on CONFIG_PM_SLEEP.
Date: Wed, 11 Jan 2012 11:08:45 +0530
Message-ID: <1326260325-3644-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-kernel@vger.kernel.org>,
	Shubhrajyoti D <shubhrajyoti@ti.com>
To: <spi-devel-general@lists.sourceforge.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The macro SET_SYSTEM_SLEEP_PM_OPS  depends CONFIG_PM_SLEEP. The patch
defines the suspend and resume functions for CONFIG_PM_SLEEP.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/spi/spi-pl022.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
index 5559b22..4709475 100644
--- a/drivers/spi/spi-pl022.c
+++ b/drivers/spi/spi-pl022.c
@@ -2293,7 +2293,7 @@ pl022_remove(struct amba_device *adev)
 	return 0;
 }
 
-#ifdef CONFIG_SUSPEND
+#ifdef CONFIG_PM_SLEEP
 static int pl022_suspend(struct device *dev)
 {
 	struct pl022 *pl022 = dev_get_drvdata(dev);
-- 
1.7.1
