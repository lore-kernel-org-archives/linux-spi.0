Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.194
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795765494;
	b=SssZxUKhdL7WCvoW9oB0aCuvrHEH9+jq75I2bEl6BzNv8QgnEi1yD6IVFie7uKxQtYGV
	 mwYW8nEkToCmyJ4oxLf3v6oSQgElscI2g11jSLkaFDCt1dYPLvHga5GbObn1uLmLDUGV7
	 H0FiYQGdlngEipvpXin4YcIm4/IqFVJRCz7rXJoUxG6u42l42w9XHHniZK2NACjm46tYA
	 l0QTnnXdiv23QvizKNA2R10o2h7GCBnoLpj0o9lhllpzBpBqCKt9fgBrUWsG/JWZuBHGj
	 fIgRXDSJm9WLtKiaeg16f019wbWU/8s2g7hLh/ko8DU/jACRSTo0GmUS/cjO60F4Nww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795765494;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=AkPj4oI+ltkrZRHSxgCmt4zkHipFyLYUmu0JR09yQLY=;
	b=k2G4IzxLr42O18/QFMJh9aJhSPGxch9mXDVYASAAAwmTnULve6VRKrV/57fOQCDo6R5C
	 LnTZ6Wd2Yaq0A4oEa6TYVhpeFqOEWc/d2bF3dGKbhLKymmbIXKWgUnqiaIolwv/BXUUkk
	 RhhNaALpvugsZFOrdMkN8HxZmCo3CF4WzFV0Q4aeyvoK3sh+JlmesJUJFYvKj2ADZ/sOn
	 gaOm5+j+TCss40ucn+nkZscEVGtiQkECxaQIbf5dPbyk3BCUNzphKfPNEqRWM1QpDSONV
	 Oy2CDfvIrk3UFC4nXO66Lm0XDhiAh4v8T/8Id9/8pWlXtBn6n0/CsuTeU/r46znRBtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	dkim=pass header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=lN6ua0BT;
	arc=none smtp.remote-ip=115.124.28.194
Received: from out28-194.mail.aliyun.com (out28-194.mail.aliyun.com [115.124.28.194])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15232606A327;
	Fri, 27 Nov 2026 07:44:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15232606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=lN6ua0BT
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1795765484; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=AkPj4oI+ltkrZRHSxgCmt4zkHipFyLYUmu0JR09yQLY=;
	b=lN6ua0BT7YBA/EmcQ4SuNBv5JMFIfzTl3g67KX3GiQIACIvd83woqu9oKVCakVmCqb3wHF7R81IVumziZ+Pmxs+pNvlmFOtU6D0xpHpue+SYXhDW9q6i3NVuyjuW9wx0kIuaeZIRRjUtOoAQcFCQ18Yinv4HSyD1FTMg0C/aYEvE1r8oPQZTyt2Aa92QcPzt55RLlkuGoZOkf6nkxDJxRhnz7p8FdGRSvu+dvOJ5Qcb6tT6+zFrSCxk57A775+4v3szJ7l00bKLEawcolWK3B+J/Y8xvrPez7oHNLBTCTMGW+a5k9WvvntvVUGGLAsBqThm3ihWU4Epn2vZdnU+hcA==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07439788|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00398301-0.000560933-0.995456;FP=7816901128200203774|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037032112;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.kBFoym2_1795765483;
Received: from galx..(mailfrom:chunyuzhiqiang@yinhe.ht fp:SMTPD_---.kBFoym2_1795765483 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 27 Nov 2026 15:44:44 +0800
From: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
To: Kees Cook <kees@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 2/4] nvmem: add panic write support
Date: Fri, 27 Nov 2026 15:39:11 +0800
Message-ID: <20261127073913.353407-3-chunyuzhiqiang@yinhe.ht>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261127073913.353407-1-chunyuzhiqiang@yinhe.ht>
References: <20261127073913.353407-1-chunyuzhiqiang@yinhe.ht>
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
index d976c0d6603ba..0db0c16dee427 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -959,6 +959,7 @@ struct nvmem_device *nvmem_register(const struct nvmem_config *config)
 
 	ops->reg_read = config->reg_read;
 	ops->reg_write = config->reg_write;
+	ops->reg_write_panic = config->reg_write_panic;
 
 	nvmem->owner = config->owner;
 	if (!nvmem->owner && config->dev->driver)
@@ -2110,6 +2111,49 @@ int nvmem_device_write(struct nvmem_device *nvmem,
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
index bc7a99f5aefbf..1c32947abe705 100644
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
index 34c0e58dfa266..2a23c24fa5210 100644
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
index 6063fe5b7784a..382ea91837e31 100644
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

