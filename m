Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253280;
	b=Le2zr/jvxpnQ47KoyPr4QgTTRE2Zrwznx/BTUoFef9H6j/zoosV8onXIn8mtS4WhbtEj
	 OJAcMAknZbRqnQ+n4sFuHwOCXE/ddzgouy1iAXVlYvO6dRCgcqjsRIA+IBMn3YJEq0s55
	 B2UfeYWTW+/DXETHFPfF7B2nZm7QeI35L7KRqneVFxjW5bVQNoMYVnl0BxE/E+j83sNdK
	 hB5HbNQ8Yo3W6yBWiBC19YhI2n0fz9Lc0FfC8MGczRGFR8dU5edBE0N6b0879jP/hneX4
	 CAq3EbtOY8hrbUJ0V4IHgZlzVNEkwFr08kdqj6asg2DgdJ3wKSpUX6FD5K6HRV5luCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253280;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=uRO3Gw4B7BUYegkURbfJRBwxO65C99A7i3r/+iHeW/k=;
	b=DHUoTFxyxS/oQnuyMV8xGwygJ0iCXv73xSoR19spzOCk6Tdid92ZGx8zjl/h6q2JgjkQ
	 pUnyQLIR4tIG65+baH/bzm7H3CVsb05vNEp8dCq8YMAEV+rAfP9mkwv+R7VZPTr/7Qz5d
	 GTgxp7kuRm535t9obQs4I7N9btRs2INvGAg/giM0iAvzwmzrcW2wZnMz8BbCH28Td0fnX
	 OkVP8qewXqoZo7XYpTA9sbcZKKh5D4JQbPv5MemKlxrx9lE0KQXraoiFVpDqjz8ZXJa2G
	 VUROWbcCCLGUcLH60k/LC3owTHPIQT6lye4CSD6mxfdRqeyPsrgPNjh0L7BOIDSVkEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I+NBXR0a;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E7060A261E
	for <linux-spi@vger.kernel.org>; Mon,  9 Nov 2026 19:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5E7060A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I+NBXR0a
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-492f563d1c6so479196f8f.3
        for <linux-spi@vger.kernel.org>; Mon, 09 Nov 2026 11:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794253278; x=1794858078; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uRO3Gw4B7BUYegkURbfJRBwxO65C99A7i3r/+iHeW/k=;
        b=I+NBXR0azYvF6cvFg98dnoMTttO5Le3Wx8KqBFYGClkExkrjW3QJAHfa3w5KZAWwbU
         7jNl1Q0KbVFFQZIT79ZVSt/6EYLuD0+J78DY7lsSyw6MfKBLpmL8FjlwHS9WQapxna3P
         yK6RGPbzueYdDgth9nq+uJVcLByRlqOl25RMfIyAABud5tHt1hBQmUsbkw2C3oUF9Qsh
         yr7iocfk8uN+Euj+QG9IDFRoRWnuKKQqupIY86SVjSr/j/qPzFf7YZF7bpZVQddHR12f
         VvBp0ZsNk3Sk5nnaoNCEVvXGCnZYpM5HWzBxofAlry0eW5ZmaY2n4iF3osQv3CMaCS5X
         PhDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253278; x=1794858078;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uRO3Gw4B7BUYegkURbfJRBwxO65C99A7i3r/+iHeW/k=;
        b=RvhCVXaSgIQDSk5OF5hAAZnu2oQuJp71OUmTC/bvcZWg1xIVfAoZRtUaCOX+1e8HCN
         E2HniUB2flckFc/UtRbe/jfUAwwRB51ObqpEO7MPgsXFkPlVrPuuYTSpurjcE3yW6zAt
         TeZ8e3WAN36cxy7uJ9gj+KVUxPruBliRPb9PpJMRKBLtfMZGDV1UnHIaVuPkWU57L5Hb
         dygZ0Jd4AJHvwQ4pYZzHSnwV6Qbuh0dUDBRj0/bH65jG/KjglJkMGmCNEzZ3KYzptMFp
         m+Br4gZxR63W15RKfJzadH+TOaXYUKdiJrFbLzpye5bRtCgREqy/obgE6KLf4hLMtLVY
         CeFA==
X-Forwarded-Encrypted: i=1; AL+hErHxzOUfYvPL5uMO6iLE929Iwb6G194US2BxLYWXtIn/yF/0I4PZwtJbXx1tL1P8mi3AoHXRKRAGDr4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ty6kK8IiC4in6j6OeMG6e7c4Q5lwQkc20Bhw9vDZTSLWK+UPC
	y1/2IrHHiIEzclSn9LH7EmyyO4ONLiiMFOuKGG+uPnrWLMDidxcUIQ/j
X-Gm-Gg: AYBFou358H2fEVuIA83WUDIL+2pikW6yoX1zFNXDq9S4nsMKRJlW1tamz/FZSf3ah5/
	kYl13r15Ki2vn9lDPmUUyv1GbsY+nH8OZl4xpeb0Os2HBHN0/qySwQBmzsrXhfBc/YRhF5X8gxG
	HaMp93iDinvh184OiqpobUZxz0mzbVsY48FKQQJr8PpF610OAl4NysgpQHOqCwe1S4Ab38Z4kU8
	yQ7DDD0/7fF2B31D+gTiBK23Sm+XxX4V36af7b0MhoQuUYSvTXR4vgo5ixfAPHfodstB4nb4XD4
	IBmnUJTn6z3DH2i6xNYG2VBttg862Eg4AxPzQ3W3ojO7vGAxnFZwzVJLfcaheBES8MbwtIeMFrZ
	3WpDB90cCC+cfpYH5u12P8cWnV7AWDJjnWJ30hOCJs7tlfVu/zk9w7Ty/1fzQeC9hDeaZt2iX4f
	kTFxSCSZDVDOnMO4I+s+2XhpalTkziphyuQYdKrxaYzRrkbXEumTyDzsUmHKU9Q6CRCKT3hHGTJ
	IPF+zBvCss70GT9vhY4qyaJu6ptLv+qPdZDogLimNuhbHoJm1asA/GcMXXRd+MCVmwmMzjDnxSi
	soKPlChGU+2/eJKdz0Plu3/b+j2vko2mxdSox9HsmzHf3QcukVZ5qeS07g==
X-Received: by 2002:adf:e00b:0:10b0:490:9fe2:6a37 with SMTP id ffacd0b85a97d-4982ecf6412mr609375f8f.17.1794253278240;
        Mon, 09 Nov 2026 11:41:18 -0800 (PST)
Received: from [192.168.0.253] (5403F394.catv.pool.telekom.hu. [84.3.243.148])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49836b8eb11sm714822f8f.57.2026.11.09.11.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:41:17 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 09 Nov 2026 20:41:04 +0100
Subject: [PATCH 3/7] spi: spi-qpic-snand: use the common
 qcom_nandc_config_page_write() function
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
Message-Id: <20261109-qpic-snand-use-common-functions-v1-3-1e8601e2db84@gmail.com>
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
 drivers/spi/spi-qpic-snand.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index cf75c142303f..a825bdb93a8a 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -1063,12 +1063,6 @@ static int qcom_spi_read_page(struct qcom_nand_controller *snandc,
 	return 0;
 }
 
-static void qcom_spi_config_page_write(struct qcom_nand_controller *snandc)
-{
-	qcom_write_reg_dma(snandc, &snandc->regs->addr0, NAND_ADDR0, 2, 0);
-	qcom_write_reg_dma(snandc, &snandc->regs->cfg0, NAND_DEV0_CFG0, 3, 0);
-}
-
 static void qcom_spi_config_cw_write(struct qcom_nand_controller *snandc)
 {
 	qcom_write_reg_dma(snandc, &snandc->regs->cmd, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
@@ -1113,7 +1107,7 @@ static int qcom_spi_program_raw(struct qcom_nand_controller *snandc,
 	snandc->regs->ecc_bch_cfg = cpu_to_le32(ecc_bch_cfg);
 	snandc->regs->exec = cpu_to_le32(1);
 
-	qcom_spi_config_page_write(snandc);
+	qcom_nandc_config_page_write(snandc);
 
 	for (i = 0; i < num_cw; i++) {
 		int data_size1, data_size2, oob_size1, oob_size2;
@@ -1194,7 +1188,7 @@ static int qcom_spi_program_ecc(struct qcom_nand_controller *snandc,
 	snandc->regs->ecc_bch_cfg = cpu_to_le32(ecc_bch_cfg);
 	snandc->regs->exec = cpu_to_le32(1);
 
-	qcom_spi_config_page_write(snandc);
+	qcom_nandc_config_page_write(snandc);
 
 	for (i = 0; i < num_cw; i++) {
 		int data_size, oob_size;
@@ -1275,7 +1269,7 @@ static int qcom_spi_program_oob(struct qcom_nand_controller *snandc,
 	/* override new oob content to last codeword */
 	mtd_ooblayout_get_databytes(snandc->qspi->mtd, snandc->data_buffer + data_size,
 				    oob_buf, 0, snandc->qspi->mtd->oobavail);
-	qcom_spi_config_page_write(snandc);
+	qcom_nandc_config_page_write(snandc);
 	qcom_write_data_dma(snandc, FLASH_BUF_ACC, snandc->data_buffer, data_size + oob_size, 0);
 	qcom_spi_config_cw_write(snandc);
 

-- 
2.56.0

