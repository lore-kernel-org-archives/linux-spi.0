Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253282;
	b=wATyrPpNBwuJBkz4AomEh6u/17vuLZllRm6EkMjXij5Yy5iWKIWKV9sfBpgw8FkOLMnu
	 fcUHbSE3VgxI/YpMSRfiZqqKN9Yqpk54SWoF3/nWQxujcJcxiWZdOEm7mqWEFgohMzS2g
	 IwecLPllP738agbjn1znLCr2VuMWpEKoUVp+iL54qNCHPOTaXutut2Q/uP8v+HXChj7SN
	 9oGtCBfpMRfJy5pphBthZsq/fBsoH7u0ERggoD1ku7EgVI4fZj1ZSWdQdRZgKPtPgcJVn
	 Il6WRLh0RzHYnyfzcg1J0tcy7ukCLqdyAqKAxbpVfyMsKREA8QN0T0gMxMYYqNLuzCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=CJBOrzmZfEeEjj8zj4QInIClRy264Xeumf7USqg34nY=;
	b=By3G7InyuiLJrlnFLVHd/WCocpUmVkHHPSQVp1KeW+Wd9zFCaKBEM03e2Cydv9s9AwiI
	 ZTcp00I4wK0nYiodeuWqwWS0bPixnDPC5cR0R+6KLxzLNBsqffRaQtBr18DAdqc8IK4sn
	 z+Nf5w+zrUSee2fqD2FOJedPzM0LJDra8rQsnB86k47zY6C91LMkajboBDHclaxXDMFxV
	 WfwqT/kQhCtJbur9yPH2mR/I36GBK2zyyyniOOEUez+37Xacg1Z5mW6/qfaIArOWD+VAv
	 t7H42yudYWbxVtiP7oR8HXxie6y6k2WTwCBdPiSAzuDEeoJDPIRkSG0Tmpi1teLRw4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Syl3R4er;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F4F60A263E
	for <linux-spi@vger.kernel.org>; Mon,  9 Nov 2026 19:41:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78F4F60A263E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Syl3R4er
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-492690dd5daso906780f8f.1
        for <linux-spi@vger.kernel.org>; Mon, 09 Nov 2026 11:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794253281; x=1794858081; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CJBOrzmZfEeEjj8zj4QInIClRy264Xeumf7USqg34nY=;
        b=Syl3R4erXBKjFGEeg3LRXecQao4OngqM9IZHhMFMkF/8J3JWGVTCRttp6jPM0xq/oN
         IQM5EWR6YncRE04TcsU3BAfkd5IygbgQ7SIv5ezI/x5VzSo9ceB9+f2WqIwFb6SCg1BQ
         wLRZUNkyEgYDUAQH8dEAaFgYWWvvNOfE92qh9+dHppwzFmcTFJcdyD+Hxag0tp8rWzFI
         0eeJb5WjoJVpcn59cj2B91oDaZoqohxqGy22BeDaHEcRL6ZOaPrOoKyERnkMjKtWxTK7
         N/1N4YFa+Zm60iIljr+7gwgP+k7X1YfoSb86jJ0EmLjhJIuXApgldJYa85sQKOmUrENJ
         zm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253281; x=1794858081;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CJBOrzmZfEeEjj8zj4QInIClRy264Xeumf7USqg34nY=;
        b=VD2i7CAla2R5AN7fRJvuaZ5DJIiD9U6YAXowFAmZ94x8mI6bs5xQeyVAd5wPy7Et9M
         Qsv4mKAvdFpI0uawMCuVysnPNdEgQS0pwI4nWcWa1Ncsj2toGdNgcmIQT4YKnSabSUtI
         REEvo3/UsFQ9ZNe9Im77Mr9tilCLCU6t+gQaKlyGgBdKLYTI269DGKha9HB4+obkNCjH
         RPPdN54ps+XyG+5QWA4cPPtlOisSaadC9WU46l8IBYMXjwXHXyv2CmP1UnalNDbgoblW
         E+EkqMmsZu0OZDQL6BTYCu/RvrFLnBxB3zX5G1GDBmM+/loEgRLy1v8++0i+RONqUnsd
         IKcA==
X-Forwarded-Encrypted: i=1; AL+hErHgPceb8eDvP/1SbFC0GsXv/dnh3lP1uJ84yAFYnM2A4gbT97SOatpy4qVdF0TDowu5ha29ie2lpFk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8hJVWcZUQ/6Wk621KaKmRhB+xx3jpzj4KqvGPStPAWnCYu9QuL
	7zjOA5vznBuLOMLQPtnxk8t8guX6W7JT+OUFBAuIBl3JAzf5hyv7uIn8
X-Gm-Gg: AYBFou0HwrWQQI80SUKq+bvRhqEA5vmqTOhhrux0ax1aGY9OTmlHXMPpl4jenApsPDe
	KhLTtRXJqRQSnON2aD9QtPc/C6Kqw1tvRsvaVtbS9CMr1kPQmX0Bf5fZMEyYSzSidLj6+B3YhOt
	2EYy01/SoIZ9MnIBOXXkRn4JLYT5GOMVMTniukqOb2FkKFcvyQPKXbQAR0DW130ciaj8+sCJ8T/
	fgUYZBa7miYWwRfLUR1KGbZfB3jwYr8O455hCg7WuGz0Bb64RuVm+mYpXofo5BjuBuRDHT/fiI7
	BwUIEd+rYb9S+wjulzWdG/dC4f+9sLMOu62xoQZEWU7PXy3SpLt5fudbW4O+abKfKiNtU5QTUzn
	RtGzEPAEaJ4McPHUTO/pKsBA0lykXP4DVuZ2RUXp3bl4LFa2n1PVEiitXUrcUOs3uFckhyDHBra
	65YsJABDgkzJlp8dhMe3mxmS9OX9RUMwk3lIMw4+2ZtgTqpsJhqLQ/jg32knSrBDEBgtHzO2jvh
	/NIsGxWgiKAjyd8Wjo4w9aYlfDje4PRzC5DAPpVc2f1EPon05+yFkJreFKvGKF7p1fttOD9rqs1
	eSlqcxA+HYAtFFe0vpdCMixqZfsY4lmwsUnjoAFgB9jzAIEngdhOS/tuTA==
X-Received: by 2002:a05:6000:4283:b0:491:5b1:fa73 with SMTP id ffacd0b85a97d-49827cf2a91mr1085864f8f.0.1794253280640;
        Mon, 09 Nov 2026 11:41:20 -0800 (PST)
Received: from [192.168.0.253] (5403F394.catv.pool.telekom.hu. [84.3.243.148])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49836b8eb11sm714822f8f.57.2026.11.09.11.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:41:20 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 09 Nov 2026 20:41:06 +0100
Subject: [PATCH 5/7] spi: spi-qpic-snand: use the common
 qcom_nandc_set_read_loc_first() function
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
Message-Id: <20261109-qpic-snand-use-common-functions-v1-5-1e8601e2db84@gmail.com>
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
 drivers/spi/spi-qpic-snand.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 6774a0a5db2a..ad91edd5f6df 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -122,27 +122,6 @@ struct qpic_spi_nand {
 	bool quad_mode;
 };
 
-static void qcom_spi_set_read_loc_first(struct qcom_nand_controller *snandc,
-					int reg, int cw_offset, int read_size,
-					int is_last_read_loc)
-{
-	__le32 locreg_val;
-	u32 val = FIELD_PREP(READ_LOCATION_OFFSET_MASK, cw_offset) |
-		  FIELD_PREP(READ_LOCATION_SIZE_MASK, read_size) |
-		  FIELD_PREP(READ_LOCATION_LAST_MASK, is_last_read_loc);
-
-	locreg_val = cpu_to_le32(val);
-
-	if (reg == NAND_READ_LOCATION_0)
-		snandc->regs->read_location0 = locreg_val;
-	else if (reg == NAND_READ_LOCATION_1)
-		snandc->regs->read_location1 = locreg_val;
-	else if (reg == NAND_READ_LOCATION_2)
-		snandc->regs->read_location2 = locreg_val;
-	else if (reg == NAND_READ_LOCATION_3)
-		snandc->regs->read_location3 = locreg_val;
-}
-
 static void qcom_spi_set_read_loc_last(struct qcom_nand_controller *snandc,
 				       int reg, int cw_offset, int read_size,
 				       int is_last_read_loc)
@@ -514,8 +493,10 @@ static void qcom_spi_set_read_loc(struct qcom_nand_controller *snandc, int cw, i
 		return qcom_spi_set_read_loc_last(snandc, reg_base, cw_offset,
 						  read_size, is_last_read_loc);
 	else
-		return qcom_spi_set_read_loc_first(snandc, reg_base, cw_offset,
-						   read_size, is_last_read_loc);
+		return qcom_nandc_set_read_loc_first(snandc, reg_base,
+						     cw_offset,
+						     read_size,
+						     is_last_read_loc);
 }
 
 static void

-- 
2.56.0

