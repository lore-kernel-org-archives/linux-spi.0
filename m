Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD176361DDC
	for <linux-spi@vger.kernel.org>; Mon, 13 Jul 2026 06:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783922891; cv=none; b=WNt4sPQztb+Y4niqYtrLSNiOhmKfbIlU4kCnqFZmZ/UACR/eVyG6O2R4NWVCJI3OV8Sbybma01ZEboh+btgo0LJLnWwFo4vRSoti7DUWRI8i3FUJeW4vzPHMCc0eqzDsDpbZkDD0KxP6PhAr5TTqURck9m5pYg4GXCAGdGjauR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783922891; c=relaxed/simple;
	bh=Io5GZS9m1lG5dPzvHr9eWo+cCXKzpua7RpJkm5bO/bQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aw3Ycj5HliqVCofZUyN8BoZCS5Mr4c4Qx8VgEiUSIGYIWAMOzViP1RgpqyChQk96SS6oohOkKJ5qTpM6tpHMEO5qDhpuHDtbt2JF/SZCY5e3Sv6+ouO/g5r8hlEL2nBb2r427FJ9spTYDeivwgPWAQ7srFEHiSWhdJ7a51f8Yh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3dh0TFk; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3dh0TFk"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8453427d3f4so2280652b3a.3
        for <linux-spi@vger.kernel.org>; Sun, 12 Jul 2026 23:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783922889; x=1784527689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wr+dAOEOkwMOdgGfXNclz6OtU7jD1eICBMUfO3Waku4=;
        b=C3dh0TFkKmt6VfZOZBkxmTXo70LzHqhPBMzml8KtkVTjup0LQvJt52Uu0zxfhXWpJN
         fvlYlxgOm1HmO0WhQMLNGx1Zoi4h6RG1ecRfFkhAE+Y6gvOnWubxYWjp92c21HIvq5Sq
         DVdVC9bfcnKOqqgMP+ghB6UVeZhE5aeajm41hghoHQza6BEoUFYjSe1nepgByMpBqTbX
         I5PRFMVrkVsLLiWJ7GRjApw8ev6LRhQAMYw6JyUKI/cewBLVQNCMfnvF23LlrXukEjTA
         XwLulI5s9SFbTl5x6CURMU/XXiJnfn2V1VQ1M2HKxU+oBaf6kMT2zKHxlflRSLyR0TB8
         GJWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783922889; x=1784527689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wr+dAOEOkwMOdgGfXNclz6OtU7jD1eICBMUfO3Waku4=;
        b=B+4LS0/lfzIgNVMNnbpgeP21gG7648E4S33uXcO+o6boi+/XwsciH5sxnMTH4m5AmR
         szSqRPufWUByzXggk2XWCdO+T0w+ukbclNPoOdv+b1ap3BxM+WjxNnMZuJIuov11/sXZ
         yA/i3cF9ImZp1Q9yxOZ6yMc+K07dPxhP4sJQOs1OBUtmxT4VCO9t6Bse/RWblzANBf7y
         V7hAo+73D0XZn0YmFYbkGXPrkDXE6P61Q5pC4FXObrjPDYdrXRX84Jx2w2XACuB9t1qo
         IgwkU+6/sv+MP+nSmF5h2Qh/DAqRwRy11JxgR2l7H7FdPzNrzhfgoQHgF4+8xnWJwBmk
         sX1w==
X-Forwarded-Encrypted: i=1; AHgh+RoiRxKSGDNaOI9YHrWXZ5v/BAvfMg+i8XPRn24p1ksA5wNmriZhsJqk277rtnd7hnzgZuAtN6sup6Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV4EaZRQk072nV/Gwo116R3XspZQL/wejvFiDWGyYZHlEsmANc
	WG8uEuMoXRcyd+q3//2+AjiHw+7B3fXjytuxUvoJMwvfVH2HQTBfvw5f
X-Gm-Gg: AfdE7cntK3g0Cgsup2Q5ayj1PSk+pUFmUY02g6pi0y30PCM2heXWn2vJRBPjIR3HHVz
	xEdh8pw3ppfGOW3KfilYKPSuTUSMK/zPhSWpCYcKWpSVPLLkKpTWrNUd5NzpZn9S3qLJqRKwE6h
	7qJDnh0xq2s/8Jo1va+PG+f3Zs761FusPNYfoG+ueIE9hyoXMTSq3tP2A7MZexc6lkn0L1+WR/q
	lI9RaTzqeVs5exBOe5CsgbKR7A3/Bh/YLxvfxHdAvsscH/PcnkU+FLpPedI0GEEKh8K4TpyyOuW
	fYrPQ+AMTAmGCKmmugsVqdsLXlVBK2mHR31dMO8vVosHZR0/JWOhs9XngdKcKHi9JoYQLjtEB4v
	23FGVBnR1fQPiZtbbwqtAjfHi3nZY7/dUOG+IMOiggez4KNwRQk15WUDD0njTF/q/MFUwb2pFgZ
	FrOJ/yg+8iru3n
X-Received: by 2002:a05:6a00:228f:b0:847:8250:2b2a with SMTP id d2e1a72fcca58-8488971d058mr6850755b3a.60.1783922889156;
        Sun, 12 Jul 2026 23:08:09 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a3c16d1adsm771795b3a.38.2026.07.12.23.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 23:08:08 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Vladimir Moravcevic <vmoravcevic@axiado.com>,
	Tzu-Hao Wei <twei@axiado.com>,
	Swark Yang <syang@axiado.com>,
	Prasad Bolisetty <pbolisetty@axiado.com>,
	Karthikeyan Mitran <kmitran@axiado.com>,
	kernel test robot <lkp@intel.com>,
	Julia Lawall <julia.lawall@inria.fr>,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [PATCH 0/2] spi: axiado: cond_no_effect and kernel-doc fixes
Date: Mon, 13 Jul 2026 06:08:05 +0000
Message-ID: <20260713060807.7-1-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two small cleanups for the Axiado SPI driver, both defects present
since the driver was added in e75a6b00ad79 ("spi: axiado: Add driver
for Axiado SPI DB controller").

Patch 1 addresses the coccinelle cond_no_effect warning reported by
the kernel test robot on 2026-07-12 [1]: the RX-only/full-duplex
else-if arm and the trailing else arm in ax_transfer_one() have
identical bodies, so the second condition has no effect. The arms are
merged; no functional change (on x86_64/gcc 14, only
ax_transfer_one()'s object code changes, dropping the dead condition
evaluation).

Patch 2 fixes the kernel-doc comments in the driver: a copy-pasted
function name on ax_spi_get_rx_byte_for_irq(), a /** block with no
identifier line on ax_spi_process_rx_and_finalize(), and stale/missing
member documentation on struct ax_spi. This silences the driver's two
W=1 kernel-doc warnings plus five more visible when kernel-doc is run
on the header directly.

Both patches are against spi/for-next; they are independent of each
other except for touching the same file.

[1] https://lore.kernel.org/r/202607121827.djB0zLAj-lkp@intel.com/

Babanpreet Singh (2):
  spi: axiado: merge identical if/else branches in ax_transfer_one()
  spi: axiado: fix kernel-doc comments

 drivers/spi/spi-axiado.c | 20 ++++++++++----------
 drivers/spi/spi-axiado.h |  5 +++--
 2 files changed, 13 insertions(+), 12 deletions(-)


base-commit: 5f1b513690edf51727e6928b97705b6437f9a98e
-- 
2.43.0

