Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792664492;
	b=H4wpGqQjWKEnyoXt4NhuYl3M7QaMCRvbjfuAVAqH2gR2Zgw6+0Xk1+4DylFoeCHC1Hor
	 f9KipugS6BWcAZqpZzGs0WXh3B2Qfb7No4kt5SvHmnw/BTwHHYclc3APqEpx/qoruTbcn
	 Nw/92g5Zjy/jIW9aYvYhl2Q8Dal9F0DCmnH/PTQvbNwVxXWTTGMSJ/gh7nV8b8jJxBgYS
	 c/SlgYJjkLngAaoYPy7pvv2jE5ckRoT3fueJewNsTzyOW5qQ/LVsJT0R5F9ukxj1Ij7vC
	 Cp7UV0iSVmLuNiTdAcrvtiltZRPYQFsYKdEprI1YzRxS4i44F9PbX6P5zhc+7Pd0Idg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792664492;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=YBxTUn7ywMgpmSnO6blmLwOaVhY7BWSoJVdPqCPYsuk=;
	b=NlaoC5aEpO80LI0hrfIW//lNJZOtAxzxEtZk7CjGy6qLMXszSQl3ENuv6jV1BT25c3rq
	 KuzCP51zfJHluiX/N6S3NJd23olW5I5pltknLQzG9fDmEqRfsmoIrjkXqs7I2OAJrGKkI
	 ScmmEWnDHGyIbxsB7lXSmLffH2Hisyv7voUeJs1BExqcQaOjM7x7ZAarMM8kbyL1uUovT
	 qoyqIMM8yIpHDE9/zuz7BA0xoJDgIg10zxvOjnkFK58ZtOl7NT4uKS9q98fsb5DbnEpbs
	 509G+StjJcjTPN/8F//EyN0GYVGFxinh3htfwdBeUIj8w9BIhjEu+kTVbSGGY1xtA8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E43OUbuz;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADD3606A31A
	for <linux-spi@vger.kernel.org>; Thu, 22 Oct 2026 10:21:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2ADD3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=E43OUbuz
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a06e79e152so782984b3a.0
        for <linux-spi@vger.kernel.org>; Thu, 22 Oct 2026 03:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792664491; x=1793269291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YBxTUn7ywMgpmSnO6blmLwOaVhY7BWSoJVdPqCPYsuk=;
        b=E43OUbuzxm4EzJfgMySiC8Ve7HyD5qb7yTndMUJFtP8nICC6fK/ULXi/5juq8CwXim
         v6c3TTMTNpJDP1HOJ+e3WWn6pUEqKIC/HT3NnsMEuzn0rxAqv+VoZr/GehiaKMOu25d9
         fLHj6lthUA/XuW/ZN9kSxD3P8nB1r8dFcXySzSrBEAHADpgqKC4ri8ng1eIkIW/VZMeW
         UE/j9sCuTYjtq4WSg6YxhWhf4EmDHC9plDTdgq7CpP/AP7fPguoc204ZEDlGXnuJpjIb
         hn1bRWEIQGT9qMsuolIJtU/fgSn6re69SBr7Zg1LWfwOidMh7L6Yk+h/CN4fMBBEkYuc
         1wzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792664491; x=1793269291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YBxTUn7ywMgpmSnO6blmLwOaVhY7BWSoJVdPqCPYsuk=;
        b=SC9vc7f0+Tvw8P+ko5p9v4vdXs5oRcM3axk3V//GSELxvlh9AalOI1jdgzzbPOKhWI
         RHL9nKUpf5sEKyajhf31gvjqoPpHgvBNysTKaDXXrl0zTfYnUxQo8kKohtoVbu2a3ybb
         I60AtynV+vgBFsUQI0hX4rSPvMwxwmM/knbpXh7gG2m1oTOOjs+A9a49y6V1cVVs2RuM
         CBMlXykTimjWdfG/w9kOuTIAFlILwkrib32jVCW5uX3PSpk/Yz6tyu7Hu7QaXRtSCGTu
         PnnUUdlLeYsmVIrJY8s/sOFRNzA625b5902WzbLUuSJp+bhbaUgKeOofLKRbfLYwwQFQ
         P3Jw==
X-Gm-Message-State: AFq9FYLYn0htcCakxHP83sHRhFPipdUzkSFovs3k0TISCRTpU1Qbm46J
	6Y3mz2vvSqpfuRH6YYmGH5/wKqOqv28xPKy6tl1fWQM/TSeM2+8EKW7p
X-Gm-Gg: AYBFou3Lk3vB7Vb7d0rabznKAGHtMZ8rW4eDsl8+J/AMUHenSbU5vKpHU6Di7DpBNr3
	qJEea0BD5bXTyZElPaeAOssfTJIc6ROYYMr/RBRDiKmu0+bDwkM0izfUylpvdqmKu+Me1Kyoy6s
	K/swkqKkYfck6NGnUqy8WhQ8F2yM6P3lLLBSGxGhxMpvhO0ZxXhkXGmvO02US/rgyjMp9i/sFxr
	Ie2m/zCyOIoCRKr2E2ZIQS/3yfERv/Kie8nekAbF7sDSJNAJW1o9KFt5vxPPHBVPPht9GcgdeK6
	OfPC4YHs5u4peACST0aUTVXS0c8JOY1H6fh0msxlDPWPxLMZY5LUyo68l+w/NOiyyBHqCEUa7dr
	sYe7oHLvZzLyqU3IoQXi7TseKyAVCrRFpEjBp3bTs8fqDfbUu6jpFIdFDLr4bZTJZ/ESveesGET
	KzxaU4XifRsEnFShpE3kYBbnJidAxPrc0BmP43bxgliv0Fbc7ieV+AWbGbYg+XJwefkmKsyze5A
	FcZ7d2q3QCR59kq11SHAK2CaaUJnLPII+TL9dLxb6R/Htd0czpwv1shjt7lEaD1ltrVS6C+uW3e
	GwL1Gv6Wqf5cP3c0r/PkC/NIPsopCImtyi3CmfZIpY+CgzMTU6IiCcomRW+4bkATRZcvwTvrn0e
	jBIiR+5tUJNawF5RHR3QYsd8zbLJSOr/e
X-Received: by 2002:a05:6a00:2e9e:b0:890:bd5c:5710 with SMTP id d2e1a72fcca58-8a089f6585dmr3709575b3a.41.1792664491420;
        Thu, 22 Oct 2026 03:21:31 -0700 (PDT)
Received: from fedora (aipl-202-179-95-46.static.ankhnet.net. [202.179.95.46])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a08933c9b1sm1943324b3a.3.2026.10.22.03.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 03:21:30 -0700 (PDT)
From: Ninad Naik <ninadnaik07@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ninad Naik <ninadnaik07@gmail.com>
Subject: [PATCH] spi: mtk-snfi: use min() in mtk_snand_read_page_cache()
Date: Thu, 22 Oct 2026 15:50:20 +0530
Message-ID: <20261022102020.107609-1-ninadnaik07@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Replace the ternary case with min() to pick the smaller of cap_len and
req_left.
No functional change intended. Compile tested only.
Found using Coccinelle.

Signed-off-by: Ninad Naik <ninadnaik07@gmail.com>
---
 drivers/spi/spi-mtk-snfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-mtk-snfi.c b/drivers/spi/spi-mtk-snfi.c
index 6e96e50fedad..bbb65a21a684 100644
--- a/drivers/spi/spi-mtk-snfi.c
+++ b/drivers/spi/spi-mtk-snfi.c
@@ -1017,7 +1017,7 @@ static int mtk_snand_read_page_cache(struct mtk_snand *snf,
 			if (req_left)
 				memcpy(op->data.buf.in + snf->nfi_cfg.page_size,
 				       buf_fdm,
-				       cap_len < req_left ? cap_len : req_left);
+				       min(cap_len, req_left));
 		} else if (rd_offset < snf->buf_len) {
 			u32 cap_len = snf->buf_len - rd_offset;
 
-- 
2.56.0

