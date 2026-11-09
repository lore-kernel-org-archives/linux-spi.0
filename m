Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253277;
	b=uzOhjrJcF+4Fw/XyMrqUf2Ng3VCd+bD9THkMNLd4+v8FiwKQC6lJ4Wje2OEO/F3tPNQM
	 C+cSsRqH6L7xtZ8korkCWlS84l7gsjCHXLtaexdQs8yZ8SHhyJ+zl4i0GsAHGM8vKazKu
	 yX1s6qdBIbRmQVU8yTEaGw6hWXpIiuBpdOWlXTq5VJymYhNw9KGGohIK1MtlNSnXsrtHr
	 ziYQ7huIEctKU8IFpWv12Y9FN1cgWwl3crKBm/6vn9mIb7wqxERYaUedbLkslO0XbC12s
	 OhWtrhQbv3qWuwwLpeFxIEi3K9OLPcXyTV5m7X2CN9tXSk4DoMq9LLHwnSLgPPZbGfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=qRwbk6U1HajIppxtFUV5odMGeHrOR5vt/U9rXvrWZSQ=;
	b=FUy2zkiRktp/znZkPgDHBUD45ZCE8IEtz3540+wxRflr/rML0nwzE83fpxeVIKbYaMVN
	 BqUw8IB1c94FqXwJSKoWEITDYUU++NFDoxSX0JmBw2MLq46N9j8PxbggCI4Vot9Ne/qmw
	 FZmUNQxytN9qsHFu4QFL6h4AYM9g3l2O6T5VrFZGYoql5D2hzjGE1lsZINFQZGUrKUZF6
	 wcOsO3fu97BNL1cBHG4onNzSw68f4nX7nKMllfP0eI1TwUqElX+rMISEOVQpZTSIDsal2
	 6QM3ENe3OLilIQ6pNOvj9S12q7a3p/31R8lj5QydjrS93o2ZVyMi6PaZRrzeeZwEhIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kYZTUad+;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825EA60A2604
	for <linux-spi@vger.kernel.org>; Mon,  9 Nov 2026 19:41:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 825EA60A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kYZTUad+
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e10a70540so794897f8f.1
        for <linux-spi@vger.kernel.org>; Mon, 09 Nov 2026 11:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794253276; x=1794858076; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qRwbk6U1HajIppxtFUV5odMGeHrOR5vt/U9rXvrWZSQ=;
        b=kYZTUad+0ITpvkCsdvGJ8/5L3EaxXidV4n6mRWztI4OqbW5rPhDvBgqSkFH+fKDzV9
         TiVcb4hlkxsrJA60HCxhpQSMnsarLaAIPvKA1dt5e1xfEFGPWxZ3LMaslazlR+vXGYLZ
         hlwIGSq3L8dNXn+Qy5usx4CIclN7pHxMdnrj5pyLvT7jMgfY2xn6+ixDVw25n/nASTTD
         UFk1XE9Ul5/PdLFaykLnhkHeu8RK6xvmIdFJuMN/oOuy0lXnmB0tgd+LTqyVoc6Z/sHW
         Uir/HaEtbGG84vTwZiN1iGYlfzw3LsgffY4NHjfpRwWt/9zwGDbl8erXMDwyvrf48HNs
         mZTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794253276; x=1794858076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qRwbk6U1HajIppxtFUV5odMGeHrOR5vt/U9rXvrWZSQ=;
        b=NxH4Z06/2QpzOt4p7SHOrTKJI2Z4KEUITYw2oCqXICElW8lXfTUMM+R6O9Q8VdmNxM
         91oqf9uysmmtrtvo54ihJw+NRJFUKWfqeVoLQEe7xBW2OdtwZs2WeYM3DDdxUgTIHE2L
         lEFhXe+lF5H8DVZt6y3FWva3XvINJeTneR/PkDam3S1+R345l5fiWC3D+36B3N2e/bhP
         4pDkIGQ9b4vhChb3fanBzoL+vvR6h90XD0utK5IQJou4kA6ZGYJfiUR4h4i4EjGMu6Ff
         66Cp8Rgftnllw6YjmjgaWUP0g3Q1sc/v6XrhSi/3ddsU+wb+WuHR+jBflgQ9blFEkiIX
         3Hyw==
X-Forwarded-Encrypted: i=1; AL+hErFjF5Smdn8swFq8BBeSSmLTCKhz4H2CKID77KpMlJlUkAsgYfPnnrZ2Pj2SPTXm/U87fB84HwtvGmc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+w/KRfV4FOdSJolftKRvhbSm/LX7dFMxs8R+hBqmN8dbZsbLBn
	g0tBmcrvg/drC6ySRPqxVy6K9sV/vNUDwbSW11iIhPzNsdW5t3QYm2Nn
X-Gm-Gg: AYBFou3DCGjrz7FtkX9AhJrkLlbKmzoH6Wqx1s9KC/X71j9gp7hiOFgFiBMQlWls8cM
	nxGhCdpzOViFELSb2iZzLCTJlN/TqCTWDnXiQg2G0YRXsVw8CCJeYcptiJkGYior6GTAmcDjiBp
	QG7q7/I4BHh6CadlojPNQpdq21w6ueAHVmjtBHcRC10A8C9Dxnow/WMmK0iIw3tAkM7BJzPmUdd
	37/H7BPDhNnKMlesuxG/pcy47NxOowsnB2ITdAJMgLIJMhDQU7YSiU9tRtzf9coJCu5r9V7jGxx
	IxyV45ykHD4TBMz/ERHCchW3O5nmawkBlBJzZ8ZBqB8iQKBXOmvyx6M4iVJ4DV2qM7hCa2P7BMw
	Ax81gxC/h6heys1StyoKJpN3IL0XWNlyWI3lUe7edgfmGJsR1oi8SWBHRM/vsKdR70wZfSxctl7
	IKXWDbm+gHT689BKU7ampzCOERYLGiFfXQgsLkQudca8mVVRrvBVuM8urRt1fb9dt8jrKdBUC8h
	J0jKiWGGXGwL8RmU/EK2wjQMsVgTgAE88zBotodxVTiuRP8Y/V2pJNa1du5kYH7DrlhPAwLWc3J
	xGx8ORI4Ej4ARO2U6Voa9v0jCEwlookryOH99EyNBPGKoVDv/O4/hJOXhDekOj4+qx7gMqxveeL
	sseg=
X-Received: by 2002:a05:6000:25fa:b0:492:e1a6:90eb with SMTP id ffacd0b85a97d-4982f1c0674mr682603f8f.10.1794253275742;
        Mon, 09 Nov 2026 11:41:15 -0800 (PST)
Received: from [192.168.0.253] (5403F394.catv.pool.telekom.hu. [84.3.243.148])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-49836b8eb11sm714822f8f.57.2026.11.09.11.41.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 11:41:15 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Mon, 09 Nov 2026 20:41:02 +0100
Subject: [PATCH 1/7] spi: spi-qpic-snand: use the common
 qcom_nandc_check_flash_errors() function
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
Message-Id: <20261109-qpic-snand-use-common-functions-v1-1-1e8601e2db84@gmail.com>
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
 drivers/spi/spi-qpic-snand.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 41685a286e38..981e16221b59 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -592,22 +592,6 @@ static void qcom_spi_config_single_cw_page_read(struct qcom_nand_controller *sna
 	qcom_spi_config_cw_read(snandc, use_ecc, cw);
 }
 
-static int qcom_spi_check_raw_flash_errors(struct qcom_nand_controller *snandc, int cw_cnt)
-{
-	int i;
-
-	qcom_nandc_dev_to_mem(snandc, true);
-
-	for (i = 0; i < cw_cnt; i++) {
-		u32 flash = le32_to_cpu(snandc->reg_read_buf[i]);
-
-		if (flash & (FS_OP_ERR | FS_MPU_ERR))
-			return -EIO;
-	}
-
-	return 0;
-}
-
 static int qcom_spi_read_last_cw(struct qcom_nand_controller *snandc,
 				 const struct spi_mem_op *op)
 {
@@ -651,7 +635,7 @@ static int qcom_spi_read_last_cw(struct qcom_nand_controller *snandc,
 		return ret;
 	}
 
-	ret = qcom_spi_check_raw_flash_errors(snandc, 1);
+	ret = qcom_nandc_check_flash_errors(snandc, 1);
 	if (ret)
 		return ret;
 
@@ -819,7 +803,7 @@ static int qcom_spi_read_cw_raw(struct qcom_nand_controller *snandc, u8 *data_bu
 		return ret;
 	}
 
-	return qcom_spi_check_raw_flash_errors(snandc, 1);
+	return qcom_nandc_check_flash_errors(snandc, 1);
 }
 
 static int qcom_spi_read_page_raw(struct qcom_nand_controller *snandc,

-- 
2.56.0

