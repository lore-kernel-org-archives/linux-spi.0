Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F6146C839
	for <linux-spi@vger.kernel.org>; Fri,  7 Aug 2026 16:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118663; cv=none; b=fGbd7dXXF8ox17hamThUaEM+jgWDGwWJF5kMIwGFQS1t9DW3jDYhwN11ebPEHqr5WGbo057UiyirFGArrAixs/x4CWA6+acoEMWxvamOyXIZtNWZUd4RUBsLK52nJadEi2q88SEpIjQPXLg4aNCxdUkFsWPrdWjmVecKNMbVjH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118663; c=relaxed/simple;
	bh=KG0GBl+723DVFVAiuh1ol7HTTiDBcSr4vDqc6QAUmyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PwMqykR5W+z7FN+Z5hUDoDJCoPI8hltsaxDTJ8kaPCd76xUjrLkr/Z4oHUwp6SAlzAr9IH5Dn2SdEqkocnFC2mko3B+xmPXKGuPid7Yie5Z3ycTFpBCcf5OwLp0NOfvPwvNxDAIMr1FG4hX5sLOvUXXkCTOYQf9QrjqDQzfhCAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OLD8x57f; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J3aDlxLX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OLD8x57f";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J3aDlxLX"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677FRj8j1367119
	for <linux-spi@vger.kernel.org>; Fri, 7 Aug 2026 16:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ie2/DvuvsUrPw0uPFMJ8pcmcDrW0q8iqj17oL8wO1yI=; b=OLD8x57fonEbyr8z
	0r7gQA+HmzKdpXtcQ1UF7fPLR2Zn+Q5uJE7q7v1UqoVcOnVlsL7JfEToPjERagP7
	Wgfh4HT9mpCrCScNHCocBXlsL1pAQSomy9Kk7ECPUpIeqIBfiZhPI+ST3Z69qKeN
	5XdbK7Wk0cS/J2FiMO8cb0S+hEioaETQ7xlo6Tfw8OypkMu0S9tdxJevFz1jhZco
	Agxu1RKnpsBD9W5gjZvuix7cKdQr9Dnz8Btck4Yn8p4SHih8yP1nhjrEsv/KRpGx
	fLlzUo2/hST66dJTzSiXwQQRbyk0kqBYQVWseqbqSO5+QT+VeGXx7DPaS39FhXne
	IM+xRw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwctp9gx6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 07 Aug 2026 16:04:20 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cbb467e56aaso3755047a12.1
        for <linux-spi@vger.kernel.org>; Fri, 07 Aug 2026 09:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786118659; x=1786723459; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ie2/DvuvsUrPw0uPFMJ8pcmcDrW0q8iqj17oL8wO1yI=;
        b=J3aDlxLXiFsHMpji+3OY0/aEp22qP7kWgxSceOeKDDJYUc8o6qxnNzkHEXyHAgXbJW
         pk2hc4a/zXhy9vIigQCM+Tia/RHxlEtAhc/ut3Uj19tEkwLKkRm2OfLcOqcWiK78HzTf
         QNDShoLnBIhfuyI1qe92XZGnV8498whEspolSZRH36bGDWtxFGALKQub5qpJaWaFajMJ
         Wr+WPhrPmH6JKW/7QvguSRSFNDoJHdaecq4qRV7crFCVpdSphtxGat/W7SJVYboA4kso
         FYSnLm/RtoPQwWgiNGjx7yiSMQ54NgTH9NAD4rbxmi0EaYaJgobdTxIzvDqSH+SOANRz
         LSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786118659; x=1786723459;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ie2/DvuvsUrPw0uPFMJ8pcmcDrW0q8iqj17oL8wO1yI=;
        b=AzPiDxKYSNHJ09NM5uzAb/yRjZKC0D4nFD8+MnkpKcCVAKvHSOs/M0AuMttVSoxJLW
         2iY5iaWf3UktQ1bwAajs7LoOLtcA80H01OZVYkfb8RGaX3Y+dLdhWQSn8knxsVudZ8vL
         /e08TrDSmq/I4ODP+wEPNPYNhf5fHXtXfT+nj3pPqxcxu3Nni2vy7MXMsgB84W7T3LlY
         lWk/Bo0HVgWO9k+QPVbjnHx2UQqN0FLQqWcERyDqMwp89kleKafsvDeyJAN4fWGuONDY
         64pzDB6pCo5SUtdD58E2yHT0WVuXCAJKxpQ9+kn25F1sYWiG6ZurAES3YtN9X8mAsV2I
         SfWg==
X-Gm-Message-State: AOJu0Yy3+eiQIX0zcGNwiU+KGSyTyrRGA9fAtmXq3edhHIUDx01SvCYG
	JqDuY6E3iVRQNe7I9+kH9+nniL22Mq2of3T8QZcMOPIFcg6VpD7CdttVtjH36WSzOT8SGeTDHmA
	J7ATDcx/rXVgzW1QQg4tW1H0vhazAmDZSPiJBdQh8jDPSFYU8qyvnSHa4zMf186FUStdtiH8=
X-Gm-Gg: AR+sD11BvZgF3z9POMbNMI4+r25Ry8WASBcjQk6Vm3HAWVjzicfLtLdzelVCLujyRtP
	pyOsotuPeL66xdb7abegUguHCq4jVreXfq9uwTMd/NTOFyRf9vrKVP1DUznyj7/3fK94LIpH3nq
	69vXO8SzXzc4J5aIL+nHqopIT1xrmdtl4RJiEr+012JSVtpXFjk7pTLdxD8dJ0sYgPGzV9g9GNC
	U2D+7sOcQEyzi6UL0rRX3PMUhkIteBxQpdg+HXenR2OEF3oIv8tbGLA9xUxvsLG3P2dquG1gyyZ
	lEaYPYQvyv9GllXb9Pn20m12bxOfpZVIbFnLn2Ttg6bjIiL/JqTuTe84ocqFbE+negjSn8L+TXI
	WUEKdp8LfYqUNdmmFfOX//I2mxQZNI5RPErIdMeaY2ovt940+tcOaBF2ayVoXx9smCsD+xI2W6s
	+IpJ+vJlEJIlc=
X-Received: by 2002:a05:6a21:6197:b0:3c3:7891:6523 with SMTP id adf61e73a8af0-3cb85ffd1b7mr30110068637.34.1786118659127;
        Fri, 07 Aug 2026 09:04:19 -0700 (PDT)
X-Received: by 2002:a05:6a21:6197:b0:3c3:7891:6523 with SMTP id adf61e73a8af0-3cb85ffd1b7mr30109765637.34.1786118657424;
        Fri, 07 Aug 2026 09:04:17 -0700 (PDT)
Received: from hu-mdalam-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1410199bfd8sm8337541c88.2.2026.08.07.09.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 09:04:16 -0700 (PDT)
From: Md Sadre Alam <md.alam@oss.qualcomm.com>
Date: Fri, 07 Aug 2026 21:33:56 +0530
Subject: [PATCH v2 2/3] spi: spi-qpic-snand: add quad mode support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-quad-v2-2-8ec821e2f22b@oss.qualcomm.com>
References: <20260807-quad-v2-0-8ec821e2f22b@oss.qualcomm.com>
In-Reply-To: <20260807-quad-v2-0-8ec821e2f22b@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Md Sadre Alam <md.alam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=Fp01OWrq c=1 sm=1 tr=0 ts=6a760204 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=LCgf8a1I7HAfrTGDgyUA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: dbRvpbbmqnAmBX7z8CO8Rk0WyGSfYYoC
X-Proofpoint-ORIG-GUID: dbRvpbbmqnAmBX7z8CO8Rk0WyGSfYYoC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDEyNSBTYWx0ZWRfX4k8GBYxXvkb3
 W0elcyi3KXPTCuvJZvgfFxEiomFExxaRAoVEWjfOAmCUFMleoZodOjr98cMaHGgGed4SbKd7tsM
 Eo3ilP26whWS0qlYCNkEuc49CHJa700qCKiBHPwXe8QxQx5r1Hatk3n9fY1thVOMAz/sUaCeAjN
 YmhO1TUeAbMCK+L3eFJAIXUQrqIyav2jA291EEccMt9nMK9z/Bgijs7aUs+ZO7RvzXZ6onspGTY
 U/YO6qC0r6/1vP9WxvSVxF75TSd1mrMJEkCea8iwVFybXBZ6gSNj3JUoNS9VhTr2dIcO48y1+t6
 Ru8pC1F+dcOkivEufhUtsRqlT2eYXR3eMsnBfS9QDOMfXCsneljrx3gaVRkMBofBUOTRRbpWYz6
 A5WI270rbRFKEXdlQNuplT86KW+qVdclstX5gODulflEMV44rpSL14Aau0SXRS2vs5AGRgxs66k
 0uTuIsp4RPweD0TRDBA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDEyNSBTYWx0ZWRfXxLFIL5dn5aWz
 /DYU2RCOyT/B8X0zENEbApeB1MgAPXSE6bK92/oJndAlquEZHoPa23BsczJCj33Kk0vGGW/u2vz
 jzLnokDfNy412TQGaFvxvCbg9jl4Eeg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_02,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070125

Add support for quad (x4) transfer mode in the QPIC SPI NAND driver.
The controller supports both single (x1) and quad (x4) SPI transfers,
but the driver currently operates only in x1 mode.

Track the QUAD enable state from the device configuration register
(0xB0) and switch the data transfer width accordingly. When the core
enables quad mode, use x4 transfers for read and program operations to
improve throughput.

Introduce a quad_mode flag in struct qpic_spi_nand to cache the current
device state. The flag is updated based on GET_FEATURE responses from
the configuration register.

Signed-off-by: Md Sadre Alam <md.alam@oss.qualcomm.com>
---
 drivers/spi/spi-qpic-snand.c | 67 ++++++++++++++++++++++++++++++++++++++------
 1 file changed, 58 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/spi-qpic-snand.c b/drivers/spi/spi-qpic-snand.c
index db105b3fd601..6ad2f96dde8c 100644
--- a/drivers/spi/spi-qpic-snand.c
+++ b/drivers/spi/spi-qpic-snand.c
@@ -46,14 +46,19 @@
 
 #define SPINAND_RESET			0xff
 #define SPINAND_READID			0x9f
+#define SPINAND_FEATURE_ADDR		0xb0
 #define SPINAND_GET_FEATURE		0x0f
 #define SPINAND_SET_FEATURE		0x1f
+#define SPINAND_READ_CACHE		0x0b
 #define SPINAND_READ			0x13
+#define SPINAND_READ_QUAD		0xeb
 #define SPINAND_ERASE			0xd8
 #define SPINAND_WRITE_EN		0x06
 #define SPINAND_PROGRAM_EXECUTE		0x10
 #define SPINAND_PROGRAM_LOAD		0x84
+#define SPINAND_PROGRAM_LOAD_QUAD	0x34
 
+#define QUAD_WIDTH			0x4
 #define ACC_FEATURE			0xe
 #define BAD_BLOCK_MARKER_SIZE		0x2
 #define OOB_BUF_SIZE			128
@@ -114,6 +119,7 @@ struct qpic_spi_nand {
 	bool oob_rw;
 	bool page_rw;
 	bool raw_rw;
+	bool quad_mode;
 };
 
 static void qcom_spi_set_read_loc_first(struct qcom_nand_controller *snandc,
@@ -1004,8 +1010,15 @@ static int qcom_spi_read_page_oob(struct qcom_nand_controller *snandc,
 	return qcom_spi_check_error(snandc);
 }
 
-static int qcom_spi_cmd_mapping(struct qcom_nand_controller *snandc, u32 opcode, u32 *cmd)
+static int qcom_spi_cmd_mapping(struct qcom_nand_controller *snandc,
+				const struct spi_mem_op *op, u32 *cmd)
 {
+	u32 opcode = op->cmd.opcode;
+	u32 transfer_mode = SPI_TRANSFER_MODE_x1;
+
+	if (snandc->qspi->quad_mode && op->data.buswidth == QUAD_WIDTH)
+		transfer_mode = SPI_TRANSFER_MODE_x4;
+
 	switch (opcode) {
 	case SPINAND_RESET:
 		*cmd = (SPI_WP | SPI_HOLD | SPI_TRANSFER_MODE_x1 | OP_RESET_DEVICE);
@@ -1021,11 +1034,13 @@ static int qcom_spi_cmd_mapping(struct qcom_nand_controller *snandc, u32 opcode,
 			QPIC_SET_FEATURE);
 		break;
 	case SPINAND_READ:
+	case SPINAND_READ_QUAD:
+	case SPINAND_READ_CACHE:
 		if (snandc->qspi->raw_rw) {
-			*cmd = (PAGE_ACC | LAST_PAGE | SPI_TRANSFER_MODE_x1 |
+			*cmd = (PAGE_ACC | LAST_PAGE | transfer_mode |
 					SPI_WP | SPI_HOLD | OP_PAGE_READ);
 		} else {
-			*cmd = (PAGE_ACC | LAST_PAGE | SPI_TRANSFER_MODE_x1 |
+			*cmd = (PAGE_ACC | LAST_PAGE | transfer_mode |
 					SPI_WP | SPI_HOLD | OP_PAGE_READ_WITH_ECC);
 		}
 
@@ -1038,12 +1053,15 @@ static int qcom_spi_cmd_mapping(struct qcom_nand_controller *snandc, u32 opcode,
 		*cmd = SPINAND_WRITE_EN;
 		break;
 	case SPINAND_PROGRAM_EXECUTE:
-		*cmd = (PAGE_ACC | LAST_PAGE | SPI_TRANSFER_MODE_x1 |
-				SPI_WP | SPI_HOLD | OP_PROGRAM_PAGE);
+		*cmd = (PAGE_ACC | LAST_PAGE | transfer_mode |
+			SPI_WP | SPI_HOLD | OP_PROGRAM_PAGE);
 		break;
 	case SPINAND_PROGRAM_LOAD:
 		*cmd = SPINAND_PROGRAM_LOAD;
 		break;
+	case SPINAND_PROGRAM_LOAD_QUAD:
+		*cmd = SPINAND_PROGRAM_LOAD_QUAD;
+		break;
 	default:
 		dev_err(snandc->dev, "Opcode not supported: %u\n", opcode);
 		return -EOPNOTSUPP;
@@ -1055,6 +1073,16 @@ static int qcom_spi_cmd_mapping(struct qcom_nand_controller *snandc, u32 opcode,
 static int qcom_spi_read_page(struct qcom_nand_controller *snandc,
 			      const struct spi_mem_op *op)
 {
+	int ret;
+	u32 cmd;
+
+	/* Update the cached command for the cache-read opcode and bus width. */
+	ret = qcom_spi_cmd_mapping(snandc, op, &cmd);
+	if (ret < 0)
+		return ret;
+
+	snandc->qspi->cmd = cpu_to_le32(cmd);
+
 	if (snandc->qspi->page_rw && snandc->qspi->raw_rw)
 		return qcom_spi_read_page_raw(snandc, op);
 
@@ -1322,11 +1350,12 @@ static int qcom_spi_write_page(struct qcom_nand_controller *snandc,
 	int ret;
 	u32 cmd;
 
-	ret = qcom_spi_cmd_mapping(snandc, op->cmd.opcode, &cmd);
+	ret = qcom_spi_cmd_mapping(snandc, op, &cmd);
 	if (ret < 0)
 		return ret;
 
-	if (op->cmd.opcode == SPINAND_PROGRAM_LOAD)
+	if (op->cmd.opcode == SPINAND_PROGRAM_LOAD ||
+	    op->cmd.opcode == SPINAND_PROGRAM_LOAD_QUAD)
 		snandc->qspi->data_buf = (u8 *)op->data.buf.out;
 
 	return 0;
@@ -1338,7 +1367,7 @@ static int qcom_spi_send_cmdaddr(struct qcom_nand_controller *snandc,
 	u32 cmd;
 	int ret, opcode;
 
-	ret = qcom_spi_cmd_mapping(snandc, op->cmd.opcode, &cmd);
+	ret = qcom_spi_cmd_mapping(snandc, op, &cmd);
 	if (ret < 0)
 		return ret;
 
@@ -1457,6 +1486,22 @@ static int qcom_spi_io_op(struct qcom_nand_controller *snandc, const struct spi_
 		val = le32_to_cpu(*(__le32 *)snandc->reg_read_buf);
 		val >>= 8;
 		memcpy(op->data.buf.in, &val, snandc->buf_count);
+
+		/*
+		 * Track QUAD mode state from configuration register.
+		 * When core layer reads register 0xB0 (CFG), check if
+		 * QUAD enable bit (bit 0) is set and update our state
+		 * accordingly for future READ/WRITE operations.
+		 */
+		if (op->addr.val == SPINAND_FEATURE_ADDR) {
+			bool quad_enabled = !!((u8)val & BIT(0));
+
+			if (snandc->qspi->quad_mode != quad_enabled) {
+				snandc->qspi->quad_mode = quad_enabled;
+				dev_info(snandc->dev, "SPI NAND QUAD mode: %s\n",
+					 quad_enabled ? "enabled" : "disabled");
+			}
+		}
 	}
 
 	return 0;
@@ -1497,7 +1542,8 @@ static bool qcom_spi_supports_op(struct spi_mem *mem, const struct spi_mem_op *o
 
 	return ((!op->addr.nbytes || op->addr.buswidth == 1) &&
 		(!op->dummy.nbytes || op->dummy.buswidth == 1) &&
-		(!op->data.nbytes || op->data.buswidth == 1));
+		(!op->data.nbytes || op->data.buswidth == 1 ||
+		 op->data.buswidth == 4));
 }
 
 static int qcom_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
@@ -1548,6 +1594,9 @@ static int qcom_spi_probe(struct platform_device *pdev)
 	if (!qspi)
 		return -ENOMEM;
 
+	/* Initialize QUAD mode state */
+	qspi->quad_mode = false;
+
 	ctlr = __devm_spi_alloc_controller(dev, sizeof(*snandc), false);
 	if (!ctlr)
 		return -ENOMEM;

-- 
2.34.1

