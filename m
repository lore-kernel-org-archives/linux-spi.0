Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA61034EF1F
	for <linux-spi@vger.kernel.org>; Thu, 11 Jun 2026 09:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781169210; cv=none; b=UlSmhkQDPcOnF2cUbVreXmnTPlMz6VoRRfWCgABaUkOfvUWmPGSbBlhvZdCFbtlGLm0QnT36l8oMZJGDvFGwzKGTYsyNUV1/prH4H3wWS3jLHttdLHtkwAPylyQm6hwila/7+IK4b8L6RmeaRct17n1NdriYIfDBU0GHkx8gUOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781169210; c=relaxed/simple;
	bh=T7XryxoFPGMT4dHct0/mm5jUu/6vwSFpJtBOscR5LKY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=c6C8K2cy7hEmZor/07zxoqgx7u1g4zxuHWulQ+SV9/j0361Farz0EQdbgk8dkzTxmenGPzt4A2G1wKNx+/Wo9UHoDsbPVEHZgJpasbB8F8hcOy2AtT5cSzt+fwm0ntORsE31sqnGl9K5Nkhu6Cj2n1aCndSw45aZJ8igSM6GtGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nm7yjAci; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nm7yjAci"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-84231305a80so4337454b3a.0
        for <linux-spi@vger.kernel.org>; Thu, 11 Jun 2026 02:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781169209; x=1781774009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hizbOWzAp2GvHnkKmoXoB4flLKn0ZG1pSO3As3FJvhg=;
        b=nm7yjAciTBQ9QEdYri4eIl0GPW/KXPhlfJos4Ba6c74u4cWAbG17bl/eP8lqpld4HB
         Vrh/gVv8LgWKrxaMDR7SiGGDFN1TQKVWs1rKXOdIZNTi1bVvAAwl1GrFVE+cGSGQtXe8
         ADn0/6MXt7k+6tzi8KpK5ZkVtTlNyWZ7hdIME4VrCiy82ZF8fYadEOsqVlgCuQcfQrD3
         rulrcpsCKeV9T2WbfLJzCDJA5hEQ41SZ2XnZEhi3VAcF2vMK8p3Af1Iq0BmgepE2D/zC
         LJcGRs6YTtSIiHaE+7tshoxDpHNyXbS2yk45o93QYe4JO4eGpgBqGw2gr+r9naNlyN/P
         XG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781169209; x=1781774009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hizbOWzAp2GvHnkKmoXoB4flLKn0ZG1pSO3As3FJvhg=;
        b=DCE0ptMw2nr+NxcagRrYdt+0C84WZvE281ktroylPtfwdyiQbAW4N5nMdYHxR28kSQ
         ZR0YuZXnNGU/bsumwGiSavfr+rIAu+Ys22aDk2KLtjUUOo+fIAEW2ww2jgdoU/n4PTma
         9GwtAO1fajHZP0jrHheiUe3YS14eR2BAuYHJ+MguxwKPjHKfwoWsH4gOAAHgn9Tdxy71
         6sbHwRU5LpZrSJOzmLKMXteyyqXd6n4c+VZMydQChYjWHlL1kezNFPdM7J1tg0FJCJ3I
         7oDx8lUCX1vYEjFJS/WBofqwdlSkqTNXEmcvRSzjDr/CzH/NOsWP5ulTD0RNyKZurX2R
         OGfA==
X-Forwarded-Encrypted: i=1; AFNElJ/aNJLF89Cv6U5z1llo11oHCbslCJpLHo4Num6voaCkajaFVXVFEMyJWXpB8/bNbWivjgq20LWQfAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+q/SXSo92ZQ6cxC9mO3xCz1gqpqHwz7QYv6TWIYjh1Ua9tvB6
	17b/eMnX0b9dGCBf2nhBlw99KKHVEYcsD8xFsBtDZy2cW42V3/SU1qSN
X-Gm-Gg: Acq92OGmgLzIXg9VpPqT0wwi/xdln90rozc9MpOFyTftIghLg00wfUuqbUbKVhmpR8C
	/5r1eaXieo3eiovpUxpphCOk4BkG97GeqYVxObvsEffK5AMdUz6gxNOl5jdNoCTYPfqmQdpV1kK
	Ufbtb5lBof2FCGCEJHyMLFXkEAXSOIaey8L0Lu6EgBGgVXXX7ETg6aar+r8rkJujSBSHhVB6oQ7
	mYjBA6/5haNMU2HycunLinyWNXA8B2lzUai7DqS7VZwj+QeSHiYke/B/p2Cuoyo0nzgGwcD+vC1
	T/KtkUjxprPpFeFJVl9aT65JE6IQzRbyQn/nUlcGnxg+43tFjgdWh50u7DcgQITCyH+5zQuJrYj
	hhf8UkQ9068a4LFLPGwAAe5zLdVZTbD0T8rhUw1lT9+Vu1LcPUl/vC33lSau2pwAxUEy6rvKMcU
	ANPT1fVZ78eSh+GkBI4IUvolx+PcMwtJBgV7S26BTmIwRuV18OXPPDjeLLf1XupakyzzMClDX82
	z4z3R6GZfprAYyfZqmxb8Kw
X-Received: by 2002:a05:6a00:4512:b0:82c:b808:4c59 with SMTP id d2e1a72fcca58-84336bde6aamr2276246b3a.46.1781169208999;
        Thu, 11 Jun 2026 02:13:28 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84338319d4esm1417446b3a.51.2026.06.11.02.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:13:28 -0700 (PDT)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com,
	cwweng.linux@gmail.com
Subject: [PATCH v3 0/2] spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI controller
Date: Thu, 11 Jun 2026 17:12:44 +0800
Message-Id: <20260611091246.2070485-1-cwweng.linux@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chi-Wen Weng <cwweng@nuvoton.com>

Add devicetree binding and SPI controller driver support for the
Nuvoton MA35D1 Quad SPI controller.

The MA35D1 QSPI controller supports SPI memory devices such as SPI NOR
and SPI NAND flashes in single, dual and quad I/O modes. This initial
driver implements a conservative PIO-based transfer path and spi-mem
operation support.

Changes in v3:
- Fixed DCO mismatch by using a consistent author and Signed-off-by
  address.
- Added spi_controller_mem_caps and set per_op_freq for spi-mem
  operations.
- Added SPI_CS_HIGH to controller mode_bits.
- Added a short delay after requesting FIFO reset before polling reset
  completion.
- Documented that the MA35D1 QSPI controller pushes one RX FIFO entry for
  each TX word in single, dual-output and quad-output modes, so TX-only
  transfers intentionally drain and discard RX data.
- Added missing linux/delay.h include for udelay().
- Cleaned up unused register bit definitions.

Changes in v2:
- Updated patch subject lines to match SPI subsystem style.
- Added commit message to the dt-bindings patch.
- Added ARCH_MA35 || COMPILE_TEST dependency to Kconfig.
- Expanded Kconfig help text.
- Converted the driver file header to // comments.
- Added reset control handling to the driver.
- Added resets property to the binding.
- Added num-cs constraint to the binding.
- Dropped the flash child node from the binding example.
- Used op->max_freq for spi-mem operations.
- Split low-level CS register handling from the SPI core .set_cs()
  callback.
- Handled SPI_CS_HIGH explicitly for the spi-mem direct CS path.
- Fixed spi-mem opcode transfer to use a u8 buffer.
- Limited spi-mem command opcode length to one byte.
- Forced spi-mem operations to 8-bit word size.
- Avoided driving bidirectional data pins during dummy cycles.
- Drained RX FIFO during TX-only transfers.
- Rejected invalid chip-select numbers instead of mapping them to SS1.
- Rejected unsupported dual/quad full-duplex generic SPI transfers.
- Fixed checkpatch style issues.

Chi-Wen Weng (2):
  dt-bindings: spi: nuvoton,ma35d1-qspi: Add Nuvoton MA35D1 QSPI
  spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI controller support

 .../bindings/spi/nuvoton,ma35d1-qspi.yaml     |  62 ++
 drivers/spi/Kconfig                           |  10 +
 drivers/spi/Makefile                          |   1 +
 drivers/spi/spi-ma35d1-qspi.c                 | 633 ++++++++++++++++++
 4 files changed, 706 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
 create mode 100644 drivers/spi/spi-ma35d1-qspi.c

-- 
2.25.1

