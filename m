Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253279;
	b=tnwgG7uauWG8s4fzvJiHsgE0ObgHl6MZDU71vyjtdD50qpQbglcQh/kI0vS3MT+KEot4
	 1TGRc5C3J1M1YLnLptl6/J8sOHbie9fpN/fgfkGfFYGIFci+goupvSg2FGNjzcGtircdB
	 IrL7hLbPkWqYC8ILAifmjO8IGkbbHHIEYPjEddOX0kh/KtuH5799YTalG4MldU7oZAO8w
	 DIUccw7DUi7GkHtKJS+162f79MMmdfXH2Lg7dsgt+qZiNKUJp/Y7TB2BPKfKoQCcsYNgr
	 ibCQR1YqUfAqePuMJrHC3k9SoBL1pzaUd+pQyTddRnz07AqfVfIQ7h4xiPtOdzsd0kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253279;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=vjB/gteyhKa5P+vqzk8KHckJQMIF77fWcQQmU9RJfl8=;
	b=RGExZlVpvCkV3UO2sezBfUODEy+q6QVqToNp7bB66L6Bk16Z0oRlm3SlCceLObF8Palg
	 Oks4SGSR+7sz2ptZLk0Juboru7Ec4kmP+GJRTc2I8ZrY9frXXOel1nsU2IukcFs/Ekler
	 Lx9HBiB+Kjglif57F89aMd5Dc9pQsf1htk/mQc91nz9NzmbHtg5MWA+T3VgPL41svlN0E
	 jUkihVKLD5SYgJjVyXBxRgT4M2Y9GH87DndNgO1jrZDlLKazMlCbY06Ck20bRke12A8Cz
	 KGtxbReQeDldoJDOGZ39P93M6ydLwg5fil5inpIczt6AJ0xwmalgRNFUvHJGKjdT3pA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="jGd/n/yu";
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E943D60A2617
	for <linux-spi@vger.kernel.org>; Mon,  9 Nov 2026 19:41:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E943D60A2617
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jGd/n/yu
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so9311535e9.2
        for <linux-spi@vger.kernel.org>; Mon, 09 Nov 2026 11:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794253277; x=1794858077; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vjB/gteyhKa5P+vqzk8KHckJQMIF77fWcQQmU9RJfl8=;
        b=jGd/n/yu4WxqhV0zfgUF+5PFskHPVqJHOa112P5FIX209dpqZWxAUR/6ROE3yteAuO
         yfwq2m1u1gcjnc2Gu8USPCE/XojE0tSrSpCHFLRLAlL4jghvS6nNiBMZX8maSJPZnX+H
         vdlcFSVbYNSr6aEXYyWIodCArCEpme55GPplHX3B2JzjR6erSJYnHwy8ZbctFIjIVbJy
         QAJATbhGvR5NtKs2rk1n/fPa4/3lJP1qAckcMEo4iQ/wTQbWmeQbK6/PHqYhpaswHQJz
         hJSJXhMI74uSPpGZtl975+8c4bPUf6MIX1RooH5wPVUal6sB099hmicDbBHVphGszFMf
         0Gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253277; x=1794858077;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vjB/gteyhKa5P+vqzk8KHckJQMIF77fWcQQmU9RJfl8=;
        b=a0hn9NF4zMSKlBWzOv6XmWJ8hz7yIp43tZs0bjKfoog1qwTH1QUB27TrNBjzGwAgs8
         f+oTuUZdIh7qfPEwbXEyTF+Jco7liGXHgewNUm2pUGzP3FaXoGY3wIIkE2BZu7QHfByh
         aKKUFjcsUHMF2LvuD2woH0zAEmtJh+XcQfVJvT74ZYzDSSir8jb3PmhJXAYlrtvB1tUc
         ZcPruenJYFIlv0aKnO3U5VEGlXISh+J0DoeEnVKEiIDfWNXrpkDznKQH4R+fBhLJMJse
         WMLr5vqo5GUhnLPtOePBME0C0E3w1d5oDQI6vNFWmUFHUHmoBCW69vEdekTNF5w3Niqw
         LOdQ==
X-Forwarded-Encrypted: i=1; AL+hErHdXx8ZHCGIMGuBhOgRRPP3nl7Rx/TNWFuy9PAg0qAHkVBy6eg+FehjlTavIrmowI7tmZyXF4QrF3Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z+57m7UoW25RmFPVO5DG4akwOuXXIn7tQfm5kze+HjXZ5uihfMX
	Mb4BX/+FwnyBxCqjehkxF3nnW9vAyJkz6qyI3V+hck51lqUOPYB1Nhzv
X-Gm-Gg: AYBFou3KvGXBPJfrAvQmQak64WGbGi95cpBOaKkBPus66gwX1eeBcf3IIb2nBwGL2jo
	ZB+iLw7xcNGokowzsKCNsMOgteyFR1sPa7K0oBOvTeAwfcJzTVGVvum0WjTs8o3/1WTZt5Ri8XT
	Rcs1vGmHW/kVwlVnvYeoQ40Mwby/m1sRkLNd1zSG3mjHeRPfFF954VwPUgZI+XdGKxXcQflKi+Y
	OXi5vi1DgV+FksGFO+ufnIe4pyBmPv8yQTajICN0px3NrlA6bHheVt0vdIatyTMmqGKp2pez1IC
	LzM2c2HbfApV2btYyAamF3RrN5AMqO2L8qUTzhs1ZpF88LarTHmxrip6k03pMYmDEPBGwb9+zDV
	DgoJPggDQEEUsnYEbrXb2GfieQ5hTmBarvr2elENywcsYNI9aWkwpl6FHytR+rhjtRGDOawlqIm
	HcTPyHH21uwDSrAFhyxVqHqLlLyU6eqzShzoz3A0RtHcgi2D95YxmDdAc1QLrsazBJdmFgpdVNb
	XWQiOmfvkbuVGsVpg9B1G/+NpAVAlwz0ck/vbxjp6ziMrwhDfTxLOv/Yqa5rluvKF9zzNV6+xG7
	HFt+trkXeztFTu6sj0smREWKUED+m7Ufpj7Mr3ZIPEkv8SYLq4jygQBJkA==
X-Received: by 2002:a05:600c:4752:b0:4a5:87a:50ba with SMTP id 5b1f17b1804b1-4ba0235ba4amr3951945e9.33.1794253277139;
        Mon, 09 Nov 2026 11:41:17 -0800 (PST)
Received: from [192.168.0.253] (5403F394.catv.pool.telekom.hu. [84.3.243.148])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49836b8eb11sm714822f8f.57.2026.11.09.11.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:41:16 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 09 Nov 2026 20:41:03 +0100
Subject: [PATCH 2/7] spi: spi-qpic-snand: use the common
 qcom_nandc_config_page_read() function
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-qpic-snand-use-common-functions-v1-2-1e8601e2db84@gmail.com>
References: <20261109-qpic-snand-use-common-functions-v1-0-1e8601e2db84@gmail.com>
In-Reply-To: <20261109-qpic-snand-use-common-functions-v1-0-1e8601e2db84@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Md Sadre Alam <md.alam@oss.qualcomm.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.3

The common function from the 'qpic_common' module provides the same
functionality as the locally implemented counterpart.

Use the common function and remove the local one in order to reduce
code duplication.

No functional changes intended.

Note: in comparison to the local version, the generic function runs
additional code when the 'nandc->props->qpic_version2' flag is not
set, but that does not affect the behaviour of the current driver,
because the respective flag is set since commit 52efc89ccf66 ("spi:
spi-qpic-snand: set 'qpic_version2' flag").

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 981e16221b59..cf75c142303f 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -518,17 +518,6 @@ static void qcom_spi_set_read_loc(struct qcom_nand_controller *snandc, int cw, i
 						   read_size, is_last_read_loc);
 }
 
-static void qcom_spi_config_page_read(struct qcom_nand_controller *snandc)
-{
-	qcom_write_reg_dma(snandc, &snandc->regs->addr0, NAND_ADDR0, 2, 0);
-	qcom_write_reg_dma(snandc, &snandc->regs->cfg0, NAND_DEV0_CFG0, 3, 0);
-	qcom_write_reg_dma(snandc, &snandc->regs->erased_cw_detect_cfg_clr,
-			   NAND_ERASED_CW_DETECT_CFG, 1, 0);
-	qcom_write_reg_dma(snandc, &snandc->regs->erased_cw_detect_cfg_set,
-			   NAND_ERASED_CW_DETECT_CFG, 1,
-			   NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
-}
-
 static void
 qcom_spi_config_cw_read(struct qcom_nand_controller *snandc, bool use_ecc, int cw)
 {
@@ -588,7 +577,7 @@ static int qcom_spi_block_erase(struct qcom_nand_controller *snandc)
 static void qcom_spi_config_single_cw_page_read(struct qcom_nand_controller *snandc,
 						bool use_ecc, int cw)
 {
-	qcom_spi_config_page_read(snandc);
+	qcom_nandc_config_page_read(snandc);
 	qcom_spi_config_cw_read(snandc, use_ecc, cw);
 }
 
@@ -758,7 +747,7 @@ static int qcom_spi_read_cw_raw(struct qcom_nand_controller *snandc, u8 *data_bu
 	snandc->regs->exec = cpu_to_le32(1);
 
 	qcom_spi_set_read_loc(snandc, raw_cw, 0, 0, ecc_cfg->cw_size, 1);
-	qcom_spi_config_page_read(snandc);
+	qcom_nandc_config_page_read(snandc);
 
 	data_size1 = mtd->writesize - ecc_cfg->cw_size * (num_cw - 1);
 	oob_size1 = ecc_cfg->bbm_size;
@@ -863,7 +852,7 @@ static int qcom_spi_read_page_ecc(struct qcom_nand_controller *snandc,
 	snandc->regs->exec = cpu_to_le32(1);
 
 	qcom_clear_bam_transaction(snandc);
-	qcom_spi_config_page_read(snandc);
+	qcom_nandc_config_page_read(snandc);
 
 	for (i = 0; i < num_cw; i++) {
 		int data_size, oob_size;
@@ -944,7 +933,7 @@ static int qcom_spi_read_page_oob(struct qcom_nand_controller *snandc,
 	snandc->regs->ecc_bch_cfg = cpu_to_le32(ecc_bch_cfg);
 	snandc->regs->exec = cpu_to_le32(1);
 
-	qcom_spi_config_page_read(snandc);
+	qcom_nandc_config_page_read(snandc);
 
 	for (i = 0; i < num_cw; i++) {
 		int data_size, oob_size;

-- 
2.56.0

