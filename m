Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793372356;
	b=xvjbX74G4JneNsJgz99sg8DnFCwUJypgtgp+y7lHqdMMkGknbvaV70bI45sxjBcLZ81G
	 Jbs4w3jhxWKU8MiOgR4hGgLZCTRmXLZ27wA/0Cq0klcy0yS/VMJUftkn104CxmK/Cef2h
	 7hWUGtQqZxFN9dr1KPb4YPTbJg58COObg9HD7VlmwrAk9OrnOAJUDTeyCNxAQVVrSCyEY
	 n/p4dJbSk3hDSOFb5UkFrXhVOS6ghaGuf4XFQXx6iaqZ7fYiynetS8kt2fVM4Bgox4Xzv
	 JGsl70UjHdHdbNA4yJeaFCRrzsPNiyWLVuDJ89dogo7B6T/wfi+E2xsO2912zoxwH1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793372356;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hVkmZ1WIXgJlvQFHDNtXyCBnlHJBn9Ta4BIDwcxaHN4=;
	b=vQatIKvopUBSts/Uf2Hq3ghIVt/f2k/lQPY1zNhMAg5u8rT/459GNydVNLEUJE+RxtYq
	 2YlONgiyq6usRQ4lROydJD1fXwGn/T5syoTgWkRdeQJkyfLvuKwhyWIRysOL1MsinYPVk
	 YphL+Z4lkais4wauCw29n+nEyZv+AGg0TPTmHCRZGTbcfu5+NTqBOPb/3V0vV+AW40oQ5
	 gOJbbuVcoKLqWZmmstioNKYGG3b3gYzAh+Ef95fLzKChE1rNQlN0xr4teRPcadnkJt2YD
	 /8NeSz4Dbyqg/+zJEp3ESbjTMSWG2McWlMcW5KKJW5pE9saMjEX0dbPFsEZv3TEgvIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AmDxv0Do;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19556606A31A
	for <linux-spi@vger.kernel.org>; Fri, 30 Oct 2026 14:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19556606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AmDxv0Do
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e00eee27dso463397f8f.0
        for <linux-spi@vger.kernel.org>; Fri, 30 Oct 2026 07:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793372353; x=1793977153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hVkmZ1WIXgJlvQFHDNtXyCBnlHJBn9Ta4BIDwcxaHN4=;
        b=AmDxv0DokxBAxYbXPzlUeaUdPj6tdb+jyhsHSgcFGXoFqssoXxLGA6FKNIdvPZRdBZ
         5SMmdCPeejpwS9iTYvJe+VMM7zDCcPb87DTjDR+D3I/1+BYOGsho+BbDn+8UTLQrMZHs
         rnf/ZrwDplNUo0VFmyR7v4TLZdDKDcDMUm9RVFjn1BbMQAbp5dUyYrH2akDeVDbaqcSE
         bncUOzNvQMq8jiEWy6RY91ShRc7j1cfL7wlx3+6AzJppF5sk0cXGKeMF1ucSDrbN8LO5
         1tCT33M4yqlq8Ikjylyf98XukrrEcx1oaYLF/gXjSBzZwAH4PU13DlUeCQMjjslRndBy
         IikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793372353; x=1793977153;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hVkmZ1WIXgJlvQFHDNtXyCBnlHJBn9Ta4BIDwcxaHN4=;
        b=fZsvJtSMFkYWhkst7smUK2VzDEoNYS1sucfqN0Dkui4+YQR2vTrn1o0xJazA7TdNld
         fOPwntChhhgyqAf91XNNqlesadtHHw9MRA7ZHkhpaz6d3C5LLfDDSk6vVg/oWvVhPlv9
         fp1E3kj5U+h45fFonGDX/kyzAd4cVTPAOGmwaMHWigXSnu9hRrqg5FdzFFk6rywWOvS4
         ZrbEgOAxYwvu6QELkwKC+EhD5N7+Rznp2MBOcRZzzidF2/ZRJYmo/IiOcx47EUR1R8Fn
         +qDsJBcaT7TpGxomqsiU8pznOmPnrFmIMa9EJlRa8gtUG9EuvGLqmN9m4po5NWtlthNv
         gfUQ==
X-Forwarded-Encrypted: i=1; AKwUvBxI8q2aa3J80dy22J2TnBRtityFUZY0funChs2a3TKHNSsnL2v4jvurcpN7xh3C6e2JGGMIDflmeRI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKiCelVr6YV2dtzd72PCEkTbp8yDdS5w0HPu2hEuFab93dYwApH
	8fFSoKkt2LrrBft81PsFsC/YW4u5irNCytFc+/jUPoITNOqZXSzwDnmf
X-Gm-Gg: AYBFou2ivCK1mpECB2p4LEZhbd2rTQAqiGSvoPltdzE2IAYMf2+pV032mVDiJliZLLh
	WNCorKjV3VFNc6ZFpevQBOMTEJlBVguO0h2vKyPejEy6WVfNsOeQYHaiabozGB22zlqlJP6y3WH
	U3HT0T4GD3eHsMgEekygWKhS5aXD5OBdVjZroWCZzTTk7pLgiMh54ZfMd25nIXD5hONTC/orL1n
	Q8thappR25o3u8x6g6X/ZZIodZcQNgmnl0cR/oW53Fu3zGqVslFbxbSJQj7r3om6gD+kplZiqQS
	IHcw1P6qq4oxLHsfiLbAAUC/XU1t6Z1erE6wjynPrKpVA6iZBnMX+l78A4E54AMOhWmyD+W7kaF
	5foLsPVXSUSYxGaiS8fzS6tUjPgNbu5MoYmrauK/VFxhx0f3bI7dp8AwBJoFWd7uyuFnKPAKra3
	V4n9/nM+Aqv9SqrhOC0Z/+TzVKu/VXzNtw94P42KidmmkE56zWq3nDezXlThA7SbJ7KaAS7oQHc
	ZGLv+HnfWPKhnYF2CdAUvVep63RF72VwPmpUZVhCY5CXs4gYegC9xGJOL+EEJnD81ZLvzdewraj
	9uCumcivq/ViKdIPUZisnEafLGeqODtyxkT+8rpd41aOBXOwp4ceJU//uAIYVElRSNZFCrLCj96
	gsiW3hHXhq9LsoZpUQ9fXVZP3UyGnj3bT6KM=
X-Received: by 2002:a05:6000:2885:b0:48e:353b:9f28 with SMTP id ffacd0b85a97d-48e6e2c2536mr5889612f8f.1.1793372352925;
        Fri, 30 Oct 2026 07:59:12 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a1dsm3584086f8f.24.2026.10.30.07.59.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 07:59:12 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jyan Chou <jyanchou@realtek.com>,
	Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>
Subject: [PATCH] spi: rtk-nor: Limit exec_op writes to one byte per operation
Date: Fri, 30 Oct 2026 14:59:06 +0000
Message-ID: <20261030145909.285144-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
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

rtk_spi_do_write_and_cmds() issues a single writeb() to the data window,
so only the first byte of an addressed write reaches the flash, yet
exec_op reports success for the whole buffer. spi-nor hits this when
writing without a dirmap descriptor, e.g. for OTP security registers.

Such ops cannot be rejected in supports_op, since spi-nor probes page
program support with an addressed two byte write. Clamp them to one byte
in adjust_op_size instead, so spi-nor loops over the buffer.

Fixes: aca8cbecdd2e ("spi: spi-mem: Add Realtek SPI NOR flash controller driver")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260930071125.529791F000FF@smtp.kernel.org/
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/spi/spi-rtk-nor.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/spi/spi-rtk-nor.c b/drivers/spi/spi-rtk-nor.c
index 75856c31d2e6..55ea7c371854 100644
--- a/drivers/spi/spi-rtk-nor.c
+++ b/drivers/spi/spi-rtk-nor.c
@@ -357,6 +357,18 @@ static bool rtk_spi_supports_op(struct spi_mem *mem,
 	return spi_mem_default_supports_op(mem, op);
 }
 
+static int rtk_spi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
+{
+	/*
+	 * A write through exec_op is a single access to the data window,
+	 * which programs one byte. Let the caller split longer writes.
+	 */
+	if (op->data.dir == SPI_MEM_DATA_OUT && op->addr.nbytes)
+		op->data.nbytes = min(op->data.nbytes, 1U);
+
+	return 0;
+}
+
 static int rtk_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 {
 	const struct spi_mem_op *op = desc->info.op_tmpl;
@@ -449,6 +461,7 @@ static const struct spi_controller_mem_ops rtk_spi_mem_ops = {
 	.dirmap_create = rtk_spi_dirmap_create,
 	.dirmap_read = rtk_spi_dirmap_read,
 	.dirmap_write = rtk_spi_dirmap_write,
+	.adjust_op_size = rtk_spi_adjust_op_size,
 };
 
 static int rtk_spi_probe(struct platform_device *pdev)
-- 
2.55.0

