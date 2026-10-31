Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793426629;
	b=EsaTGw45mdKAuFeDcQJJCwyXzt74UUr3cCKPLP/uMMRKniiT+i8XMsvE0dewD1DibffL
	 BqGQNq6vetj9LFXo2xPis2wQf+0P7l39Zv/+aA52OUcVsyW7x5eBM4wvzpbCKiP/Uk2Oy
	 KTpbPsO9P6yYWIjwjqh1NewwLPWAg90TKFF3t+DrAVpEMiW9MRnwRZsudHaEhBDnECjII
	 vwQGhery49oD+d7WyxIW6YQigib4jywO7IIcuTTqNh41LtU1YrszDNPxGheV6A1U6ao6K
	 6VTBXl+utLA7wWJ7ZO5q97sEMXHl8U5HK56elFQiSCmFnoEYjpxcVunRlgoGHTX0/fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793426629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ZnHzpDNAsYwgZW+/BH7mx2GO7ajwWfSCvotHqaQHR4k=;
	b=rPazj7yw2ZxUIlqckGFm8JGnchUSxHuYStxuIUYH28U3RV00SocgCqjy/w2Ay3u0CtQX
	 KscgEjmlBa8vJj649fNOZp8S+DOSmZ5nb9Ov7PHoe5luYkRWBpB2VJmcKAGc8gmlWwhCG
	 W+sYoKgt6aoYiT3cN/U7YpgW0MRw5YUsk+ri+1sT1ilC+hyD2rVWmWk1Uxpp5yS4/YUxY
	 e1paQ0amr9/vEtu/kAw4BjmGmBjkdTfvgAE7eYP1ddntzCNpVNxcR55YGesNkdp9YVm5l
	 lou13SPXV+6HG6oXOOEYMaUXlf5bppUult6phLRQS0SFOfcjZK2P3uMku9FGW1ctDGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FukbCKf0;
	arc=none smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F8C606A31D
	for <linux-spi@vger.kernel.org>; Sat, 31 Oct 2026 06:03:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6F8C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FukbCKf0
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-33fb4680717so859373eec.1
        for <linux-spi@vger.kernel.org>; Fri, 30 Oct 2026 23:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793426628; x=1794031428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZnHzpDNAsYwgZW+/BH7mx2GO7ajwWfSCvotHqaQHR4k=;
        b=FukbCKf06+gFykKXBYrHgaupwkigiMTsPqp4vmDTtHgqtFGofaur3OblXZYNCzY/Gh
         r7tm+B5mVs/EI0k1ez/FST6AutKSTauCYHfJPTTHcUHcTDuWKaGIZgsDAWGgi0TYHJ53
         ++C/tu2yDh6Fi0nUO+9Ax7ya25G3TLN+KNneSQzHNDxr8qgGuYHUrhvs4nlRsdTDlyBo
         41lY6Ko9POzLise32MxFcxjrsPwlu1ZXEYJslWkWCJDTBbR6q6cq/JmpbW3XV5ou3i3d
         6/v5EVVufR9aDVlqS21xg6mOAS/z02IoKaIUfjZyQQkGLJ6iWWncNUXB4stZeSuIDL7u
         hxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793426628; x=1794031428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZnHzpDNAsYwgZW+/BH7mx2GO7ajwWfSCvotHqaQHR4k=;
        b=yY6yimngaGNA9DN/v06cFBvIGo6npv5d4fYA2T4/i42m+2J2WiAqYRfIbdoGkqAjHY
         R34gzVkC9GNsWv4rvXaG/tZQfm1psz98TXaoXT2QlfaH9pBcI9R6AqQtDtM8vLFqWMxl
         t5X44QM/vm/jnW3IhP1QLYI6nAYCcA041/9vBKj+wogUlZf8o9I0Nbxgsdb5T5RBxFmO
         ro/g7ywEaRP73iHZRDWTwMujK17sIm6rP+tAmLACNJ3ncutO5reguPVqJogaH7u86Gp5
         gu9Ktp2bePwVOzGjj5uIwz/mEQrFPE7kGZnefN5NVMZVOrkW9a9Uqgcqb/xwnCQN63k3
         pt6w==
X-Forwarded-Encrypted: i=1; AKwUvBzRoX10sSCjJ3JpA9Ln2oK/gO6B8Sd7EHm83ssQqhfa7TCUXM7ccNzuqgFKPrkSlpmbIgbumtNsqAs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSdaaBau7z5YmlU87H40H/YbT+NYSRnxxaklREyezam1uKkXb2
	ycy7fBw5VzikQYKFgzqbQomYn8oQNRe6khzrfG1NB1/z/BYJvW0/Qfr4
X-Gm-Gg: AYBFou0k1n//7zoVVMlC1M8jN4epbh12B3zYIR2jE2L1R75h625UV3iQGEa45mH8vPJ
	ef3cfmgYz3abIGCKdBLmMM0SRtNmiTdVtKxvsAmE0xircJPhF+75yO9norl5bFD0g5unycNd7wk
	xfhWFqf59beCtfwk6m+Sw3fUl9nuS+zQKF/2kQNCsnCdmAouxMXSz/iXCErhfisSmV8hmUTnwT5
	w/OQs2FYmeozztG8j8AcdDRL0PffxYlmJM8dIM0fg94W6WdWtd2vn9hyw7/BTKId+U48muNTurH
	BnBSij0d7v9XkWM5tJyMR6YE1361Y6ON+a0uzpAYa1DOP4BJ2uC/LThEo+J0U/iZB7R4Q4Z6+Hj
	5VX7tceuI4UZqWanW1OAIv0DBMVCIJQlEvnZE1x5hCc2KD+GSXCg84+cuyduOfvK+4LRGaImd5l
	4gicf8H7jY3kaqGHI2NtJ4OlgPtLd/fUVpgXMR+NJcbGaecaLnbXrW2JtO4YuFDhNm6UFxtYoJp
	i3chK0z2VoTcpPjD9olSRG9VWchWJsikqyOf1SHbGNMtp5DARMgQmMnL8AzqejtGmTEwfRlcYxo
	e7RAO13AJH+xRrSMiBLddFzX1WM8JHuXfCN2tzB1mZNcUjgOvgmtZzam2A8gNOYW+68=
X-Received: by 2002:a05:693c:65d0:b0:369:f7d2:d7a0 with SMTP id 5a478bee46e88-36a423c5d12mr6714625eec.25.1793426627830;
        Fri, 30 Oct 2026 23:03:47 -0700 (PDT)
Received: from asahi.tail4da9e3.ts.net ([218.48.198.193])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428af91bsm13254968eec.8.2026.10.30.23.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 23:03:47 -0700 (PDT)
From: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: "Baek Kyu, Kim" <pocj8ur4in@gmail.com>,
	Carlos Song <carlos.song@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	linux-spi@vger.kernel.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] spi: imx: Avoid PIO replay after a completed DMA package
Date: Sat, 31 Oct 2026 15:03:44 +0900
Message-ID: <20261031060344.94687-1-pocj8ur4in@gmail.com>
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

A transfer can span two DMA packages. If the first package completes but
preparing the second one fails, the helper sets SPI_TRANS_FAIL_NO_START
for the second package. The driver treats that flag as applying to the
whole transfer and retries all of it through PIO, sending the completed
prefix twice and reporting success.

Clear NO_START after a failed later package has been unmapped. The driver
then returns the original error without replaying the transfer. A failure
in the first package still takes the existing PIO fallback path.

Fixes: faa8e404ad8e ("spi: imx: support dynamic burst length for ECSPI DMA mode")
Signed-off-by: Baek Kyu, Kim <pocj8ur4in@gmail.com>
---
In an arm64 QEMU/KVM kernel, the SPI core and spi-imx driver ran with
modeled MMIO/FIFO and DMA provider callbacks. A 513-byte transfer
completed its first 512-byte package; failing RX descriptor preparation
for the second package made the original driver replay all 513 bytes
through PIO and report success (1025 bytes in the modeled record). With
this change it returned -EINVAL after the first 512 bytes and sent no
PIO bytes. First-package fallback still completed through PIO. No
physical ECSPI/SDMA device or external slave was tested.

 drivers/spi/spi-imx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 79a6c1a60b0a0..eed1936388aa8 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1968,6 +1968,9 @@ static int spi_imx_dma_transfer(struct spi_imx_data *spi_imx,
 		spi_imx_dma_unmap(spi_imx, &spi_imx->dma_data[i]);
 
 		if (ret < 0) {
+			/* Earlier packages have already been transferred. */
+			if (i)
+				transfer->error &= ~SPI_TRANS_FAIL_NO_START;
 			dev_dbg(spi_imx->dev, "DMA %d transfer not really finish\n", i);
 			break;
 		}
-- 
2.55.0

