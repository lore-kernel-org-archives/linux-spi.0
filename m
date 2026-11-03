Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746301;
	b=GGTseJnhFmdmqi7un7ajQJMfLpxTvzsPIyqoF2xNgArUH1V1wnUITI1jineaf6vX3UUc
	 57ozAyLytBRxoAzTPM5xqABV5myUZk2FgIMHLPi5v/bSAckXx3NhCeUwIV2CN+Ay+feb9
	 w1A0N4rYBRoPhat6i9992B55gk+PgHmdUP2AMC7J23jtsWuKKCc4BwIHKeQ/tkrUWQB4v
	 Ootadw8jQh7C8Vi7OCbvPr72oqDHT4soKN048DdQB1CTqCJOCosO7EXQftqRX5Be6RYED
	 RjUaxCpgJ6khu3gtHIHPf6RMYardYy8ZBk8dKQZdbqOzu5tRqWEcUtVk61w2+0e6ESQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746301;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=mTFr8rIsSfi0KzlylEkkBifd1sp9ypU7C+PX+e995Ew=;
	b=YDZX5QsaO1nBIgpyS3cVcEUscKCXR9aG0tRhFc6VJHNsdhoQvMH5DPVRB3Utv8GECEXn
	 P1tF6vDzVsaPDq7vUdb5ftpNzcyWxsEDTqZCUt4RYpKTafHOchhJa3Vtj6/5EGt8tn/q5
	 BgOBFqc9D2g7RaQafBxAXJMQ4e43iLn13fj2HHT7pJF19jDGYmfVb5XVnl0rWKCC70qgU
	 tZH0OTb+RL74C7LkW79XfNPqGKS+2F1/o51yY+o2SmAw/4q/8v946ANTZZshPx8l6xwvr
	 5NDgNrCfBXJzs0583XsMm99LzKBcjDqJaAayJyAMRtP5tpH+OoBw8d40MqSTMDubINg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="rNu/6lY/";
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85115606A31B
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 22:51:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85115606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rNu/6lY/
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3acd21ba21aso123045a91.1
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 14:51:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746301; x=1794351101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mTFr8rIsSfi0KzlylEkkBifd1sp9ypU7C+PX+e995Ew=;
        b=rNu/6lY/sFwBEOO5X25bMnUhGWQtfJy0P2Vj1FqH54ly9hYVP6IW7+JKIYWmLBlizC
         rGrwzj4ofYSPDP+eMKv990gyswU6B/AvLDzxyhVDdXkS9yJrm6qcnzgwYF2ovlaMOFi3
         UI7WcfaP/ae9FRtosbDXepjoels2/pQCC5YK+ZYv0ftSbvf3aVwt4v068SRCiOqpC8bb
         gGuu+EkOf4k7oNQ6Ax/RCTp5j3wWupmTN834Nz5Saf6DXTjcNyz7DNNjqC3hn3e/lLsS
         yzVFVSkWEbWxe80goTGvXD72eK+nA/+ayE+TT2uLE7/n/ycQslltXde3DMPGjROoFSUp
         jExw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746301; x=1794351101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mTFr8rIsSfi0KzlylEkkBifd1sp9ypU7C+PX+e995Ew=;
        b=DhbgedBstdqN+pIw+adblAaIC2oo4wwvcH3tIe9kRRlddXVrWuq/OqI02Ed2difASx
         ceajWaan/YaXadFDY0KVCspP6Xm1urBuBDVi+jlwUNZ1Eos5S38JJnJHTqzoUzLmn5xl
         qV1HCUOJMI5LIylDCI9gjj8lwIXWfnZTjhOcxaQKgaTWgDzvlOhk9KL+/EvYfafJx5ZG
         AAx+OxmTm9EwGYKlYOHtZfkYqh3CwNPdxha8PCRjqW+wLmRmISHudpKLJcwafCRJbwcG
         rLW1zD4iFedp/j5dVEoAQYTaa+W9KmmVj0jSRXKwoUZmyohfVWHba4BEux7VWwL5BWPg
         Ueng==
X-Gm-Message-State: APuU4Z/nLFJvlwNssMhMvHLsDC/duL04Y+KkqNFI/oTJA1OdUKgNHoh3
	kRA8HQCRzTeni208taUk+HSG8ut7swhr3jjU205eXSrzlNwnjVR7CNM4
X-Gm-Gg: AYBFou0fxDXajjMgIxzagTOLD/MkI3MpoGfU0BDz/XI/GD6FIYbwF/MjBklIit2meVT
	rYrHZC+mHycrsNAGEAi8ADkYkJilhWbBgT+X58kTJaOLDLHDLz8adTPjisqPTE1e/Nsk4G62vlK
	pE6oh2cPrxUCi9DrVkxainEp5S7mrFWcRrCA0LUO82QqIGUaP3xejdraVDkYdVlAzUF4cNUbBk3
	suj/Tcdlfhv6X9NAfzMfzXuHqQ0zgXYDKpToHVc0tpnu0llXIyZGfHi1RPZUfK1QeF/+3waSqgh
	HCbK6vc8Vbh0UTDHB1jZy8faH/WWoJvjKsBFOs6OeSZBxsxNYZYXiWBUh+wxrzmolOfNVCx+6di
	MhbxLEj4MuFsfnxk3igUm7XsGxWpq/w0gwtjv0bun7TAkFW3QZgVz6vdVb71MEAFRFpTxGm/KIn
	DD+MrqPKugDRPYox+bIflrHv5DHS8PUlOi4u/+PZ/FwNvOyidTK3ZWR6dVN538aWvacfjbZNTzz
	e3wW6PPhlPfVr8VaEcSjaVP4w31TEuEFZPK576ffSgbIPE7BFy4qk2q0MCxPJtQp0V1zEaOwD4Z
	8kKsI1DRZKGOCIF3uycjpU4cv4w9ijqlQE1qTPqLsrDxdE0X12s2CgJ+uh0NJlz8gAHyEP3NpiY
	QbH9KTGX7pMwKBkepqSFhE8VFp83eEdz4IIJ36QqR2WuXUaJSv8UjSYV1UzElL1X3CQ1jQMJQJx
	YoRg45Bv18JgZ8k64UW27sN0999H1kRYjJJVGmBGNHmytX6QcvlRhd4FFSk/aSPKkjiA==
X-Received: by 2002:a17:90b:1845:b0:3a6:e99b:bbdb with SMTP id 98e67ed59e1d1-3ae8984de26mr10277735a91.50.1793746300882;
        Tue, 03 Nov 2026 14:51:40 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b09449bff2sm913217a91.9.2026.11.03.14.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:51:40 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH v2 0/2] spi: spi-ti-qspi: finalize message on transfer error
Date: Tue,  3 Nov 2026 22:51:14 +0000
Message-ID: <20261103225116.3624270-1-jctchan@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
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

From: Joseph CT Chan <josephctchan@google.com>

Hi Mark,

When a transfer fails in ti_qspi_start_transfer_one(), for example on a
write completion timeout, the driver returns without finalizing the
message and without writing QSPI_INVAL to end the frame. A queued
caller then waits forever, and a spi_sync() that took the no-queue path
gets -EINPROGRESS instead of the error. Patch 1 sends the error through
the existing exit path, which ends the frame, sets the status and
finalizes the message. Patch 2 adds a KUnit test that emulates the
controller registers with logic_iomem on ARCH=um.

Tested with KUnit on ARCH=um: ti_qspi_test passes with patch 1 and
fails without it. Not tested on hardware.

Changes in v2:
- Split out of the v1 14-patch series, as David suggested.
- Patch 2: trimmed the comments in the test.
- Moved the AI assistance note from an Assisted-by tag into the commit message.

v1: https://lore.kernel.org/all/20261102163023.2574632-1-jctchan@gmail.com/

This series depends on the SPI core series ("spi: unoptimize message
when queuing it fails" v2), which adds drivers/spi/tests/.kunitconfig
and the KUnit Makefile lines that patch 2 extends. Patch 1 applies on
its own.

SPI core series v2: https://lore.kernel.org/linux-spi/20261103224753.3610049-1-jctchan@gmail.com/

Please consider this patch series for the next merge window.

Thanks,
Joseph

Joseph CT Chan (2):
  spi: spi-ti-qspi: finalize message on transfer error
  spi: spi-ti-qspi: add KUnit tests for transfer error finalization

 drivers/spi/Kconfig                   |  12 ++
 drivers/spi/Makefile                  |   1 +
 drivers/spi/spi-ti-qspi.c             |   4 +-
 drivers/spi/tests/.kunitconfig        |   4 +
 drivers/spi/tests/Makefile            |   1 +
 drivers/spi/tests/spi-ti-qspi-kunit.c | 188 ++++++++++++++++++++++++++
 6 files changed, 208 insertions(+), 2 deletions(-)
 create mode 100644 drivers/spi/tests/spi-ti-qspi-kunit.c


base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
prerequisite-patch-id: 6999a3baa2d32de8fa42f2626a845fe3cb63b0b2
prerequisite-patch-id: 686a62b9223209bf1e83740a0874e20d7607f69a
-- 
2.56.0.385.gac671c819a-goog

