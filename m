Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793015571;
	b=45gEnn0sbAhfJmSaQ/yzImrQE6jF0qi9nXga8cS5y7Zbmpf8s4WicoGRl+iY1CWFTeGD
	 fbncBUUJFSa+OqoVvXocGPh33RZ/vOUaeR6iQnLsUuRTjCoMmMdzMQstJktOK9r3prwHn
	 P/xW6GsJJwO7piXA0quWft7uY91Sy26/WxkL+nLuLHMeLR3xSvLHXA1bjdv5fH/1TO59I
	 bkzBb5NubUSLqOUxe5CWuM+VCjrdBVNZaxYlUP+I4kDfO1Th3oTzxAgj/9/oRvkQOQlD7
	 p4gQd23yrAWLIMWXPyCLxkCENeGcYcWMvBhTSyCuCAHYD0MTaIJhK8sn6Sa77pfYDzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793015571;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=q4qz4f3w8qZvH+lfEWnJgHnh5JL7fX33lsldO436874=;
	b=s76jlBnD2l8AMmuHxoYrpd6SG2waa42AMEtYsifKWWmCCv5IN2xxpq85ICrdLVpg+8pT
	 Y3Dohtv9oIlSHYbETpuSmN1kjndoDN6wkJn9CHusv+i+cjfqMyyHuBmJcvZAj8fBiR6P7
	 ltjiNh11keMiZkt++ltubqHwrvodooN9sTz9KthMs8ayklDUg/3D2rZREJ0qRk29d64Ns
	 CgA+PApR9qW+L9U/HymscZU1Yl51rUdpLdal9nWWsbn1D7WRBSdgCTvjPPWRdtE0Eq/YP
	 bJmVL43RT6a28Ab5HM6iwIQg1mMk4iQCajchft5iTtIw1CdWWHRjR5+LS7+lu3hQwGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DE025+Ft;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579F2606A31E
	for <linux-spi@vger.kernel.org>; Mon, 26 Oct 2026 11:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 579F2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DE025+Ft
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ae0852df46so797342a91.0
        for <linux-spi@vger.kernel.org>; Mon, 26 Oct 2026 04:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793015571; x=1793620371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q4qz4f3w8qZvH+lfEWnJgHnh5JL7fX33lsldO436874=;
        b=DE025+FtBNn4VeEvMFR5gBWQ5Oai9mVpesiny7S8dqECCx6kCIRfZWvKX8hSnDiBhh
         3euXFRXyZFF9U4zXPEAwAeJmcJhrfH9T8eIig1KskiInFI3JhRX50esPoQ6hiQvJhYFK
         ItscDTwxEFIAR+CELhFji6Juk13MYLHathnAhni3KgMSKN94q30Td5oryUw9+D2DHsNk
         Dn9MOqNIPx/3KYQQe2p/Kr67HJ8QVolg4HwWrGlc9PJnJVQEw07xweP5uo+B/5YpdmPA
         5wMxwbORGeGxTS57+xV9uI8zofxG1a1TtKcxkuB9niMsFlAhyK8WROJkhEzT4nNJrC8r
         lseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793015571; x=1793620371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q4qz4f3w8qZvH+lfEWnJgHnh5JL7fX33lsldO436874=;
        b=I0o5XBhsam1ClDBF8P+y1gL/EFs93etwexSctniSkdxkXFVeconuHFUU3NddgkZlSV
         jb5873seQWCrrgB6Ai33tnmO9l6/u/E1XNOhFGjvHvtJ943I9fSPUWydT4O3O8ZR+TGG
         AAjqBSDG+TQ4ZCXIoFVJdWbovlHzhkIO0WB6jKMZNbst0xQ2iCFgrbJR3DvdZunDmYKJ
         Vyc28VzJDoKZBZjvLi1QCA7qGh4kE5ffVuuy1aS6OUA5ea57w4F/UySxT7GKfSLQK56N
         SfDARi//GhJ30EAfuOiZD0mp0a4lff/6iChhLrvjKI9qQxdEpwEvgiGuHaQRlG7TbHCd
         TK3A==
X-Gm-Message-State: AFq9FYIy/q8N2wzh7rLvFd3dvpfzKvgVAzdWEpbW0Kh6WgYc4Ucf8CBV
	YA90Qyip3D0jEQAgKXk+qGOgHSJEVqhCVxi7jN0HmGUEY++/MLE6OxEH
X-Gm-Gg: AYBFou3ybUirB/WKqrq9fh9xs2hgtzod26iPnn4jWz5/i1OxVQCTIo0ykN72iZVrx4l
	3Ermj2vObGKJcK8RSO1cRlRveLnqChozzys/viBHX7so3z1tngwiPbO2ZR1xnY7jWgvbVpwXO5Z
	2O/DrvXgMspwyt9cWWs1DdKdEBelHYLM55QPKwJRQlgaf7yFnJUsrTp6bI+sVYfAJJ/BoHPqNGP
	3UDIzJrr8lH3sLF+vsDstO52vkU/jHVdPOVHNGMC/G9FFwPHQG0Rx315E0tvcqNQRKiX9FqmbY1
	eksHdA8xmbiPqB1RaYM5l6YrWdHNNY8a35iPcO13iMJ0u36+aNfd1vyJIAXJHm7R3rj/6qEXdzn
	d+XD9+4c9ivAV6kC5+YBDDEAgPokAG+EVquIoCcqJng0Bpwcv6s3hliSonVXm1tRxdHk7oIRLLN
	kw1zrWCmEodfsuBNo/YZey8Hl5h3zqO4DNzooOntZN3Is68629kZvrpN5Sl/lVKKWkI7IJuxVkK
	+/Q5mCNNM2VRuMQcMeDr+GfX2C/YSn92pkXieEfk4DvRayiP6JkNH5ZiC+X58YRihEBYfkiRY8=
X-Received: by 2002:a17:90b:3d4c:b0:3a7:a485:9d38 with SMTP id 98e67ed59e1d1-3adea093f2dmr4017214a91.5.1793015570761;
        Mon, 26 Oct 2026 04:52:50 -0700 (PDT)
Received: from spiderman.taila3fd8c.ts.net ([202.112.47.77])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc21026sm1374699a12.6.2026.10.26.04.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 04:52:50 -0700 (PDT)
From: Li Ximo <lixicaicai@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wang Haoran <haoranwangsec@gmail.com>,
	Li Ximo <lixicaicai@gmail.com>
Subject: [PATCH] spi: pic32-sqi: guard against empty BD list in pic32_sqi_one_message()
Date: Mon, 26 Oct 2026 19:52:19 +0800
Message-Id: <20261026115219.3528114-1-lixicaicai@gmail.com>
X-Mailer: git-send-email 2.25.1
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

From: Wang Haoran <haoranwangsec@gmail.com>

pic32_sqi_one_message() accesses sqi->bd_list_used with list_last_entry()
and list_first_entry() without checking whether the list is empty. These
macros do not return NULL for an empty list; they return the
container_of() of the list head pointer, i.e. a wild pointer into struct
pic32_sqi. The wild pointer is dereferenced immediately (bd_ctrl flag
update) and its bd_dma member is written to the
PESQI_BD_BASE_ADDR_REG MMIO register, corrupting the DMA engine state.

The list becomes empty if a message with zero transfers is ever passed
in: the per-transfer loop is then a no-op, no ring descriptor is moved
into bd_list_used, and the code falls through to the list accesses.
Note that this is not reachable from userspace today, because the SPI
core rejects messages with an empty transfer list in __spi_validate()
(drivers/spi/spi.c) before they reach the controller driver - and the
core's own spi_transfer_one_message() likewise dereferences the first
transfer unconditionally. This change is therefore defensive hardening,
found by code audit; we do not have PIC32 hardware to exercise this
path at runtime.

Fix it by bailing out with -EINVAL when bd_list_used is empty, before
both list_last_entry() and list_first_entry(). The xfer_out cleanup path
tolerates an empty list, and normal messages with at least one transfer
are unaffected. This also matches the existing list_empty() guard in
ring_desc_get() in the same file.

Reported-by: Wang Haoran <haoranwangsec@gmail.com>
Reported-by: Li Ximo <lixicaicai@gmail.com>
Signed-off-by: Wang Haoran <haoranwangsec@gmail.com>
---
 drivers/spi/spi-pic32-sqi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-pic32-sqi.c b/drivers/spi/spi-pic32-sqi.c
index 5d3921e29..005bb6a0c 100644
--- a/drivers/spi/spi-pic32-sqi.c
+++ b/drivers/spi/spi-pic32-sqi.c
@@ -391,6 +391,12 @@ static int pic32_sqi_one_message(struct spi_controller *host,
 		}
 	}
 
+	/* a message with no transfers leaves the BD list empty */
+	if (list_empty(&sqi->bd_list_used)) {
+		ret = -EINVAL;
+		goto xfer_out;
+	}
+
 	/* BDs are prepared and chained. Now mark LAST_BD, CS_DEASSERT at last
 	 * element of the list.
 	 */
-- 
2.30.2

