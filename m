Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279723CB2D9;
	Tue, 28 Jul 2026 08:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785225917; cv=none; b=lKtv2CY/jVUDsyGN8LsCpUK7zdxRvVGrt2HkGn0nnqMNVMWJSPSm7ZpZrKYwOFuAVdTBSjEfdF9wDxDg6GJIoSNWkGJ9Lm3ZVjWOwmUaQAU4rMK3gll84n48mOigwa6xG27ASv/W8Of7RzEyvcvKEbS4jIWP+bj283l3blt0u/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785225917; c=relaxed/simple;
	bh=HaiQ625Ljeut2k8BGmf/zrDG0K09qrM7SfXiXlbyeu8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=gmXxbByE71caF4GNItdgizkUkMqfPHpopiyIlPMjR0rXtT/h78aoB9HvPGm3NNGLpOQU4f1XghD0t6UXKKdRwnITkQQ+h+oM64K0qrALJMYJ8ITAaSaG+EG3DxgQLKXc66toSzvrQV7svu2O3c8fKvfQVmrUhfOO3zBSVssT2k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ot6yGPvh; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ot6yGPvh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785225905; bh=6CkhQvU7AhKWkI+WdisZ5s6NGaw33xt8r3EKWCWR5X8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ot6yGPvhUxP5JP+5Y1sNWfP3bRQzaJSmcuM0t6jYv3cJ0zfbvd6ugUmZje/bRAnsD
	 XMSMo77XKs7CXGThvxCM5fLYDvBcjx+DhOQp3EZkPXDRqgAE6pBOu3GbJI4mfw08uE
	 8Mwks5yDu6jHVCGf68wA824bqiABYwq4k1JpGb8s=
Received: from ws006419.mbzu.ae ([5.195.0.150])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 12B9D80E; Tue, 28 Jul 2026 16:04:43 +0800
X-QQ-mid: xmsmtpt1785225902tn30x4u1e
Message-ID: <tencent_9A37C7A91DB0EF57A552A99EAC881CD24605@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoe0jkdZScXxa+9aeXz1k+rAII5BXPUdeYpSQLaFdjnvO6zDov9P3
	 izZ547NF1aFT/okEAMzG1Bn1PytdO5C9YFRFkzJ30v0zvTEwazTokOmDryG+LzxBRTm6LkZxlmv2
	 hUsR8Fjspy4GTr45d2LGPzRfeR6NDM3Sc0jEHt5xQEh9mDbsdOZ4Q6Qlfx1yju3FtfthcqvQUvbE
	 +WgtcnzmbjddQbqJq9pNx6sMn4C/WGzmvq9cY20csKz4rwtYuP+FtIq4f/4HZAfhI+xGPS0K/PSx
	 21ll4RRfK+tSRhKEX19/Vy2d4G1/uZNx38LGCp7vEB6y65d1FAmsnEnR7Qt7Xo8BxpkvidQpRTKY
	 UZ0GhNMtH7GRxg5zrQE9W3RYtZqGk1iAXtgluPxiiHi3LRwjM4ny8SSFzW4EgA7a0L0DLW8LnzL2
	 o3KJpQM1tiIjrCTY1wJOPuvKAHNvFcoPYPPxBYkT9wz/ucmkzCXGgNZQEf0Pf2u+q85xqM8Y4siZ
	 NvvO0ii3iZ+hxqcm5gKc4WNurrRzva+LuAWM3Po1e6xSjd2nmt0ibFEe7ApNMyX/dbKnAXDeKeO1
	 0dMFiSsD1AanonBLnU/no3VPJG7aiwtdQhcyqMPqfkIxXxrO5R1lrnrvuOAAXOD3Bts3Ga48J2Fn
	 qigmhODE+21SO7fz/tUCDon6hTzFk+uaeVx6TLZMp1dXJW5VY2P8bVBqsfxnmYruimjAZF+9N8Hc
	 4/cmZTkcsUiQOl4aO6amIRGWJxCdPArIYNTGw8qtTn4j0Vs28W74Qi6t8tt6Hsho8NaXGg/PzbRH
	 m0uLBvAYH+2JpA2z1BGP/AUh76buy/RbT35hvleIVe7Eke6McRdPRrWP2s2Hk6kudyQ/EbcCjC0W
	 2q9QrrmFaA38AqrdkUKIzt6HrnE9DGmANhZkDyNMmT33XX9EjJxlGPgFZYVZTaj8j0aMSjyoMPfV
	 GkhGR52i2zSYVWSY1+HKbOkhinmy3Q01MDx8bTjlS4bfngeaKWWqhiu/kUC8OjoGqGu+5fZMhpjV
	 mMnMwVP06AquDJR8CyK7W+/Dhr4HZPzQUZrSssRM6oGlWPwtqDayrJNe5Mzy6QGzAXRu8r5Pfp8V
	 ntiSI4
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Jiawen Liu <1298662399@qq.com>
To: Han Xu <han.xu@nxp.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Jiawen Liu <1298662399@qq.com>
Subject: [PATCH v2 3/3] spi: nxp-fspi: check runtime PM get in cleanup
Date: Tue, 28 Jul 2026 12:04:43 +0400
X-OQ-MSGID: <20260728080443.153827-4-1298662399@qq.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260728080443.153827-1-1298662399@qq.com>
References: <20260728080443.153827-1-1298662399@qq.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nxp_fspi_cleanup() resumes the device before disabling the controller,
because the cleanup path writes to controller registers. The return value
from the runtime PM get is currently ignored, so a failed resume can be
followed by MMIO access while the controller clock is still gated.

Use PM_RUNTIME_ACQUIRE() and check the acquire result before touching the
registers. If the device cannot be resumed, skip the hardware-disable MMIO
write and continue with the remaining cleanup.

Signed-off-by: Jiawen Liu <1298662399@qq.com>
---
 drivers/spi/spi-nxp-fspi.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 3f1c3ed748eb..2671ffb49096 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1268,14 +1268,21 @@ static const struct spi_controller_mem_caps nxp_fspi_mem_caps_disable_dtr = {
 static void nxp_fspi_cleanup(void *data)
 {
 	struct nxp_fspi *f = data;
+	int ret;
 
-	/* enable clock first since there is register access */
-	pm_runtime_get_sync(f->dev);
+	{
+		/* enable clock first since there is register access */
+		PM_RUNTIME_ACQUIRE(f->dev, pm);
 
-	/* disable the hardware */
-	fspi_writel(f, FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);
+		ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+		if (ret < 0) {
+			dev_warn(f->dev, "Failed to enable clock for cleanup: %d\n", ret);
+		} else {
+			/* disable the hardware */
+			fspi_writel(f, FSPI_MCR0_MDIS, f->iobase + FSPI_MCR0);
+		}
+	}
 
-	pm_runtime_put_noidle(f->dev);
 	nxp_fspi_clk_disable_unprep(f);
 
 	if (f->ahb_addr)
-- 
2.34.1

