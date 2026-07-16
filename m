Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED3F305682
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 05:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784179684; cv=none; b=L5GtLkHilTTPch+vpSGvP+xOdyA9+s/UQmDAFXmO2zuLJf3O9NsmctYUneqZxvZgHQa6AWACUNNEaHf7521kdLxxj+awB2PoL4rXWTDRUrPsMhfZGNnr2rU5WkLqAk9irjAGDLyg0yosz1DN1j1uCT835RdpJRq9RiPtB7MtItU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784179684; c=relaxed/simple;
	bh=FJCOkr82uBlHtDHrHTjLZhw8Ri5FjduiBo/WDahh6Sg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IhHRS4X/VxrceovjcdTZ3Xy/HgrKT1R9CGzT/8D/5DguAtx60rhRIfseGpoK6fRMuvhWePl/Ye5f05CilSypfqmvfD3o+7+l231M3SX9uqrCXcXnPwxmyublUFSDT86CO1c25/j7aMDC1FdyVyZSI/029uFG8dkCa7WsJQGmUQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ZIr5OAkz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dWGy0I2B; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZIr5OAkz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dWGy0I2B"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G3wRW51412214
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 05:28:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R6h9FcF9DDa6d36d3YHHrMo5TXJSy+ELkvqqZiE+R+s=; b=ZIr5OAkzYCykFMPV
	zTCvT4MhJoiIPksmp7j7irsvfxejURdJbhAosPVdY/sX+wrZcWBobiPXezbcmB/J
	EZeS+xuHntUIRw5jl/tLjkXik2UnPVZgYkqLf0hDG0+Gu9LQSfwQsrciRqylxvLr
	xEP5jmmlWgL1cWSVV4eqS4Q75LFugwSvsqo9bFGSzfsM6/5jZ6fZtC4DpI9r+ooF
	xcIhyYlCQe7EmFUS2nGkJv2v0+Syqy7F3bNnv2KI6rgIU5H5XG1S+G1yQyY6zwyi
	MHjxCU2JWPB6TZIuBF6R+VrSp6ljUALCKCyzYh4r0ZEJNrqPn2kOoekA2E22yFl7
	+NW2aQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe7kac8xc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 16 Jul 2026 05:28:02 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c9d5a5b63c5so9327885a12.1
        for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 22:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784179682; x=1784784482; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R6h9FcF9DDa6d36d3YHHrMo5TXJSy+ELkvqqZiE+R+s=;
        b=dWGy0I2BOLOV3t+mh5Sab27rk7D96seozrYFqlp42BWUIR0d2i8shdB4f0t7W6LUXZ
         TMRkBYsR5plOlm6+p+U7JjNtF2B5HyCZw6RLmHz+J8o108c7VGBofKZmmTn6xOJHRuFD
         fdAGr6OdnRuuPC4QTMsxGfc4WIKNqAzst0Zt0+5Qq35PlphE8LG7MP7F1ZmU80af7zIf
         MXR07D+lGQSeLD+J6Pzo1d0c47oZ3XTbizv9PYYv+xnJnbJfzxC5WcEhgsx1hqGz5Uor
         19MEpJsuIE16yVrP5TntyzAq6aHTG6FmBe56b3e2uFF5wcXO7Rp2ahTt64oGwJtuYe4J
         wBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784179682; x=1784784482;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R6h9FcF9DDa6d36d3YHHrMo5TXJSy+ELkvqqZiE+R+s=;
        b=mIO+EO1WjQ4teyMp/ZB69e3jMo9tDHunUPknLxpOEVuOI+hZhESu11eS/3romkh8if
         kS1HN3I4TWr0GnR9+nupL5gjQdMRT5AA9BeF1ftVDiH9t7/PYboC0ana3pXgxbHN7BR/
         9kCuY/28uEqOQdsGWYUi+46jSfczhyYpI2O3t1cyJr15RP2d0WQkvmKlvpMdpfpXsYLr
         bH12Pqyy35Te+PK6PjeqbLgtxzGIk+wOIPRXGfUtY0J1b8TsQk0QuivDwi7/AqSNiYjw
         8AdyYrfEAMjOk3Qdvnta9Y8iib2qB+ZZ+1GCdq3k32AY9vP8WtURWymvqoppYKWjuRwg
         yBKA==
X-Gm-Message-State: AOJu0YzqEcQ7rWdeZsg9im0ZfLsi3Z/GHkaFVVBOsa9x+3sQGBOkzet/
	FRuUnqAu1gDaLhMoDGsARCon/XgUqCGyWuoJ4jW/JE/aOxbdAZFw4UHi+6Yu0dEHENlLs4Gm2gX
	UWEN1MNNt/ulszkUz8V5ue5U5msfSsEne4j7wIqp0OTsVbhoKuDuFWSVu4e5sblc=
X-Gm-Gg: AfdE7cl0Vvo1ay3farAw9wN5Ew+8/rt0eP0QgXeR+Zk84JL/76gHPoGRRfYejkKJYaI
	+V1NIUOBfdlnBtL/pw81dbuf/HjWxDCT4vP89FgAPiNnkTLpL3/cBSz6dhWwPAuI2zhGtvwafm6
	9uq19q3vmNlbEWbEJYxKk5/zAxoJLuK/n43P9zKcLKHIFu2GYFm1SAVg3hsAHwmli1W1P22bCYP
	BSTghQqoLFmWrGrAfiBp0tS1p45FUGSatgevXxoaakkOLz4Y7+zGpTGY5ZQ9koIarVNWWzNjPY1
	maBPO1RpTNoDllFFgklEvshkWnhaKJMxsUod4sHfpMNPUJw4/r1yCxUi1AjgUx5kmA5A/S9zy4F
	HeN/NPrNCutRzyNPV6IqHtaadD1RDAg5x9dALql6tXuYWUyihC8HC3JuthRUozpyr8Nqwm4ZN+s
	A6+l8D/3HH97g=
X-Received: by 2002:a05:6a20:93a1:b0:3c3:8f0f:b6a0 with SMTP id adf61e73a8af0-3c38f0fbae6mr1214415637.49.1784179681547;
        Wed, 15 Jul 2026 22:28:01 -0700 (PDT)
X-Received: by 2002:a05:6a20:93a1:b0:3c3:8f0f:b6a0 with SMTP id adf61e73a8af0-3c38f0fbae6mr1214388637.49.1784179681048;
        Wed, 15 Jul 2026 22:28:01 -0700 (PDT)
Received: from hu-mdalam-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3140e53349dsm7795812eec.7.2026.07.15.22.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 22:28:00 -0700 (PDT)
From: Md Sadre Alam <md.alam@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 10:57:46 +0530
Subject: [PATCH 2/3] spi: spi-qpic-snand: add quad mode support
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-quad-v1-2-636f74da17e1@qti.qualcomm.com>
References: <20260716-quad-v1-0-636f74da17e1@qti.qualcomm.com>
In-Reply-To: <20260716-quad-v1-0-636f74da17e1@qti.qualcomm.com>
To: Mark Brown <broonie@kernel.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Md Sadre Alam <mdalam@qti.qualcomm.com>,
        Md Sadre Alam <md.alam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=TMF1jVla c=1 sm=1 tr=0 ts=6a586be2 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=LCgf8a1I7HAfrTGDgyUA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: nbnCdImqQN9ZRKmG6O9pvsMVJ3eroQAq
X-Proofpoint-ORIG-GUID: nbnCdImqQN9ZRKmG6O9pvsMVJ3eroQAq
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA1MyBTYWx0ZWRfX5tNb5itTDPw/
 BdrltDHw2Qd3SAiswtRTBjFP4foT9YjYFYMwON6TR64vOAsLC+Sg1EkgOgFoAMBJ0Pkr2KznKoM
 hRfPhd4F8FrQrCxLRnbUSHW0Tkkj4yw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA1MyBTYWx0ZWRfX5jTWcEVtW53W
 7M178ef3uoNSFs8UbPIwI5yunczMvvW5Uzmgnkrfl74Eg9Ui9MgkV2q2MbiIu7TeQ0f35snskDI
 Pv3mkEREjn1Xk84H9br3uM9puO/bd5t03q9SiZNvYByir7hGdh5PfsT5c6jNLzV2tiEOXxNW01F
 PdKMMSZiOL0zwB9VusurT4/+vEI8MDpRbPh4DQ91mWvJ6jGwlpDHY9E48rJCXEMFoZZqZYTBeCr
 pnAdYeqVFT3qgd6yTD9rchns2LcqQu8Jq1m3mL+UCJeCbAViyP2Eq4h1SiNtqu/Ogtsp5XIOEIM
 iJoNcN5BostDW9PHjeMAhp5SerdOlojNwgtgCBspSMRfRMACZOAhCdo0eAgeK+dORl4oSpvvxzm
 TQ3u1tjdimUTAX6HVX7e7fwWpMTfo+K/0DZfO17poLD1mkhmaQWCKmlUQOgInn6n+RWizRdSSFm
 MEaV9VslKOVOMs/Wh2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160053

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
index b96b6d149ca5..5c077f7023f1 100644
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
@@ -991,8 +997,15 @@ static int qcom_spi_read_page_oob(struct qcom_nand_controller *snandc,
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
@@ -1008,11 +1021,13 @@ static int qcom_spi_cmd_mapping(struct qcom_nand_controller *snandc, u32 opcode,
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
 
@@ -1025,12 +1040,16 @@ static int qcom_spi_cmd_mapping(struct qcom_nand_controller *snandc, u32 opcode,
 		*cmd = SPINAND_WRITE_EN;
 		break;
 	case SPINAND_PROGRAM_EXECUTE:
-		*cmd = (PAGE_ACC | LAST_PAGE | SPI_TRANSFER_MODE_x1 |
-				SPI_WP | SPI_HOLD | OP_PROGRAM_PAGE);
+		if (snandc->qspi->quad_mode)
+			*cmd = (PAGE_ACC | LAST_PAGE | transfer_mode |
+					SPI_WP | SPI_HOLD | OP_PROGRAM_PAGE);
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
@@ -1042,6 +1061,15 @@ static int qcom_spi_cmd_mapping(struct qcom_nand_controller *snandc, u32 opcode,
 static int qcom_spi_read_page(struct qcom_nand_controller *snandc,
 			      const struct spi_mem_op *op)
 {
+	int ret;
+	u32 cmd;
+	/* Call mapping once again to update the quad mode based on
+	 * buswidth
+	 */
+	ret = qcom_spi_cmd_mapping(snandc, op, &cmd);
+	if (ret < 0)
+		return ret;
+
 	if (snandc->qspi->page_rw && snandc->qspi->raw_rw)
 		return qcom_spi_read_page_raw(snandc, op);
 
@@ -1309,11 +1337,12 @@ static int qcom_spi_write_page(struct qcom_nand_controller *snandc,
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
@@ -1325,7 +1354,7 @@ static int qcom_spi_send_cmdaddr(struct qcom_nand_controller *snandc,
 	u32 cmd;
 	int ret, opcode;
 
-	ret = qcom_spi_cmd_mapping(snandc, op->cmd.opcode, &cmd);
+	ret = qcom_spi_cmd_mapping(snandc, op, &cmd);
 	if (ret < 0)
 		return ret;
 
@@ -1430,6 +1459,22 @@ static int qcom_spi_io_op(struct qcom_nand_controller *snandc, const struct spi_
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
@@ -1470,7 +1515,8 @@ static bool qcom_spi_supports_op(struct spi_mem *mem, const struct spi_mem_op *o
 
 	return ((!op->addr.nbytes || op->addr.buswidth == 1) &&
 		(!op->dummy.nbytes || op->dummy.buswidth == 1) &&
-		(!op->data.nbytes || op->data.buswidth == 1));
+		(!op->data.nbytes || op->data.buswidth == 1 ||
+		 op->data.buswidth == 4));
 }
 
 static int qcom_spi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
@@ -1521,6 +1567,9 @@ static int qcom_spi_probe(struct platform_device *pdev)
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

