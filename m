Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746103;
	b=xztOn62WDqfbjSTGkBcYksDQ1tG+XnUebroFB7DNn6TgkqBzB/FQ7Fj4rYgVcd/EfoKi
	 bDtEMB69LLS7rzKgq+RuX54C/2bbN/4pvP2g8jqxGtrZtHFi7Jm5QIMasfy/ByCUfXrP1
	 mgeJUM7h/BVQ1UrbyhqL0WtZWcmatzhGJBC7Dn8u4p+P3NSOO7eRSbnqHS1kZRfD6M/FE
	 exRGpgWHQr67F+/m0aTK4QOOltVKmhxhUMdQd+Y6FuNA1cxRyBfNPQZ0hISqwlRlliw5J
	 XK9f2+78i2jI4eVfhysCClISofpy/tDex4Uj3BvuiF2AUzCsANFzFvzNPiMTdDXG8Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746103;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vW1iUqFZlVR39jLsQ+HyhCS0JP8FWv+AEbr7ZP65ZLw=;
	b=J2QJLK9jNhe8lXs1mP188/oSf4WzVMaJyLHQUwwMkIhEQ29x2rJPc9xxHx0sg8z8F1iR
	 4vinI8jiQxGKKJCFZLnsZMNxtsxcLbADqxpaBXUoRM8L673Dp/tszCahqZReZbmpcUv1J
	 BQpo9bquM0p/n1t4gJKmZQRVfpGpAoBxcLvZtRhndJDjLPRyY8GLykS7fx1P7ubI61S1i
	 kBiXJH9Uq9D0W7jEZYlKim+f+0P23lTOjixGsvxwupsCHmjR9rNFRZduuaZGY1IlgZZCg
	 OHc8hPgv2e+t5gn74gR/VasyZYM9kLuRfqONnQCunOg6vlggPlBRLuYoP5QcpE/LeLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qrCcGhj7;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834F1606A329
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 22:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 834F1606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qrCcGhj7
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ae7626d14aso95304a91.2
        for <linux-spi@vger.kernel.org>; Tue, 03 Nov 2026 14:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793746103; x=1794350903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vW1iUqFZlVR39jLsQ+HyhCS0JP8FWv+AEbr7ZP65ZLw=;
        b=qrCcGhj7gUHoy9/9UnsO/n2fO59HKjQDCOgKNwBGKGFpq2lM/GNP4UxTIK9rBP0JMo
         D+ME9U5yK/f8kXB2GqPH+zIZR/Z0LFL8SvuSvWd8xQayNi9Eva2aWmyf1j5ndfSIs5uG
         Sr9FTTQOu9GVQh1SJFDFhrnIKZ4wwy2bDidHSay6Id0o1MIVKHX0ZFImOSLEdXFeNXQp
         3x/IAWxqqRAOIqHuhrWR2Kftg+ulKwSXwD7PmWmFdxSyXlRn8xGcQS9yUepFjomhzd9C
         1wRh3yROApgzuDoz8gSbusWMFZtUvVNSgsBJIaRpCPp9TIfT1Ltgm7VJEPPjLJ5AYBdG
         UDBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746103; x=1794350903;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vW1iUqFZlVR39jLsQ+HyhCS0JP8FWv+AEbr7ZP65ZLw=;
        b=mIEQvAsJa1Rcgwxr/vY4oTSTVAeMHWllORyRO5ybZXJuOvbJnJr/awaTPVAj8tuUao
         No3Pctj15wFAbQKtc9U9kcupIrNcJRyw3sajRaoueazwUTEFcsz2EUjDFnZxMRIIm6vf
         DwGAkT235DXOU5KuinkFfgDuQOAjCBWZH2dKXFWOdrPjWEVjDvCF832M5MIh6fqeN2cu
         nZCUGxQQLVT8sG3lN4Yy+N0QqUhaABtGS/i7a9uAo1dYaNulBAruzO8sk+dBCs3DvNIr
         0gZ/3rAT0tdlQicuZT82Lr2EhbuFOmU0y5fyaM7NHrF5hxRVgcrwKI7EGA8sTXTjg3sp
         79iQ==
X-Gm-Message-State: APuU4Z8tgvrV9enaqbXuyZCsLh4YF/uUDqRE5QlTHItO6iG323KnTrOG
	IdlrRhuVf3HkZqmND7EUqVSByakuaFRiiYl2w8p8hSJY6Znpf5c7Rzll
X-Gm-Gg: AYBFou2c6PhDWGfbZrOVqKSyxAmJWeecNchYfeIib8oqXpLCTGOMn/qQkMNIiOP8voC
	bOgzxCEnh7fsiFAoz6o89UNaTVC3SGadSbdkXx4rYKvj0Ncqff93+3D8fo7YoMXrmZu3ZDIhQtH
	R2L2oKNY29tJ53jSnLvtHVvAH1AYISvqMkPRtonhM43pKiOCkbsHufprvlOx7Fi6OQ3O58ovKwr
	UvLa7gKatUFapZVOdJ06TIhnjM76upWh+nay3fuQ6qh4lDvOAnyzZdi9Mm0GzvGfCw+LpmKeTJ7
	48rqhxWT9BlKMk81h+/rtlQVatAetoapQpfcRG8DgqhvPgHRotqPQ/CxUkR3cOa0F0ykIQpp0oV
	N5ZF41/cDfNLokV8/n63BL2yYg8OVvutgU8T0Z7bL4rP9fKfIkcCPQYpdFo1wlqstPBkJksmbVa
	PONpxsKpiUU3A3RbnNek2N7lCNU0u12uNyMg6GEhLhBLya3UtkfAuRlAXJ+Mn9Ujw2og5oexEVT
	GDmxuQB48nJeTWWikvhPrePnk5ERTild71gE5H9wFh++8eoDMWPCFUvScZwzJjtstbwpK/ParMa
	1yAS+PDyHdAThB27Ft1UqDqd/dQGZ9WIfvdN1dPAU1OJ8wpDde79SBfk1/8unjMWdHp5WkNkjsv
	ks+I5xH8CxwsC8sr0LKswwRmWGQ8Av1w5dQxleM1K46mEVRhOGopi6imoi9vwxQ6KCKjnb9rVBZ
	bQ+aoADz1Y+JMTuCkydxbS66hDyqJaaPdPhTYIUGepBYJNwfC7y4FdrPva5E5dcA2mmA==
X-Received: by 2002:a17:90b:164f:b0:3a8:59d3:530f with SMTP id 98e67ed59e1d1-3ae8983e34amr12373052a91.57.1793746102724;
        Tue, 03 Nov 2026 14:48:22 -0800 (PST)
Received: from josephctchan-96c-1t.c.googlers.com.com (95.100.125.34.bc.googleusercontent.com. [34.125.100.95])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0982e9284sm129962a91.11.2026.11.03.14.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 14:48:21 -0800 (PST)
From: Joseph CT Chan <jctchan@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joseph CT Chan <josephctchan@google.com>
Subject: [PATCH v2 0/2] spi: unoptimize message when queuing it fails
Date: Tue,  3 Nov 2026 22:47:51 +0000
Message-ID: <20261103224753.3610049-1-jctchan@gmail.com>
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

spi_async() and spi_sync() optimize a message before they queue it. If
queuing fails, the message is never finalized, so the split transfers
and the controller's optimize state leak and the message stays marked
as optimized. This happens with -EBUSY while another device holds
spi_bus_lock() (for example mmc_spi), with a stopped queue, and with an
error from a legacy transfer() callback. Patch 1 unoptimizes the message
on those error paths, and patch 2 adds KUnit tests for them.

Tested with KUnit on ARCH=um: all 7 cases pass with patch 1, and the 3
queue error cases fail without it. Not tested on hardware.

Changes in v2:
- Split out of the v1 14-patch series, as David suggested.
- Patch 1: added David's Reviewed-by.
- Patch 2: inject errors through the fake controller's transfer()
  callback instead of mem_ops, use designated initializers, and trim
  the comments.
- Moved the AI assistance note from an Assisted-by tag into the commit message.

v1: https://lore.kernel.org/all/20261102163023.2574632-1-jctchan@gmail.com/

The spi-mux, spi-ti-qspi and lock context series I am sending
separately are based on this one.

Walkthrough of the bug and the tests:
https://gist.github.com/joectchan/9a14b5e6facb75058ebc5a6ff1757131

Please consider this patch series for the next merge window.

Thanks,
Joseph

Joseph CT Chan (2):
  spi: unoptimize message when queuing it fails
  spi: add KUnit tests for message optimize state on queue errors

 drivers/spi/Kconfig                |  13 ++
 drivers/spi/Makefile               |   1 +
 drivers/spi/spi.c                  |   7 +
 drivers/spi/tests/.kunitconfig     |   4 +
 drivers/spi/tests/Makefile         |   1 +
 drivers/spi/tests/spi-core-kunit.c | 262 +++++++++++++++++++++++++++++
 6 files changed, 288 insertions(+)
 create mode 100644 drivers/spi/tests/.kunitconfig
 create mode 100644 drivers/spi/tests/spi-core-kunit.c


base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.56.0.385.gac671c819a-goog

