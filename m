Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793991808;
	b=e5GBNYgIA88kz5hC60fGn2XRdtcyrezmIVKfO81wmAAXQ3wpGASbHAO4Zyi4AOF4hoc+
	 DP5lyKtoini77Tsbzz5bg5RgRylk+KaK0GPj8ori4q7W+67HR9MoOD66mGt8KIcsXEkXS
	 MRIlvf9zk8Z7P8nWs0C4iZFjhqYHgJ2SkE1rvpEPEkjmcP6uZ13FRIbxXlyLltBHTNepN
	 cSBVZlBX41IeqbcFywhJXOtJD1au6inAfNLgF/ZCQQpYK/hBgCbgR28shqb3ZzGRMQraP
	 fctZ2KBGhMn5NdNj79V6D7yhkJIJuzkHhJ2GZPUHTUYTz/36KW0Zs0K1gCqZaQr8OCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793991808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer;
	bh=KoIWhNtJmxZBVyIenQ/WCpX88ezjIaOb5DLauh7L2NM=;
	b=CullWx4q/RLVtNN2SVvNhr6osBk6dcMlWjrYeF9OeXoYI6UwSl7+E8QD8zefhwf/lKhZ
	 JRBED/lXoCROULkW2GIHdwVw1MZDxorcwe2hgGfo4rJmP+CC0X9MJATCqWDtzcYuumLwY
	 XA2aEN6bvf0e0royDXEKWVInYUO4ZuXm7BhFYb44nijQx3394hhf3LkAnzxWaWTSWX6My
	 TrEADKUaNKYA1oS9dhe6zOviUgDXpx65i0ij+mbncoXqcbkGosK1y9NTHnniCk78GROmb
	 3oAxFV9M9R6tGlRj+9Bop8OW9MBJp4dbd5BX1MV+IxrZ6q9kIGn51sGiM7CYDgP+rjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=emcxuYq3;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFDB606A329
	for <linux-spi@vger.kernel.org>; Fri,  6 Nov 2026 19:03:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EFDB606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=emcxuYq3
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so8443485e9.3
        for <linux-spi@vger.kernel.org>; Fri, 06 Nov 2026 11:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793991806; x=1794596606; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=KoIWhNtJmxZBVyIenQ/WCpX88ezjIaOb5DLauh7L2NM=;
        b=emcxuYq3c/RZcZ41az/ZF1XcFdIxhiuhFsnxtHxbY+j+qByR+FlmXP79e57+oBkz99
         TSGPlX7YXkZD+Q8I+61BD8vtNd5m2vaf00VOqViCcjheFUoKLvhrfinNOwWO8ej73L4g
         O7VcOjbcqth7e5CRkrEB3Hijgx93FXLoDMmNtHH8LYfCppnH7hp1ekn1O2Rw5F/YRzBu
         rV2dEs7yEht92ByaUkGUfRZT8OjE6rpy1t8WtAVJEsqfFMdHbK1aG8uSw+FTJjBN5FJu
         aV8LR9TicW4swgJZKdbU/cZiijxZwjvd3jdFoP+qh0+FB7n1JL8DMjKbJrgextb9TocW
         Y7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793991806; x=1794596606;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=KoIWhNtJmxZBVyIenQ/WCpX88ezjIaOb5DLauh7L2NM=;
        b=zob5GgQdzrRtAAG2b24G3tFMiH6FM5gcsqm7uUQPGuZT09CI7ljwLqVTbR9guxCl/r
         27kwqou+eMjiWSHk+B21M2CYt/VqdWR0li77UD6mzPGg5Tc03B0vvllUeqI0ZCLkRQu4
         VEY4p1EqRTsJy0uYFoejej/i9gU1be50L2TedvqRChUClSFeee6d235H/UPwzwm03UIr
         RdFFRzn9dflTe/eV2c4ZJwTRzornWnbcX5MMMicCDqtn1B+w5EIUmjjQHvvVBAC6c3D/
         GRR5d3rFg4QtFdMnNqBzO76lDO9YPbd6DiQum7GPftc3I78CxIlP9ux8AVJ2hZ3UBbiH
         So9Q==
X-Gm-Message-State: APuU4Z/6CdSzi3wMYxlppk+WatxdQS4RfKLxi/wDeKfu5VrVlXIHxE8B
	f1UVTt77rCQ8seTqH2EhmUEqraWo2NP6TV6WoHuO/N2CUg/pT/yTcchM
X-Gm-Gg: AYBFou11qG77XkLrUVYNMTh8x+54R73oNFkwpxHDNfPCmj2auePGuXz3D6aQvYghzkq
	MpksjzVQDXrLcSwx7+wTOY8/IeCZ5QGxNeLz4mLn+Tl6bgZdr8+/Ul0EzDXoeHyQ8+r6ILMH6yU
	P29GkKaAuuT9Hxg9clvNCEt55kDzJ111S26x/Bmp3g/2TPISsrFBX6gPxw3zwrNq3rnWpIcUpD6
	SmvnMf0Eh7RP4UX3Uy8jeB0u5eLmho/oZgv4VLPflupKt4+2xWCRhMCQTl7E22RqFo70oQV2xRN
	HUIIzGVTxVqQjknJA8GmHIBOYua+YAOiVUT5XnzHQnh+ijC0eiT89JF4+6sXRPQYSwJ2V2b9WAa
	uKbb0bI8pn3dKOHhrXEDsh7lQywjHLas88K79EjAV8SMJPa8KZXWbudq8zJPPp5KWGuxqkJipjN
	o6v4KxM5/zsRwMMyl7ddDHlG76Q9w8qn4sm16qBKan2APs8ynNhNKSPMdGoIo8ojEmCn0vV/pDZ
	v3iOQv2Y/VWW32eyAuJFr9y1u+DV0GC8+JJgiJKbDaIxhj3U4yXw0b6pmAaHVG2oFf5/iL8RuCu
	jHgO0UKxTsLWpk5DRLWhlDQVIf4FhKeUE0BvSU+yxUnLOyZUqLWT7KOry8gLH2MZXt/l1FL/IsT
	nkNA=
X-Received: by 2002:a05:600c:529a:b0:4a1:d675:b031 with SMTP id 5b1f17b1804b1-4b6ddee3235mr55014455e9.6.1793991805836;
        Fri, 06 Nov 2026 11:03:25 -0800 (PST)
Received: from [192.168.0.253] (5403F394.catv.pool.telekom.hu. [84.3.243.148])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4b7e327a6d8sm977005e9.9.2026.11.06.11.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:03:25 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Fri, 06 Nov 2026 20:01:54 +0100
Subject: [PATCH v2] spi: spi-qpic-snand: fix various errors in
 qcom_spi_config_single_cw_page_read()
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
Message-Id: <20261106-qpic-snand-fix-singlecw-readloc-v2-1-18de8226fe15@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NQQ6CMBBFr0K6dgwtlYAr72FY1OkUJoEWWoMaw
 t2tnMDl+/l5bxOJIlMS12ITkVZOHHwGdSoEDsb3BGwzC1WqumyVgmVmhOSNt+D4DYl9PxK+IJK
 xY0BAjU370FXduovIljlS/h2Fe5d54PQM8XMEV/lb/3evEiRo6WxTaSNLR7d+MjyeMUyi2/f9C
 yW6ggfOAAAA
X-Change-ID: 20260922-qpic-snand-fix-singlecw-readloc-c4c89b4369f5
To: Mark Brown <broonie@kernel.org>, 
 Md Sadre Alam <md.alam@oss.qualcomm.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.3

The qcom_spi_config_single_cw_page_read() function has several errors.

  * When the cw parameter equals with the last codeword, the function
    configures the read location last registers. However it completely
    misses configuring the regular read location registers for other
    codewords.

  * The 'use_ecc' parameter of the function is not handled in the code
    at all.

  * The last qcom_read_reg_dma() call which is supposed to read the
    NAND_FLASH_STATUS register does not use the NAND_BAM_NEXT_SGL flag.
    Due to this, the respective command element never sent to the hardware
    so it never executes the read of the NAND_FLASH_STATUS register.

After fixing these issues we would end up with an open coded
version of the qcom_spi_config_cw_read() function, so drop the
current code and call the existing function instead.

Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Changes in v2:
  - Rebase on tip of spi/for-7.5
  - Improve the patch to also fix two concerns raised by Sashiko in the
	review of the previous version [1].
  - Rephrase subject and commit message according to the changes
  - Link: https://sashiko.dev/#/map/177852 # [1]
  - Link to v1: https://lore.kernel.org/r/20260922-qpic-snand-fix-singlecw-readloc-v1-1-41fd834a10fe@gmail.com
---
 drivers/spi/spi-qpic-snand.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index c90c2001ee8d..41685a286e38 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -588,19 +588,8 @@ static int qcom_spi_block_erase(struct qcom_nand_controller *snandc)
 static void qcom_spi_config_single_cw_page_read(struct qcom_nand_controller *snandc,
 						bool use_ecc, int cw)
 {
-	__le32 *reg = &snandc->regs->read_location0;
-	int num_cw = snandc->qspi->num_cw;
-
 	qcom_spi_config_page_read(snandc);
-
-	if (cw == (num_cw - 1)) {
-		reg = &snandc->regs->read_location_last0;
-		qcom_write_reg_dma(snandc, reg, NAND_READ_LOCATION_LAST_CW_0, 4, NAND_BAM_NEXT_SGL);
-	}
-	qcom_write_reg_dma(snandc, &snandc->regs->cmd, NAND_FLASH_CMD, 1, NAND_BAM_NEXT_SGL);
-	qcom_write_reg_dma(snandc, &snandc->regs->exec, NAND_EXEC_CMD, 1, NAND_BAM_NEXT_SGL);
-
-	qcom_read_reg_dma(snandc, NAND_FLASH_STATUS, 1, 0);
+	qcom_spi_config_cw_read(snandc, use_ecc, cw);
 }
 
 static int qcom_spi_check_raw_flash_errors(struct qcom_nand_controller *snandc, int cw_cnt)

---
base-commit: 4a8faaea975be15cb636646c0d4c6ff1c2110baa
change-id: 20260922-qpic-snand-fix-singlecw-readloc-c4c89b4369f5

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>

