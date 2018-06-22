From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH 5/8] hwspinlock: Fix one comment mistake
Date: Fri, 22 Jun 2018 16:09:02 +0800
Message-ID: <215e82a652063b244e0892829a204b3da5a69056.1529654288.git.baolin.wang@linaro.org>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
Cc: baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
To: ohad@wizery.com, bjorn.andersson@linaro.org, broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
In-Reply-To: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
References: <c23ed23d6d355e80401abce6242523f32ce480fd.1529654288.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Fix one comment mistake with correct function names.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/hwspinlock/hwspinlock_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwspinlock/hwspinlock_core.c b/drivers/hwspinlock/hwspinlock_core.c
index ba27465..e16d648 100644
--- a/drivers/hwspinlock/hwspinlock_core.c
+++ b/drivers/hwspinlock/hwspinlock_core.c
@@ -767,7 +767,7 @@ struct hwspinlock *hwspin_lock_request_specific(unsigned int id)
  *
  * This function mark @hwlock as free again.
  * Should only be called with an @hwlock that was retrieved from
- * an earlier call to omap_hwspin_lock_request{_specific}.
+ * an earlier call to hwspin_lock_request{_specific}.
  *
  * Should be called from a process context (might sleep)
  *
-- 
1.7.9.5
