Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795765493;
	b=RpPjKGr4dpvnTEpkcWskQ2nvaptlLzm+5M/PW3t6CgkbFFgQiEO4LnK/DpGb4rLWxl0B
	 424G58PFbhDjoaJ5bzEOWp1xxApBhKVgiJUSPLQ2GnDgLGe493NO5XDj1qNZv6tWHeDyt
	 AGTEyNBJq8/UuG39dsV96d3JttMZMyq7jxLxh5u+tmTvGe+z6OqVT9x7WvYcdXWGAORdE
	 sjcKcx2+YNnZsFMziFWuUhAjwpqP4P892pScq6+ewet5LW4AgA4fxJI/2+gzROO8HS228
	 2f+cfq7ucAKb6+VDkXm1/MkRUjaLiUh83fbGBleFWAK94WKgdFYCeUxR2y3VzBvLOyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795765493;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5gz9cOzUlfBvDHMHhosMYEbuPfrjTFcnYAa9cwcoXlI=;
	b=KO+3NeGkGE2D9KFz3Fp5OGc/gZgKKY2UWi0jI0czmm75rLWueHrsdECA2K1H7B/sEp30
	 2bYwv1bnWAkAbqXIg4ybeyLNJS8Ala0aUIm+tPxhX47CDvqiZ8Ca/Qmsu1KpUFItdndwH
	 jNtk9ID1tTpvxa8pPIFefNFztz2vYFfZb7c/dzCixAl1LqmfebLL7qdut0ITFHQSOkbDa
	 l+GVDu2A26Y15yXlcw+kuaEtdZEE3Q+IZaBGy2qb8tFX3NHuEdKe1GKVqeVGJKfD0KGf+
	 IKkEUm2lFIA6dUBq+MmjtKiigEY94+XdJ3q/z+sdc5bf1vzx1SKkDhXPSNEudrEVIpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	dkim=pass header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b="afBALMA/";
	arc=none smtp.remote-ip=115.124.28.1
Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0D7606A323;
	Fri, 27 Nov 2026 07:44:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F0D7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=afBALMA/
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1795765483; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=5gz9cOzUlfBvDHMHhosMYEbuPfrjTFcnYAa9cwcoXlI=;
	b=afBALMA/mWCJ5xK/VIIz0tzXqbKAfc3C0R3d40ch9q7Gipm6ttuz0WLHQ0kXVvXrnr5uPMaKGu1M/aIh51NqexO9bh6Lo6vFivOIwGU47QVBcAi8waWUqmHmFDJ0h6EbW2T4PpQbOitezUbc/wixz/b6Pi/ksPcFDMgYQkYLAoY0996dGtVlKtXnixsvyy1J3vyERatO/qcC+DX1JApEYW6PX/S4kPyqjYYaW8yXvnJHY+KzpUSS9ateQhhVOtgPX1FtOSKtFOWjvDdEnr5CM6LbxuvKMfSWGpL6iXNQOsgYUfaglxXAkOX9xzPvZwMeNMEwfBZTbP0E9M8uzDTq3w==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07447876|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0727759-0.00276261-0.924461;FP=7825485084603504059|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033032106048;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DS;RN=8;RT=8;SR=0;TI=SMTPD_---.kBFoykq_1795765482;
Received: from galx..(mailfrom:chunyuzhiqiang@yinhe.ht fp:SMTPD_---.kBFoykq_1795765482 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 27 Nov 2026 15:44:43 +0800
From: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
To: Kees Cook <kees@kernel.org>,
	Srinivas Kandagatla <srini@kernel.org>
Cc: Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/4] pstore: NVMEM backend with panic writes
Date: Fri, 27 Nov 2026 15:39:09 +0800
Message-ID: <20261127073913.353407-1-chunyuzhiqiang@yinhe.ht>
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

This series adds the panic-time SPI entry point and its first user: a
pstore backend over an SPI FRAM.  v1 was based on an earlier revision of
Heiko Stuebner's atomic-transfer series and is superseded; this version is
based on current broonie/spi for-next with Heiko's v4 applied
(63083539d2bf).

Patch 1 adds spi_sync_atomic() for panic and oops.  Heiko's shutdown path
is gated on system_state being past SYSTEM_RUNNING, but panic and oops run
while the system is still running, so they cannot use it.  The entry point
reuses transfer_atomic(), takes the bus locks with trylock so a normal
transfer in progress on another CPU returns -EBUSY instead of deadlocking,
and validates without allocating or optimizing.

Patch 2 adds a panic write callback to nvmem_config and
nvmem_device_write_panic().  Patch 3 implements it for FRAM in at25:
FRAM has no write cycle, so WREN and WRITE are issued with
spi_sync_atomic(); EEPROMs still need status polling and are rejected.
Patch 4 adds the pstore/zone backend over NVMEM, selected by device name,
with normal writes through the regular NVMEM path and panic writes
through nvmem_device_write_panic().

This avoids a private pstore-fram driver and a new devicetree binding,
and reuses the existing at25 FRAM support.  The fsl_lpspi controller
implementation is sent separately; this series only needs the
transfer_atomic() callback.

Testing:

  - the series compiles on x86 with COMPILE_TEST and on arm64, including
    against the for-next versions of the touched files;
  - a mock SPI controller test in qemu passes (spi_sync_atomic and its
    error paths);
  - qemu boots with the pstore/nvmem backend built in and no regression;
  - a mock NVMEM provider runtime test and the i.MX8QXP panic path are
    still pending.

Changes in v2:
- rebased onto current for-next with Heiko's v4 applied;
- include spi_sync_atomic() here so the panic API and its pstore user are
  reviewed together;
- the fsl_lpspi controller implementation is now a separate series.

Questions:

  1. Is the panic write operation at the NVMEM level the right layer, or
     should pstore talk to the SPI device directly?
  2. Is reg_write_panic in nvmem_config acceptable, or should it be a
     separate provider operation?
  3. Is selecting the NVMEM device by module parameter acceptable, or is
     an NVMEM cell/devicetree nomination preferred?
  4. Should the backend live in fs/pstore or drivers/nvmem?

This cover letter and the patches were prepared with AI assistance; the
submitter has reviewed and signed them.

Thanks,
ChunYuZhiQiang

Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>

ChunYuZhiQiang (4):
  spi: add spi_sync_atomic() for panic and oops
  nvmem: add panic write support
  nvmem: at25: support panic writes for FRAM
  pstore: add nvmem backend

 drivers/nvmem/at25.c           |  59 +++++++++
 drivers/nvmem/core.c           |  44 +++++++
 drivers/nvmem/internals.h      |   1 +
 drivers/spi/spi.c              |  69 +++++++++-
 fs/pstore/Kconfig              |  64 +++++++++
 fs/pstore/Makefile             |   3 +
 fs/pstore/nvmem.c              | 230 +++++++++++++++++++++++++++++++++
 include/linux/nvmem-consumer.h |   9 ++
 include/linux/nvmem-provider.h |   3 +
 include/linux/spi/spi.h        |   1 +
 10 files changed, 479 insertions(+), 4 deletions(-)
 create mode 100644 fs/pstore/nvmem.c

base-commit: 63083539d2bf955ccf84042d4b044d1133752bed
-- 
2.47.3

