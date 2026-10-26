Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793009880;
	b=pdZuOqwNvMnA7vhHPvfyHRLd9q89tKlt1y6RDPSx0K73OqDmdeT9r8u2sl2kxnOjGiHs
	 vvS64E5Mv65CZEtP4usM9tUv7L8KR6VsZg9tFFFQGHGHqvbqwpXfEq7s7CKvkiW4209nf
	 ixaH19rhbo21K6FuysoAgZKuU6uy85UuNhjLbO7TEEvjhAOgkVBdvBPOBPL4WElHpwQdc
	 ezbKT/kQmRaEsMDDIVoxn/mt/FFyQdgqd19DF0gqdKKhY3o6wQNeurE5OIjg9wHvHr02c
	 II5Lo5St2r7tVvFS+/jqkP1zLz0wt1CGJhjWbf673kHIPsuurJwWfQOcDUjP9EA2AiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793009880;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UIOLNzeNMeOGOabzPa1El9g7evCOREjpW/YIP8YMHZA=;
	b=L1bD1B4tAfQetTNb3RenoFfrnh5D3bHJeQWHvDg2XMxePb9h3/F2YfVFkycVVHdnNAke
	 QIzNYo/a2qeAFYOrlSU4I0yvAAspA8n5Sw8SUsO8xpKFu33MoO1bvUlABxlj5i/VaW7NZ
	 jiiVB3Tx+Mv0PXt3nwq7uXf6Dfhg8/cKAStiQAZQFdJOoPhQyGq760yYIFk1D+KxU1aAb
	 T4iB/qxp//Y2NA3EHti09U58T2Tm86+HBubp8sAAfrjmBN0RQbQ/odXtlaEuo6rWVSRNN
	 0bYT+fJJycU7jZhxl45xKykIkvEGxr2KDtX6WGA0B8ErVGcLpE7Jdg8LX0aYc5EC5hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=rN0EE4tx;
	arc=none smtp.remote-ip=162.62.57.49
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F00606A333;
	Mon, 26 Oct 2026 10:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3F00606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=rN0EE4tx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793009873; bh=UIOLNzeNMeOGOabzPa1El9g7evCOREjpW/YIP8YMHZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rN0EE4txiOuxFCoYHLo53Lve41VgTekVHucN+SaB+j5TSJ1iIhdTGVZ1YrU8bCPMW
	 uNKaHsoBP8+jVTgsHEXcV4m2B6JcxmsgkbxRjKnLQXB2tN/v0kngf7VWzqTZja5dt3
	 /ZhzZ/H7EaBg52JTogbetzRIl06X63DKaq1PM9mU=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 46F8F47C; Mon, 26 Oct 2026 18:17:47 +0800
X-QQ-mid: xmsmtpt1793009871tu9a03ye3
Message-ID: <tencent_A78901F7336925967D79DBA602DC53B19C07@qq.com>
X-QQ-XMAILINFO: MfnHk2ggLakhAiWDAuEY7dx88TX6/G7Kxk9nWfS0U3v9PFlBSQXXIevDt7q9AO
	 z1px/GbakaQ9nvjALawoLC5ByAKMT8wGyKUuQwZEmJRVoUl/2rit9c2fRCAVDy8ayHmVhWWtuPmE
	 Xvlum1tIPYaH42jzbcC5DygBmxwVegmq7ear2fZf6tFI151lZTwmCC7DINGEz612bTYaaNMkG0Fa
	 mZU2MncCIG9wpMcjtRAlK3HDGeC/cy7s29lUTWudoihVYUwG83uMsSUP8JLHsxBnCRqpv9Oo1Lxm
	 A+IgiTZ0nbWE8pbRrB1yfY1qYnUMo7GIAPkREXdfu/IfyAPOd+snc7zimzU5RJxT75O2fnTJx9BF
	 IimOKABLInvlkXESg0wO0YhYoDCgON1+62bsakP7uvbrriEXJoL7XqiKgFAEv6YHexfU9q9FPSEH
	 PuLPQFlqlPRe8sFKxCg45GFtWzVYON8VChjCr81ztP6o3oB+qIo9uLRGtt9XJMF333Lxz2oKyRqK
	 kZ2BzIimTSLD7dI4y21reH6GUtp1fFtwaoeNWZKGnRr0+h084wSNDgZfoC1C4Kz773f8vyEaaKyO
	 JzJggGoq+moWOxftypq7M4hwkbewP0RmE3P6/3XfxdJhBdq/q1UdDu5Ylxty8oU7zWeZa6trgqN9
	 aFURbnrqKCNoPVv9/GmuKNuZN1irIad1rsxo3wfHfebLZBbh3BPFCXj9xEXfeGiblsXc22sHMH4x
	 FyUsUEtxKnkXuSEqkvIfshoHakLwS7vbrkDLZiqF6VbdRhfsHuXNWPOCL6gvDGtxslPCniK/aIiN
	 Hmn65TzgR6ShgkkRVmH4D7pMCI3rG28UVQuBOPIjBkK6fVZgK+3bJBVSZkWmdshqkG53B7tLdbgy
	 0pnVlmD+OF7e7Cf6M3AKzCP/umMjCFGJc90Wz4h6eNgzwildnbIIcnTHWRQIbDzwlkm7qS8rf3UD
	 SP4oeTAjj5l/ofPlPxyfFu8jbg8OW+3xHig9xgGLvqvNy73kUIR1d+MzUzIIFQy5NhskJy9xDkjX
	 lG9QnTwTqlpTErG/PMquT9W8JBPomylDRUPYuDyi0NHDLJ61aUo5Y2hFIL1NqW8gbj43smwMtbhZ
	 u4NL+ayZi5avMUe8kELyzm7jLWfNsTuCbJmaDTofXhIfTXIbv+JrnQUiYIMxhqahKzZr//siuVN7
	 P1zGY=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: broonie@kernel.org,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH v2 3/3] samples: rust: add SPI driver sample
Date: Mon, 26 Oct 2026 18:17:47 +0800
X-OQ-MSGID: <20261026101747.126903-4-847807867@qq.com>
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

