Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794618480;
	b=Hu013kU5tjG6OxK/+wA2Pfm8pbFQBeEJNT3RA+3Lhwb5sLv8LgeOanNX5gm90AgEeVE9
	 OnID9/ZNk4Y6wZOL9nKsF2mS6cREFbrAJF+V982x2q/gIivc3HLRdl2obt8stv+eP6LeO
	 olynZUakuulKxGopNUJK5R4RV2nESoLibQLI/5y38s9SwySvobrs9QJL4Nt05wbfcXBez
	 jMYm5cl3POrUpAar58iZRYHmOucLQWHPF05IXg2t7UT1UkbtD2PKgy1klYrsuVLTkzpfH
	 gM2k3dbQMcLM8nlBCU+ydY2jGnUGb+SvyOtTmmMt7+0hRwwlxbJI3BNHAo69+qYv7ZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794618480;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rxRAgEE86SlLwK3IX5Xy1zhn3BrMGyKGzawkBpoWNRs=;
	b=tn4/IllWrsFRhX5LU1wCdF67IU9DTk5h+AMitO4KVwHDros/hDbCXPHJeB1T4/cON9Ul
	 LttI296JDklstXJ+jgqFnwHhBdlycToYFAmJfH3+sr8h0yTFvd/XLhwVMylwLJHgznkRz
	 WUaIj3Oa/3mEZLl0rz3TQ5IgkEoxS/v8Q7fjtj08fy5+t58pTtUTAdvQR7XMoNvegqujP
	 RAau1P/L7BiPUKz1ECdi5bM+dSK0A5p3gjJ1YsyHC41DrD0d2aFTVIwicUSxnBmoAPW6e
	 aE8rV2+soAOIsyjTCF8W/MfLBkcAFqVgfKPiDiKYXXnj7JhN8ffVlwRCO3S8sP2AwHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Wpw3RENQ;
	arc=none smtp.remote-ip=162.62.57.49
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39210606A889;
	Sat, 14 Nov 2026 01:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39210606A889
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Wpw3RENQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794618468; bh=rxRAgEE86SlLwK3IX5Xy1zhn3BrMGyKGzawkBpoWNRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wpw3RENQU/oNTtgbEnuzV5TYSlIFCGaCDP1uPiZYH3DWOiD0/dxqm8FTpLLAm4VpB
	 5ALcvSmjEzbRoaejTBVF7EkinYtncqbaRl/+pTmv6gygoF/Vd3nYj9Ev6XxMf6v6hq
	 jyJu7H+VWYTIPTKFYxttKbZtb+vOyhNe9mldF9Gs=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.198])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 1EE0C051; Sat, 14 Nov 2026 09:07:46 +0800
X-QQ-mid: xmsmtpt1794618466t24zrybg4
Message-ID: <tencent_848DC4EA263ADC71A4F3580EE4AB9A687009@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9XbXZ2D+oNSNEDFiFEBNtznNLdbW2ql85pn2kYASdqvpeuK1zqMk
	 07l7u0GUg1fv5BK32iCsw3oFkXmK3MayLE2w66qmfMCWiqzM5bJx1vo9XJJ+qMw+1IlkyNwiB0MP
	 M8EotzxykXm94SjwNa6YtgK08Ny3lIabuL2bajikuKCO0NkHMGGURRJyNo7eEhvNPbW5H6dqbLYq
	 mmNNNbYSfo6RM5XmBi0AHMyv31HKyRewFu0ZeSJshMUmzlTOGrTSJJY0+mcfuVpbWcnVoQiUBRJ2
	 UT9yX4bIFKbGLl65Kon1rAmjYFxTKw/pc661yal9hT7EKpwihG9X+KZWe/I7lHuroIKlSaVdr8qf
	 De9z6/TEfGPIhdpAwbTBy/qWHNCWUNridkNXiUJvgBC9b9Rn36rjgipqvWcwaNptkGxyEIqanOV8
	 w6vrHwZVx1CjOMPR3941ix92uQhRsiBfPPRFmkGngxIWzvFbB3kd8gRgdZeLrwxz10yhyvGMQlx4
	 vHNd59H335TXJBOUnNCsSHkqoADNLRxpETRIgWw23OPxEv+aGkvest6BZhnerLFoEwMdGPUpYByF
	 LvuLycRRiSWpO99KbDSChfEEIXgHMdqREXPSs+hrh2HToSS24gRWNUjvX32dtLbg79zy9nkWaMUU
	 SwKvteXJiOT7FEPMKKcrGndVZcTe9FoL/grUxJfthzt1/BExO4qC3fV75Y4Yw3cR1HxU5VpT8n4P
	 1HmeiD2pcxc793MdWqVzFr8V20gA/TPAl+czQZeNqYUWYZ/HVAdo4V2OZ3FPTRaUNNOogrWSLHPn
	 qK86kjI6+V8mdGWQ7fSV5aoTwdMi4pWm5bQNQfAS0yg4bRFMRudlhhMCWr4etGZQG7EL369MOf+U
	 dvZ3sFAHRoTxjgCyza2QWaoFMVaATherWapOpRSHFBP4azD4HA8y6GNHX9sHjShnTgfbAgHCwWaC
	 DFk0u+D1143Y0Q/W0IERjOTPjbprSVptDfP6rQ2HCEf07TzLHg9PyQPXXrffy1liEVpLOXRH+wNM
	 CYffV6vul3W+UbSm2iHqaGLj1v4WP1d78YIjgd4SMJwhxjoUtXUGhRrosMV2NE4rWbz97iBZUh9q
	 FQh1yH
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	847807867@qq.com
Subject: [PATCH v8 1/3] rust: helpers: add SPI helpers
Date: Sat, 14 Nov 2026 09:07:43 +0800
X-OQ-MSGID: <20261114010745.82389-1-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_5FBF490F375F4C66A2C8DD421A8E8542FE05@qq.com>
References: <tencent_5FBF490F375F4C66A2C8DD421A8E8542FE05@qq.com>
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
 rust/helpers/spi.c              | 26 ++++++++++++++++++++++++++
 3 files changed, 28 insertions(+)
 create mode 100644 rust/helpers/spi.c

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index cc41dc9467577..faa4149682fc2 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -89,6 +89,7 @@
 #include <linux/security.h>
 #include <linux/serdev.h>
 #include <linux/slab.h>
+#include <linux/spi/spi.h>
 #include <linux/sys_soc.h>
 #include <linux/task_work.h>
 #include <linux/tracepoint.h>
diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
index 787dd8ff8c6c8..0f854e051415a 100644
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
index 0000000000000..179a90e014e04
--- /dev/null
+++ b/rust/helpers/spi.c
@@ -0,0 +1,26 @@
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
+void rust_helper_spi_message_init(struct spi_message *msg)
+{
+	spi_message_init(msg);
+}
+
+__rust_helper
+void rust_helper_spi_message_add_tail(struct spi_transfer *t,
+				      struct spi_message *msg)
+{
+	spi_message_add_tail(t, msg);
+}
+
+#endif
-- 
2.43.0

