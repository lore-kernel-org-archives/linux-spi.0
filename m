Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AFF3BB126
	for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2026 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790269387; cv=none; b=AZI2abXcEGiHGpGZZCq/wIKaYxQKI48I3QjPYMJ9ZKsf8VVooVg2sFZ+uGdVq6awx+6Uvrj7UOB4zlMMf/52Gkfb6cyRzXCoUBqY7glN0HS5ik9tLmSm3wenWmvMC4vlFgFUbAsinw8X8LlzVY7ODdOfcUIvYxGDRKeoc3FAdWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790269387; c=relaxed/simple;
	bh=+DishUC9Q/FjQaKHTl665w3QwFFpXMruE6ofyX0ZP1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qZWCbsxvw+6pVDapZwgyEPASIn6fSwkoHjsGTanPe8h8C48Td56u2bRJAYPjd0UKDJ61UN5TIzCWl/K8N9JE+j8eLzpdJalxSECZVvp6ZayW4UfQ9S5kMnIy2a+nX7QnTxN/a/7CtEhLB0eOY1fAdulbShLqoLG4wwPDzJAlEVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XxJkACzT; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxJkACzT"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e79a408deso358625e9.2
        for <linux-spi@vger.kernel.org>; Thu, 24 Sep 2026 10:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790269383; x=1790874183; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ZhfhCdd8Py1unbndSuBk6kmJMuO/LMVFXW3aXeose2Q=;
        b=XxJkACzTupgkX1nqjBituYPiT2wRuzaqBZlGBpwI9SrtFA0lDbrLw+ofqNon97he/y
         dEj5chVd7iNLhgd6urzXopyxt23EWMtZGGY32fqvFILkMTvBxMz8K1IBeMVw1iYTesCX
         HLYGS0A/hCBmdZ7CxuymhOOjVvumytalI7nxjaAfAFfDDnJRqYY3cNmWlDbhKlrF58to
         40/OC5rqsTRq+iiT+i274ueJf1fuDCVwVOLUD0K3g1RP0tdqkSp57X/gUBC1BhU+7kRb
         MOGZWbFD1Lm+6tRuFeo+I6yorT50FqoN4PTyNvSId5/zkCI04mZX6dqCu0hNqLbPPgb8
         NeRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790269383; x=1790874183;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ZhfhCdd8Py1unbndSuBk6kmJMuO/LMVFXW3aXeose2Q=;
        b=LkT4VwiLba4XhmZMCIWrkOflZIFy9EY2yGzUVvy6GqNI3tUC57JPUkNY4O4indKZ5P
         G6a6GjTXQ9kqs3oY7PSSAIU+Le+KFDqkjFv7X/7nZXNwIC7dseBCgB6jKe4boFlB4cg3
         RKwhWpPMK3Ng+o7CT7LXE/qREP6dsGKO6ci5oLCo4FcrdQgG8uOSBfgTa40WFbxRiHIL
         zWGUSz3cTekByTv9ZaSrao05YIqpBbfEkPqjUvr13NOWxoLOEu8i9Be2jSJ/TM0IEK9g
         QrwBNq68BkKS/mTJ89tGwUbQK5GFQFZCV46dftb8UlAgK4gfa3liH0oXPw6kaMNsOp2U
         UznA==
X-Gm-Message-State: AFuF++nlLkZCrb2+Db4JKFB3bSeECzTLAAfd2JgxpmUeeMiyIveQgsx/
	dG4wVh4w/UGDqUeV+le0ImXvsTpDzcuFK7+0X7Qz3ZInSFz07UHpU8JT
X-Gm-Gg: AYBFou2dymucI3Kgasf6kXPJVYtbFjrw1pLlswlUjn2CiAL+QC+stsfbWrGwWeKlIgv
	QMlOIzV8yVNibBtez56MvhiivPKV2lWwRb84/UBBzRR/38tfng/TL819XnZ/K47+OCYZ2uoR8rb
	DtwYXNb4/m9/GdA5pCYRChFSTTSQ+ct9QjhtmyVoHS7Lds1bmQ1fXWUFp9SBGjWcdOjAqZ56U4M
	ZMLm/HrRqfqkCrHgiuoxikxi1CoQJryuUj+LmEek/L0/8DcIAdk8rA9h6cXJs/meYXuttVZo6I4
	QP5FvYThjRSxhc7cxcYvTNCa68o4kaLQaU2YcumlVetav9+fJnRzoMhqhwWoB1Xj3oFBbCkGrnA
	jDm1BN4twv3dISYMB8DQDi76jLsCXtwQO/Dt1ODzlWGqDP7AcJF7V/Rcw6Y5zFyfUP1fEBq10Wr
	bLja9sv3blpOV0kbcWuQrMshh75Uk41yLcScvVuTr4LMC+R5W1Spna6DM7mxZJAeH5j3qkgP/dK
	vk/s2kWOf+UnHQnNlckgehJE7W8S/WvFg4Nz1E=
X-Received: by 2002:a05:600c:34ce:b0:49e:7caa:e7b2 with SMTP id 5b1f17b1804b1-49fe670428emr51811075e9.29.1790269383141;
        Thu, 24 Sep 2026 10:03:03 -0700 (PDT)
Received: from [192.168.0.253] (5403F394.catv.pool.telekom.hu. [84.3.243.148])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49fe5e07bdcsm73460935e9.15.2026.09.24.10.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 10:03:02 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Thu, 24 Sep 2026 19:02:56 +0200
Subject: [PATCH] spi: spi-qpic-snand: set 'qpic_version2' flag
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-qpic-snand-set-qpic_version2-v1-1-a0a9a3e0d06a@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MwQpAQBCA4VfRnE2tsRGvImljMJfFjqQ27245f
 of/j6AchBXaLELgS1Q2n1DkGYyr8wujTMlAhirTkMVjlxHVOz+h8vlzuDh8HSGVtXWNsXXBBtJ
 iDzzL/e+7/nleoX8CDW4AAAA=
X-Change-ID: 20260924-qpic-snand-set-qpic_version2-2374a90471e0
To: Mark Brown <broonie@kernel.org>, 
 Md Sadre Alam <md.alam@oss.qualcomm.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.3

The kerneldoc of 'struct qcom_nandc_props' says this about the
'qpic_version2' member of the structure:

  "flag to indicate QPIC IP version 2"

Since the SNAND controller is based on QPIC v2, set the flag in
the device specific properties.

Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index aaa40753d274..b5fa561bcdd5 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -1676,6 +1676,7 @@ static void qcom_spi_remove(struct platform_device *pdev)
 static const struct qcom_nandc_props ipq9574_snandc_props = {
 	.dev_cmd_reg_start = 0x7000,
 	.bam_offset = 0x30000,
+	.qpic_version2 = true,
 	.supports_bam = true,
 };
 

---
base-commit: f6c3117b539d72095404bcd974418f6dfee6d8ac
change-id: 20260924-qpic-snand-set-qpic_version2-2374a90471e0

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>

