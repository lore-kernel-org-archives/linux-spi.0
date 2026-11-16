Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824946;
	b=qmYzB/piB3G1aEqQ0J/MkHhwHr25MjFi0kYcNS2/GH89rvIdtx/xZclYAFDwavrN41bY
	 HKhZrIZMyPwxxQQJFsd8wVGtX8LpRYyqkmb1lIXCNTUF9lP17AYXD3uZ5yjFMHsXAsd65
	 GDRLq5liCS4Jpv5QT3nOYArLRnyO7m438aGtMEwEfQFHJJNQgQNO/5GltvhmKoZ4JurYk
	 wwJWduRBQqloyyubRXfR0f6NXWIvy0zfZDuYF+xNLo6KijijjgK4iZf9KsAWf+HwGbfRA
	 bjK5o9Rf5ce4j9pXkbKnnDIfUp13EcL024YvrDdaXfW0P/DejKp7bJTIeGQWgJpq4oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824946;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FGxtYhvOvYMjkXhg5Oa8UFOmv2LwD3A5bo2Vpfsvqa8=;
	b=Wf3H65lrjF1/CCvfu1z7mJO6R1rAZv0STQhfGgd24ZGD/hlzMqqiZtxRY9iCweblMSPN
	 YSNksvf3O3yF2SId7/aVefY+px7OUzMtdbIHT6ji8IdLnj02NMlKpfN2ENEcLvDTPtm0h
	 M3xfdf0DAV9UGZq6TvSc0mNOogaUOkSNYOfFv+5iCIGY4HkK3IQtr8sJkXktiNfUp0KGc
	 lN7H3QT+9ST2fuM+GCXqED86hXK7rwd3rOWHX5MZnnEeU5sZPStbuydUYpcy5gLBthN5c
	 QqAicr3i8GXS0sBCEs8jj0K4Dpc2VstiVwdst5Avm6atuzGs7HIRs6v0aBSUpgWr0Ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	dkim=pass header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=bwTOUhkp;
	arc=none smtp.remote-ip=115.124.28.123
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86158606A329;
	Mon, 16 Nov 2026 10:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86158606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=bwTOUhkp
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1794824936; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=FGxtYhvOvYMjkXhg5Oa8UFOmv2LwD3A5bo2Vpfsvqa8=;
	b=bwTOUhkp2IfsImsrSPvUN9RWSBnU+QWBOKGRxZE9ILbyzWj75o4/S8P7bqsXtKQG+Y2QjIhBNv94MlxkoXGlhrrGBczxiZwhSqfAbP29T1J+PHZrcLW1wRnHvqQaXcNT4KHrkKzOa7OJR9SgxexwHDz1X4COaPialnO3cDTVm7n7bhisc5QBFSuTrYpd7K2RQrUIZoxaiPZwhceMHLStCkln4oiJIRyXkJyevU/PYNNtqSnSknAW/bdJvT/1I9U4RLXkrlmzmW4hnNyDTOrTBMSBS8ccudjq+vGYSWfqUcKDFWbLsbW1P0co1YzCQmVTUiFUA4z/MaaM9RQg/CcotQ==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07440252|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00382826-0.000535643-0.995636;FP=7816883536013127102|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045099153;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.k35E.fj_1794824935;
Received: from galx..(mailfrom:chunyuzhiqiang@yinhe.ht fp:SMTPD_---.k35E.fj_1794824935 cluster:ay29)
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
Subject: [RFC PATCH 1/3] nvmem: add panic write support
Date: Mon, 16 Nov 2026 18:23:55 +0800
Message-ID: <20261116102357.4127825-2-chunyuzhiqiang@yinhe.ht>
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

Add a reg_write_panic callback to nvmem_config and a matching
nvmem_device_write_panic() consumer API.  The callback is used after the
system has panicked, when the write must not sleep, take locks, allocate
memory or touch a GPIO that may sleep.

Providers that can write from panic context implement the callback;
others leave it NULL and the API returns -EOPNOTSUPP.  The regular
nvmem_device_write() path is unchanged.

This patch was prepared with AI assistance; the submitter must review it
before submission.

Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
---
 drivers/nvmem/core.c           | 44 ++++++++++++++++++++++++++++++++++
 drivers/nvmem/internals.h      |  1 +
 include/linux/nvmem-consumer.h |  9 +++++++
 include/linux/nvmem-provider.h |  3 +++
 4 files changed, 57 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 7d4cce8e2..40b2f59e2 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -960,6 +960,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 
 	ops->reg_read = config->reg_read;
 	ops->reg_write = config->reg_write;
+	ops->reg_write_panic = config->reg_write_panic;
 
 	nvmem->owner = config->owner;
 	if (!nvmem->owner && config->dev->driver)
@@ -2111,6 +2112,49 @@ int nvmem_device_write(struct nvmem_device *nvmem,
 }
 EXPORT_SYMBOL_GPL(nvmem_device_write);
 
+/**
+ * nvmem_device_write_panic() - Write to a given nvmem device during panic
+ *
+ * @nvmem: nvmem device to be written to.
+ * @offset: offset in nvmem device.
+ * @bytes: number of bytes to write.
+ * @buf: buffer to be written.
+ *
+ * This is the panic-time counterpart of nvmem_device_write().  It must not
+ * sleep, take mutexes, allocate memory or touch a GPIO that may sleep.  The
+ * provider's reg_write_panic() callback is responsible for using a
+ * non-sleeping bus path.
+ *
+ * Return: length of bytes written or negative error code on failure.
+ */
+int nvmem_device_write_panic(struct nvmem_device *nvmem,
+			     unsigned int offset,
+			     size_t bytes, void *buf)
+{
+	struct nvmem_operations *ops;
+	int rc;
+
+	if (!nvmem)
+		return -EINVAL;
+
+	if (nvmem->read_only)
+		return -EPERM;
+
+	if (offset > nvmem->size || bytes > nvmem->size - offset)
+		return -EINVAL;
+
+	ops = rcu_dereference_raw(nvmem->ops);
+	if (!ops || !ops->reg_write_panic)
+		return -EOPNOTSUPP;
+
+	rc = ops->reg_write_panic(nvmem->priv, offset, buf, bytes);
+	if (rc)
+		return rc;
+
+	return bytes;
+}
+EXPORT_SYMBOL_GPL(nvmem_device_write_panic);
+
 /**
  * nvmem_add_cell_lookups() - register a list of cell lookup entries
  *
diff --git a/drivers/nvmem/internals.h b/drivers/nvmem/internals.h
index bc7a99f5a..1c32947ab 100644
--- a/drivers/nvmem/internals.h
+++ b/drivers/nvmem/internals.h
@@ -12,6 +12,7 @@
 struct nvmem_operations {
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
+	nvmem_reg_write_t	reg_write_panic;
 };
 
 struct nvmem_device {
diff --git a/include/linux/nvmem-consumer.h b/include/linux/nvmem-consumer.h
index 34c0e58df..2a23c24fa 100644
--- a/include/linux/nvmem-consumer.h
+++ b/include/linux/nvmem-consumer.h
@@ -75,6 +75,8 @@ int nvmem_device_read(struct nvmem_device *nvmem, unsigned int offset,
 		      size_t bytes, void *buf);
 int nvmem_device_write(struct nvmem_device *nvmem, unsigned int offset,
 		       size_t bytes, void *buf);
+int nvmem_device_write_panic(struct nvmem_device *nvmem, unsigned int offset,
+			     size_t bytes, void *buf);
 ssize_t nvmem_device_cell_read(struct nvmem_device *nvmem,
 			   struct nvmem_cell_info *info, void *buf);
 int nvmem_device_cell_write(struct nvmem_device *nvmem,
@@ -215,6 +217,13 @@ static inline int nvmem_device_write(struct nvmem_device *nvmem,
 	return -EOPNOTSUPP;
 }
 
+static inline int nvmem_device_write_panic(struct nvmem_device *nvmem,
+					   unsigned int offset, size_t bytes,
+					   void *buf)
+{
+	return -EOPNOTSUPP;
+}
+
 static inline const char *nvmem_dev_name(struct nvmem_device *nvmem)
 {
 	return NULL;
diff --git a/include/linux/nvmem-provider.h b/include/linux/nvmem-provider.h
index 6063fe5b7..382ea9183 100644
--- a/include/linux/nvmem-provider.h
+++ b/include/linux/nvmem-provider.h
@@ -94,6 +94,8 @@ struct nvmem_cell_info {
  * @of_node:	If given, this will be used instead of the parent's of_node.
  * @reg_read:	Callback to read data; return zero if successful.
  * @reg_write:	Callback to write data; return zero if successful.
+ * @reg_write_panic: Callback to write data during panic; must not sleep,
+ *		allocate, use DMA or wait for interrupts.
  * @size:	Device size.
  * @word_size:	Minimum read/write access granularity.
  * @stride:	Minimum read/write access stride.
@@ -128,6 +130,7 @@ struct nvmem_config {
 	struct device_node	*of_node;
 	nvmem_reg_read_t	reg_read;
 	nvmem_reg_write_t	reg_write;
+	nvmem_reg_write_t	reg_write_panic;
 	int	size;
 	int	word_size;
 	int	stride;
-- 
2.47.3

