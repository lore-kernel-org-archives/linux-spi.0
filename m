Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.242
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793070247;
	b=FRJob39F2W4FNnoNwfTVYXgp6hgDo9gMLHjYc9KSbnmItb5TX1XlFwgNmJeHW8ZCkwkJ
	 n7n6y/dFgP5xbOfUqIpt2GTZu4MYqcEdrx82uxEdz8YakTV1ohh5wETzDfSvy9dXrsLr0
	 fOuyW+1jKnacOMzVyKg1Ut+EaNa5Pi1d+g2NzOaGiunflnoxVipiegJK0pKFusDAwSi76
	 /zQJvA3iS0dhsrNRjuyjYJMa2sfKu4UTRwk0BUyoG14fM5mqz3CnM734WMy47HOeJESQb
	 OzrfWVDPFNrcf4KP3OF0jKfQ9qMWqMyu+90ys2L7yHpnlB3upebqZ0cfmwbmlsKnCSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793070247;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UIOLNzeNMeOGOabzPa1El9g7evCOREjpW/YIP8YMHZA=;
	b=hBKsp0Tvvb345SQtfGBV9RrGsx5NIceDVt7pQxyW545yydzFyPQJH7LYeFNj58OjDqT7
	 FelhdLbQ9I8xXidF8/lqO675ImO5jesSgfI/L0FwSaMpg/VhlHKpC1M+xRyWjwGLy+HkN
	 5IZVJwjsiwK6oYOFmoGf2OtvUokTTl80DTD1hflhSptcnK3IOLdHOgmI9ANKLRFznZvvi
	 RCdkoa9qD34qV28nrlbyP6B7ONC8H8OGfyvrbN/wyFVWaVrn7C7lqbs9zMZ2ME26qfajm
	 VIL444TxbdyhT9gEYHUFNjJWCjHsJERG+WD7wx/gTN0SY+i0Ty7VkIPgE4LP5yw8oOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=SZM4TTM4;
	arc=none smtp.remote-ip=203.205.221.242
Received: from out203-205-221-242.mail.qq.com (out203-205-221-242.mail.qq.com [203.205.221.242])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF03C606A31D;
	Tue, 27 Oct 2026 03:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF03C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=SZM4TTM4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793070238; bh=UIOLNzeNMeOGOabzPa1El9g7evCOREjpW/YIP8YMHZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SZM4TTM4EKFX9ddO1edzES2HR0q/2ntfAQ81/njXzqiX8BLkzI2aQ/tTVgEgxtma+
	 vaCSpI6UR9g5UGi0SIuqIJrjoZm5DWsUNbjOgF7D6laFozMOU5pV2PqPWvZ21IKakO
	 GqAPww8EjbQuD57HP2w9RBkGbtsfFCtz25OwkWg0=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id F43C6C8; Tue, 27 Oct 2026 11:03:52 +0800
X-QQ-mid: xmsmtpt1793070236tbqacnd6w
Message-ID: <tencent_666DC2DE9D493A8BE540DEB8A908975E2C05@qq.com>
X-QQ-XMAILINFO: N2tAbpslmkSCApiApkoihN78lfbWWWXj785xC84zMvoHvjPenf37HRp/HyM0CA
	 Ohmr72uZ3BT0Ovshr5ZX53SBYWKzfLREUM2nNi2jlLSt7V58h9BYvsFSAMooukKaYG197ojachR0
	 Xq6Ztptj+Ch2s/IaoGOjINebM+E7qYbx6MdbfzVtvzGfCieAIwsCL/OL5dp+C2OK4N+imd0sJyZF
	 uv9Zh/E0cD+n6eS0HT8KazTgSEdDAD1NiNTHwFHWEmCnzzEQcTdD0aAPyuibYBhd8ZQ/64wNUrY0
	 hwGtfbXc5sX98NM0EaOKJRI8qttlJvMky8nqxLRcWFGxVXqS52GqYkaNoNZ3dn9pehpR5kCzq3zq
	 WjP2LHUndxJ3A2l40iTugOR4JF9YyUqqiVqfFk4FeuJaIjFSPawQXA/EFpKj+K/+pQr1I/wELt+P
	 afL/qS31Ja3Y0JK1bdktpIqR3bWK5Wb3zLjZV/Cjk/D1UJf1eKU9NBI4cdNRV0sw5iXFcvD3SJO3
	 9JX0a2+XhkQylwIqnxDfpN792Z1yb+8ry7D/ozjIzBLDSQU+M/REZQwcXROMWj4I8YQ241Q16WMw
	 HJIrawfnvh4ZMdffbwFBQM6/yuI7RkyQl5LP2eAw/B0WfNh6tnCF03+yslcGebnJyMuaiugA7q8d
	 Lyk/ehnbusfX56Gitt+1xM7wriA//oOm3F1yX3gBuRTRsLS1Tsc8z5QPppuCU8q0aJTGO/Tl4yYs
	 ft/c7jLYsCxlhBmuP5n2hW2wy3TYe/icxZUPtcp1chtukTFZX+CNRQdM52I3Tp4DGdSqyT3supM3
	 OsUTwEGIibkL1bgv7vslHfn/shmVjw2IV/Iyeo2zxBGXELD3ahOMQNpBsX8dwdGrGwDgp/7CmZda
	 roGoPQQeizkekxU5EqJluiflZvkHKGkeTncB5tcrV8vXcNecUvX/2XIb/IkIRplRYEeBUhB+kIgE
	 uznWK+Lb1X6LQocAgq7fItJV5R5OwiZWIZyaanHZR7OYZG2JwRaksA5HqWl+W/UDF5s/PYwDg0sY
	 +2vxuc7UuO9o27c5uG+FdmUxA1B4uf/Q5ryfgEuShVWZiwchxdnDc3oFeubkUZbun3/mVOY3/hfu
	 c8TzNCV1pqcw4Og+hD2Ti4YCiMd0AMVv8MGaWJKNYSHDc9bLoM/C4QSXDcYlouYHxNbDN2JKVcBE
	 bxb0+09Q//QVF7+3kYp4rOxEDU
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Shuai Liu <847807867@qq.com>
To: linux-spi@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: broonie@kernel.org,
	ojeda@kernel.org,
	dakr@kernel.org,
	linux-kernel@vger.kernel.org,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH v5 3/3] samples: rust: add SPI driver sample
Date: Tue, 27 Oct 2026 11:03:52 +0800
X-OQ-MSGID: <20261027030352.615926-4-847807867@qq.com>
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

