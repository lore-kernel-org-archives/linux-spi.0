Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060415;
	b=EBtByNpue1z9WI07H+FwlYALlx8XM0A0JJWCbs6U4H8yUJzFRlFhfKpaoElrSMTA3uUX
	 Mk+8kEK5dggu9M4ZlQcJ6E7LOqJAqvkKae2yr3vbLnT/G6QFB0mpEZwidqMr2mqIXS2hw
	 8m6CBdEV21xlSetVSwwUMK4z3GhzDi5otinpIEpAfuyHnZhsxdWq5NXbAdg1q1rvVB0kX
	 UITw4b/phVU8VbeQXea3TJXOkJI0PHnG5VO7A70dxpnKQDZ/6oJzs89esNhK6xml4IPH1
	 1VQo/if9NlqNpzUNn9n3NkUMk9wAJRtmP4RoZbbP3ov/Kzc+unACcF7h6rjHXvzd20Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060415;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nIdwAIsQM59LO76nrCGAWzZXk8En7EoY7C0IHrefwTE=;
	b=3FKmo0IJR5nHsJe8U5cMfJRWR1k3y8TuGAngWrJteaLY7l1ph0VvNtC4uQDa7Yx8gkn5
	 iY5cweQwJOvNEdd8lCbYhoznU/xZwcWQSjtXwhEZcAT2aK6MdA9zMID1m/TW0PbmXFajB
	 hWJuLgSpPGA3oOsP3IXFTtuM5FpCUKQnkhlR6F9qcV+KhEhL49pJflEMRoYvC3nuwqMgr
	 HtHjRmH7/LE6oZUAceIDskwNKAC/f5FrDQtwCbsN+DNbY/dXi6z5Tp0OQT0tHuRek0VfY
	 uSUsQTH1USzdzFAZvSUqR2U6Tk6AUy1boxFEH9g6a1CDz1azkvvEEs25Nh0KNSeEgdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=xhSNgiu+;
	arc=none smtp.remote-ip=203.205.221.153
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E1C606A31D;
	Tue, 27 Oct 2026 00:20:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2E1C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=xhSNgiu+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793060411; bh=nIdwAIsQM59LO76nrCGAWzZXk8En7EoY7C0IHrefwTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xhSNgiu+hzwVTaNnjsf+x7wGxmU2FCmtyG3papfHMuCh9hxLy59ziyq0E383HR6fi
	 7oKxTAZY9SBjyUwvEu3Dc/vO5vPckmIYNjLkwbuHTfVW8Jox4CzCBTBVTlxC9vXkul
	 R3Olcq9fLFQ2mXYIE7nZ+Iv5C8LAZQAT8pP8e9Lc=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 50815682; Tue, 27 Oct 2026 08:20:08 +0800
X-QQ-mid: xmsmtpt1793060409t0j5bvpyj
Message-ID: <tencent_E4B7D8D204A1BBBF34374B9ABC53D313AE06@qq.com>
X-QQ-XMAILINFO: NHgT31LhP5vD5vaokKW7/UtPUKyGyz5Rdot4bRBv+jL93Tm3MRJrxhKjQwETT4
	 5ok7ArqFgWqVp6CVUKPQ2R8gs3AfiPZjsFsqdHmsLNkvrTh1aryM2SCrsvY3JXZKt0VRs9clSBr1
	 9+OsNhrh2FteE28keE+0WBLMtFzCuW0BdGkWWr2Va4GRI2wFmU0JrOwfzQcoH+zdPrELTtbJKESH
	 VU2O4pnepD3T3mh/aHkdcZ0FSI9+/dhJ4EvJ29HarKE9F08XZ9vMLx3AKUbxczNaHfusVt3SOff7
	 iApTr13dZDIPcqABULjks3/Yx3sOWb7Upa8rc59sqQZb80glb82n4pI7/6TV3rNP5zpW7VhtW2hh
	 X9Kt7cJw1iqKEARcsdYIe0KucnB9eO8dSz5AnSlfpGNACfrGyfZgdaST/joOTnIYBfHijGk1KPP/
	 XayIoeYFkiExEJEk9yg6iXSDiYXKrBl6f+iyCIf3py4AvxfBAhtOpv0c9AYoEZedgfvz2csfwYAo
	 qmbGlaQo9/L1FdM0GfEhF+GvLDnRk4zt4yC/XVO2T2s3sOuaam4A6Ndms2IqaO896Qqkaakf+HLS
	 5w9LSfJij5XIFDtMBGiBLCmdK0IgzB9oSuelyoc0+8LuT3bfSydgQ0+quOWsIgRKcCwHsPJoBYMA
	 4XEQSnuIzBMmwdrfRvaIucoOJ+cShHx70VzfY3bkNx5F+jsSdpg0jYGW7FBF0mVT7XLcaG27YTs2
	 Bgw8OLroHuCS8oTsjSGwb9Ch9mvDPjprC9vRzzQ1qjKS7/k3LPuJ1TOjzVbz/agHwnLMi2TFWbDA
	 AYKk1MjNwPqeJqIbNCrr5mZULUpN21GnIl8uazGIHFYBEWKUVEnKN/CFl15SWZUGsyBY1JwLeUtj
	 zvVmc170pdkedpuO5ZCV+rE9y/LQxF6qhVfZubOKkbwyuCpnrDAlRMV+dqQ0wBmT+9bBqHOIHYUg
	 hgECNKbRnYJNN/Z+wJUvlbntR2DWpi2t13VGmmu0jbqmZo0KY4cZguXgsmMAFLenrOyIun8M/uxk
	 ZwJrtmFJ0ppv+PbKqg91YWO2/pHZ2hZtcVgkfDI6EhTnXO89YYh+MBXYo6a7uekcutylviJS+XUw
	 SeWvSXmf7HEKI6LnmTXHhATWmhHsBXJLDy6NI+FTuezbtU3Hw=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: broonie@kernel.org,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH v3 1/3] rust: helpers: add SPI helpers
Date: Tue, 27 Oct 2026 08:20:05 +0800
X-OQ-MSGID: <20261027002007.303020-2-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261027002007.303020-1-847807867@qq.com>
References: <20261027002007.303020-1-847807867@qq.com>
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

