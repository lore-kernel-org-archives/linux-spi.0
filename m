Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253285;
	b=2Gax/v1V0aNvaH96vtQRJRk1KwawFl4D6Y2LKzal45TAjmIYBeesTHo9K0AomUbDgoL/
	 B65Qv6eX8PkdYyL9EvUhdPX2STgX+I6KktId0moF29LTBYL/VANIQQJEaM0TT5+B6DdxU
	 xAcVQa5oDvU0YbFqSOMtYSSZOkHwv/txIOVqnHrB/1wC0o71b0Ou3Gdr9pwH81jl5MiSC
	 mbd12q0liVh7Fu7MELimTLaKuU/Wd8odujIEcEZFEUDHk/CqjVs9dLHlSeIu8hoewQETI
	 LLPaXt3i40M9EIBbplf8lcW77gtHvUB5Nnfw+AZXo8Pku/obDCGzc88qnnG/FVgjvxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253285;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=yPj6/SqRUU4G27b4S8AB+m7SzAAWnuPJHVAUoCo488I=;
	b=XUDorYGyLHePZpMZwBfO1Bmn4b3UqLSHAFSsSDx9zoDwPEH/fer5OHcT044n+44b54ew
	 aq6O8BF7hHQ1FZMQqFNFIGLrkOytX8Q9wGQNWAFIFa8Bm0+LmwcoViPP2ioZLOvs2xSOt
	 /ewvIRfgwVQU//gxesP0PDdNV30LsCBsgAVORAc/hObNlRFy/kTnEuDDVjakOpOaTvech
	 X3orrclt+nzEBxz4GptN82nJT/ny+aLdi+lQhcTIrzvZXlS/2cqo8Lq1RIOEbxehjtCyO
	 ffujUW9ODJvQZEVt3RwGr6L9ZLDqnQBkcb0GrWojTd8iwyWlTZCcMomPCIHcp+JqMYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C7fieBjk;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB37460A3815
	for <linux-spi@vger.kernel.org>; Mon,  9 Nov 2026 19:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB37460A3815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=C7fieBjk
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so18157535e9.3
        for <linux-spi@vger.kernel.org>; Mon, 09 Nov 2026 11:41:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794253283; x=1794858083; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yPj6/SqRUU4G27b4S8AB+m7SzAAWnuPJHVAUoCo488I=;
        b=C7fieBjkZqxonGqisjpuD0Y/A7tVT7XygPE/N27Qly4Tnwewfo90QxxH3C+e8jTf1S
         aoalvkygtChaebkuwASQ6SQxeaKorUJgxXBFpOZU68z9G33CDqFktSYW/PXNOQsVlkYs
         78E3VP3HD2aYpcmz/IMtrl8jgR3QpoBnwheQ2ZAFKxuvtlzONRRpP+uz/aVdV0+jkJZH
         RPGVwM+y3484709lK/WkC1nlGA8UZN1rshZLtN7BlwdDBvbUKPh16idZDEvQsmUfoALQ
         SbLoBgHF6XXz3Syoppl3zK71WB8iMq+j4ewvPW3tFfaGyvvDeDLY9ml8h7sS2IpoGV9P
         jO9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253283; x=1794858083;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yPj6/SqRUU4G27b4S8AB+m7SzAAWnuPJHVAUoCo488I=;
        b=nF9NzW3ovPd3ylJpzMsyw8Hu8r+Z8vYEsCHAVn2vpYj4VrHfVJIXKaAo0oEJcz7ps2
         NhdHkr34VH/d88hy8I40cbK+T/B1g6tB0Khn0VRdvm5Dt1AubwBT1cLVzV2EQv+Tr6t+
         PjjrdYzUzx1p8JpYMSBzmDo+fQcWZA0uKkH6Mil8x4BHpreX29BcAYJfuigE4DAPPuNV
         Y3X74JF5vZ4JsU4ZfBkbqSNfA+4Js47wSv4NRLjMh6i//0UIUarmyLcOXcOCTzZSA3cl
         BSwcIQd8aViCn9vq3cXSWEbx0fl62y+7E9NYeHeV0ZJFv2Lr5bqjJVeKX2Z7g+WUg4Yz
         tpew==
X-Forwarded-Encrypted: i=1; AL+hErG8gPzsxVrbvPgxgH3BWAi1LzUQPE2wpJOS958rxkDGuhpkrWeADlLrkNGp3PoZ5OeypLWUJWKM7lg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/eKekN8jsYSS8PqWOW0xw2tpmr0dpf4hm8466ASAVCIH35FfTz
	M5u22lGomIZfm0ltBOA0ivyV4ChSD++lQkQRHb8R6zH7VTce81zmLQC+
X-Gm-Gg: AYBFou2Sd1tkEda6XMA6YKmwp+ZGhiL3P4/bbCALEwipBja6maSumSOv5A0QdvJZUcC
	96/4g+gDa2zxBxLJ4kh1Ufb8SVgFR00WXYLzBRaodHfRz9q1yDEjjPazt2Z8I7elDxdDreBIucZ
	Nv4jNBvQwOTrPQCYVjy4PVDvGsuEHpQMClyNlyoH3Ge+n8fauZc8LjXV/Cn20Sb73Ph3hOIeNLc
	8GbzKj0Xy1FzCmOrp3l8J8WQvSdGPuBC0af/CiBge4hbBAeFFldyFzwoQPlKkSYD9ashlyZn5e3
	eNwinb0BQIm7FcDPAOX60XbuzNMHxORrUpjRNERg6Y7+MWbFx6EqzXJZch4QFiRbh8DawxEAOWv
	iljMaobt6aSV+FJ92xSIChiYu/x//VVJ5rVX0LvqrlrMdqp7UGu3iG7BsglSWK35eKJUCsTcGVz
	1gOMdAZtbSF0rK2S1l/EAFRVtmiJNKv5YZ8+Jv2cPg7bLKevtLzyvsSb8ulvYqKnyPFLirlc/ad
	Wh2CHHEmaqPKT/xBowuHAlwwTdMU4pSX4PW/A368Z9cWKfw9VjbKXfm9OrcH8L1jFM+FTOoNaC9
	slmoZieDZtWaPbLxqL6IThuuZ2zjv5XsLJOmsIDrtMWCeVQZTGpR2UD3sIkvSbgqU6vxAm6ow4d
	cnB8=
X-Received: by 2002:a05:600c:354a:b0:4a0:b6:4619 with SMTP id 5b1f17b1804b1-4ba022ca866mr5590405e9.0.1794253283177;
        Mon, 09 Nov 2026 11:41:23 -0800 (PST)
Received: from [192.168.0.253] (5403F394.catv.pool.telekom.hu. [84.3.243.148])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49836b8eb11sm714822f8f.57.2026.11.09.11.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:41:22 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 09 Nov 2026 20:41:08 +0100
Subject: [PATCH 7/7] spi: spi-qpic-snand: use the common
 'qcom_nandc_read_stats' structure
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
Message-Id: <20261109-qpic-snand-use-common-functions-v1-7-1e8601e2db84@gmail.com>
References: <20261109-qpic-snand-use-common-functions-v1-0-1e8601e2db84@gmail.com>
In-Reply-To: <20261109-qpic-snand-use-common-functions-v1-0-1e8601e2db84@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Md Sadre Alam <md.alam@oss.qualcomm.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>, 
 linux-spi@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.3

The 'qcom_nandc_read_stats' structure defined in the 'nand-qpic-common.h'
header and the locally defined 'snandc_read_status' structure are
identical type wise and both are serving the same purpose.

Drop the local structure and use the global one instead to reduce
duplication.

No functional changes.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 4105a04afcdb..6c5878f3f8b6 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -64,12 +64,6 @@
 #define BAD_BLOCK_MARKER_SIZE		0x2
 #define OOB_BUF_SIZE			128
 
-struct snandc_read_status {
-	__le32 snandc_flash;
-	__le32 snandc_buffer;
-	__le32 snandc_erased_cw;
-};
-
 /*
  * ECC state struct
  * @corrected:		ECC corrected
@@ -610,7 +604,7 @@ static int qcom_spi_read_last_cw(struct qcom_nand_controller *snandc,
 
 static int qcom_spi_check_error(struct qcom_nand_controller *snandc)
 {
-	struct snandc_read_status *buf;
+	struct qcom_nandc_read_stats *buf;
 	struct qpic_ecc *ecc_cfg = snandc->qspi->ecc;
 	int i, num_cw = snandc->qspi->num_cw;
 	bool flash_op_err = false, erased;
@@ -621,14 +615,14 @@ static int qcom_spi_check_error(struct qcom_nand_controller *snandc)
 	snandc->qspi->ecc_stats.corrected = 0;
 
 	qcom_nandc_dev_to_mem(snandc, true);
-	buf = (struct snandc_read_status *)snandc->reg_read_buf;
+	buf = (struct qcom_nandc_read_stats *)snandc->reg_read_buf;
 
 	for (i = 0; i < num_cw; i++, buf++) {
 		u32 flash, buffer, erased_cw;
 
-		flash = le32_to_cpu(buf->snandc_flash);
-		buffer = le32_to_cpu(buf->snandc_buffer);
-		erased_cw = le32_to_cpu(buf->snandc_erased_cw);
+		flash = le32_to_cpu(buf->flash);
+		buffer = le32_to_cpu(buf->buffer);
+		erased_cw = le32_to_cpu(buf->erased_cw);
 
 		if ((flash & FS_OP_ERR) && (buffer & BS_UNCORRECTABLE_BIT)) {
 			if (ecc_cfg->bch_enabled)

-- 
2.56.0

