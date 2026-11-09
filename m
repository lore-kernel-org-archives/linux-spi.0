Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253281;
	b=ItdorJi7wLx1setr0DluZxVzDG9y2t5htP4rOUxI4xq1YXM1sJwSCbUX9oJpfbXs8Te6
	 r1tomyamU7mPqx8XKZN+PRSWyRiX+OpylNU6vtksnbhistfZjOPkrhRfd5Uxn+0jYbreE
	 5r8iV5XNdoDbUXGeR4YSG4o6Xi3X79yNyPptxFe2OOYEnqYo8r7C61OCBcKN9dBJnDgFC
	 O4h3JDTWw0u+DmLjNF6ANkRg9+9g4JM8IEKJfSKSV1Jf7xd3jo9UUlqKTgNqfH+zmWevs
	 3gvQcXIZa/DujI3aStB5Q0QiC1fFolN7kG335lSkDEUlFPlTL48l4nwQZBR7EkyX/UA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253281;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=hXRH5duEyw3mUcCWcjPhOLWXWgyqrG4tmCM1l7tyASA=;
	b=V9Yfp2LGsvs9C7Ig0zkOTkwmPrqbRlxF31g5ciok+2wPaFolHJYSYm9C7062bpcz79T7
	 4jSc346TUB1W8yNVg3yqrwL213NkVGYBycS2VwkOuPXQBH/PZrIptfVvtzAI35yzsjhyf
	 AIWL82gbxxjtJQjxQZK8p37ITVEkXLuzRWXFw3atGjXoGh/6SZrhNrMx0bxnWAgQ9xSB3
	 spCBk4Za3GxSB09PY/qJzAy07VxxZ5EKDJZjbw4AQ0LUJAV+5DM1UDGIR3i2ScJLuYGLs
	 RmAkS+r6xJg/j+7LDFVjobf5trHa/sQ1Nn5k0s4BHW7salUaO8iIhBJX74uW1P1DALQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UQi3wQtf;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B958606A336
	for <linux-spi@vger.kernel.org>; Mon,  9 Nov 2026 19:41:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B958606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UQi3wQtf
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso9005045e9.2
        for <linux-spi@vger.kernel.org>; Mon, 09 Nov 2026 11:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794253279; x=1794858079; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hXRH5duEyw3mUcCWcjPhOLWXWgyqrG4tmCM1l7tyASA=;
        b=UQi3wQtf9r81/s7uonnwSY26mbn0xs1utlp3+GUyCw0SfFhPgolqoyMwgW9nXfXWTD
         W9mcSs40QBf9OlLQnpTQy7qF51mxpOFyXuVMHTkvQq80nyRvb5F+PkhcjMq8rpiI4Qo+
         sYobdfnPxEkv/nKx2jfyGpwLTRrIW4koiGWauCXAjiBz6FIJ0VqPuof1Q5vw+JCOohEu
         tZwznJaETXhbkF/t0C0XePOIZuSIoTXjlRkHWnEZJnxGK7Hg1E4K6bNUPUtZi4WjGHbq
         xHlPiCuOoEmEcBi3rRvAk/01rhdi/y8uV3LREBZx7CmIvrB5ISHGXkHqKMqA+pZ7zJ6Z
         rlBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253279; x=1794858079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hXRH5duEyw3mUcCWcjPhOLWXWgyqrG4tmCM1l7tyASA=;
        b=Zd/iBevwKagN15rbIEb/rYOpJZYQsdOm/q5aYDJtCLkVJhAUTpAoKo0RgFF44HugyB
         Omx7iY0+pnabmu8N9baPm98sXmQMg0R8xxgwQAjF5D1SsY61l/Ax+VnbIXbj6TfVQxYs
         EOqAsbbssM5k1ul1Sxqpr88U6o/gmDPzQZ8kokEaqrtqkRQgjDPBNiZmMjGz/PinfVby
         Wn7vyw/jHuq8kA0QKf3XffVPEsAK1uPOLFSoVinJZnzQvhTc0EaCOPLBYtirfuAepzFQ
         /8z8HHzH9rPOplCVa2HLZpEcTK/oS6F3+uwczeZ6WyQz2Nyr0on7E2meRzcesFeZf4rj
         MAfg==
X-Forwarded-Encrypted: i=1; AL+hErHbgTDmOD4cdMzNOBu0H+eOaAWm01UwLK8kbWhDNCm4+IWHgS950RDQ9YBKLGB+vAKg9x6F51TpIC8=@vger.kernel.org
X-Gm-Message-State: APuU4Z95V8S/TrZp+p05BB69M8g7zLSrojZQFz21R/M2qYcbf48aekkU
	dndtdQM+cQv4P+3Q0dVq0+EzlEYmBmn1A64QmZ0KlUnXQeYudQdCfEW0
X-Gm-Gg: AYBFou08TZU9CjXp+47cQEFOTd+D/UrwzFCmdOFwDD04Lwirk6V+XJZRQBRUVQqoVlP
	5TzSuRPYntjRlkenOHhLzclbteDkj1KxdaPbo8tr6Yz3wZOebv1z1LxiakbVZqU2FFqkPO6uEGg
	Uul3nfpVoatQ9n50SKI65qxW4C2R8Vw8XBRx7pCQVhNfUL7GDtXZPW019VaZJw9ZnEAU8vZ+Ema
	yVEa9LTpxYjK2quN1F0mXqWim42FIz1k3oqBzzhKOK4AcL2JpNIcF+Pyyf6EDFhUggxayzG/L4W
	Cm950PCUEbJRSGRlIs6khIwGgu6tZRDW27SD/aObU1bYsDpMmOy7XnBS7l8pjD2YgGs8B/hAqxC
	A1DFJNJYI0XenKUJjHLeIyzOcBjpE6GQ11QARkF107KHOSHbYGoqXSPyrBSy9nZVhLD4mfOaJ58
	3ygaUB8EwmjMHBJGoz273h6H091WbrUr0sIteaeEui8sWRLj/rAXwQOAQqLXVugQlXb82yJY7MM
	j2kv2veW6lysmSSjBmr1rZ8rUG0mMa99qDivsw2oRAXtp7rJzNH+xhYH8+AkluNny55XRnobNHh
	XHuFuaPSvfQd0nLQbTa+Q/U2wmHskjO9tDhgxnLAsmGu4ees3VqKo2kn5Zg=
X-Received: by 2002:a05:600c:350a:b0:4a1:f377:5c6c with SMTP id 5b1f17b1804b1-4ba0233d868mr4333885e9.10.1794253279437;
        Mon, 09 Nov 2026 11:41:19 -0800 (PST)
Received: from [192.168.0.253] (5403F394.catv.pool.telekom.hu. [84.3.243.148])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49836b8eb11sm714822f8f.57.2026.11.09.11.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:41:19 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 09 Nov 2026 20:41:05 +0100
Subject: [PATCH 4/7] spi: spi-qpic-snand: use the common
 qcom_nandc_config_cw_write() function
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
Message-Id: <20261109-qpic-snand-use-common-functions-v1-4-1e8601e2db84@gmail.com>
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
 drivers/spi/spi-qpic-snand.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index a825bdb93a8a..6774a0a5db2a 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -1063,17 +1063,6 @@ static int qcom_spi_read_page(struct qcom_nand_controller *snandc,
 	return 0;
 }
 
-static void qcom_spi_config_cw_write(struct qcom_nand_controller *snandc)
-{
-	qcom_write_reg_dma(snandc, &snandc->regs->cmd, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
-	qcom_write_reg_dma(snandc, &snandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
-	qcom_read_reg_dma(snandc, NAND_FLASH_STATUS, 1, NAND_BAM_NEXT_SGL);
-
-	qcom_write_reg_dma(snandc, &snandc->regs->clrflashstatus, NAND_FLASH_STATUS, 1, 0);
-	qcom_write_reg_dma(snandc, &snandc->regs->clrreadstatus, NAND_READ_STATUS, 1,
-			   NAND_BAM_NEXT_SGL);
-}
-
 static int qcom_spi_program_raw(struct qcom_nand_controller *snandc,
 				const struct spi_mem_op *op)
 {
@@ -1144,7 +1133,7 @@ static int qcom_spi_program_raw(struct qcom_nand_controller *snandc,
 		qcom_write_data_dma(snandc, reg_off, oob_buf, oob_size2, 0);
 		oob_buf += oob_size2;
 
-		qcom_spi_config_cw_write(snandc);
+		qcom_nandc_config_cw_write(snandc);
 	}
 
 	ret = qcom_submit_descs(snandc);
@@ -1214,7 +1203,7 @@ static int qcom_spi_program_ecc(struct qcom_nand_controller *snandc,
 			}
 		}
 
-		qcom_spi_config_cw_write(snandc);
+		qcom_nandc_config_cw_write(snandc);
 
 		if (data_buf)
 			data_buf += data_size;
@@ -1271,7 +1260,7 @@ static int qcom_spi_program_oob(struct qcom_nand_controller *snandc,
 				    oob_buf, 0, snandc->qspi->mtd->oobavail);
 	qcom_nandc_config_page_write(snandc);
 	qcom_write_data_dma(snandc, FLASH_BUF_ACC, snandc->data_buffer, data_size + oob_size, 0);
-	qcom_spi_config_cw_write(snandc);
+	qcom_nandc_config_cw_write(snandc);
 
 	ret = qcom_submit_descs(snandc);
 	if (ret) {

-- 
2.56.0

