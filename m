Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794536752;
	b=na86H+Itm589EbI0kHDOve+8U5R7szW1xExJkr1X8yzDzTTpnc6iC2JIS4q8ofMgfYRd
	 rMoifhXD4qAwgg75mJJdyheuixfWLD1xLqVZ9zOiQ7sRFdQ6gDPjGIV8qFEjEXCLSGHE6
	 R8hi6Pq/39TZP9fEE80af8d73DdAtYfMwJeMZRPWLkQQABPZt6u0+XAqCadJMrY7+YW4I
	 z17wkoHw9PHOn6FmlemxFqTulyzjBiEKYncpL/v50Wr1N1XrecY6a024D9cR7CL39S0x9
	 jW1HnZVid8BfW/rRfMuFNjV0DXCbj08ASoglnPe82sTz3h6aMw6hiI3nAc40Eh5VXcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794536752;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ADjBHf/Z79qmaHh9vebe2wTNxsvzvEheUooSYsrIzlk=;
	b=omP3lUqGOxNqqq/9LOg+UAZCna6MvSP0DDXX49aDjjr4bL4crPjm1nKa5wc2xl9v0kjS
	 ZL/DmJrdctiqr6akoj+dVjhjtzdVns7qVtwWDGyEdWGd9LL6mN77R4ihHNpfF8wf/ldda
	 04+C6HN1rHVa+4SSIJZU+SsKt7kGV7WjXf2+ett0rlQF0u05N9bQv6fdlcVgtnhS8Pasr
	 ObUEgJX+zaBmPIkG+E+WXIDCeIPVjlUPG6Bp5ZMOm2UpL67qNykJx8DymgPxnID3Teqva
	 dOSYaMFK4fldufMFm2i+biLyrGNTWJfbJElo5Y98fE8SySOZnxG1ymJUJAVowtG7BvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=mQv+6+sb;
	arc=none smtp.remote-ip=203.205.221.173
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com [203.205.221.173])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F1EA606A338;
	Fri, 13 Nov 2026 02:25:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F1EA606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=mQv+6+sb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794536742; bh=ADjBHf/Z79qmaHh9vebe2wTNxsvzvEheUooSYsrIzlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mQv+6+sb+D3GVGollcgA4gVuh07bFFXoA15mBFcN114k1NNeW5ji9EJR1Rntyo538
	 7DO4bIvT9OYMzVWs6j4/CDK0NZp+u/OkZ+p8qwobBHFnI9S7CH4vzNB+cIJBBuKYol
	 hk/r07imBU8J/PjnqRW/02zM9J+5M66gIxmZyLUU=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 667ADE1E; Fri, 13 Nov 2026 10:25:39 +0800
X-QQ-mid: xmsmtpt1794536739tob2yl6zv
Message-ID: <tencent_B6A2CE7D561A81654F1EA4891DF74FCC6C05@qq.com>
X-QQ-XMAILINFO: NinrIUTAGdhbVtYpzGpY2pRQZZhIKhgc1jWHhXwJZjja/shGPqN755VLHoBK/H
	 VaDXfEoigIzIEIMmK/zNyTek7MSB/a8haHWiV94ToDVow4bi1FnTnwcMgd2cZu7YlpHjJV7uzql1
	 STEeb8Fm+BLMPmDxdtYDbccNspQfFWrjgHN3/idoZ4k/0wZd/8sdZGpblWs2wCqQSmcm62tExVer
	 OzVpk+AAVHEe2poTGbK7JkLOzF5Y+KR//1KlkKTjuZ0PQxncRVqIOCTi1bKNP01oTPa7BUZ9T5IL
	 AtwcEYV0L6HavZJvIQfF88H85z/gBwU+ku+mCJMfTAtROTz43S4ZZ7Ckt/S09KVK9Wd8/1B6mVZj
	 zpv7LefZ2XAMkvZWsPUdMkokW8oHSexsw/Nlp1m0ZJwIYBGbEgV9+igl/vgVr2L9uC4g3G7FI4z6
	 N0IlZcilI8PzulYXGQcToxuYCUoXBHbPxYhFcYpyWi+PXGEMLXwjufo632TNqWwmlwBZ8RocZgRb
	 5CsAtx/X2dr/+mjBIWxpkmF4/LUK6lsp5ddGOE0MBz0p+r2W+vuTFvUM3vYs+e5E9m1l8Cl1meMg
	 pt+cAtDQHZ9kIIguixFn50mSWMj47zsanQojNASCzDvYWsyk8oAh2WnaqWW9y2jAO9U5xtW2KajH
	 KshN6E+i8bdUOCQge7UGpDcs0laLIZP70mDecoRtSM2JN/JqbYFhclwi4/NC8DIMrFmRkKxbt5NR
	 X6fHjaq8GeVZXWuFIqakUDjx9JYcsfsJHdOGnFz9OgNYSIrBxmDAOlo1TsOiu4xlOv9/7Cv1RXNU
	 dWzgESr8j51QtHSGeC/+r331UXgqau9cjRscIOminER+EEYDX5oVtzEc9hNrrX+akpejrZbHZIOS
	 OTrBBxKIhFhWp1/IpYRFRAxSOyD0eqbfKvuBcXcnNL7NvAc+pGobpy+4xTaJ7Y3hc5+WiZpCP4mK
	 NE/7flCQ3PpGD8nFIyKY9us17uvOhn5A+LcLbLNzgrS/j8GDJsvXzY8C2Qkxms1zJMhwNPlhMH5F
	 pBjgarxKgXS1RseG+txWctzWOEqR+Hh7z8ULdLxKa7HkM5pUQtWxVErlWsUTsywJ8at4lPyQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	847807867@qq.com
Subject: [PATCH v7 1/3] rust: helpers: add SPI helpers
Date: Fri, 13 Nov 2026 10:25:37 +0800
X-OQ-MSGID: <20261113022539.601421-1-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <tencent_097BA6F40A0B8FBC4C130C6EBF58F8048006@qq.com>
References: <tencent_097BA6F40A0B8FBC4C130C6EBF58F8048006@qq.com>
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
index c706dda5b5ca7..c9062aae959a1 100644
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
index 9bb850294a2f3..6b0f50c12f9ca 100644
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

