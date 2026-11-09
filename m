Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253283;
	b=nZegcwxCN1aSjH1W3mWAKOAA62i8VdaebXsL4Ki1haAkL0ukwisrbW1E337SppBpgtIc
	 +7dIEXUTgKS9KtCAtJcb3jIeH9pSuYQ8CPiEcmHCaHk22mIw4YCefBSe/R5HgatHFQU4w
	 MLX8vwbVu3tlrNIvMm8EPqX1OiBNSS3M6ZC7mJ05VbM4g6m1TquKhMC1aNcOY2cWLS1NS
	 9hk2pqFGhTu80AW4tpzxmBQVn/ZdYWZTBr3747djj4B9AEEY1kFJKDWu8frUXs5uq2XIQ
	 uTxcU/DhO2O42/7si4S45F35i6rmDtsAigCqlH5UyPB8JMvZkgeKCW/aFU/0kfkK+9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=wZi3AbEuRwrPOxFpdt26jeERVpxEwSJfhncQlRMhB9g=;
	b=bS4KPjA1rCCnMF9AlBkfwqE716W5jEX4y7u5hYTxBhGJxaDP3PNibWKJ8/UDW45hLeXK
	 v9a1TJFp+EUO6BnL5I4qXbXG0OrGamBdH5ypDzzwSC0O41H/InV/CQndpWXhtOzpxWBRE
	 h+Tv9x0Z8emV7dQr0s2bR7rJImQPPX9ATM/KpoIi4pD95c904Oxqv64cZZX09sqA5Z+M9
	 XejtuR6u7+2l9hxQ/hB/l9xIEKjdsuC9HCiFq89I38bSHz1sh8J5USXtkynb0yWcm25SN
	 G1b8+xYJ8pCEdc1H33UIYEhQWFxEpzgsIIjfqre2u2po+ggpWca63l13iBjm661i3Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CepEGuOM;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9186D60A260F
	for <linux-spi@vger.kernel.org>; Mon,  9 Nov 2026 19:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9186D60A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CepEGuOM
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48fd2e38825so842411f8f.2
        for <linux-spi@vger.kernel.org>; Mon, 09 Nov 2026 11:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794253282; x=1794858082; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wZi3AbEuRwrPOxFpdt26jeERVpxEwSJfhncQlRMhB9g=;
        b=CepEGuOM2HlTOQq37OEk1WIY5J9sn3vF34fjvorViNxe5MPe06DCSo6Nd0VWDi7WNk
         hUap7YfbBW0Y9zguKlVZlfyt51Id1ovZNRhZ9xW5cXWz8jaWtGuqo8zoKaJ8DBrO6IvJ
         Gv+uWSq2sprYwO8bNaTp3jsHdNOf5OrUQQruOXPs2cK2lzC8NvIw4jWdDrIeRSnYgMfK
         XqalE6g6Qnh/8b6Sy2AAsKgKsZq7YAvMWVuyrbchKAQvumJT1DNYOQq+X8kBDzqS4LC+
         iFvJNcrvl5yNwIv9uyLW5c7fhf4IzTPxzbT/r1JAlJR1hVbcNtz0H3Zpd22EDtKB7d9G
         JMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253282; x=1794858082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wZi3AbEuRwrPOxFpdt26jeERVpxEwSJfhncQlRMhB9g=;
        b=UuNbzExzLzy2betgmHSC425wdrckuLEUgOmLJ89O95vj/6uvobWKITTNGi+TrWpQZn
         Ot769J8C1BimV16vTk3ujO97tLSN2mXVPGiUFZqoceEuFQUzF1qgEcoFJAP51vbdVlgK
         /WBnhnnFZ7oZOkh5ud60pB8KobPfBC3u8Rq50kLpU4YdT2s1k+uTuvTCPCSGBI+qUtqQ
         yE/Pc8jkBTx0O/YldFFhGng0mEehEL80KlzYXncNzs1Wn1cC3HNV82zVCSpUL72L6IkK
         WF+vqVmlcHYWQK5g2vXbSDOhj9r9lRGItoOLVTWEscSuOKpZq2eXUP8eJSCy1x6AuxHa
         0XaA==
X-Forwarded-Encrypted: i=1; AL+hErEmXDAr8a3ArKkW8rK+3MzyTibAcpic9g37EyZPNpg7HxBQs/D/Q2fV7Eg6sT6bzUeRmLB+gVZGxls=@vger.kernel.org
X-Gm-Message-State: APuU4Z9wmyipr7rV2devxeJt9nnck1MhIV+INS5O5ZchHlNNQZaRETZP
	eNXrjeoxRPrsvhPTNSz5HSah+YDhRMp+tLJIcBtHxc7G5zXKK2NrhT/0
X-Gm-Gg: AYBFou2wjFpzO9f6cDJeKE7XSiiMfEJkWCfkzjMrKsvzfiKMN7r62GXlp3Td0TkRM4c
	zyBDAjsrpET/rGdxzqUqY81nGHZpB35zJt1SCIxm9hcoT9UMTUQc1h3xiMorfUg3nLa7v/DaMDc
	Nnnn7TyhcBYOMbC0HzukYMeYNaUxmhlAmkTcda/cwF5Z8TtyjRJVWQJso226in9zbeg3dEFNNE0
	r9N8SbzbVGKbuVr33W4e0upDJkr1XAg/acfXNDmWsrkc1d+qltbBy/KQXBaY54JqFxkn5Yr2gA5
	b0a520D2boSCtu/z9bWt6wOrb0QPVmo7icDtCq736tv11OD3+72ZBDRko4jbCISm/typPGSN4IS
	fcGGYfOSmJjnRzAKG09tIKS3z0XTq0DeYDI4DO6mt6Bqscd/kD9B7tpb1Y0FFbr8PfupTkZm+wR
	e3lprAbecIXX90rkLxFJfiP1EHI5u7woG3adu2ESXw1pkZ6ECFvz2voh7VxE9IQONttDcydosnH
	xtI3LbfgH5aV2VKwML4gRU233A43Trb/9uxDCHX6uZVP2hUJI0Hvq0wAxv+92rbT1OPKpb0v7dw
	4//OESerBg1ChCkJPLhlaPl2P2P5FM/91DKQu9luSRus7oynbvdNR4gCxQ==
X-Received: by 2002:a05:6000:4028:b0:48e:2f7e:bdbb with SMTP id ffacd0b85a97d-49830d81993mr835355f8f.50.1794253282019;
        Mon, 09 Nov 2026 11:41:22 -0800 (PST)
Received: from [192.168.0.253] (5403F394.catv.pool.telekom.hu. [84.3.243.148])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49836b8eb11sm714822f8f.57.2026.11.09.11.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:41:21 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 09 Nov 2026 20:41:07 +0100
Subject: [PATCH 6/7] spi: spi-qpic-snand: use the common
 qcom_nandc_set_read_loc_last() function
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
Message-Id: <20261109-qpic-snand-use-common-functions-v1-6-1e8601e2db84@gmail.com>
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

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index ad91edd5f6df..4105a04afcdb 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -122,27 +122,6 @@ struct qpic_spi_nand {
 	bool quad_mode;
 };
 
-static void qcom_spi_set_read_loc_last(struct qcom_nand_controller *snandc,
-				       int reg, int cw_offset, int read_size,
-				       int is_last_read_loc)
-{
-	__le32 locreg_val;
-	u32 val = FIELD_PREP(READ_LOCATION_OFFSET_MASK, cw_offset) |
-		  FIELD_PREP(READ_LOCATION_SIZE_MASK, read_size) |
-		  FIELD_PREP(READ_LOCATION_LAST_MASK, is_last_read_loc);
-
-	locreg_val = cpu_to_le32(val);
-
-	if (reg == NAND_READ_LOCATION_LAST_CW_0)
-		snandc->regs->read_location_last0 = locreg_val;
-	else if (reg == NAND_READ_LOCATION_LAST_CW_1)
-		snandc->regs->read_location_last1 = locreg_val;
-	else if (reg == NAND_READ_LOCATION_LAST_CW_2)
-		snandc->regs->read_location_last2 = locreg_val;
-	else if (reg == NAND_READ_LOCATION_LAST_CW_3)
-		snandc->regs->read_location_last3 = locreg_val;
-}
-
 static struct qcom_nand_controller *nand_to_qcom_snand(struct nand_device *nand)
 {
 	struct nand_ecc_engine *eng = nand->ecc.engine;
@@ -490,8 +469,9 @@ static void qcom_spi_set_read_loc(struct qcom_nand_controller *snandc, int cw, i
 	reg_base += reg * 4;
 
 	if (cw == (num_cw - 1))
-		return qcom_spi_set_read_loc_last(snandc, reg_base, cw_offset,
-						  read_size, is_last_read_loc);
+		return qcom_nandc_set_read_loc_last(snandc, reg_base, cw_offset,
+						    read_size,
+						    is_last_read_loc);
 	else
 		return qcom_nandc_set_read_loc_first(snandc, reg_base,
 						     cw_offset,

-- 
2.56.0

