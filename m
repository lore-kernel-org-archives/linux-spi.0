Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.235
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793079736;
	b=gfDJVHavJg3Tq4/9pvGsFIaxihGWiTpWrQXe2Ras3l1jY1vD35iQ3FSAaDQJgneMsdF/
	 Utibw3S4CxuNTZuh3+s9yzrW5jC3k6H9i93N+YzEgNvMtpZiV9dKzW0leAhUS/N4Lk5/s
	 JQNvh/lUIT8F7a6M0OrwoRGyM/nU7DxK6CR/+iV0NwFARPoI8IqQItAxUo8L/qsMLghAS
	 nOjPc5TCvtyB6neEV5TIZZI3SoOlFIKvSkbwqg8egbH3ilkhmGJ/InEv5Qgj+CDhTEvMG
	 RHd4G5zcGplzcjieHjeo7qh8c6VDFfHpkMKXMZ64I4TxDXiIvInRj620+PnzJXyQHXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793079736;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nIdwAIsQM59LO76nrCGAWzZXk8En7EoY7C0IHrefwTE=;
	b=K6s5eWxJwhg7M8jh1tPKVZEKtZcQUt6GcHG7E5fhrM9yyB/05npsjtG9MP6qUEN+eJFF
	 zW7yZbXuJuwsVE/v8kd4AT5ZHyFfDgZUzLqLGPa8iqWiTOa/tfzZnlyOhSSuLLsPqQ0Y4
	 ce0fDrZ0PS9uLpgIfsoBOSh8JhVQWRCWsZNCxaDzaSLKHyeMEaraDyDFDuKi1UWe5FkFL
	 gfCDRgCUDZ4lSCuEc7uplP9oog77OUud0c0nuccauZn91GB3a1GELC0nm6THooAMgdOrI
	 +1GaBgJgEpjywW7YunAH/FeenqR8zGl5ID3TnN/NX7S3cIIXCXtPMKv2tfQ2uAhenFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=D44jDUJG;
	arc=none smtp.remote-ip=203.205.221.235
Received: from out203-205-221-235.mail.qq.com (out203-205-221-235.mail.qq.com [203.205.221.235])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C241606A31B;
	Tue, 27 Oct 2026 05:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C241606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=D44jDUJG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793079732; bh=nIdwAIsQM59LO76nrCGAWzZXk8En7EoY7C0IHrefwTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D44jDUJGpXYG2IqP2YpF8zkbvInwVxK+a17+F2jXBCu0CBzu/YZ1onZF4gogD5ycD
	 C8oQowAVllUBevSCflKKZjliStqOLCmAaFT8JRLAF6ZX9S0C5MSuuM7hYpLstChc8p
	 ZW7wVxYfomjedLGhUzfxWEaBkoiUO8650E/E1HeE=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.198])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id A89B7814; Tue, 27 Oct 2026 13:42:09 +0800
X-QQ-mid: xmsmtpt1793079731t8ops1vky
Message-ID: <tencent_C9776A6908163E79DFA626DC39B1CC892F07@qq.com>
X-QQ-XMAILINFO: MhLcXbI0hPoHqiEo4mKMST48HUZ+AlFsKE9w5BIaC263RpU6bPwFtrnjQ8sVf9
	 gkPfjhnysmz1j5ZfrZVEKNTGx174AU5rDgY25i+gsIBnJcfwy3UPLiiHVk4dkHTimJEunAIkRv2Q
	 HrCB/8wIQOap9SvcmSDA+SDGQ6mlt95Ls38xpMuNuDDPmSIJop2sWFOk8PRjHI4YskPp9xwUPxnB
	 eorguOZ8FO5eqI5O5Gp1IVCI0ebodHAfo0kfYrv3um0XYUkHGDMajThEAv/Sad7JmYbxV49xODUy
	 FgVQ2490sKFaWlGEQbgcNX414g5Uc+WWTnaonbzXqnk0pg1me92zBXw0Jc/tULcSE3RjVjMz9qUG
	 5xSGPEoIQy8joe/t7jvhvNYXC3BjCKkcYyKdxsK/khuJNcyrtDutl/19B/0QzmToonSD/fZj/Z0U
	 QYJ4XkI7v6heBeM7izsOKFHq1uZIG5Kpi78sjhdv9afC8/TdyR9RBq4/UIROqIlBc2ZV9mpxoRmC
	 wY25xUh7ED4OyaW7fXiWQJQ14FoLT4c644w/FtbSncpTM4LYCc+Z0cySibgOzgmJoc4EY8+p73iL
	 1ytTJwO5QZP9x+ikTC1CDT4FaC42xCVNZNrns4srYvqsdmF/c2IvFLWTL8bPsOY2cLsa1i56MaZV
	 uYCRZ1KvP+wM7LArG+JGjGUxSeMipCrOXc1KrtJhwr+FX17Hp74T5AhqKncLhAYZY4U6uMlhwM3O
	 bCVn6p5w2YHbVXMczMkPOQjP9FxgdHmp3kgK8w91m3vEUkWeu2xnfTh6PqRgH5rH0NcZhb/63c3a
	 PtrywwlF9ARhV0IJ7SjXBVvw/C7QK5zI043R3Pa9y2R/c+6hKbC3wxlrKdMIqxPFuWTckJTF7V+h
	 XwwWpimX8e/VvgCDjkGX0PToGf3Wh20Rw4O3SduwGtHQcHjFyG/JCssB9miK7ldzuMGl5aiBuQiW
	 N67c77h407jDZ+debNmKT0JzOTuQ0rWxuEgGohL66cEa92T99+lWFTM50yoESvjSrdxLnjiIp7Me
	 DZniGRDXotvZ2aeZfsgy3KaNB0d/xh+sbtFEqvzfQKz4gO+72P65Vcyxt83KedjWqFYEF666Y+/J
	 wjFmuulLoZX6kuxkMAyA6iyS8U2IfbQm9RTYwUItgDaT0Oo638Url5JB+I4w==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: broonie@kernel.org,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH v6 1/3] rust: helpers: add SPI helpers
Date: Tue, 27 Oct 2026 13:42:07 +0800
X-OQ-MSGID: <20261027054209.904654-2-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027054209.904654-1-847807867@qq.com>
References: <20261027054209.904654-1-847807867@qq.com>
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

