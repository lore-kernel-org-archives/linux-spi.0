Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C2E3750CF
	for <linux-spi@vger.kernel.org>; Sat, 10 Oct 2026 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791621322; cv=none; b=VBtEGHlndz6H+dpL5rDsangnK4O6I0I0dT/UgYJEpf2TwSrHflTEgpaphOedPZmk9UDN0vThh+qvUXaNQJSXtER368k3pxAkTxHPIUcxZU29TV433sUtuamzQ44O9VsXcxSVeLoNiuLs4tH61JfN9eVb7FMgUxOCItZYZdDu7Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791621322; c=relaxed/simple;
	bh=5mdUzxIr2uleWa+kpKhc7DCtFAC4LuwwFGfpuLa97ZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pFWzZ0lwzsFL7Enf4mpYtRTENFjEe9BGmdPli169Ayz2h/OK56FiiInQ2n9x4hPiRPnjOJVvIltmNXN9G8jrZDcKOy7KBcj/aIopPlW9/bu5fygJBU5GOdo962ikxpOCSuXSrO7+B4wGpzcL7R/nf2MRN5BOkAOwsYZErF7tsfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=aayushk.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35829219da8so368723eec.0
        for <linux-spi@vger.kernel.org>; Sat, 10 Oct 2026 01:35:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791621320; x=1792226120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=njAznGdYasKrT1/VCSuQJgMHPzKgYQg5CyE2w0aynkE=;
        b=So0HFTC5VyKEYu/ZTKkmLYC3Cg50W1k0D7FSlc/XQwHUH8xvYLU7Tz/Ure4rlXUTOO
         iw14/pU3J6pBUbx7lVfklgRrEqA7wapbviITOFq5BRVrkVVrIoUx/VpvFXe6ubex50eJ
         I90LAYB7EfnDleWpmO+TI3oEzR8J/ZaYyFeZZ/obWwYWHfKwZhDN1sVKU1EGvMO8Ntpe
         13O0t2JSimV9nsZotf9E7mxPbwY1/3TeJTwMeMRrY44b6K+kKJVOWxruVi2Q/6JkAnsq
         yjUOm1XOxQn7l3v96V1UbvRBwy8ZhM3qnUGSl+BvJqP48+V/xQI5Bvj2DJyejojKdI5J
         ZUrA==
X-Forwarded-Encrypted: i=1; AKwUvBxH/+aMTg38uw3CvED7tEQa7FYATpxgvQyVZ6kN6Gwi/4jEWDnrh17hEj1zux89guIdNRm0NK4Bv6Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYKYqO1amN7+pfIZqTVuSK8xUuryV+07sQTqLFA6Y4Ex//MIepri
	Fk06UyatSF32vk5il1l6Cbx2yNgTooEk2IjgUViQADxcZYfjd81iNFzZ
X-Gm-Gg: AYBFou16ILCS2xTAOCRtgUTrfAzFvgd8Gpl9mDkJdEw8Mplhjov3E1KVNMNM+Vl/f5l
	qpQUIvxDa5393BB8BxryEmKjcKySatRUKtcCVcw7t6kgvrVDZp1WQfG/Zzs/DPpnAFz79+CFqrx
	oMuM1Y0NGz0jJEYSrTrFWCrPPGOR/hFFSrCRU9nH9ZFJ4HRsnDc/qZTMLS0x9C4FDiyFKBWjycv
	6rI93QdwYGCCNt0xrtrXLL/Rw4TKFB86sT0pcp7PPld0GP/Li+/YKLiT69f2C1vAB4O4UiWIo/h
	iMoJlpTUO5Wyo+UHPxoLnevszsb2+wDWgGxd5S3K05e/962etiyZjc1o7oLr2RnJSUwC2BdTFUp
	0vwxGaw7Qxxy7ABRFjQAcDpvAV644aEox74pT8ERuzzZD0zxf7PBSdu4xyZQlYtTwDfkG9YK5fQ
	RAxNlI0+dsAN4oPySxDl6o9QZpmU1tv598DOO8Tl5ChqZUBzFM96CdsDbc+x7t
X-Received: by 2002:a05:693c:87cd:20b0:353:5d7a:cabe with SMTP id 5a478bee46e88-3536c53930dmr6687600eec.13.1791621320473;
        Sat, 10 Oct 2026 01:35:20 -0700 (PDT)
Received: from linmach ([182.156.30.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841579sm12689858eec.4.2026.10.10.01.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 01:35:20 -0700 (PDT)
From: Aayush Kumar <code@aayushk.dev>
To: Mark Brown <broonie@kernel.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aayush Kumar <aayushkmx@gmail.com>
Subject: [PATCH v2 3/3] spi: s3c64xx: Use snprintf() instead of sprintf()
Date: Sat, 10 Oct 2026 14:05:04 +0530
Message-ID: <20261010083504.26261-4-code@aayushk.dev>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261010083504.26261-1-code@aayushk.dev>
References: <20261010083504.26261-1-code@aayushk.dev>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aayush Kumar <aayushkmx@gmail.com>

Use snprintf() instead of sprintf() to avoid potential buffer
overflows when formatting the clock name.

Signed-off-by: Aayush Kumar <aayushkmx@gmail.com>
---
 drivers/spi/spi-s3c64xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
index 8d4120cf9..8195bf376 100644
--- a/drivers/spi/spi-s3c64xx.c
+++ b/drivers/spi/spi-s3c64xx.c
@@ -1331,7 +1331,8 @@ static int s3c64xx_spi_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(sdd->clk),
 				     "Unable to acquire clock 'spi'\n");
 
-	sprintf(clk_name, "spi_busclk%d", sci->src_clk_nr);
+	snprintf(clk_name, sizeof(clk_name), "spi_busclk%d",
+		 sci->src_clk_nr);
 	sdd->src_clk = devm_clk_get_enabled(&pdev->dev, clk_name);
 	if (IS_ERR(sdd->src_clk))
 		return dev_err_probe(&pdev->dev, PTR_ERR(sdd->src_clk),
-- 
2.56.0

