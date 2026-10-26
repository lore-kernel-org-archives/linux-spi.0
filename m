Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.211
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009878;
	b=EjSNmL9SQRjJbiWyyg7QHykq3GYku+DvnoE0+isuDk3zfOfntfGNwk4ujDiVL8qWOr9a
	 ZvjmSwk+O3ggP6z2Vf/mGwhIA6tFUYFagi99a6KrP0xYqOjjPJwsSsiJ9iqbTuV+167yQ
	 F6U69Hl6PUEyKrAA33CF1iGP1Q1XP6ad9oa8Qclkxex1A5SuZtXvt7OwEhKfNfw6j+byw
	 con6NnWvFeoYNF3U+AjqhVeEyBvQ1XeB6pZh8K1ZJOyto2LJ6y1JqivJnSq8EnLW0kOxy
	 9SHm3d3IKlSWkhlHgYVcllvRnTYg3ebSJW+l4doOi/Xuau8DBosmZ2EvwFZDA2Jb08Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009878;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nIdwAIsQM59LO76nrCGAWzZXk8En7EoY7C0IHrefwTE=;
	b=DOpzGhHX4Lj6X59VxsVrlM8dlpzzlCWakm+sk9NZUEDhWr0uQKAINbgsqcjRBZaacUvG
	 dalimvTxRdNDLViZOwL3C4EWodIx5y9p0igk4NVjvVR52vFmUNs10RzPJEa5+N4tEyr7G
	 1HkkILhKY0G0E5IFmv5hhEVsyc1OwEHENb626pUcLzEMcWKFd9dKhJ3jpboykZYorQCbp
	 UAHKE47Z/in1QQWSoblgOo4HbiGDYF79ndcdahGJEE82pXuCSx+BLIfDxC88j+UFUJ0f1
	 BpX6qZ63KB8yQChGsyuomtSVf2UtbVI+ZQO2tvtwjsaJOhjIiwQ5OmqtfQJjWjfF+fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=BWwdRF4l;
	arc=none smtp.remote-ip=162.62.58.211
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BB3606A31D;
	Mon, 26 Oct 2026 10:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63BB3606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=BWwdRF4l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793009871; bh=nIdwAIsQM59LO76nrCGAWzZXk8En7EoY7C0IHrefwTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BWwdRF4lkuc2Law2XRnE9yy2PpidXifbZep8M4VpiSnS76T+FJRQ6CsvFdbpSnNyh
	 XstipOxTz7HZ2SJ0NrNzFIR3xpADYCCP7rMxmdNUVEuC3yJnJObELMZJfXMTAsX6JV
	 GK8Rdq2BujHAJdWSXndqBlXWO+rVTPPINWHF03n0=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 46F8F47C; Mon, 26 Oct 2026 18:17:47 +0800
X-QQ-mid: xmsmtpt1793009869tc08rj5jk
Message-ID: <tencent_B38CD8E484847BAF740ACB8E7C5613002E06@qq.com>
X-QQ-XMAILINFO: NRA0BSos0T8khA8ICPBIjwbFkcndRvstyu8419qAvg5VhbU2kmBLx+/CXagEqi
	 6A3tXTuQJahjjs1mEJJduWKI3uuJhGN6aHHRyTLorSRiaWWJMGdnOgJGSh2zEB4LEBS0PZj+MuNN
	 HrrLfZamizZABMP0hoiLfUS7yVTccH5CPrTWu6aed2CvJp94QXBcchqwcAfiqB1UxPXJUAheMAO8
	 i507Q5BTHf/IP0CaYlKrKOmOBHGRCgIe267qIYmKf4uyvHcS7Kv2TOxJbOPqwf4G5YSiDs6PJuYQ
	 9rEmWuH92xo1nLB8nqA+Sserg8TloKy9m+nXjrHZpJMZ96Rvs3WczVHnpQu+tuiHlzqe+UCIBhYd
	 fhC6KdqCZV+Yrl+Ed61U99gc6YgVldjj1yHWITQmxijwnVBPGK345ybIVBhXRsTuFSiWXoAT8Lr2
	 KlrMn8DqoYIeRSMcw2CxV60ofsZZ2FtBCue+k+Be0u5VHTQFV8lxzeEqTdeMav9ELV14YH1+riTC
	 2XtSYcAMPN57yizPNOfrxvkrLksOi5ESyPXQTcw/DNH92kT/xHL6K6ctJlt8uxvaWMLiNOkJSXXH
	 QzhvdyGFotLGMk1H39yLJsVA/a8KSlzPkNbXqo8pMV7TJ4c5YIvt101U7KlrlEKLMgw9npSt+9XE
	 fC932+YrMHSPJHfFCRv4Nm22NVT3A90WqPsPuhEWZpBu0h7WYd1zzommEfqd3FtFE3v6S+ROBs22
	 layxcsO0MV38VSnHiBc8V2IWRC9oParCt05vfyeVEWu96AUqH3gyxE87gfSThDC+6gMk3VctKmJo
	 uGGcyr8BZwXoTgp7XmcHirky/OR8xeD2eCKpiGctY69A4r5jlH/BS1pogyQfmXd08vZp2i7Hscfp
	 KHxUtb1PkEPK5khCZaX4zFmqchxgItpXj3YMpyVMWUsY3lFpRAVxdDkUzK7F/taUaX1J+qd5o252
	 Byeg22daL9kPFJizWqeaRyfCd7ZSgoTJtcvZe6HG3ucoRsqw6WIO/VeN0GJF/IncPfQPYFrZ4kUR
	 2hUHUF4dxQknAFDFvDSxoK+AyTdFuFNy5WvHSvGii/9RjoLJKo3K9QjnB2doxVpxyBSYcb2JMB/w
	 mptCyAEw1S4bnXhaiQnu5mZJhcX56WIHIzK8TJvycNuGevoPuHtvSnjJvy5Q==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: broonie@kernel.org,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH v2 1/3] rust: helpers: add SPI helpers
Date: Mon, 26 Oct 2026 18:17:45 +0800
X-OQ-MSGID: <20261026101747.126903-2-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026101747.126903-1-847807867@qq.com>
References: <20261026101747.126903-1-847807867@qq.com>
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

