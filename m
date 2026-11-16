Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.220
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824946;
	b=3E9pfZo134pP7BFiBbl+ftDdNGyS6XgO9iGC9zGna3BUAfJ7C9YVsAldv/eEFgS5G+BM
	 S0qHODfNdaFy80oFGmmESrENmYUgwkaxwbLnt8ZRPHO+2zEi2/sq1AXyC2zxm6afZsb2A
	 4KYzTjJ3scfjRPUOLq1OLYwZtt3yNCU6g0ysXxRBBEEnVyZ0IjNyfZa1QPmpIGQUcjyNm
	 ivkKLFzJrtPPPp+iQvpqWVvnjGSoNdvpzXIJURkTl7RKhsN/V03aPP7ZNcU2X57xnLf+q
	 crBowxc+XIJ2oLX9npXgqsZqr9nZTmrsitSn5tIsnVD1OxqIJaJ+vr+9fZH6k0Y6AIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824946;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/UO/CJgYQ2JBoy2zyhz0IR72AhokimalGxTertQg//U=;
	b=WfoY3/slTFLpGkM/zV+FEgtXvuKSgedn34XSe8G9IGeu7u5PASMrV5RpAksPGZFBiqfQ
	 1LHe7w+Q9HJ4N6+giz8+7as+23NaVcEQ+iQq7XnaoUUL7b+5gpan6h1BGqyOAULfeYFbk
	 lECq8J2TIiAzeLBmA4M4v7JHyIC98IzXETakqTUKDaJlecedVWOT1i6bBoimLU2i/2lfQ
	 cE9Xo+UROWlIuQfajHHH3DB9Fzr4iu30kjcCbbS0Z7YdNDrkiBM/ywTjwgxGpkxLsykaB
	 U1O0jI2e1r5Qqs3TMSsMl87U9kt7NOIfhG4JetDFCaONjqPr9jFXDSCosIXLw+ogJVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	dkim=pass header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=bPIQ3p53;
	arc=none smtp.remote-ip=115.124.28.220
Received: from out28-220.mail.aliyun.com (out28-220.mail.aliyun.com [115.124.28.220])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31742606A323;
	Mon, 16 Nov 2026 10:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31742606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=bPIQ3p53
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1794824937; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=/UO/CJgYQ2JBoy2zyhz0IR72AhokimalGxTertQg//U=;
	b=bPIQ3p536ziEDOAJWGAKYm3HRjmRutG3DjNWs6jzxUydmJyEdGFDJT+Q7avEnsqHiVGTaC3dT2KFWgdwOHqDHQk66AID8sL9Kb5Mswq/p6JsSBWZULYPxpdNfmCq+t5mqNtb9H8Njz9U8XJu/vZlrLMOmIHElrbyntG0HVOcV98oiwy8Dw/hcdCMjH8VDcZNr584+YL6hPPV6aQAU1GuhQ4QQNLX1eywvq7zD2zslyuvCf55ZDGhhAtV2BgwiAO0PNMCRdsNDTVCDgmhKxqMdL2Lf3lEhIFmA+00ODY61XZzzsySGE2Uwir7HCRHSewAsMRof5TmPqQbdmcXvCQSeQ==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07436259|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0309002-0.000954233-0.968146;FP=18200556205844792507|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037026024;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.k35E.gT_1794824936;
Received: from galx..(mailfrom:chunyuzhiqiang@yinhe.ht fp:SMTPD_---.k35E.gT_1794824936 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 16 Nov 2026 18:28:56 +0800
From: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
To: Kees Cook <kees@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Subject: [RFC PATCH 3/3] pstore: add nvmem backend
Date: Mon, 16 Nov 2026 18:23:57 +0800
Message-ID: <20261116102357.4127825-4-chunyuzhiqiang@yinhe.ht>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116102357.4127825-1-chunyuzhiqiang@yinhe.ht>
References: <20261116102357.4127825-1-chunyuzhiqiang@yinhe.ht>
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

Add a pstore/zone backend that stores records on an NVMEM device.  The
device is selected by name; normal reads and writes use the regular NVMEM
API and panic writes use nvmem_device_write_panic().

The zone sizes and the device offset are module parameters, with Kconfig
defaults matching pstore/blk.  The NVMEM device must already be registered
when the backend is initialized.

This patch was prepared with AI assistance; the submitter must review it
before submission.

Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
---
 fs/pstore/Kconfig  |  64 +++++++++++++
 fs/pstore/Makefile |   3 +
 fs/pstore/nvmem.c  | 230 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 297 insertions(+)
 create mode 100644 fs/pstore/nvmem.c

diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
index 3acc38600..7393236b7 100644
--- a/fs/pstore/Kconfig
+++ b/fs/pstore/Kconfig
@@ -189,3 +189,67 @@ config PSTORE_BLK_FTRACE_SIZE
 
 	  NOTE that, both Kconfig and module parameters can configure
 	  pstore/blk, but module parameters have priority over Kconfig.
+
+config PSTORE_NVMEM
+	tristate "Log panic/oops to an NVMEM device"
+	depends on PSTORE
+	depends on NVMEM
+	select PSTORE_ZONE
+	default n
+	help
+	  This enables panic and oops messages to be logged to an NVMEM
+	  device such as a SPI FRAM.  The NVMEM device is selected with the
+	  device_name module parameter or PSTORE_NVMEM_DEV.
+
+	  The device must be dedicated to pstore, or the offset and
+	  total_size parameters must select a region that is not used by
+	  anything else.
+
+	  If unsure, say N.
+
+config PSTORE_NVMEM_DEV
+	string "NVMEM device name"
+	depends on PSTORE_NVMEM
+	default ""
+	help
+	  Name of the NVMEM device to use for pstore storage, for example
+	  "spi1.0" for an at25 FRAM.
+
+config PSTORE_NVMEM_KMSG_SIZE
+	int "Size in Kbytes of kmsg dump log to store"
+	depends on PSTORE_NVMEM
+	default 64
+	help
+	  Size of the kmsg dump zone in Kbytes.  It must be a multiple of 4.
+
+config PSTORE_NVMEM_MAX_REASON
+	int "Maximum kmsg dump reason to store"
+	depends on PSTORE_NVMEM
+	default 2
+	help
+	  The maximum reason for kmsg dumps to store.  The default is 2
+	  (KMSG_DUMP_OOPS).
+
+config PSTORE_NVMEM_PMSG_SIZE
+	int "Size in Kbytes of pmsg to store"
+	depends on PSTORE_NVMEM
+	depends on PSTORE_PMSG
+	default 64
+	help
+	  Size of the pmsg zone in Kbytes.  It must be a multiple of 4.
+
+config PSTORE_NVMEM_CONSOLE_SIZE
+	int "Size in Kbytes of console log to store"
+	depends on PSTORE_NVMEM
+	depends on PSTORE_CONSOLE
+	default 64
+	help
+	  Size of the console zone in Kbytes.  It must be a multiple of 4.
+
+config PSTORE_NVMEM_FTRACE_SIZE
+	int "Size in Kbytes of ftrace log to store"
+	depends on PSTORE_NVMEM
+	depends on PSTORE_FTRACE
+	default 64
+	help
+	  Size of the ftrace zone in Kbytes.  It must be a multiple of 4.
diff --git a/fs/pstore/Makefile b/fs/pstore/Makefile
index c270467ae..76f44410c 100644
--- a/fs/pstore/Makefile
+++ b/fs/pstore/Makefile
@@ -18,3 +18,6 @@ obj-$(CONFIG_PSTORE_ZONE)	+= pstore_zone.o
 
 pstore_blk-objs += blk.o
 obj-$(CONFIG_PSTORE_BLK)	+= pstore_blk.o
+
+pstore_nvmem-objs += nvmem.o
+obj-$(CONFIG_PSTORE_NVMEM) += pstore_nvmem.o
diff --git a/fs/pstore/nvmem.c b/fs/pstore/nvmem.c
new file mode 100644
index 000000000..95039baf5
--- /dev/null
+++ b/fs/pstore/nvmem.c
@@ -0,0 +1,230 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * pstore backend for NVMEM devices.
+ *
+ * The NVMEM device is selected by name.  Normal writes use the regular
+ * NVMEM write path; panic writes use the non-sleeping write callback so a
+ * SPI FRAM or another NVMEM provider can persist the crash log before the
+ * next reset.
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/device.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/limits.h>
+#include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/pstore_zone.h>
+#include <linux/string.h>
+
+static char pstore_nvmem_dev_name[80] = CONFIG_PSTORE_NVMEM_DEV;
+module_param_string(device_name, pstore_nvmem_dev_name, 80, 0400);
+MODULE_PARM_DESC(device_name, "NVMEM device name for pstore storage");
+
+static unsigned long offset;
+module_param(offset, ulong, 0400);
+MODULE_PARM_DESC(offset, "offset in the NVMEM device in bytes");
+
+static unsigned long total_size;
+module_param(total_size, ulong, 0400);
+MODULE_PARM_DESC(total_size, "pstore area size in bytes (0: rest of device)");
+
+static long kmsg_size = CONFIG_PSTORE_NVMEM_KMSG_SIZE;
+module_param(kmsg_size, long, 0400);
+MODULE_PARM_DESC(kmsg_size, "kmsg dump zone size in kbytes");
+
+static int max_reason = CONFIG_PSTORE_NVMEM_MAX_REASON;
+module_param(max_reason, int, 0400);
+MODULE_PARM_DESC(max_reason, "maximum reason for kmsg dump");
+
+#if IS_ENABLED(CONFIG_PSTORE_PMSG)
+static long pmsg_size = CONFIG_PSTORE_NVMEM_PMSG_SIZE;
+#else
+static long pmsg_size = -1;
+#endif
+module_param(pmsg_size, long, 0400);
+MODULE_PARM_DESC(pmsg_size, "pmsg zone size in kbytes");
+
+#if IS_ENABLED(CONFIG_PSTORE_CONSOLE)
+static long console_size = CONFIG_PSTORE_NVMEM_CONSOLE_SIZE;
+#else
+static long console_size = -1;
+#endif
+module_param(console_size, long, 0400);
+MODULE_PARM_DESC(console_size, "console zone size in kbytes");
+
+#if IS_ENABLED(CONFIG_PSTORE_FTRACE)
+static long ftrace_size = CONFIG_PSTORE_NVMEM_FTRACE_SIZE;
+#else
+static long ftrace_size = -1;
+#endif
+module_param(ftrace_size, long, 0400);
+MODULE_PARM_DESC(ftrace_size, "ftrace zone size in kbytes");
+
+static struct nvmem_device *pstore_nvmem;
+static struct pstore_zone_info pstore_info;
+
+static int pstore_nvmem_match(struct device *dev, const void *data)
+{
+	return !strcmp(dev_name(dev), data);
+}
+
+static unsigned long size_kb_to_bytes(long kb)
+{
+	if (kb <= 0)
+		return 0;
+
+	return ALIGN((unsigned long)kb * 1024, 4096);
+}
+
+static bool pstore_nvmem_range_ok(size_t size, loff_t off)
+{
+	if (off < 0 || off > UINT_MAX || size > UINT_MAX)
+		return false;
+	if (offset > UINT_MAX - off)
+		return false;
+
+	return size <= UINT_MAX - (offset + off);
+}
+
+static ssize_t pstore_nvmem_read(char *buf, size_t size, loff_t off)
+{
+	int ret;
+
+	if (!pstore_nvmem_range_ok(size, off))
+		return -EINVAL;
+
+	ret = nvmem_device_read(pstore_nvmem, offset + off, size, buf);
+	if (ret)
+		return ret;
+
+	return size;
+}
+
+static ssize_t pstore_nvmem_write(const char *buf, size_t size, loff_t off)
+{
+	int ret;
+
+	if (!pstore_nvmem_range_ok(size, off))
+		return -EINVAL;
+
+	ret = nvmem_device_write(pstore_nvmem, offset + off, size, (void *)buf);
+	if (ret)
+		return ret;
+
+	return size;
+}
+
+static ssize_t pstore_nvmem_panic_write(const char *buf, size_t size,
+					loff_t off)
+{
+	int ret;
+
+	if (!pstore_nvmem_range_ok(size, off))
+		return -EINVAL;
+
+	ret = nvmem_device_write_panic(pstore_nvmem, offset + off, size,
+				       (void *)buf);
+	if (ret)
+		return ret;
+
+	return size;
+}
+
+/* The NVMEM device must already be registered; load providers first. */
+static int __init pstore_nvmem_init(void)
+{
+	unsigned long dev_size, area_size;
+	unsigned long kmsg, pmsg, console, ftrace;
+	int ret;
+
+	if (!pstore_nvmem_dev_name[0]) {
+		pr_err("no NVMEM device name configured\n");
+		return -EINVAL;
+	}
+
+	pstore_nvmem = nvmem_device_find(pstore_nvmem_dev_name, pstore_nvmem_match);
+	if (IS_ERR(pstore_nvmem)) {
+		ret = PTR_ERR(pstore_nvmem);
+		pr_err("failed to find NVMEM device %s: %d\n", pstore_nvmem_dev_name, ret);
+		return ret;
+	}
+
+	dev_size = nvmem_dev_size(pstore_nvmem);
+	if (!dev_size || offset >= dev_size) {
+		pr_err("invalid offset %lu for %lu-byte device\n",
+		       offset, dev_size);
+		ret = -EINVAL;
+		goto err_put;
+	}
+
+	area_size = dev_size - offset;
+	if (total_size && total_size < area_size)
+		area_size = total_size;
+	area_size = ALIGN_DOWN(area_size, 4096);
+	if (area_size < 4096) {
+		pr_err("pstore area must be at least 4096 bytes\n");
+		ret = -EINVAL;
+		goto err_put;
+	}
+
+	kmsg = size_kb_to_bytes(kmsg_size);
+	pmsg = size_kb_to_bytes(pmsg_size);
+	console = size_kb_to_bytes(console_size);
+	ftrace = size_kb_to_bytes(ftrace_size);
+	if (!kmsg && !pmsg && !console && !ftrace) {
+		pr_err("at least one zone size must be non-zero\n");
+		ret = -EINVAL;
+		goto err_put;
+	}
+	if (kmsg + pmsg + console + ftrace > area_size) {
+		pr_err("zone sizes exceed the %lu-byte pstore area\n",
+		       area_size);
+		ret = -EINVAL;
+		goto err_put;
+	}
+
+	pstore_info.owner = THIS_MODULE;
+	pstore_info.name = KBUILD_MODNAME;
+	pstore_info.total_size = area_size;
+	pstore_info.kmsg_size = kmsg;
+	pstore_info.pmsg_size = pmsg;
+	pstore_info.console_size = console;
+	pstore_info.ftrace_size = ftrace;
+	pstore_info.max_reason = max_reason;
+	pstore_info.read = pstore_nvmem_read;
+	pstore_info.write = pstore_nvmem_write;
+	pstore_info.panic_write = pstore_nvmem_panic_write;
+
+	ret = register_pstore_zone(&pstore_info);
+	if (ret) {
+		pr_err("failed to register pstore zone: %d\n", ret);
+		goto err_put;
+	}
+
+	pr_info("using NVMEM device %s, offset %lu, size %lu\n",
+		pstore_nvmem_dev_name, offset, area_size);
+	return 0;
+
+err_put:
+	nvmem_device_put(pstore_nvmem);
+	pstore_nvmem = NULL;
+	return ret;
+}
+late_initcall(pstore_nvmem_init);
+
+static void __exit pstore_nvmem_exit(void)
+{
+	if (!pstore_nvmem)
+		return;
+
+	unregister_pstore_zone(&pstore_info);
+	nvmem_device_put(pstore_nvmem);
+	pstore_nvmem = NULL;
+}
+module_exit(pstore_nvmem_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("pstore backend for NVMEM devices");
-- 
2.47.3

