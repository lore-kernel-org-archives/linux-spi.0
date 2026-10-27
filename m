Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793060417;
	b=TISShcibe8Er3gse6m5I80SCmBvHqce16PeoF4ZoqyC48ueGjNX7Yr7fkmfcCpyAkPce
	 MFYQKNy/ke3Z1KyLnjl6GP9YInbPa+i3wg1UuNVw9YHdsm8Y59oPu+qqH/HdgG6tgWxfx
	 9+DGBJreHc7gMd+Nr+nrLB/Z5cw5ef4AW63br7ZhxrErgWl+G7xefPRDDQw3MDROxo5Mk
	 Wb5j0N11r0G46oxd6XwOtWe9eHmSh9kyrXzwbz7fshsTpqNWgIQXG0AdQDkqwOyLaRET3
	 2ZlQz0eZjTf0CwzsxVRsCxqpSKEr3fh6LpLLe2rx7EDLpoNWrIp4sPd5IUSI3bG1jTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793060417;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UIOLNzeNMeOGOabzPa1El9g7evCOREjpW/YIP8YMHZA=;
	b=T6KbY6IwkuEc5BxRMowMYEC+K63mQx53UWqOiXq5OiWbQSrwLq/Af1kSnf4bSQPPwdQG
	 qC9U/mRbdpwl5WEcM94c5i1iPReYsIAfzBdhzwkitcy/IydvCIy8ypruJ6Wt/8kpsnhib
	 5HWJ9qxIirG9xpWrB2aVkuBm5Ez/r9ivuQrbdJHkFHqC7iBhhaBCkXF9kx/8Nd8sBMbJN
	 NPnEIhiNNkScrAy5ayOOGX8CfkwLEbAGIwNEprJPrtHfI2a5jRu+NTye2LJ2FkkatQHy1
	 Cv8SinlaBZufwu3YuLq2ZiwFjBXq1kAnHy2HI72S2GQDdRnkJY8OO+i2keOsKz5wvQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b="c/Kfz8QQ";
	arc=none smtp.remote-ip=203.205.221.153
Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51FD606A327;
	Tue, 27 Oct 2026 00:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B51FD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=c/Kfz8QQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793060414; bh=UIOLNzeNMeOGOabzPa1El9g7evCOREjpW/YIP8YMHZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c/Kfz8QQ2ZXHpIK6VmRB+UFGFl3/8gfztOQJkrgfk75smQQjiFr6ivVT7ipLuGQWO
	 7WcwSdFcjFlf/ucZvpWIeqBmVZ9kpFnRDToJWoTSYcjZgys7qQSfFDcCHrN5iK2zEq
	 2IUAm/kbN94xmRHGj2QSuMiqLK8K7bRpNuDrmc/M=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id 50815682; Tue, 27 Oct 2026 08:20:08 +0800
X-QQ-mid: xmsmtpt1793060412tks124ui2
Message-ID: <tencent_EC4E2C51F28E4D7CB8E76263133CEE93D208@qq.com>
X-QQ-XMAILINFO: MzFuFcyvqEECJmuNGjjG61Z0IolF3OLUeCBKOVKj38Eim6zJd8/ja4xOoXDiny
	 I8T6dn3vKUBYGxi89ifdFOmkgEPL/UL24Yndmrh/DZ0xR5jRX07RKK+0GcjI9RTWSF2sBqx6npeW
	 R0ivt5S503J8CfEAr3Eyy3bfV8JXBTQRl4huBCJXmi0Tk/zR8qomBx6mOwVFslKWtdcLHysHyfbs
	 MZKJxRD7wQFcX2M76usyYUwU3kS53CWbT2b0cenvhbKM+8LUW4mBjvdg7Hh3g84z5qv++byG7xtn
	 3eEkbwwF7oRZIE70bEa1hXEhdAmbmeH2GuqM+ZrVneO78Yn2z1l53ytHvo8JCMCu8hFzMcpcfGCo
	 0XmSIrzDUknwgrrkMWTkZ+iqdSPlagVxYLDMbRX4gm58PqZ316JT5AetQFA9qvMraduYv7bFY+sB
	 34s8VxmGGvi3xkIpXBaIcURCTqzfhXVb3x6hENMSu5AcwD3+QBI+vVtyRC+LVRvKIOI1GCeAjO3P
	 9cQkx2rOzykp0kO5glkLnLABy5vlFzioIybS6y6F/decZKC3FVfca2el22C/Fu84/oTmRmqcB6r8
	 D8HhQVU5JsKBAGG9+9qZ0P8S0PgwB0W+P/JkWFuY9ZHaWRP25a2cMklAE2hXgaYXJA2q+qL0+szX
	 zO7ZatKylhjDgn3pXOzrK4W3xiwgaxsbNf7iPZBsT7oEr+OU/Db0GAyNhXucND+/XfM7uw/2Il/P
	 bIgSTSJ5JS0R5bypdcN/O6EBZlWcqn0kbgeMqO/yOclZgsG6DNY0Ve5ypgTgwkTUgRMpOnTiYl1P
	 pugz8EvpEEbBaFyZwHGMEVAR9mVYCMyuKGgCAXYdCr3hH1NxfcdkzTQxMdDyZzcs3hhCyBPliYQL
	 giqvyNwIdKrCy5/+htny1brHJczpx5Mq+QqZV5tXmQihJJV02UEleFJVjBotq1/QK04s5Av3i9Gl
	 vC+4z1SN+B7Yq6ygs/j0jmQsGfO0zrxr5fgW+YdNuOOvtYJmkYa9gsBiMqxKgw2lxWgC0gHGNFkL
	 xItaAPdYuGzYz/hffaw66jIBab+DlKfG/7h55SsFebOzFL+bs/d6XVRAHQSnMhSjzvjJYWJ4X67K
	 j48WR40anYcTa1f8d6lOyjIxbxE/lLbReJO7XQc9lc/vwPXCw=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: broonie@kernel.org,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH v3 3/3] samples: rust: add SPI driver sample
Date: Tue, 27 Oct 2026 08:20:07 +0800
X-OQ-MSGID: <20261027002007.303020-4-847807867@qq.com>
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

Add a sample driver for the Rust SPI abstractions to demonstrate their
usage.

Signed-off-by: Shuai Liu <847807867@qq.com>
---
 samples/rust/Kconfig            | 11 ++++++
 samples/rust/Makefile           |  1 +
 samples/rust/rust_driver_spi.rs | 66 +++++++++++++++++++++++++++++++++
 3 files changed, 78 insertions(+)
 create mode 100644 samples/rust/rust_driver_spi.rs

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 31d62533ef25..f99bf52654a1 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -84,6 +84,17 @@ config SAMPLE_RUST_DEBUGFS_SCOPED
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_DRIVER_SPI
+	tristate "SPI Driver"
+	depends on SPI=y
+	help
+	  This option builds the Rust SPI driver sample.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_driver_spi.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_DRIVER_I2C
 	tristate "I2C Driver"
 	depends on I2C=y
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index b986b681cde5..efe04638a990 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_SAMPLE_RUST_DEBUGFS)		+= rust_debugfs.o
 obj-$(CONFIG_SAMPLE_RUST_DEBUGFS_SCOPED)	+= rust_debugfs_scoped.o
 obj-$(CONFIG_SAMPLE_RUST_DMA)			+= rust_dma.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_I2C)		+= rust_driver_i2c.o
+obj-$(CONFIG_SAMPLE_RUST_DRIVER_SPI)		+= rust_driver_spi.o
 obj-$(CONFIG_SAMPLE_RUST_I2C_CLIENT)		+= rust_i2c_client.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PCI)		+= rust_driver_pci.o
 obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
diff --git a/samples/rust/rust_driver_spi.rs b/samples/rust/rust_driver_spi.rs
new file mode 100644
index 000000000000..7eee7b735794
--- /dev/null
+++ b/samples/rust/rust_driver_spi.rs
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust SPI driver sample.
+
+use kernel::{
+    device::Core,
+    of,
+    prelude::*,
+    spi, //
+};
+
+struct SampleDriver;
+
+kernel::spi_device_table! {
+    SPI_TABLE,
+    <SampleDriver as spi::Driver>::IdInfo,
+    [(spi::DeviceId::new(c"rust_driver_spi"), 0)]
+}
+
+kernel::of_device_table! {
+    OF_TABLE,
+    <SampleDriver as spi::Driver>::IdInfo,
+    [(of::DeviceId::new(c"test,rust_driver_spi"), 0)]
+}
+
+impl spi::Driver for SampleDriver {
+    type IdInfo = u32;
+    type Data<'bound> = Self;
+
+    const SPI_ID_TABLE: Option<spi::IdTable<Self::IdInfo>> = Some(&SPI_TABLE);
+    const OF_ID_TABLE: Option<of::IdTable<Self::IdInfo>> = Some(&OF_TABLE);
+
+    fn probe<'bound>(
+        sdev: &'bound spi::SpiDevice<Core<'_>>,
+        info: Option<&'bound Self::IdInfo>,
+    ) -> impl PinInit<Self, Error> + 'bound {
+        let dev = sdev.as_ref();
+
+        dev_info!(dev, "Probe Rust SPI driver sample.\n");
+        dev_info!(dev, "max_speed_hz: {}.\n", sdev.max_speed_hz());
+        dev_info!(dev, "bits_per_word: {}.\n", sdev.bits_per_word());
+        dev_info!(dev, "mode: {:#x}.\n", sdev.mode());
+
+        if let Some(info) = info {
+            dev_info!(dev, "Probed with info: '{}'.\n", info);
+        }
+
+        Ok(Self)
+    }
+
+    fn shutdown<'bound>(sdev: &'bound spi::SpiDevice<Core<'_>>, _this: Pin<&Self>) {
+        dev_info!(sdev.as_ref(), "Shutdown Rust SPI driver sample.\n");
+    }
+
+    fn unbind<'bound>(sdev: &'bound spi::SpiDevice<Core<'_>>, _this: Pin<&Self>) {
+        dev_info!(sdev.as_ref(), "Unbind Rust SPI driver sample.\n");
+    }
+}
+
+kernel::module_spi_driver! {
+    type: SampleDriver,
+    name: "rust_driver_spi",
+    authors: ["Shuai Liu"],
+    description: "Rust SPI driver",
+    license: "GPL v2",
+}
-- 
2.43.0

