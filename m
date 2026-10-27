Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793067227;
	b=Ybb5/KLoiLhR3Z0V6Tt0ueNm/nySXiBmPnyn2LY7XAeGMW0vtKMq99yzwOVLpTXxWSYa
	 nVa2PFtt4DkHp8nWsJPZmOgt4IpzgYBCpWVP5RSurseClFUn35nlHOLop/s60BhEAdkCl
	 37NEqyc5+tRyKyAs4GMhLluYyBUW5cnVm0Qms9EUV7JzR9HFgL21bxBykHUC65B/mGRLr
	 6XOf1NlsBi+nkkUBPaUx9e1J+ov/0i2VwZ34YjPQlU4pqCwfCCwddrgSnyMCgqaa7SG0g
	 qlU2qmwq2GrvnOH+fcovztQ4wMq/tNPKoHpAXfflm7jf21Ek3HOC01jUrXCmif+Pxaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793067227;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UIOLNzeNMeOGOabzPa1El9g7evCOREjpW/YIP8YMHZA=;
	b=Z0BXOU4e0vMPxUMG5b2dkqBi1BaUAlSCd5cPjTwAM7irxkje6J2PTgOeuAfDcWYkPg7m
	 UWKa0RCJiyfqYEehHIkn05nUztcMbwIoojKvMue/4VRyCDaQ9GhLhxZO6k3Fda3X2aAxF
	 rGkKxLVDL7ujzg67XkJUh2dI/okgZuHqhIdPZSoCAVdJKPMknWqFDmK3lDeD9QsTD9/T7
	 jSNCWMlUN53n0EkQdH3bRaruwjFFGYo4MMA6R+Ik+l4qjkm/2xyfa6jzVe4ul09eBzJF9
	 CChEMRYT/Qx0V0MDSWL0D6zGYU3ty2+XSKReH8pWBOtt4cU/DcAVYrGUzWrMx7kb0Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=xlkZPDfh;
	arc=none smtp.remote-ip=203.205.221.209
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B06D606A329;
	Tue, 27 Oct 2026 02:13:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B06D606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=xlkZPDfh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793067218; bh=UIOLNzeNMeOGOabzPa1El9g7evCOREjpW/YIP8YMHZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=xlkZPDfhVQOK3h6jZfh4dADxvo6dXo3waT32ChWNaRiuoH5AhZQTd/515n5kYJE1B
	 cACHekJMVcWGmK2Q1nN4E7zVtCQbtXaW5ZByEzDx4BdgPIctzjnBf7EqLmJsycviE4
	 yOpJ0O4NUMnOgoAcYkIcB7LNpemy1otVHO7iqv6g=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.198])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 360172E7; Tue, 27 Oct 2026 10:13:32 +0800
X-QQ-mid: xmsmtpt1793067216tix23e45v
Message-ID: <tencent_946299135DEE36D2492C95F2A44D33B8A408@qq.com>
X-QQ-XMAILINFO: MDbayGdXPuoeVa7Nf8thKLEUHbAA2r1912E3FJJT+drfFaPgLjwVSJPuDkzQTa
	 8d+wNyKsjmKCad3xy1UusKYa20YD221DhsFxf2zd4eI7OIqexIgLtSuv8At3bgSm8gSsBr69SHd3
	 TQgjjnhxYsxvPOyYFtQAMelOuyZrqwUnI2FKXFbvXmJU+lppmTVf2utEka5LRPY4KnGI/i3pghxW
	 Vx1ZNlA+7+jrXCfB4b6E6r6XMOHgasDycj/JcwB84da2gWtksiRPE4p0IirynVqr371vJqu7FGCB
	 K1MGfdkCUERcalt8GT+99S1+DCveuTcX7D+uXZR9L39O1v+Sre6LMOhKWUU5bkZx5mueg7EIngyk
	 ZBfZBAFO6P03IZXliDJD2IyWFt+Mc91PNF8XpYLXHf9xDdzxBt6DA+qeTJVdIs7U7h8J6sUQVhLT
	 l3pZvak4p716oDOKvcz50jqu64uIOXJZtUBFi5R7rZXsBuLePfM3pF1MF9b+TzSfey1C+TwoXeyX
	 hO3wjGmH+vplvWWA8ffBxlJhS2nEnZN4Iko4nlrnM9niBK2qWqE9s8FiC73yEvzkPDi/Lmozdl9M
	 UKqD3FEcU0sw1eScoTPjnsHDUniHQyUJKsZzkXqT7f1E/1E6J1bba7qNQdIqlpKnUbm3jIjHGncT
	 ub76WT9JK6PkmRiUW0PIOkmAsNdCyO433n3J/2V+iwhBf7bzk/R54kMokh4S6dkcA6+PjbLxsuHk
	 r8nA9ahXVc2IqiL/pM8UbUUX0wvf+VlgSZd9fsg1cJDAQLs0EAyljb5wMFcL3DGYpdY1JxOqeyiN
	 qzOCzwEC7SdjiTdX/Q8A77COnYzVSJT+Q8MYAtrNlPWvF2DHPStIz3RHrggQ/oSVLRM6xkxTtkYY
	 hMlxNGw0L6PYfGF2/xwtOAQAPQXQCl/Wek5MTmrVetrtWhmz5Kfzuy0oVxHyBK/tL3A6fOZN8HhQ
	 ZT9F0CfmWQ3Dq9H7ZwQmS/H8AkN2kqmT/YLt56mm6v6Ar7hVgIPzBKSRlUk1GLJ32yhrJRtJlUnt
	 5fX/m7OsI97bLfBU2rCNz3U0QJZd4LjL6gmV2em3Fzyz0agTo0ENiMZVl8u7B4raxBNGfNxVWxUu
	 C9/rZa3inwGvQeyt9j82ofTLfCbUxyKBZXBVjLQBsfTpyP7wkzpX/m4x2vRA==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: broonie@kernel.org,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH v4 3/3] samples: rust: add SPI driver sample
Date: Tue, 27 Oct 2026 10:13:32 +0800
X-OQ-MSGID: <20261027021332.440224-4-847807867@qq.com>
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

