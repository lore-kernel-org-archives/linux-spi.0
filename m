Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FC753FD37
	for <linux-spi@vger.kernel.org>; Wed,  9 Sep 2026 14:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788962918; cv=none; b=c7vfDNqXVdXiac/rZXdnRgeRhviPoaN4gxkEpMcgQGqLemo37alOiBUPJWcW6w12X2URSi5DOC4hsKsonxx/nI4qk8ermFEQq/fFmUedCIxbr6KttneOp1N63EvrT72RDykdaRqIqpnZhHxvhgANroaGUiqvq5K9B7PeaqMuzKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788962918; c=relaxed/simple;
	bh=9HbugYz/pYdC/cG1I/ccf5Fqr7JLyMLydPSVYhaBuN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fJBvHtvKAcMByJn2X12lgX0H5mhs4rDvvg9SS7sKCLXDqCEm1mSMxYMM8nzYtNXVShTai3IJ7VAgPs1hQNuQFr0Y1vIdsgR1yARkaDMTKxbaqluQlXgouEuGqtTHs4Jv+Irsaq90X18JheRBAXbC9FyxC5DMYRUMGMcrUN6a3hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHIKQDc2; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHIKQDc2"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48589798dbbso4874285f8f.3
        for <linux-spi@vger.kernel.org>; Wed, 09 Sep 2026 07:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788962913; x=1789567713; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DnHKDNRI8iYm5ZtC0djEPukDxOPGWya2GFDssTDt+Pk=;
        b=CHIKQDc20DOXCag7kbTgnR4a6iJUeKK8xSByBRSJDtfE291hPocgU8NsjphQ1X76X0
         LIvo5PDrjR/qxGa0hu285ckN+7GjHtNhYT1RKaLiKxXt3Al6KrXJZ3FHGW7obpnf3FSQ
         6pRP/ej+LrwGnEnXONTx4GChqAv92vhcWjutoMxIfjpaloroe2au8yZRfG/2dHBdCfWI
         INPc/+aRLmsX28b9T0bFqWqnkvrFrXO4uzP6jJIUMlPtGHdg8od4AkMHkRoxmr577tKy
         /LxoL3CfpM6GtBULVSTPjQzajbB6B9AEoSIKZsgSqH0aMgfB6+hhVRs/SFW1CIGB1uxx
         dY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788962913; x=1789567713;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DnHKDNRI8iYm5ZtC0djEPukDxOPGWya2GFDssTDt+Pk=;
        b=FnT+y64TaRLMA/DuuVMARAe/f4sIcV0qw67Bazguq/a4M6Lj0SVhR9zxGrWqvzKmNh
         vkf2eZvLBb6eU7ViXzwKhQuVW+zaxOgXpdsdjGLewRigb8Oga2Bxu0wmIB327TywdjAH
         aJI/N6abt5v3DPN09lkiUlrfdEGj/pR97+kVlOK+cPvGAlFYWrjaAdkhQniSRz/WVGp7
         DFmnjS35mQGPvqSgAgq/RjNBCVHr9JpEn6oupEdDYueEbKZRs5cnIrrr04IlDc0QCwZc
         SWBnrChS48vA61g73kTWrWBLYm3AIOwjDyhkuLvn1IZ6Ql6P3MkeJ1AeL+03nBatQC5S
         eWwA==
X-Gm-Message-State: AFuF++lwRMXsIPi1vxoVOF4dkaJRKmJfPlP3K3aRBH+KXR0KkhgQWafe
	QKPi0Yoj/tSk5TxMg3i80/83Lk/2WRGyTlCrht00ZMvmY6DxG51daFWf
X-Gm-Gg: AYBFou0wBUg3sVcN/kutgbkeyIZFTvXwHJpnnNd8Opa+6t5m2bsQGVHUOfLB3OV4Rq5
	T6U5ckZkYmKYnJJ4+vKLHypjRQd1yyMSk8QionnFi1qQEMcW+GGG1dC8UslVokQyk30mwsisWAU
	ZTLJ+WukpBv/f5DIgrSwYOsiRwbo/YNdy1eJO3pQHGfS5pRY2nOmeXs7BPpf2VqttD6AoY6lhaj
	HeSHugTbzp9LkOtrhZSYmW9bJQ8gkYxZMK5ZVc1LzZJlSaG0INAwfBGFzTpi0Ei4qggXNM2i5Ux
	7GYZdpCz4B3sUbbAS4t6+Fu0nZyDPSg2tkprLKSfPwMcD2bV6Q0B2xwXuCxEnGM6WRXxXFgJVSe
	jPCanYdpFb7p7zPKDaNWf+vCy+irUolZyjPK3midRrKeGBCCWB883Xbn3GJDNJj4eUTZDXI+hIN
	fFnSZ1M5TQNHM81mIQWLwSV5YEaj6aSlpyckmZsQhaTiNN4XvQzQFLN5y0MP2RhvEvSfi4KF/RQ
	7fHrMqb4SNPPCfrIImybljEOi1H
X-Received: by 2002:a05:6000:4a1e:b0:482:f0dc:b4f7 with SMTP id ffacd0b85a97d-48587091b97mr39900449f8f.4.1788962913235;
        Wed, 09 Sep 2026 07:08:33 -0700 (PDT)
Received: from [192.168.0.253] (5403F394.catv.pool.telekom.hu. [84.3.243.148])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-485883927a3sm34278510f8f.11.2026.09.09.07.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 07:08:32 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Wed, 09 Sep 2026 16:08:25 +0200
Subject: [PATCH] spi: spi-qpic-snand: avoid writing QPIC_EBI2_ECC_BUF_CFG
 register
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-qpic-snand-avoid-ebi2-reg-write-v1-1-9b1b1466cc75@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3NMQ7CMAxG4atUnrFkTEEKV0EMSeOWf0mLgwpS1
 bsTdfyW9zaq5rBK924jtxUVc2k4nzoaXrFMxsjNpKI3CRL4vWDgWmLJHNcZmS1B2W3ir+NjLEG
 lv2rq0yVRqyxuI37H4fHc9z/mREapcQAAAA==
X-Change-ID: 20260909-qpic-snand-avoid-ebi2-reg-write-0920452b4b3b
To: Mark Brown <broonie@kernel.org>, 
 Md Sadre Alam <md.alam@oss.qualcomm.com>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.14.3

The description of commit bfb34eced559 ("mtd: rawnand: qcom: avoid writing
to obsolete register") says this:

  "QPIC_EBI2_ECC_BUF_CFG register got obsolete from QPIC V2.0 onwards.
  Avoid writing this register if QPIC version is V2.0 or newer."

Although the referenced commit is related to the 'qcom-nandc' driver,
however the hardware supported by the current driver is also based on
QPIC v2.0 so we should avoid writing that register here as well.

Remove the register writing code to avoid undefined behaviour.

Fixes: 7304d1909080 ("spi: spi-qpic: add driver for QCOM SPI NAND flash Interface")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
 drivers/spi/spi-qpic-snand.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 61b1f2eb19ce..05efe6313b7f 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -765,8 +765,6 @@ static int qcom_spi_read_cw_raw(struct qcom_nand_controller *snandc, u8 *data_bu
 
 	qcom_write_reg_dma(snandc, &snandc->regs->addr0, NAND_ADDR0, 2, 0);
 	qcom_write_reg_dma(snandc, &snandc->regs->cfg0, NAND_DEV0_CFG0, 3, 0);
-	qcom_write_reg_dma(snandc, &snandc->regs->ecc_buf_cfg, NAND_EBI2_ECC_BUF_CFG, 1, 0);
-
 	qcom_write_reg_dma(snandc, &snandc->regs->erased_cw_detect_cfg_clr,
 			   NAND_ERASED_CW_DETECT_CFG, 1, 0);
 	qcom_write_reg_dma(snandc, &snandc->regs->erased_cw_detect_cfg_set,
@@ -1104,8 +1102,6 @@ static void qcom_spi_config_page_write(struct qcom_nand_controller *snandc)
 {
 	qcom_write_reg_dma(snandc, &snandc->regs->addr0, NAND_ADDR0, 2, 0);
 	qcom_write_reg_dma(snandc, &snandc->regs->cfg0, NAND_DEV0_CFG0, 3, 0);
-	qcom_write_reg_dma(snandc, &snandc->regs->ecc_buf_cfg, NAND_EBI2_ECC_BUF_CFG,
-			   1, NAND_BAM_NEXT_SGL);
 }
 
 static void qcom_spi_config_cw_write(struct qcom_nand_controller *snandc)

---
base-commit: cb2ad3c020579bf51fb0d702db9cf64af9698377
change-id: 20260909-qpic-snand-avoid-ebi2-reg-write-0920452b4b3b

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>

