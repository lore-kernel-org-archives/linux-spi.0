Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821B7305682
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 05:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784179682; cv=none; b=o0LErLIuwDRZ4FMvgClbO05DaDq9cxt4+emxec2n4N+fnBPOKcRKbx1rfvZpGSn0YaQHMWs7oP4K+XKM2H/i6Bsui5vlXM6VEgG3gi5A1HKvQIoVtqL4RGrLveX1U3lKAaLnXxguUawkxajSHkg8HSFdO9LgOkdTHg0w6ixe2lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784179682; c=relaxed/simple;
	bh=3xgmuOamZaTeCWiAYgEejt1I6jdXRbo99KADyV9iZJg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cUXvw3UQXo8oN3GvGM9AW9ituKh6pxCG2eDgA7+hCIBA1Rjplt1/2Q6yqouY6gpivWliQUTD8VBX/kyBXvbvHUO6eMWSWBoAqFZqGLL3l797aYoblPPkKipmmN3xKEzVRVbNcScWOxLy3YuaQlNVGIiSQFChhcnF0IpqAZEjgjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LwMzzt29; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Vm7refIj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LwMzzt29";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vm7refIj"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G3wMdv1753938
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 05:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pm4smN8xnc3VjFF87Dikg6BlN/viVNvb3HU62LBPdjk=; b=LwMzzt29DwGaGb69
	4sSp9fh4Qi7MCpPTQ827nYdwxZxYUsGgMPn3e9pLNcsi8MVPBh5dPpQBjfWhuYhR
	VTuKwGSHW9nahu+IrzbPCwRTMjF8AoBtbBlpxAj2GdeE+om74I1CkAN7UauDDIY6
	t+cWaOy3FfORKw7oWt68hdIccwuQyGiaXXsXaZUhcSAuRNmkW49Gz8IaKgedHame
	Gsa7E8YSP4Ygh33wXCvpsMC0RtRx+gQj8UKUoDkrk9qXkv+b8o02rWyVLNtHGuyi
	Ho/lQdieQLZqqrKZleKrwzYY598hS2XWq/gQksky2kw5mHEXy/QP5U+MWr1Ze5cc
	fBzdkA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe855c3x4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 05:27:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-380b630c505so7668960a91.1
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 22:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784179679; x=1784784479; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pm4smN8xnc3VjFF87Dikg6BlN/viVNvb3HU62LBPdjk=;
        b=Vm7refIjjVRGvxNtnssy4p+FVTmoeuk8M1bOw1eoC5+D+GagvIN4Y5HlobXv8+ShEa
         F9H352YWgItNtJHHnZLQmj9Zo8DIA89KW6x4atRZcRJGzyMxfkB1EfBIM+LnMxYbxV9y
         4J8TNAZBglFieZsk+lga8qRMiH7X8elk9JDNhxYCd6TgcXTLrcQntnyuiuPH5ZardaD0
         UQux7fTGRnvQrv+pfgRKmFKaU1NYYJ+Eom/0MQ1li4pP/r2tW+05Q5q7GUxwapEjh960
         kSJaDUHJSWIQqFcE3i+erdCEukMEqLCxHs0Kd11+Cehvat0xAPQOhmDbrymzf37klMGV
         a55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784179679; x=1784784479;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pm4smN8xnc3VjFF87Dikg6BlN/viVNvb3HU62LBPdjk=;
        b=mryB5yY9bOqIrTYlu+29W6hRlZNLx8QAziSCYJTXkAi51hYz9fsfNt4ZC1Y/AYznjo
         PYSDqnVI3pz7+NmaMi08E6kqeUjBK58YuALajmV32WCXgLEU3xZ8QXhKLqxkpHjiRqoT
         XTM2xpJ5npCJOtvoaEItV+GsJK6J0oVsI0u4Fl/C3DJ5g6oiC6USavSr3wkjDCb4sosj
         +ukIkAoHjNlaBaTxXm8eugIRNxOOlZ2hJjTG5FzodUpwA1MzfxdlQft3QYKdHpI6G2ge
         eysaHhZwP1c5lrIwNaAikxXQJNbnwWRJo2x7m0kaTCo8l3fEsiVb7OuWqWFKTSAuZCfa
         EgNA==
X-Gm-Message-State: AOJu0YwNc0mpdeanjDlONCnw4RoNqRrigRKEzFNg4acGfIuiCQZwSp0f
	YWFsNmFyPl0jXiFCi5+4fIAA8sOnaZ4vf5fZFm8Ox3nX2nnMCNNYJBlx+Oa/+SwuWcSLnSY4KAm
	yqdGJhKTiKu0gmFiVnQQUmZPz0Ud/SELkHr4RSne8sjaRTqke9npN2bThkV4HKzJKsBsHWv0=
X-Gm-Gg: AfdE7ckL6xyi5wapOdmLfxBKJFfuxYpYbKyzgr6q9Hbrh7bQSo6sycW6tEITLiJixtm
	zPpCwQSQXm9Sx1pbc7x/ShlEVDC5YdWal8Aszz5h6LjlZxMduaFv1sNMgJdTbk/oEyuuakcA7MZ
	g69X21m3bmFeyXsCnn7Er9DYniV8pFohVC65z1eObyquYMARX9aWmAhpXmbEwd9Ra4kufFeldDU
	QaTqXWZKqfO0XAt2dLYrO5hi6TwoAGX845hlHSeN+em/1pOlqsI/BCkGiOFwky/u1gL68ah3NMb
	CyMsy4qoh+F6xgMfcgV3H2JVqnEIbrTyFfLs7bkqbVr3nfnpgbwShflGOP0HGDsMSXJTiL01ggP
	y+s8DnlA677QWWhBcox0PHN9EI6JXvY/v3YVCg5SUF0dH26LfAesbRNW7VLe4p3bFNbn2GVOxKN
	egwM/nmgyX6Zw=
X-Received: by 2002:a17:90b:4c46:b0:37f:bfd6:8b40 with SMTP id 98e67ed59e1d1-38e1add8ad5mr8567999a91.5.1784179678957;
        Wed, 15 Jul 2026 22:27:58 -0700 (PDT)
X-Received: by 2002:a17:90b:4c46:b0:37f:bfd6:8b40 with SMTP id 98e67ed59e1d1-38e1add8ad5mr8567964a91.5.1784179678468;
        Wed, 15 Jul 2026 22:27:58 -0700 (PDT)
Received: from hu-mdalam-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e53349dsm7795812eec.7.2026.07.15.22.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 22:27:58 -0700 (PDT)
From: Md Sadre Alam <md.alam@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 10:57:45 +0530
Subject: [PATCH 1/3] spi: spi-qpic-snand: move command mapping helper
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-quad-v1-1-636f74da17e1@qti.qualcomm.com>
References: <20260716-quad-v1-0-636f74da17e1@qti.qualcomm.com>
In-Reply-To: <20260716-quad-v1-0-636f74da17e1@qti.qualcomm.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Md Sadre Alam <md.alam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: iXa1_XuwWRRGIt2zvTHrajL8zSyTnUjt
X-Authority-Analysis: v=2.4 cv=KOlqylFo c=1 sm=1 tr=0 ts=6a586bdf cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=a1To8mgfp0J-3_lObMEA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA1MyBTYWx0ZWRfX02xZCN0I0U3I
 Eepe28acbqCiJx0XYi6krWChlNev9LumKFUWfcXKg9R7TEE22cyJxRcud9Sn+C+oELooYeCpklB
 tHbp9+j02wtkHWhbKcsgwE4t6hzibOP4QWKGfXi4TIax0hGhHvwaCIKmczbYqgBpJnvr8fUsrIn
 9bL/r/4k+JQGylWt3VWR+AjybXoBb35jGUYAPHYkogHpY92xgMdinpgl6e/Si01XGI7Dwe7baM6
 APNc8Uk9HML6gA2npIGodJglb4ei9workNgde/DxKz1bp7F0xQTibmDBouRggP6m1ug6xhVHUHD
 kdra+edIA7WuROCH8ovw6AeTyDfuLBNFAE0jy37i5AN6BbD6k7AlsdpzUH1dRBnToUCwK3Bw8aq
 6SekpB+p9x58MycJk1ZYhDeCrHqx0Ge7qDBks1DMOc35WRmI8weQW29StjC2C2nb1AyGBWLT8n2
 C3WEPm6tjNaTig2k7AA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA1MyBTYWx0ZWRfX0ZaiJp41eimh
 Qc1NGJQP/8KzxbvyXvlZNOz60+iVBznWz30M6GR/QT4SXAx5zdImWJ/3wGD/OIX7b614/1Oa1yn
 wIGBak8aNpsNpB6qaLAdA3r0W1SAsZA=
X-Proofpoint-ORIG-GUID: iXa1_XuwWRRGIt2zvTHrajL8zSyTnUjt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160053

Move qcom_spi_cmd_mapping() above qcom_spi_read_page() so it can be
used by read path changes added in a subsequent patch.

No functional change.

Signed-off-by: Md Sadre Alam <md.alam@oss.qualcomm.com>
---
 drivers/spi/spi-qpic-snand.c | 96 ++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index 6cc53586b8a8..b96b6d149ca5 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -991,6 +991,54 @@ static int qcom_spi_read_page_oob(struct qcom_nand_controller *snandc,
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
@@ -1255,54 +1303,6 @@ static int qcom_spi_program_execute(struct qcom_nand_controller *snandc,
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

