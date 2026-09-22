Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108384A260D
	for <linux-spi@vger.kernel.org>; Tue, 22 Sep 2026 19:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106605; cv=none; b=YkB5r2maIILxTIg3uH3PHIqpauL5F3CggEnEtj8OgB4s43DgXnokHeqCnLT4bbeZxSpwVlk4o/blx5HmtmwoF6uEcoE8UZcq0wbc0erisxP8bzfATrlLOUsyU5Oix9rW2OHN6PuTmjhqoS+dvy4wmaT4qrrqifZrCRWBgKBznZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106605; c=relaxed/simple;
	bh=6hHR7aNkwpc/Z/OKkHBG+3SUNPzcTX4j+ywWnDHnsqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=H8c5Hvf/bc9a2ieOUwiB3VNQ9Rg3uNjoDI+PNS/NejyULzGrPZP1lmByYTpO9PUdYuu3wL9X3pbDqtuhsmRbeEMyIF3/zxQU85CQeuBjoECPeoRb+YbPC4GULgagV6Ta4yJK3fS09ZTIPj0Vq6IyjvHr+I47z7G23wGnMeM/628=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NNKRQYyb; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NNKRQYyb"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e83a388f8so964595e9.1
        for <linux-spi@vger.kernel.org>; Tue, 22 Sep 2026 12:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790106602; x=1790711402; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=g0QuVMlMWUevT7QcuyRM+FePdkLtnJVfWDEQgXRfZ/I=;
        b=NNKRQYyb+L4pdaynbf/sw4o9J0QlH3TgwSISfTwXh9qD9y1V2cd/lsUom/EzVWZum+
         vYBmhjJkpRA27S9tfLmzk2kINYGs58/TLGjBZTdVJCfI8e7N7/Dd3DAt6w7z3PCTHUJn
         XYH9DL57b2Q0/byMoV2YUHgrx+jsQYz2NAGGKmvRku7+2i6kQ2ousZyi0G5B8AyPlSMB
         bdRNsxO69Htbs4047p/8ECtkjc4x0hvFjitmllwciHuQjVyqZYX++IZGGbzaiyWvE4IG
         L0fIr2mIH2i0l4wtrqDNdRHfDZh1UZTlda9guci+GJDde/oLj3iltEzLksQ9x++ogplC
         aaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106602; x=1790711402;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=g0QuVMlMWUevT7QcuyRM+FePdkLtnJVfWDEQgXRfZ/I=;
        b=MbqpnJx0cL3x2eQXhi6J3zRAdvx0YkcDJ4h3jECSLtBze6a9TuKVWh0Z/v5ZSOWMvi
         Wvd2IsgINTd93CvnXV4hQk7qAbkS/EE9+HtCbQ/CDsYwqGFV5oW5u9ve3BwY1d6Wp0Pb
         CRVgHwYt8ng3TmM9E3ub2YFMKDqaVv4/O8PNm7Z56s3z+H3FeJFFUrZnxHlWlSDxj/U9
         8sV/31zK2tmYOi6x0lsrYVkJScD5S5AyHBzMT3fjxLdfIfbh2JUbj2TRnUgbIrLZp8Xh
         IlK3jErRjhGz5sCe8BnvtqZBcz2C5sP0QSrZqrKhXgvv2CufJQlfNVq+k708LWj8zqRX
         iD9A==
X-Gm-Message-State: AFuF++nheNKP0lz74n2B/j5ipMsKhmlqoLP+T2Wju7XrxVYyu7Ri5tcU
	dzJv3NEst84FuvVgAuB6AUpG7EFnQYarRjIsS4/zIbjOJTh5alhfj5/yzTIRDw==
X-Gm-Gg: AYBFou1vZX56qn7DIzzIadUm/uR7zS40SZe9EzSrcxFw9IOPD6jFOK4nejPnz0gboPo
	RKNfz+FhOiwP5g7F0dbATS6hOvxoxb1WIP9HIxICA7x5fEssHSPdIly/nPchUyzT8WafzOxHsA8
	hmGqi6BlmRMGn2pYB1ujAM2dLyt/oBmSEBXalu35Y23pQ71RxwTrOnyXjrwV8su/6oFTyk+RIXx
	M/GXSzYJiblIOB7EGEwXC7OpOxpfVoD7Ucfxdg58/tIlkxyMWKjKVy/iwY7qCoLYeRxoCzZ7RQv
	kL+E0iMpluEfT2j/+VKFJ+sCJnfecV49fYq3HXgkPGTEQKwXZRr7VWW0xZBDGDONvMMbFIWaBmu
	dZ0mOAYqfRgZvofvIFZoTBu4TdnKRTVCXyKS80v2B0iigVbalZM4yV6GhLMVUaP1fueox94zQ2J
	A2xmURJA4ybK6Dgf7GOwUDKTmrHYZOwZ/Wqwpo3MWwvlByEGaM+NdT6mG4HBcv3AXRZuFDQPN+O
	HVp0lvi1s/9V2iSO1QzdAeo+XM=
X-Received: by 2002:a05:600c:81c5:b0:49f:bd3c:bc1b with SMTP id 5b1f17b1804b1-49fdf13b84cmr3269845e9.22.1790106601998;
        Tue, 22 Sep 2026 12:50:01 -0700 (PDT)
Received: from [192.168.0.253] (5403F394.catv.pool.telekom.hu. [84.3.243.148])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-488684863d9sm714041f8f.12.2026.09.22.12.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 12:50:01 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Tue, 22 Sep 2026 21:49:55 +0200
Subject: [PATCH] spi: spi-qpic-snand: fix read location register handling
 in qcom_spi_config_single_cw_page_read()
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-qpic-snand-fix-singlecw-readloc-v1-1-41fd834a10fe@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2NywqEMAwAf0Vy3oDWB9ZfWTzUNGpAojbgLoj/v
 mWPA8PMDcZJ2GAobkh8icmuGapXAbQGXRglZgZXuq70zuF5CKFp0IizfNFEl43pg4lD3HZCaqj
 3U1N3fm4hV47E2fsf3uPz/ABViwQhcQAAAA==
X-Change-ID: 20260922-qpic-snand-fix-singlecw-readloc-c4c89b4369f5
To: Mark Brown <broonie@kernel.org>, 
 Md Sadre Alam <md.alam@oss.qualcomm.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.3

When the cw parameter equals with the last codeword, the
qcom_spi_config_single_cw_page_read() function configures
the read location last registers. However it completely
misses configuring the regular read location registers
for other codewords.

Change the function to always configure the registers
corresponding to the actual codeword.

While at it, also drop the single-use 'reg' and 'num_cw'
local variables from the function and use the respective
values directly in order to make the code easier to
understand.

Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Durig writing the previous patch [1], I have missed the fact, that the
qcom_spi_config_single_cw_page_read() is also broken although in a slightly
different way. So this went to be a standalone patch.

Link: https://lore.kernel.org/r/20260922-qpic-snand-fix-cw_read-readloc-v1-1-67f6819fb3d7@gmail.com # [1]
---
 drivers/spi/spi-qpic-snand.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 05efe6313b7f..32bac31b5f00 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -560,8 +560,6 @@ static int qcom_spi_block_erase(struct qcom_nand_controller *snandc)
 static void qcom_spi_config_single_cw_page_read(struct qcom_nand_controller *snandc,
 						bool use_ecc, int cw)
 {
-	__le32 *reg = &snandc->regs->read_location0;
-	int num_cw = snandc->qspi->num_cw;
 
 	qcom_write_reg_dma(snandc, &snandc->regs->addr0, NAND_ADDR0, 2, 0);
 	qcom_write_reg_dma(snandc, &snandc->regs->cfg0, NAND_DEV0_CFG0, 3, 0);
@@ -571,10 +569,15 @@ static void qcom_spi_config_single_cw_page_read(struct qcom_nand_controller *sna
 			   NAND_ERASED_CW_DETECT_CFG, 1,
 			   NAND_ERASED_CW_SET | NAND_BAM_NEXT_SGL);
 
-	if (cw == (num_cw - 1)) {
-		reg = &snandc->regs->read_location_last0;
-		qcom_write_reg_dma(snandc, reg, NAND_READ_LOCATION_LAST_CW_0, 4, NAND_BAM_NEXT_SGL);
-	}
+	if (cw == (snandc->qspi->num_cw - 1))
+		qcom_write_reg_dma(snandc, &snandc->regs->read_location_last0,
+				   NAND_READ_LOCATION_LAST_CW_0, 4,
+				   NAND_BAM_NEXT_SGL);
+	else
+		qcom_write_reg_dma(snandc, &snandc->regs->read_location0,
+				   NAND_READ_LOCATION_0, 4,
+				   NAND_BAM_NEXT_SGL);
+
 	qcom_write_reg_dma(snandc, &snandc->regs->cmd, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
 	qcom_write_reg_dma(snandc, &snandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
 

---
base-commit: 3d743adf090cd4c9a2120c1e02b0482e88aa0d2d
change-id: 20260922-qpic-snand-fix-singlecw-readloc-c4c89b4369f5

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>

