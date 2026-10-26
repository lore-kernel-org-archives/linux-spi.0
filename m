Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792996156;
	b=Vf2Zr6VhcmCeoeOXyBLk/GCjAj71veK9GU9FRpgOJQvaJAoS6WM2hWZI1F1IfI/Bijku
	 fRwdeoyyZNoCOFq1k8giUl7PThdVY5LEi+vPGToXpJ71e8LPrE06PXQ0sHubDo2xFHR4Z
	 3tXnRDOPsYLv6L0RXUyO1PdHrC0yIeA3PYXlevaDY7/FgmUKJYOYwtgFwVS7PJqkLBIeX
	 13XgVWG+6F2Ny873cMkyUVau0cv6UymGtbp9kSNuiATLZMKEe8K0L5uWC67AwN4kfW8Ec
	 PnvRIg0vTv1nj3fW5WzxINP0RJ0SvVQ05Zo2fNAlkTLzT+arY8VijZrjDxMEZ8xENNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792996156;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YJ9sOA8Nsg+qQDQcZZMvUJPFoEFL6QU2tHu4ECQIv8I=;
	b=cj/E+CcYYqY8k1zbHUNIeRRj+throBWcYGIQae4/i4VbyuZl8nzizWZj4hKVSpzGhhZe
	 aSyImjgMesOlhbzq6TbGK4dPvIaKeCvPH2msbIn9Uyw4oxEAxs80Ih96E+aBsEVovxHZn
	 1FXRfq446rxywZF1si7fxNpAg2epF3jxNNNR8N107xGQ9BZ2m42ITJlVvC6x051s6XfQB
	 m/gnXZktjlhLwxzp8wTNnRhPWCBwZKLSzRiYbE4Ip52ZDxfByrySAP6ZcelsqEmTdSqYE
	 Qz0XvZhSR3pxo+VnkCg88QgI8mssQrm36ECXb0F7dSsxV3sgNunl6ZQp34JByTPT0RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=mxjvjLyt;
	arc=none smtp.remote-ip=162.62.57.137
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAA4606A31A;
	Mon, 26 Oct 2026 06:29:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EAA4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=mxjvjLyt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792996150; bh=YJ9sOA8Nsg+qQDQcZZMvUJPFoEFL6QU2tHu4ECQIv8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mxjvjLytfzN0jaR02gykYvBxqfIH00MHreRNas5i6qLBcyo6sRTzDfaSbMmCLwhb2
	 HRJHeCf3q/7YKo0C0wNXAnHONhFNxh5I3M3Ac8ss8/XkyexFeUCME9VD4F/KClcLp/
	 v0IKO71JUu9W7YOEGNJI5jlizILqLo36PJ5nAo1c=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 74605611; Mon, 26 Oct 2026 14:29:06 +0800
X-QQ-mid: xmsmtpt1792996147t36cfnsjz
Message-ID: <tencent_9684B27B83743A8B8ABC689311AE9158D306@qq.com>
X-QQ-XMAILINFO: MtaEuttEGLYblNaLB9ioDuFazilhAIjJoWMJUMmFi7Gn7VG+59xPUOh9n7baAO
	 WbmGazdpaxxmmPkPYBYkmgb8T1RMX/+Hlo80kZ4BVCrvkJjMr2aizLgVEOpNs2qG61al8AyL43EZ
	 0lklIDzk6p11jA9hX50YMhqu5FmpkBRi2Y1hVCv5kEzGcPHwIg2OJn5nattUp9urAVTxtg55vWZ9
	 2rOJ5yfpRfPp5VDG24mBgAbCuoOCM8gboK+56oQWYQSjnL9/GSU+SkpcZkkpbdGaxjn03gECPgMO
	 XdZ720YlDEPcznWpk6GFfxzPTE1Vqf2kzjR6WYV3tXsyDyZlpchrVi1s0bp+RudGHlzHvFLsKDEb
	 SNHY+Il2YKtPKhhBGrhn0H2ybV+odST6jF8tniFFuLZs7RPrwDrRuj91ugsdQV1FKJ7Cjpg7XgAt
	 qHXtqTu/toc+5EygsVvbauacGoMKwNPge+Zc32I/ReXk4fqmxC2Cl2sF6OEZjxr/pH7EhJochehQ
	 KKw7sHjNpa98OCapljsr+l8GkBNcYvkYusHyX+jWYwaTUd5ZWTWp5cqXBd/UHGnM7AG7AXmS1xR5
	 W7mh/U5JTng7SX1Ky7ixSw0Hk+g1eur/uocftf25bdMXbe46OytlSiCHlVon8bcTuxmi5R/KNBka
	 m5ct0ze+LHy3IfPLjlBs79wbADhNaBypRhVOqTL0opx5BOpPt2B0i8fxjgzWvFNi4rukYnzO/yt9
	 FIeTEtLJ32OuHsEXvXGxPxUgf8fZI2nAyJjIvwMm5XDI0qv13HdvzAwYKwVWgHe9l2webtPp2Jua
	 8ddsj7uYUYj5n5gOcD4bE/1VVjntlfg6LXcsG2otCuDqS0VvA5XBJAs3pb0gvvf9hWCZyvNBcWsS
	 BCW256A3nWm8MR3RrOE7h5QoakSObU+BP6+VCaNlK5El1xP3G/aHIqjKBCJlA1Qicid8NPhnohQk
	 QIbf0mREQ25531jTKmWhfuj0kAeNhWUUYSNvEaOPaa/6ZuNPGYyrMUmxWSChGlnWhB9vj3Oe6HEd
	 GrSSsJe3raCw/xwV/AZuntCiCWgXXfiXwBy9msrKZ34dSOtJIUEXb8bN9ACfGM9l5OZXyReiWqEE
	 Oqv1reg+9AF+QAPiD+1UIMODvvTpzeD1S+yjF+OD6Zt5dLlj6ldy/qseo8TaqbZjcULim0GXpt7G
	 40qvM=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: broonie@kernel.org,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH 1/3] rust: helpers: add SPI helpers
Date: Mon, 26 Oct 2026 14:29:03 +0800
X-OQ-MSGID: <20261026062905.6570-2-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026062905.6570-1-847807867@qq.com>
References: <20261026062905.6570-1-847807867@qq.com>
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

Also include <linux/spi/spi.h> in the bindgen bindings helper, so that
the Rust side can access the SPI data types.

Signed-off-by: Shuai Liu <847807867@qq.com>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers/helpers.c          |  1 +
 rust/helpers/spi.c              | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+)
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
index 000000000000..5046ddd1a2a9
--- /dev/null
+++ b/rust/helpers/spi.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/spi/spi.h>
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
-- 
2.43.0

