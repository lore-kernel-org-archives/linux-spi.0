Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794536764;
	b=DpxXk7yPwJL/alvOmHQivy56OrjsWWfkoYFhpjCOP3rmwI7dpUrCQmAFl38KYxMrmp4C
	 TFUo1aulvPAYVKvBr9Qm6lq3rrjOsHSXWgZEr+MpyrdiI5t3ZAQhKVLSLAIU9MzbHG1gR
	 2DuqhgkClYuNyaPcNu9FD+vvsafN/LLVK/VXai756UAdYxH9NjdJAue668ixIjXV4RTB2
	 aOuzWA00LtAkmpDrGrZHRyoDnjhWZnH7z9Imjcwv5RU5pVis6xsIyewiTlwu3sUXr4VZx
	 ijna8wmQeuzUCS2Uh3luRynsVY3RC3Hghy8Bp94BN01WMoQzDAL6pCZJvKMCRAA94+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794536764;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ADjBHf/Z79qmaHh9vebe2wTNxsvzvEheUooSYsrIzlk=;
	b=LDktdKMeiRrbevKLpo3yOBXz3ePVAzXo+oxHR0Hh6NiE/4H34QSphCGSqYEWAfYAsp8T
	 s3ukfpk7alkMIuq7DYKTyFJcgPjtNVV3fi7z3t68ZDUIhhWOkn2zJ2voWQeLalG0FwWEY
	 xJ4xA0H/clL5o1dTdUChpkSLVsHyEVQ0leoHIrtORV7matDtc6KGAvh1/zfiNg0bgptBR
	 6iifDz/73n/Kw1euSR+3X9VuO5/z+S50lBAHvY2/woZukP61fPyJP7etDQknlAfelazc8
	 kJkU8vsZvJEUctXMaIZKf2Qt46c3Tc62leohRmjFchMAxinbZHAq0ggLGYLASZGHycg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=yhFdL7lZ;
	arc=none smtp.remote-ip=203.205.221.205
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38C860A260D;
	Fri, 13 Nov 2026 02:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D38C860A260D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=yhFdL7lZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794536754; bh=ADjBHf/Z79qmaHh9vebe2wTNxsvzvEheUooSYsrIzlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yhFdL7lZ20qMZ8eiWjtH/QevxjIrt6kk1cnXC5+4QhGxSXo9C9cyEc3cVP61nsBcq
	 KMGUil4KFPI1BLf69dAb7w5wc0+9qhZeXiPn0O1LvIsnS4xvv3XqHkDfOd3chT2/Pl
	 wpZQn6dRHzFSSfwd2myf45Ets1Hzyj9IKlhaMuxU=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 67422604; Fri, 13 Nov 2026 10:25:52 +0800
X-QQ-mid: xmsmtpt1794536752tzw4b1zvu
Message-ID: <tencent_49DD1BA5EB5812E5DF9A6470C9C44826C809@qq.com>
X-QQ-XMAILINFO: NeLCmDDONCsL4e38iuqP7ZzIVFQM4ST3emajsByrZ8hgmFZzyGvJalsOQvvxSA
	 SVfPhU7sqex9Ts0bH+eHm0j56bvsB+klYKe85WBZ/YL+yVRtKFQ7rWuIYML3SG7UdFJyJOb6jxwM
	 vKj0f7cqSrPDQkywwNBd9AIHIDhios5SO3ScYqPX3nQSNCcuT+3dQuxYc4tD8fJUSqSLt3ggiCmk
	 rGnhOoXu6T9lOh7J5tOBBziRIIB8Eua+8gFb9x6W3mBcPI46LUonMvaQz2YYDFww3a5NF+9wxFVJ
	 I03eVxjJYKGlHsCpwtu1CABw+X+7G33yxXqq29rpa5lbBQoG/Q3guqXuiLCLPms6L4Omo3YwPlXC
	 DMLf/iaHCmiQ2FmvIPf7J//FoFoiRsDG3N2tX+v3yi/cRIoKaE4ppkaRNtzMO6lguqCD2Nh31tbS
	 uX8Vk0v6R+Z8UvOWYJN/IWnkW6tIgRSNc6ITLCHtL+HH9keE7JQA7KuOA8USjIucrXb1Vsuk7go7
	 EgUz77ZrmAzSy3oBZRnQh6ImKwdBN0UUCtS2WqgFUoCK0Ho44x8HjJcPlpT8gwGIjo6h8f3fXOwV
	 Kcr6anJavGlMEozfleQMjdwAssezFPOQ+fbfuBPHopfp6Baxz7emP7yaZFJXv4eMKQpMLGFfYC4s
	 t/w+SootcoV4nmU6h+nzK3c/cq4gQVv9cOjStZW4mJ0nkL65BDJ6Jdy1ns0mIbk+Ye/z7cCGHt/8
	 C0NHKElkbzOt9rut00iOLgJBr7XqnEr0livpqFJ3qrqA1I620UfxAwPZ2FJ7c8rgKgwj22tQNi54
	 OskPFBLo0rAfYiGkE+7JMVaeDu6I5qV7jyjnDgDpnd+feHTzUbbCbqmpFjlRi0A32kFOzaumxNyK
	 96VnpPmMZ21hhdyvd4+Qh4KV/mE40Mq66teudWsknIKp6bzqPRZ27hXs2cetGpBekXKXsUuR/R1K
	 CMK2EWAbqe13i+QQ7O2N2oxkZFjMO2LzhYqZU+SB7dy7JRW6zrF19S/sv8sX5UKgTBf4ljIJue1g
	 9XIpyztPsrIjj+t1cjl2q5yX+bWRzYhk+91jxe5Tnu8Nv1g7wn01PqDzCa52ai8FwHDzNIfXif2h
	 fRFc3fxaZ8SKfauuQTo8oQDqArIgZgq0uSGTtVfD/N4PHcHTL4pVp8NUyAJUtxL990GrwQ
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	847807867@qq.com
Subject: [PATCH v7 1/3] rust: helpers: add SPI helpers
Date: Fri, 13 Nov 2026 10:25:50 +0800
X-OQ-MSGID: <20261113022552.601873-1-847807867@qq.com>
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

