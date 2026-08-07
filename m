Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367CF39A7F7
	for <linux-spi@vger.kernel.org>; Fri,  7 Aug 2026 16:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118659; cv=none; b=qGi6CLyTPJVZ4hNAs7mTIoF2l4uv5DIu5li8ljK75dm7bXpIPm1Iot+uq2zpzw3sc37/36LoFn5Wuk3mHx9qnit2TrK/CNzaUuGriJFAcHznec6F7udPL5kumpzdTiQ2j+/f/vPi2Fx2yPV5xrxLZw9NJxXNmEtqnshoS5xeCt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118659; c=relaxed/simple;
	bh=RTHMKxogHTIVdAiFZGs5J+GGbqRIMipvqbZrX801VyI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J3Lx5E01NsHTyleyWi6Mh9j6YH2oaE57osrDjH07DB7QLRcZYd6qMvV27zOK56kqYuRqRi9nZg9m7NIml3OnkqWunE+xQFNXBYWQUIkLgPmXfXgRi9sFII/Y7hHjxfsfPtRymhG/umGiFS5dUXKVwiAbEYMJgW473LjpGzmUXaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BPJkqmk5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fg76XiL1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BPJkqmk5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fg76XiL1"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677FRiSf1669684
	for <linux-spi@vger.kernel.org>; Fri, 7 Aug 2026 16:04:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	33TYFwncrN46/2iN8rzuq/WUVc3WbHSRn/5XMBLGW3E=; b=BPJkqmk5xiiSKIkk
	/ckRYGErHWsuHeXCA4oA2j5STN9JCMZAKT/9bg3MaFkVUOOfPJ9KGQoiUgMk62db
	ntA5MSPm07aWlksqvIF+lYMdBwPF/zvnMhRI0tKYZhwmYUK3ELozV7Q6W58QiN0v
	Ei0X9Xa89KLjvCjI+VgbBvpj/89LtrWOOQdnjEhyaczjnhI/vQbbDBD5kf61uKiZ
	VdpE2MvXl5B+Rn33GyKLGVMTnbNCeWtTojLdykGyiTzPW0Ud4Dk2BlG/MsFRMK54
	hde9fepDPfqOvkghY1uoyh00YDNSeWQPaZjdRhMPTUYKFOgzKjJLE3tGNPF2c0zT
	cQsppA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6gvt1u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 07 Aug 2026 16:04:16 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e11baa66eso3330628a91.2
        for <linux-spi@vger.kernel.org>; Fri, 07 Aug 2026 09:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786118656; x=1786723456; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=33TYFwncrN46/2iN8rzuq/WUVc3WbHSRn/5XMBLGW3E=;
        b=fg76XiL14PIkmKGjYK1I7wvP3yV4KzsTc1utaSCejTyz1ppZMsZ0pTvc5SJXKHd3ZW
         ihBMgkb9gtRG6xaJMgBMeIbgf1p6haChLg2VBBkPm/Fhe63b/D2X7IA4UJvTAiYDC1q9
         n0wUdiket+MVhs+C1CCoEGQDP1KIx4M0P1wJWBkNr61/uXWfGjBF2DnKg314CrbW9SdM
         H4ivsHWai9H2HTVyfAHD/QoVG04r4357++A0Gwk3NTM46urRVglB/Loj0MC8H+L/znap
         ySnKzC7L/8xFtImtD+sBx+bMQwU1SwsZhATry7LsM3wf2yuMDa/hySLF/2PiMeOlOdCo
         ShXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786118656; x=1786723456;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=33TYFwncrN46/2iN8rzuq/WUVc3WbHSRn/5XMBLGW3E=;
        b=PLPtJQMTEcirk2FKiNy2o3wjTRDfSf7htZiNg3eGQ5cKYR+Eyb93hBvNUnbMdDc4Ex
         KXUTZ3qjxg1DrjRhMu1EuarfHy/BJ15b9pPkOexLbuWeh7rXHXeK2cPXpnq+lJaB5Uhp
         Fcbp6xeSS/fD6tSytLqJgYy284LPM4AhxSZ05zAuUaWWmsZzY8M/gjALtVgmIFl6qirG
         2YhNVJ0znZAFUXpl/9gpuY5OtiU+bwJfFsadBKQ67w9IzQqGWhTVLnUCu7R2mZZ8qERU
         TGwx+c+x3EagKyodjZQ9Sg+clYvfum2rbYuW90KxFDtLHv3Q7USHguUVE9y1C0iPK9RM
         fykg==
X-Gm-Message-State: AOJu0YxfhfJSS+73FscVhCPTP0C0B8Rw/BKXPhn96uuyuQYmNYHs0HsN
	mob6DS2vlcjjnR4g161oZEH/R2ejJx1OLt644PnWSy8PVbjvXFaaK51/ZyTNblMxZOUWSqBFkq8
	oJXScaOICMQgF1/tDx2BZzup+HvYhWHRkS+LMvnL7ShiChsY2BF2QoQ+52DPEwM3oWkyitBA=
X-Gm-Gg: AR+sD1117i9cITOOewyUFubOQ5J2vW8SCKGKyFjYnxEo+rc/OwTKtsGilDV7PL2H99/
	J/dBpKZL3gEZ//xUNBLh8M8mSKWH88OsxJ8YIiUskgMaizPf5kS6Tlw3y7gTuNCsMIR3zaj+2UZ
	ryJNohVdzzRscnl8wagn/iNUKGpCfcOmom1XEZYu1fqMJqLmHNR2t5DNpKTN+td2+yk8FGBtK5x
	FOJ32rTJoxtiSZnqk+E8sIwkMCdTl/uQDMRt499bOltITo+O4c9pUll256i7fLSW+XriCWNgUst
	K9J1d6sGhsuC076Zz/zTCWMhXhDzRKsyzebSkf1fr5SQveSgwswkUHiMEjeZBkJBFpt4YNNHP7f
	Mg+11zmeXQJCDGWxZiZjDB20mQC7Re8yIcwafoR46yGZoO9wJobFIVeJQ5bB39d4bs6mljZ30Ys
	VEPPKvwZq3/oo=
X-Received: by 2002:a17:90b:2dc5:b0:38e:ad9d:1151 with SMTP id 98e67ed59e1d1-3909d79f314mr12715372a91.4.1786118655685;
        Fri, 07 Aug 2026 09:04:15 -0700 (PDT)
X-Received: by 2002:a17:90b:2dc5:b0:38e:ad9d:1151 with SMTP id 98e67ed59e1d1-3909d79f314mr12715044a91.4.1786118653692;
        Fri, 07 Aug 2026 09:04:13 -0700 (PDT)
Received: from hu-mdalam-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1410199bfd8sm8337541c88.2.2026.08.07.09.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 09:04:13 -0700 (PDT)
From: Md Sadre Alam <md.alam@oss.qualcomm.com>
Date: Fri, 07 Aug 2026 21:33:55 +0530
Subject: [PATCH v2 1/3] spi: spi-qpic-snand: move command mapping helper
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-quad-v2-1-8ec821e2f22b@oss.qualcomm.com>
References: <20260807-quad-v2-0-8ec821e2f22b@oss.qualcomm.com>
In-Reply-To: <20260807-quad-v2-0-8ec821e2f22b@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Md Sadre Alam <md.alam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=EYH4hvmC c=1 sm=1 tr=0 ts=6a760200 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=a1To8mgfp0J-3_lObMEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: 9InG7QzE94X05oe52ojJLvgu9I0CNF5H
X-Proofpoint-GUID: 9InG7QzE94X05oe52ojJLvgu9I0CNF5H
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEyNSBTYWx0ZWRfX1TIdeB37slJW
 JGIJi59IiP1SIc1Lp4SS1f7/1qdmfsN3+8qRJ5tOqKZYYCdN/ZPhDnWNao7/Wh3xEy2XHkrTjiH
 Hx42kFBGAQmTSHPl4fszKUo6wv1fho8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEyNSBTYWx0ZWRfX8KTs5hLCCtVi
 2QLNXl53d9ysc+c46HPe/zjzlln1JmDDpMJKQ/MPz+xhtlBEzOzoJJcwJMmAl8mod/jIPR5v5CJ
 2bETv/c4orDvlNeZle86e4vI9QRCfOMak5TNJy6mIMR2X2hL7FZFbwpdjSPiTlYWfl+Z+A3aRqt
 lVa9G+XKNC96d9SQbq/NUKNyqT/0Pf0shQi4i5LuIUNRjRps+I+Xs7sNrdt1STrJedW+9NkjryA
 blIhQwxS6d+5OxEkg8xKC+mGtQqjAaCALPh4t+OEjPbN1A+1KGWbvAlwb+yvIJ16YF6bt+2NiFz
 GBD6jzQjz/9yUxWqy3ktqsgmavxwclJTHwJZkqpzTX2HDZ8Mx46EUFroJAVvrX+6rUl7EC4MTGX
 k49RCo33Bv6wFWpGBkcWKXIAdNihZoD92eUkKzKwuq0qykucsJUDmrx7Wocve5OAkljGV6MBJXH
 tIfKK+mEHmEYqhHM0NQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070125

Move qcom_spi_cmd_mapping() above qcom_spi_read_page() so it can be
used by read path changes added in a subsequent patch.

No functional change.

Signed-off-by: Md Sadre Alam <md.alam@oss.qualcomm.com>
---
 drivers/spi/spi-qpic-snand.c | 96 ++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 1e2fc875cd66..db105b3fd601 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -1004,6 +1004,54 @@ static int qcom_spi_read_page_oob(struct qcom_nand_controller *snandc,
 	return qcom_spi_check_error(snandc);
 }
 
+static int qcom_spi_cmd_mapping(struct qcom_nand_controller *snandc, u32 opcode, u32 *cmd)
+{
+	switch (opcode) {
+	case SPINAND_RESET:
+		*cmd = (SPI_WP | SPI_HOLD | SPI_TRANSFER_MODE_x1 | OP_RESET_DEVICE);
+		break;
+	case SPINAND_READID:
+		*cmd = (SPI_WP | SPI_HOLD | SPI_TRANSFER_MODE_x1 | OP_FETCH_ID);
+		break;
+	case SPINAND_GET_FEATURE:
+		*cmd = (SPI_TRANSFER_MODE_x1 | SPI_WP | SPI_HOLD | ACC_FEATURE);
+		break;
+	case SPINAND_SET_FEATURE:
+		*cmd = (SPI_TRANSFER_MODE_x1 | SPI_WP | SPI_HOLD | ACC_FEATURE |
+			QPIC_SET_FEATURE);
+		break;
+	case SPINAND_READ:
+		if (snandc->qspi->raw_rw) {
+			*cmd = (PAGE_ACC | LAST_PAGE | SPI_TRANSFER_MODE_x1 |
+					SPI_WP | SPI_HOLD | OP_PAGE_READ);
+		} else {
+			*cmd = (PAGE_ACC | LAST_PAGE | SPI_TRANSFER_MODE_x1 |
+					SPI_WP | SPI_HOLD | OP_PAGE_READ_WITH_ECC);
+		}
+
+		break;
+	case SPINAND_ERASE:
+		*cmd = OP_BLOCK_ERASE | PAGE_ACC | LAST_PAGE | SPI_WP |
+			SPI_HOLD | SPI_TRANSFER_MODE_x1;
+		break;
+	case SPINAND_WRITE_EN:
+		*cmd = SPINAND_WRITE_EN;
+		break;
+	case SPINAND_PROGRAM_EXECUTE:
+		*cmd = (PAGE_ACC | LAST_PAGE | SPI_TRANSFER_MODE_x1 |
+				SPI_WP | SPI_HOLD | OP_PROGRAM_PAGE);
+		break;
+	case SPINAND_PROGRAM_LOAD:
+		*cmd = SPINAND_PROGRAM_LOAD;
+		break;
+	default:
+		dev_err(snandc->dev, "Opcode not supported: %u\n", opcode);
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int qcom_spi_read_page(struct qcom_nand_controller *snandc,
 			      const struct spi_mem_op *op)
 {
@@ -1268,54 +1316,6 @@ static int qcom_spi_program_execute(struct qcom_nand_controller *snandc,
 	return 0;
 }
 
-static int qcom_spi_cmd_mapping(struct qcom_nand_controller *snandc, u32 opcode, u32 *cmd)
-{
-	switch (opcode) {
-	case SPINAND_RESET:
-		*cmd = (SPI_WP | SPI_HOLD | SPI_TRANSFER_MODE_x1 | OP_RESET_DEVICE);
-		break;
-	case SPINAND_READID:
-		*cmd = (SPI_WP | SPI_HOLD | SPI_TRANSFER_MODE_x1 | OP_FETCH_ID);
-		break;
-	case SPINAND_GET_FEATURE:
-		*cmd = (SPI_TRANSFER_MODE_x1 | SPI_WP | SPI_HOLD | ACC_FEATURE);
-		break;
-	case SPINAND_SET_FEATURE:
-		*cmd = (SPI_TRANSFER_MODE_x1 | SPI_WP | SPI_HOLD | ACC_FEATURE |
-			QPIC_SET_FEATURE);
-		break;
-	case SPINAND_READ:
-		if (snandc->qspi->raw_rw) {
-			*cmd = (PAGE_ACC | LAST_PAGE | SPI_TRANSFER_MODE_x1 |
-					SPI_WP | SPI_HOLD | OP_PAGE_READ);
-		} else {
-			*cmd = (PAGE_ACC | LAST_PAGE | SPI_TRANSFER_MODE_x1 |
-					SPI_WP | SPI_HOLD | OP_PAGE_READ_WITH_ECC);
-		}
-
-		break;
-	case SPINAND_ERASE:
-		*cmd = OP_BLOCK_ERASE | PAGE_ACC | LAST_PAGE | SPI_WP |
-			SPI_HOLD | SPI_TRANSFER_MODE_x1;
-		break;
-	case SPINAND_WRITE_EN:
-		*cmd = SPINAND_WRITE_EN;
-		break;
-	case SPINAND_PROGRAM_EXECUTE:
-		*cmd = (PAGE_ACC | LAST_PAGE | SPI_TRANSFER_MODE_x1 |
-				SPI_WP | SPI_HOLD | OP_PROGRAM_PAGE);
-		break;
-	case SPINAND_PROGRAM_LOAD:
-		*cmd = SPINAND_PROGRAM_LOAD;
-		break;
-	default:
-		dev_err(snandc->dev, "Opcode not supported: %u\n", opcode);
-		return -EOPNOTSUPP;
-	}
-
-	return 0;
-}
-
 static int qcom_spi_write_page(struct qcom_nand_controller *snandc,
 			       const struct spi_mem_op *op)
 {

-- 
2.34.1

