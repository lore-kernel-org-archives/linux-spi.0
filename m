Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218CC3358C6
	for <linux-spi@vger.kernel.org>; Mon,  8 Jun 2026 02:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780887019; cv=none; b=RXKPTAnmAptcQUNy91icFUqrNkOxsylxIoNMDtJLTA20tSe54YGgOg4yuWN44BvwQQ5DV0z+bYRm9twEk5fjABS+ucRTHJd2NyxUzdqVu//qz803DuZFSiprJ2v+l+dyb07E8/f55gGgAWbanwt5TgwO9h1Cg/nxsXXKTMKyFak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780887019; c=relaxed/simple;
	bh=jAOSPN2oexTHH3AS+nKz9qosEcTRLYOWrtO5vDxx1vM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dNZ3UQzN3lhKaCGzOZ/avQTU/nAKLYP+oe/Cr9QmiYurT16MNQVribNMAbr/CCx4lR+sQZIg9+2E6QxDYymliQXDK93+ep5g0sfcXRh7TexQ/pgP2W8hcehEs+D3m4ZgNfWnfxJCnmrCbwbGvVATdNn9TQbgUI+/eHdwkipZQxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dDRzZnYC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dDRzZnYC"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0c2c7d45eso33799775ad.1
        for <linux-spi@vger.kernel.org>; Sun, 07 Jun 2026 19:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780887017; x=1781491817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fw5nXFVyb5GRYqiTkdD93jih+EMJUvklwZZGtUHOoyQ=;
        b=dDRzZnYC4hd/p07DB2130bIkHSS2BgPoSlG+OoSCTZHloTua2oEvpkjfL4Ucx8B5Tf
         9GCiDJ8MOM7rny8eoqC4jkndeHg3IfvYGwVfPBOwRLWePg8RcoFJz2aTnjSAuv5/VvnX
         zfPA6ynTotJx5bF33bNosa/yF8KH794evRhRFLbU4qVEjLRq1NzHG9HGCVsC9pK6qZbR
         5glqFtMYHtFRlXomwMWQLk6FotLspSAhgzZDxe/aK2M50GJt77YhvFmZhZUIzljomo6G
         3RslPX/r9oWPub84Uug3hewJVaypDcgMzSTN9W+zq0lrkADlj/QXALoFbdtsYXNIVGqK
         FGnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780887017; x=1781491817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fw5nXFVyb5GRYqiTkdD93jih+EMJUvklwZZGtUHOoyQ=;
        b=dIRwaVBCCIUcsNaKNvQRnmZxx77YczTBmjq7ZItOd/3g5/sqLfD0lGu82tXM/5A43C
         FVuqCw7qbXgpuS6s+1I7Zxood8zkWPDVJ91T2+XD3XIR7i1uMh2yr71DP6EU3n+AMvo9
         D7+KpPAMcCGltwwcDH3OCED3oSTb9VTQZD8ZcMvx5JeHChfFhgh+SjvEZ8HPClhnQhm7
         SmwSuTysCrYhj6DMRp+bm8A83E9FsK2jqLEZAZohYGnr94QY64zx+hxJwMw1n6vAJHLn
         /VE2sPkiQlq4osnDwP4kUJD9ZUTOugUjVUa+ESOtZqjcyat90RmGtSJKAwt2SoMTyhIP
         gDew==
X-Forwarded-Encrypted: i=1; AFNElJ83U7YkrtKBzGDLnz+87PKTHz0BEEiFUhEVGTdQ0lZHO1l6T1YxmIfLCja9IgNztz5Lu1M0Fw8PkKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz91beP60tHMVAoaoVq9+vVbpsBzAYBbK73pkgDyzmqAoRB0v7d
	S8/vkx4pg4/w48habu/fqj08fbwmmiEa0unk1PN5kKpnTvRJPhuNSG0r
X-Gm-Gg: Acq92OGsM23BBTRZDjA9tlz+7OC+PAIDgp0dqu9AMjTHot3AL+fB25S73iK2S0hOJId
	gjHEpdfJz5Jtt5ARppYepFgOkgt2FaX1sXomMsoiCQ1k2+PJFSoJWaXFulb+rQ7hcmJnn18Sv/C
	pjEzsF+WFlZqn5fvjgkU36rWT0f3AHGyO1tpMIeQFfzgO2R3kRFB8G/IVzdFGOZ5C/KnW31kv2P
	8dDyEP7chwFqlGTQjoinfwSzfoBbXwJFfhQbimtr11Zm8vjRd7P8SVD6axMhgBV7uaIhsZQPjDB
	XBtDKuwxCgR5+3nshVPOQkjnJbARjXH1ai82AwWIUWDSqcaCE5U2OMXr2mu/+asBqCsQsXczapk
	7EqWplOagSbG1Xa32MsdM8IsCPvL//b13OosnMQJaqLp1ThOJzV6EhJR1JeKnb2KGANKmnzsqew
	LDVhGQ83VqAHvU0gwDaQGVjcRW0ORKtepK45aUyhxuesTz2YTd0rQs+coXVs1djUg/mLs4kAMcr
	HRjPp1xE/JqGcT2vqI=
X-Received: by 2002:a17:902:ccc3:b0:2c0:c38d:9d37 with SMTP id d9443c01a7336-2c1e849534amr141810325ad.25.1780887017485;
        Sun, 07 Jun 2026 19:50:17 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d211sm165745555ad.3.2026.06.07.19.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 19:50:15 -0700 (PDT)
From: Chi-Wen Weng <cwweng.linux@gmail.com>
X-Google-Original-From: Chi-Wen Weng <cwweng@nuvoton.com>
To: broonie@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cwweng@nuvoton.com
Subject: [PATCH v2 0/2] spi: ma35d1-qspi: Add Nuvoton MA35D1 QSPI controller
Date: Mon,  8 Jun 2026 10:50:07 +0800
Message-Id: <20260608025009.1504971-1-cwweng@nuvoton.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree binding and SPI controller driver support for the
Nuvoton MA35D1 Quad SPI controller.

The MA35D1 QSPI controller supports SPI memory devices such as SPI NOR
and SPI NAND flashes in single, dual and quad I/O modes. This initial
driver implements a conservative PIO-based transfer path and spi-mem
operation support.

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
 drivers/spi/spi-ma35d1-qspi.c                 | 622 ++++++++++++++++++
 4 files changed, 695 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,ma35d1-qspi.yaml
 create mode 100644 drivers/spi/spi-ma35d1-qspi.c

-- 
2.25.1

