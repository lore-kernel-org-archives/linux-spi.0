Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824946;
	b=4CNuN9DxbPTFjUww4MG5xbbJk0LtwQP0V+UGGXvqiToVJYKu084IHA+2QKq75Iow8woP
	 lfot+8f5Nc/vQaNfPkONS4Uji/yz/rmLNHScZsyIb0fe8fsSpVtzQPHBdfVfIU/MRXbIA
	 WOo/3Eu4UgVBE4qO9ILb6DxKnLmiDE3PQ4WmfdZejDcYkvoYW3S0Sxhql24xpAqbvidkR
	 zrdKn8Sbj3MJN21CGMr1Y4ql6msP3IrSESzAJj1DwL0z5FyEz9vfLgWlBfLWd0wVfDhSj
	 0t0qsFvW+1KDNVxDo4gEfFxJ2Fe0rgqdFuNurtfeg2YPh5pxWL1wDEzZvS4xO53RuZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824946;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=3Id0hsgYyF1MNWyUmbOw9PnJtuPWJdtHxVZgRs+q9NQ=;
	b=dqsoWSg0BJSpkJuWt2bwr0gXdJeh2TT6ZrY28Krr0sPt/DmgK3AA7TkVGnmFnSn92vam
	 SDhGM5fY7DLPgUf62wvc3iQZZjetBbzqv+xumTzSa6hPKF7I4EMahWseq5S45A/2UFbDZ
	 mZjvdeuuYKgJHGqUVSYpMZuEYDebFsHTWGZXeRvLBH5X8xJYS9HyE99/VxkDZjPi6E8Y3
	 Lq5crFLRAQLu1m8XnFrDs8rZRMogkUzzavDAjbvFnoTwhK2oLenRoF2pJgspYpdR19WKk
	 oBd8jN4nUiQsCU4ZrPo2Jt9AD8ETGoyGitsWWvktsieocZhHNfjUYRHFtCanETHk/rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	dkim=pass header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=K8PgSRxY;
	arc=none smtp.remote-ip=115.124.28.49
Received: from out28-49.mail.aliyun.com (out28-49.mail.aliyun.com [115.124.28.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B28B606A31C;
	Mon, 16 Nov 2026 10:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B28B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=K8PgSRxY
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1794824936; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=3Id0hsgYyF1MNWyUmbOw9PnJtuPWJdtHxVZgRs+q9NQ=;
	b=K8PgSRxYBdsQjORV7zVmjy7D10nyNP9yKHx+r/N2gCIwO9wz2jrRWwilN3uhEjGcgs73KANmQdAUED99mHjO/TijAtHdkXy5c99Pq3d25fMvz0OAMijDznuNCf/ks71MpWoekoIUuJ7HOaE1UQPctnxLqHIkqvflPjpRzUFI6dYr+JvldyK8zyysSS9CsKXWdoKPZVgSnT+DJKofgD9kA88gBW8CanJFYf3RQs7S2iK8kIyLjKPtQDd0TxYZg0OaO8AnOIDtos9pZaKS6MhCUVWv6/9O5mLIxuvb4cN5FKQDJzBmtMptuWT3XS11u27WWBTgtSO3dsnuSO78eQiy3w==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07452955|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0661257-0.00124372-0.932631;FP=7823091585212073403|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034017;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.k35E.fC_1794824935;
Received: from galx..(mailfrom:chunyuzhiqiang@yinhe.ht fp:SMTPD_---.k35E.fC_1794824935 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 16 Nov 2026 18:28:55 +0800
From: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
To: Kees Cook <kees@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>
Subject: [RFC PATCH 0/3] pstore: add an NVMEM backend with panic writes
Date: Mon, 16 Nov 2026 18:23:54 +0800
Message-ID: <20261116102357.4127825-1-chunyuzhiqiang@yinhe.ht>
X-Mailer: git-send-email 2.47.3
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

This series builds on the SPI panic atomic transfer series sent
separately.  It is not standalone: patch 2 uses spi_sync_atomic() and the
pstore panic path depends on the controller implementing transfer_atomic().

The target system has no retained RAM.  A SPI FRAM is the only persistent
store, and the crash log must reach it before the next reset.  Existing
pstore backends do not fit: pstore/blk needs a block device, mtdpstore
needs an MTD device, and the new spi-mem panic write path requires
exec_op() plus a native chip select.  The FRAM here is an NVMEM device on
a GPIO chip select.

Patch 1 adds a panic write callback to nvmem_config and a matching
nvmem_device_write_panic() consumer API.  The callback must not sleep,
allocate, use DMA, wait for interrupts or touch a GPIO that may sleep.

Patch 2 implements the callback for FRAM in the at25 driver.  FRAM has no
write cycle, so the WREN and WRITE commands are issued directly with
spi_sync_atomic().  EEPROMs still need status polling and are rejected.

Patch 3 adds a pstore/zone backend for NVMEM devices.  The device is
selected by name, the pstore area is described by offset and total_size,
and the zone sizes are module parameters with Kconfig defaults matching
pstore/blk.  Normal writes use the regular NVMEM path; panic writes use
nvmem_device_write_panic().  This avoids a private pstore-fram driver and
a new devicetree binding, and reuses the existing at25 FRAM support.

Testing:

  - the changes compile on x86 with COMPILE_TEST and on arm64;
  - qemu boots with the backend built in and the SPI mock test still
    passes;
  - a runtime test with a mock NVMEM provider and the full panic path on
    i.MX8QXP are still pending.

Questions:

  1. Is the panic write operation at the NVMEM level the right layer, or
     should pstore talk to the SPI device directly?
  2. Is reg_write_panic in nvmem_config acceptable, or should it be a
     separate provider operation?
  3. Is selecting the NVMEM device by module parameter acceptable, or is
     an NVMEM cell/devicetree nomination preferred?
  4. Should the backend live in fs/pstore or drivers/nvmem?

This cover letter and the patches were prepared with AI assistance; the
submitter must review them before submission.

Thanks,
ChunYuZhiQiang

Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>

ChunYuZhiQiang (3):
  nvmem: add panic write support
  nvmem: at25: support panic writes for FRAM
  pstore: add nvmem backend

 drivers/nvmem/at25.c           |  59 +++++++++
 drivers/nvmem/core.c           |  44 +++++++
 drivers/nvmem/internals.h      |   1 +
 fs/pstore/Kconfig              |  64 +++++++++
 fs/pstore/Makefile             |   3 +
 fs/pstore/nvmem.c              | 230 +++++++++++++++++++++++++++++++++
 include/linux/nvmem-consumer.h |   9 ++
 include/linux/nvmem-provider.h |   3 +
 8 files changed, 413 insertions(+)
 create mode 100644 fs/pstore/nvmem.c

-- 
2.47.3

