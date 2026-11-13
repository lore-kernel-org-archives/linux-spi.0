Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794536748;
	b=VGzzRDPHViicWIyY9HOzLR+LwS5+IbqpRiF97SxaE92GCnS8XYPFa3TsLM/dMdEi+Xhl
	 5pbwiqoLl+X3YUUXaMOy71xxbkrH7Ol2Obq7+u1rfuVVkVO1FJbS2LViqYHL3kyi54j+Y
	 dmHTriquP8qcKs+v1dLNl6NaYD1LiZpmc14pophpKWIWNVXxYMCuM6H+/g0gOoywx549A
	 nTpzaMp5Hhntoi4dC0TAsVCNGYUMis39x0cIkVHah5SFHyNAzsGiEtBoowVTL3ageZi1v
	 nV290EUiMvxbMILzxRAk/5q9O+NUUTOIu0YmcUjOKPjBOuoEd04fWs0yhxItJYYzPtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794536748;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=adgGF6Y+EY3ng5J3ZlI+WZuzQBE8vUwfEB8/besoPZ4=;
	b=YWLkgFNFzGEr3R0Qt0O1KvDYwuvIYx6aC47D7rBQLQrdKHXE//YmArxwXtV7z45jhWBf
	 vTjDcr7OK0Mxacua94EbSUiUvPHGDRbHBsUJG8D4bP+ClN8iu0bjGKCkSHf5yA5zOwPk/
	 m2LH7J4Zm7j0YP03kvvEA7lM3crvEyKiv3diV30k5FjMdWChOLNUHCYqp/7VOqsrmV+Uk
	 9QYqqEEk29zRJeiN94GyoKR/ZoKBrU7ufozJdAdpYVmKjRVPfC0WK3/uI+oQr3phSEXAx
	 8ve7tEBqmcYrZaP/msZAjgHTrjRQhBMV3pDBjEi0hgkrH1q08x7sUq5nRpWrlTxvKOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=XRYtLUSB;
	arc=none smtp.remote-ip=203.205.221.231
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38CD606A327;
	Fri, 13 Nov 2026 02:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D38CD606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=XRYtLUSB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794536744; bh=adgGF6Y+EY3ng5J3ZlI+WZuzQBE8vUwfEB8/besoPZ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XRYtLUSB7ioTj137Lnc+sSPP+Z0zUtwmr68gWkFFXNWNVtD8Wy07ttBaFwHBZJhyz
	 tErN9mtlYGnyRHT355/L0hZ6YrsRw97QqYpDGs7x3Mg+TsAwteMMuM5zeeVvyMtNK8
	 dk9L0xzFmXw2k0QwB/6ZjD4Lz35BrfTR5oJiQQuE=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 667ADE1E; Fri, 13 Nov 2026 10:25:39 +0800
X-QQ-mid: xmsmtpt1794536742tvuzepfu9
Message-ID: <tencent_0D58FEE5259A807105C5BA27E4DC9BA4BD09@qq.com>
X-QQ-XMAILINFO: NgHXPu8ibN06FSUNIzwDtpkB96DOdEEv+1pkm01tJKk+F7+zm3Jbao4zzARQiv
	 Ln5cETvGxdEOFAo6AsImgqnm/ReEo4LG9a8D8rdZajCNtxQMG0WQVQHfHVTJc86hCQ6ABhbjjboS
	 JcYCmUTb76ApguT/eGDQO3+qBphDMD7uSZ6xy19fYEI4A9pYNIamO0bBGhI4LPvH9iKUz6LHrM1C
	 F4t6yHQwwesLba8gdvMAe6rNlaZfmjqInZTkpBSMm5PotiN+Qk+OiFjKowjeg4+IXhIoyz6L2NDK
	 oWB6uiQG4mnSGizKQtNjsnfKSDdsD/gCgmK82inEQDSJKUCfs+uHVVJoYxWmvAqdZQLOMYu5wKSP
	 igW1yzm6D9cvtRKNVt5N34AaoZoJJX8LQeCJj1X6Y0pCrbcuNIJQwB5mY6uPYysRusqtwN68VKCO
	 a03w2Zxq07cn8EMyhAOUKJbNZwHquY6YFkxSKL+8uHoVdzbDuj6k+BQJzUGagvl5E0+6rmKwbuAo
	 F2h5j0IgNwmbXwFm8/ze+XKZ1jUGgQPn8NJOLKlau/qgbywrCGmaX5Cgcmxm39CibzsTxIx9XH9c
	 jg/ylbtE2ax65+s9YfZm6OcWo+Dnrh6V3k7u4uneEb8EYuvDO8vxaQeLguNApwwCd+LtNgAEeTcA
	 z+56qeSJXAIXbmdk/tYrTJjIgZHhx56lEx2XgN89Iqf6Q+qUQ5PnhItm2Uwcp5UKPsgVryRlqhT7
	 cpnY+bt6av6emAcSqVKljLwy0eaxTnGLDcSpoehJ8TZzE6UnUpbRHXdjIhPwIw7NmhKwZTlSH55R
	 V2aYHn2vu0/dk6xT51xDeyQwQVDAXtW6zYZG2CkmXzWBKESWkVOWyIr3mQbW2J6xWkVymsLcKV7a
	 U2Zs2r4HPim+QfZzprE/7Pwsfq2dUiwScqGBVFzUB/VCHYDpfCIHtMtqU5EPIY/VrKJ9Kvmsfo+2
	 W8Md4BDRVZQqevlncymQr0BElQ+fiwRQJ65iDteTCXoRIZs9WMfN77YTBOX8NeA1GBat6fAlXNR9
	 7JxBMcwjRmfZ1gY5GbHi2s0+1oBFQOjPFwjdTmnFputJbA4a1r66oOLNRiTsVm0oDdAshtCOzfJH
	 Xb1cxLk78gJlCSv8YHyT8nR0oiraVrM9tYISnmYluyoYiYEhXcmNFSVz90Og==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org
Cc: rust-for-linux@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	847807867@qq.com
Subject: [PATCH v7 3/3] samples: rust: add SPI driver sample
Date: Fri, 13 Nov 2026 10:25:39 +0800
X-OQ-MSGID: <20261113022539.601421-3-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113022539.601421-1-847807867@qq.com>
References: <tencent_097BA6F40A0B8FBC4C130C6EBF58F8048006@qq.com>
 <20261113022539.601421-1-847807867@qq.com>
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
index 31d62533ef25f..f99bf52654a15 100644
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
index b986b681cde5a..efe04638a990b 100644
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
index 0000000000000..7eee7b7357947
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

