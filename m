Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793067220;
	b=Aem9ZVC9MOGrj8hWj/UoebY4DeflNI4QbL1JUXwcJW5B9/eMDCHEYEjPxEvzOBLzMkq6
	 5XWXdq/DekRHNC9PtNox6rf62QaaOBE4fXXH3HT+0e2yYODeVXugvmYjoOiM9HUt32ypK
	 1f976+MSnGkTo9vPXbj0RjJNuuOuXMl3P7CGb+cjqtNzgoOi+2a9vgE5fp1Zsp92mE+Dv
	 Vw/gJe/dSE2+nJzgk/pPhIFj/9cC7LEePi1E747spdrS3lPyVn4dqkrLxZkaZEuv82RcY
	 6XsszmKSL9IIbtxQneJja9Emms2mjmlEFN4zbtjZlUchVn8txbQ53jJ+blAadT5aQNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793067220;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nIdwAIsQM59LO76nrCGAWzZXk8En7EoY7C0IHrefwTE=;
	b=jl+kAvG/Qo1axcto8JYDGXdM5UbN7pQ386cfvMxDZCgvuLclX7BePrnnMgKULcnn402Q
	 rivBhiQAQKlmOGiTnigpS+2I989bf1Px+Pdch/3KB7s9Auq3wLx1cZrcaj6592jfo/qzJ
	 USKNdH6QuSOT8wz726sl+ZhOxBPVtvsy/h0mqBOHte1l/fznHizelMSC3CSSDP5gUUZSv
	 wM/FjFtAqIT5AkAm0Hz+C5r5a1w8kpN87AQwE4sBZm2jvMJJbaKVsYpV684ZKI4IuDMuK
	 pWFMVm320mLrhdBkCMJxj4bT/aY5Ho5eoD5ymAEyzToz6SCM2WOSvyR1QS0Eh7yh7fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=iLpnUKAc;
	arc=none smtp.remote-ip=203.205.221.155
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2D9606A320;
	Tue, 27 Oct 2026 02:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A2D9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=iLpnUKAc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793067216; bh=nIdwAIsQM59LO76nrCGAWzZXk8En7EoY7C0IHrefwTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iLpnUKAc6Nl9+iWcSOU17N0sZ7Jck6BRTxocQKFKSfR7Jn5hNYdiBcY5PhyH13Gbv
	 SFrZ3Z8d171yMggx5x6nLwhxgPC+Ik+YlzLvCD0cgcuiwJItagIj6PKkoPAAwLt0UU
	 v3PUyVxcCBJRnRL90Vyxrp0Cj224Pie+DCKq8ql8=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.198])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 360172E7; Tue, 27 Oct 2026 10:13:32 +0800
X-QQ-mid: xmsmtpt1793067213t3pmy9ua5
Message-ID: <tencent_C5AC7EC2D25D443A8685591EAA290A374905@qq.com>
X-QQ-XMAILINFO: MhLcXbI0hPoHqiEo4mKMST762qErBkgElE0o4gODEmq/bGpLZYicYf8SbGxixu
	 xG1i/b2dlGkgOFi/tDCesgAwy+vwyslAenS46aNz67wnVxendZQQuqbv/LH2UaaU6PXKt7r4775p
	 3pGlrnrlchvG0fpAg+i289QxqK1MF7CJmeaffWCnDbVwuOCfuBas150NFKnu2EGLCZRvdF6bLnRt
	 JrgNxOS3rVDrYlSRmUyFLSvwYFBrygQbfAQAIyFlMxvXZW33cbOTViAPB8p3ig3IHx0GuPljFTxy
	 56GAmCJf0RIdTKVvCeSDbdNOZzx6jI2jL+XabfySSZMdG03EpTOrZq/WpM6770wcp0QDcXXJu2+C
	 Atxfr3uL3WA4WRrRoCUGlsQZ9HqKllhCglbsA4T7VRV1nS2wFRp7AJOzrgub5Lb1iLs2qJbPoZLv
	 iK7cDJnPEjAHtH4zwMsktNTsk3Jy0HBnVLZhxJRh2ZI3brfnMlZQ812u+hfZbWn5EKV0SqULJhEo
	 6U3tiQpJYSUmUb/lDnBoM0Giu0oURd+P23ukJe5ZPAL184iG63x1MlREjxdHHLnpPPh3y08IyQIS
	 djLJ5BiaQC62c0fh75VHMFzCLbUB4edMCCl9b3Mc0wSVZkevluOJabtK7W3ouaX1ONVFk0cVnjJO
	 4Kx525y255s1uHatWNW/Pn6/ozE2/Bl3QgkTqVcmPQFBEXG2aTgDTNJakDAvqVEJDQ+tOQdYpMTU
	 iDlGghK1Qr2aWlQDG1JXcQ/c/KbSkUuizVaIzEelVZSZ3bCBtmsi0q78fUBkWuXphLkio2vuj+NX
	 HKFcgERK42Uq+iFC8zfKZ16XY1r4lVMtZeYifgm6css8QtJw+9Umx8/NqLZjO6kSg00Y+zuVHk/p
	 i/aOdgJhchjc6i2Fe6uxlh9jAiWKGqpINcJJ6U8reSt2l0BdcagBxM9vhHV16sKy6t09e0/XEu6j
	 oNa4byc24XOAFLAAF94qZkPzkVcGttPc01luEBZWn0FVPhjVM43KDwBm/uOfA0ClhuKnFuWFaSx6
	 zSyUm1h0I9BK5HARfkHYf/+Nb49ZQZaukM+yOL1eKPSzL1Fuoy/hXamuMpQ8Zfj3/8CLwDgj13gc
	 Kq/qqfR932qcW0/MVmd3u1WNQoUBNw1mlzBuxOp5q6L0Fg3LI=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: broonie@kernel.org,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH v4 1/3] rust: helpers: add SPI helpers
Date: Tue, 27 Oct 2026 10:13:30 +0800
X-OQ-MSGID: <20261027021332.440224-2-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027021332.440224-1-847807867@qq.com>
References: <20261027021332.440224-1-847807867@qq.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add C helpers for the SPI functions that are `static inline` in C and
therefore cannot be accessed from Rust directly: spi_unregister_driver(),
spi_write() and spi_read().

The helpers are guarded by CONFIG_SPI, since the SPI core functions they
call are not available when SPI support is disabled.

Also include <linux/spi/spi.h> in the bindgen bindings helper, so that
the Rust side can access the SPI data types.

Signed-off-by: Shuai Liu <847807867@qq.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/helpers.c          |  1 +
 rust/helpers/spi.c              | 25 +++++++++++++++++++++++++
 3 files changed, 27 insertions(+)
 create mode 100644 rust/helpers/spi.c

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index c706dda5b5ca..c9062aae959a 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -88,6 +88,7 @@
 #include <linux/security.h>
 #include <linux/serdev.h>
 #include <linux/slab.h>
+#include <linux/spi/spi.h>
 #include <linux/sys_soc.h>
 #include <linux/task_work.h>
 #include <linux/tracepoint.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 9bb850294a2f..6b0f50c12f9c 100644
--- a/rust/helpers/helpers.c
+++ b/rust/helpers/helpers.c
@@ -96,6 +96,7 @@
 #include "serdev.c"
 #include "signal.c"
 #include "slab.c"
+#include "spi.c"
 #include "spinlock.c"
 #include "string.c"
 #include "srcu.c"
diff --git a/rust/helpers/spi.c b/rust/helpers/spi.c
new file mode 100644
index 000000000000..8609d54962c0
--- /dev/null
+++ b/rust/helpers/spi.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/spi/spi.h>
+
+#ifdef CONFIG_SPI
+
+__rust_helper
+void rust_helper_spi_unregister_driver(struct spi_driver *sdrv)
+{
+	spi_unregister_driver(sdrv);
+}
+
+__rust_helper
+int rust_helper_spi_write(struct spi_device *spi, const void *buf, size_t len)
+{
+	return spi_write(spi, buf, len);
+}
+
+__rust_helper
+int rust_helper_spi_read(struct spi_device *spi, void *buf, size_t len)
+{
+	return spi_read(spi, buf, len);
+}
+
+#endif
-- 
2.43.0

