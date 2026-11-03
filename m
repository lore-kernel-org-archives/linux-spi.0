Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746413;
	b=XZNYl9z5t1MGOpSS05dInJQW80kI4G6iC/9I1At6L/uNQcEAoSWilUZiyixsQkD8hUOW
	 4KCyBG9LVHJkgJfSoP5y5S/WL6tlp6yO61mhImrekk03QEBVaYehillcgZJi+jrjKtrmU
	 eMFIxO9M/EjnFxp4EWhLtbXBSkdFHWwvG94R028L6KC9sILQtxCqI6OarTOMpk6340p0q
	 EEvZnp4Kzjai9meRzvH6cndHX/Bt0H4zbQKCOuRsjMYjMLYz2laPa2Ab4d1d0weEhldj0
	 85ngPj5zxQJcxiT4MFkkoCnwmZLlZCoeRukcivfr+cnWUkDuKV6HQwvwGHvQRFtXKHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746413;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=rPcCFLlBGbIieXIJcYJhfutQkzo582k8Qo1pmtx/upc=;
	b=uv5+k/fQXbhMDeVZPqh6i07PEKGMDg3PHASxXMNWFLcrLd+LZhXlDV4tXtypntxaal98
	 +veUEdBAm5/G1ceXrmGqX2I31iduZfcFaUBiirshT5zJAbMWWAWa0LPR/aktuu9JvdT9b
	 CMB2PHpOwW5CaMFhXUMN4ervSUEw5Z7Fpqgi+Bxj5TETTer7j47EBiBTEdFezRk6vZOfG
	 FJ1UNOFGU249T55LeK1yDZZRPVhGqYujA3w9qs/sCnjSvoUR5zOEWQyxDylt7Y9iOKIfC
	 UAZvikSAvR3OkVu5dv3bkYRLeOwGJMTn+pYp8JTbcPRzhSbpqGj+Qba8hbFWgOcQmcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CTMm1Evr;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A277606A328
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 22:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A277606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CTMm1Evr
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ae691283ecso8283a91.0
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 14:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746413; x=1794351213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rPcCFLlBGbIieXIJcYJhfutQkzo582k8Qo1pmtx/upc=;
        b=CTMm1EvrSn0jLBeSUEP/0bgJLPqr31ESaTh6B5jwmpiExr6089nQjWFxiveIJlI4xt
         0pijXrqY5QzLNSo9XZzi4nLeMmXJIrDlewL+5/OgsmTx/Ee/0+YZ5DSr1bUCOfp5NlZC
         HJ7vRLEUvpwizzz3X6xSQsfJSkyMKsVuco7oIf7Q5sRYvyBmdN4LvvR/eLZnJrM8zmGo
         QxLDtd36aJBseBCRPQ9Vut5TqohoUfg5azaE5MNmRaHKLLLzmV0GAmDm8QSCYu9YIz+W
         GOtU0jThESMR2rNlwIUKIWjkHj7AqT8MksisrMuL72FQevAxWJ00hdxKCa/iIMvhPLCE
         qzxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746413; x=1794351213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rPcCFLlBGbIieXIJcYJhfutQkzo582k8Qo1pmtx/upc=;
        b=ZEsepM2hfGvFp7dgs1D19Cgp7Stzyx5KpbHEIyCWXSRecZRFS/qQ/psHxx11g98L5B
         i5Fxs1Y1ah2BdOzEvqdl9po075T0nR00I66sDtIJop2IMpqHV4W7sh+HIcn7PUIAA5E5
         EEOFTc2aHBU++LdvaPclTzMjXcsYvQjAEBAloVUmsrv1YkLgVY+/eV2jCxC5J4gWJHcM
         sNBr4H1RTT8oxU2wsLz1hYWdHtB65PmMnr/wVki4vfO1htL/HDBTjLlIYvz+b4qXvRQY
         0ZTd6vyM4w2dRFMuiZXauWioqpqlUoC5pQ8NXr+N/VV8jbT/Agfb/eqLgXPecfDr2FwI
         y+yg==
X-Gm-Message-State: APuU4Z+jo8C78VHsJmKYWha22FIn4y87OVnlKIuzZXAtQYWHbPIp2T9i
	iecFx/lxUS3TGAHrVjyiohl0R9cEqWXBNL+gzIvCL3pxvpd6pGQUPMky
X-Gm-Gg: AYBFou1KNnMUkwj8dO3YHCkS2CEx0vsRLFALwM34Nw8VczYX0WuSmN3O5nghnvxGiyX
	zWKLY7w0opRwO4ZwM3xjIMhksv7gdC85pGNat1N5BKaYYuGuUQRTfhVGeVmLQtdQ3yuR/yu6xR4
	E9CIjqYF3GcjGUOia1Uc/jIkgD62JfuSMmtkIrDDmCi5QyeKEwyFsfY7Q/DnOojuiDUNxSvrzVb
	4j/Dhrntr5JQb07qvsTdrcGYBNNJ1dT7mtF/5aUn5IhQnTnW+nzFzbbreXvSz8Y0RYdJiwU8rnJ
	thBapOS755T/jCaFxrjk10q/cfN8cnUAyrso6rUUcXqKE7FnN4QnscbJfqYB7C8YSWSxl1VSc7E
	n9gECosGN/tTr+aKOTjnDn4I6w/XSoBbAyLAujKL2PJaLxDMgI5y9TdsGCm2RAPTXIfBTGNUTXS
	pkzhkLx/ATApNEuO/Q8DbJEM6r0JSkKBslq/LIGd8QEB9zcsdbDCTS1fxkhgxn7UBf/Uek82O1s
	/A/GtnRn2m5U+nz3YzctWbK+7QxipPPFO0Pcn8YTmj5FFWB6ldQaA2JGEiV6fD9y8KZOY/nb05n
	VEPOpAn+CADyp7kJPMxW3KDQC1rWoHfkTOAJfzDJxPGSVDPEkJmkbHtH3xh0bvv2oB90XU6D1HS
	HYFx5FThtLuJb/pCmNWWvPzOkEWLdIxE2ecWmKsfWk64unO2ASHevh0ZYPukXROh4cKG6i2CPMg
	GBMYAfj5lV5wPxkWe533ZW7E232c8bSjrzFInOmIB+F3f+2z34bvKdRf9YxKY5oKKGUg==
X-Received: by 2002:a17:90b:2b47:b0:3ac:860e:1af9 with SMTP id 98e67ed59e1d1-3ae897cfe6dmr8408218a91.41.1793746412902;
        Tue, 03 Nov 2026 14:53:32 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c896cc6sm6096249a91.9.2026.11.03.14.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:53:32 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH v2 0/5] spi: spi-mux: error handling and delay fixes
Date: Tue,  3 Nov 2026 22:53:03 +0000
Message-ID: <20261103225308.3633046-1-jctchan@gmail.com>
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

This series fixes four problems in spi-mux:
- If spi_setup() on the parent fails, the mux stays locked and every
  later message on that mux blocks.
- When the selected child changes its settings and calls spi_setup(),
  the new settings never reach the parent.
- If selecting the mux or spi_async() on the parent fails, the message
  is never finalized and spi_sync() on the child waits forever. -EBUSY
  while mmc_spi holds the parent bus lock is one easy way to hit this.
- The child's CS setup, hold, inactive and word delays are not passed
  to the parent.
Patch 5 adds KUnit tests for all four. Tested with KUnit on ARCH=um:
the 9 spi_mux cases pass with patches 1-4 and fail without them. Not
tested on hardware.

Changes in v2:
- Split out of the v1 14-patch series, as David suggested.
- Patches 3 and 4: updated the patch references in the commit messages.
- Patch 5: designated initializers, trimmed the comments.
- Moved the AI assistance note from an Assisted-by tag into the commit message.

v1: https://lore.kernel.org/all/20261102163023.2574632-1-jctchan@gmail.com/

This series depends on the SPI core series v2: without "spi: unoptimize
message when queuing it fails", a failed spi_async() on the parent
leaves the message optimized. It is also based on the spi-ti-qspi series
v2, because both add lines at the end of the same KUnit Makefile and
.kunitconfig. Patches 1-4 apply on their own.

SPI core series v2: https://lore.kernel.org/linux-spi/20261103224753.3610049-1-jctchan@gmail.com/
spi-ti-qspi series v2: https://lore.kernel.org/linux-spi/20261103225116.3624270-1-jctchan@gmail.com/

Walkthrough: https://gist.github.com/joectchan/9a14b5e6facb75058ebc5a6ff1757131

Please consider this patch series for the next merge window.

Thanks,
Joseph

Joseph CT Chan (5):
  spi: spi-mux: release mux when parent setup fails
  spi: spi-mux: re-apply settings after child calls spi_setup()
  spi: spi-mux: finalize message when forwarding fails
  spi: spi-mux: pass child CS and word delays to the parent
  spi: spi-mux: add KUnit tests for forwarding errors and settings

 drivers/spi/Kconfig                  |  14 +
 drivers/spi/Makefile                 |   1 +
 drivers/spi/spi-mux.c                | 124 ++++++-
 drivers/spi/tests/.kunitconfig       |   4 +
 drivers/spi/tests/Makefile           |   2 +
 drivers/spi/tests/kunit_spi_mux.dtso |  42 +++
 drivers/spi/tests/spi-mux-kunit.c    | 506 +++++++++++++++++++++++++++
 7 files changed, 689 insertions(+), 4 deletions(-)
 create mode 100644 drivers/spi/tests/kunit_spi_mux.dtso
 create mode 100644 drivers/spi/tests/spi-mux-kunit.c


base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
prerequisite-patch-id: 6999a3baa2d32de8fa42f2626a845fe3cb63b0b2
prerequisite-patch-id: 686a62b9223209bf1e83740a0874e20d7607f69a
prerequisite-patch-id: 616b18b757805a6f1520177e1a3e572ac95be582
prerequisite-patch-id: 0d46943b5bec4900701286d93b8b3e975701fb3d
-- 
2.56.0.385.gac671c819a-goog

