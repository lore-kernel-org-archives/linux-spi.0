Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793070255;
	b=DW7xSe4ecYu2HYF0h1x5qGP2tGZBgR6BDLo6PIRG4Lyg6ZQiV4svl4Ucq197NVl7Qi6l
	 NerTVa3VWtEJ9zehZEVfugwt9wlxCNFmAgVW2w5ExNTmgGMtYY+dQbTCuv5cLOWX4yZNz
	 8oCVDQBri6BcsxDTxIf5SNabb7s4xgDJo3scJmhcqE6g2drqYzFf7E2efQ5tVXetRNIqz
	 /QtqjrNZjncdLlkbyO/oc9gotHwL6ZETyzgnoLxmYMXAWTU842L7y27iU0vwdSd3idPAb
	 Bp9NjujMbATOKSXGrLDjvrXhYpsIbYnFKnnrsn40+Zk1umgZKVRFTdO3VmJgF3pI4PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793070255;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nIdwAIsQM59LO76nrCGAWzZXk8En7EoY7C0IHrefwTE=;
	b=0Sh48YgcNaEM3FXa4tWTN1iwRU5z+ZaP8K4e9Eo1SSzIUS6iA0sGheGe7pxyNp7ytCNm
	 tjxrL5BHPmHSF9EK/6/yFnHYGazmkBk8zEKHRsbXB9umPomUv4mQRTrkYQmk0p3Z012f1
	 Qv9r9rct1QldBeaMsLoK8nXdpRgP0B8++8TB+RyeCgR4H4/BhCG11e8wJiNdmTMUKNuds
	 WGbQTi/BVdn13W6/ikwl2DaJriTZ62sMeMEDmkrKtBaJ4jMk8MGbD4cGofJdwHB3uMUAi
	 mB5+qWXGpi+Dt+J90UhePleU6Jx1OgTbepQZQuRhtK5q5Odx483qJPzeWx+nx1gLw5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ZO0M6QWC;
	arc=none smtp.remote-ip=43.163.128.50
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB11D60A2608;
	Tue, 27 Oct 2026 03:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB11D60A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ZO0M6QWC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793070236; bh=nIdwAIsQM59LO76nrCGAWzZXk8En7EoY7C0IHrefwTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZO0M6QWCIMvDOKjxOJ20+5WqDNKuQPX4C04h9NdE9QVrdkpZxx8SFiErIyCR6NgBb
	 oiRWBNQu/UXAPIEM0/XevynCx7h0Jx4dhJCvKNwmyiauQBtG9KCTgbhFX7ZrJUT85S
	 xJK9X5RanmrtxInotfNugdUGw2h0DsLJL7VtFLKc=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id F43C6C8; Tue, 27 Oct 2026 11:03:52 +0800
X-QQ-mid: xmsmtpt1793070234t5xqaxmqb
Message-ID: <tencent_CAA9A4F95858E52B9A2070A9C41426E2DD09@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUA7KqhjeEkmWe6bPED102VKBON/w6cTqeEuOSiND54oD6eTQfc+3
	 XTJlzS08WIM/lo0kJvTCx0RkCsGb/ALEjfcIIcWyZyLimjvcpYfKD3lMiqY6AnscuPvvO1RTWExd
	 Rx5EeufjnKBrtej1Ude8wFWatXpbAy6XMUjQIDjfMFxQJGVEwK1oyu7IZZEiJpbs/syOd6IHywoT
	 +VhHs1IbaoP31LzpBWs2GU8o6MS4zi3Y1FCl0hypH0YuiuovSbfep4AsqHyVz+izIwXuXpR+G6et
	 /Pp/Y6VP2YBfSqWUJCx1vrXwrR0I+FnKoCBXej7resNxIW1e8G+aKe8fYTCMVCnILD6iXZ45U1/f
	 mhbNtzWEgeR34RPiblThVZh+YSHYuxUjrDtlU/bEDyqjBf6reW0zKfSaTl3M8z6rwPqmkh2PJsA8
	 7rK1mAnBgbQAncrihXdwS1JL/zt3+7lWtu7544ER1zibJF7ErbBWch0lU9q/rrxn6QlfOnZMVirO
	 gGGxAeckkvKdM4a1rq2J/Ru5d0jFnhW2rnmOsN9n2rHU31X7YCnzWh+p92uAv/v5m1K1g3t8II6s
	 2pCbZF5vftXJWPYIrC8+BaKCQ7YyxOB0kd8uRZ8GGDBGNdMOl0XSPe6O0mb04m/GR6VPEvE1jVgR
	 3qmhD5lNDGQ13UVvg8CeSBAdq1p/yHhqFOMjb+IwFrl27q4Q3ynHo4ft/HL6DVVTWklzl9nVdSR0
	 7C2dU2acM1F0VS+WFYwSf7vlFiQPasKFwGTwTOjkPpfdNdRkczmgi+AF6/zBKQegtl5O/AEH7I/J
	 O8In7NioYiqMdBNteKcjlg72ubhvYoPNRF/VMHb2wn8f2nZibVOq8EZk7o5JDHxpvOms09birdqx
	 LBItEavPJGkz3L1kZIWwigzUnDtM30P5ZXSgmCGkT9LEiR73zJuPdibSa9+F7m+bm3YWOdeRdBUh
	 MjfXZgNpE5UFfS5x/C/E87SnRn+6MgRN+GYWuoBiY37MTAbO2qSIdMYbcYXcOW4OrInajyzX2bR/
	 NFGgNwVm+b/cOzbQS93wJmfyE3Rz6uTtXVVQoAQSKfqyL4GCdofRue+f8gu5TYBejdlTK8zJxv9f
	 FKN/4WeHrzfcKVjrEPtdjS6incHmOqxzF/WgQrUTZXGbWyh/jSOZZ4TUYRVnNPb3V3zaHTODT6+5
	 1klVg=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: broonie@kernel.org,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH v5 1/3] rust: helpers: add SPI helpers
Date: Tue, 27 Oct 2026 11:03:50 +0800
X-OQ-MSGID: <20261027030352.615926-2-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027030352.615926-1-847807867@qq.com>
References: <20261027030352.615926-1-847807867@qq.com>
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

