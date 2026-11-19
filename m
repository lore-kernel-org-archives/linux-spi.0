Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082804;
	b=mRdVq+kGK+zRDGCMTL8LCwwjWyahUHOZL9dbtCfFedKaASFlsuLayYUaMnQSK4Cp6EK5
	 Z/jdzc8rVBLZfvpFzjNG2hIxpQhllQu6d9hK81FaWIomlfqgWwyqRqhaBhzLvUckKyvKP
	 az7plWmI1x1zgzGjBJVZb+qQT5D36eGCq+d8JG8Gg2CbDUSVv4NPiP3RiAGEEfyDBE3L+
	 k6gH03DTOOOMBkaQ5xzcixYr9EM2Qo38vmhz9xlOP5x7tbIvPqQShpENtbNMcxvkGghyd
	 B4Hnllk3SUKe2SDxlynv00A+rEfUCasY52p5Cg8pGn8PPwPN83xnUF0VD5qicNqBzfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082804;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-SNPS-Relay:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Irxf5ZrU6z48pdJiHvUPN47tl5DPe2pMGpMl6QeotBk=;
	b=b0HR8ZZ+fOKYdv+mjKHasuPHKKzcuJUW2IMW/Dz6oyN2pYZUdo/2WjHup36tDMOyv91A
	 af+e1VWiCPTJgLM6G71bwPj1UlOdR/qsGBktTcMceunWxE94HXqHZau3wNY1aJLAWmv7w
	 2JV6n+Rv78RYZbQnkRHEIsSdEJgKV9GrnQ0IOJKrqBS1FoP1k230uEJ8WH9aAgS11U2gZ
	 u34CpxNcmskAvyXCDpa7o3ElIrRypdaS10u4hDRtfvp/jtKjPeE+5aNp8uyKHA3SgovKy
	 kq9jz62xTCA6v5iRT/41mTdLPx0QHGWPkBwJ6vcnfsN+QKlu8WT0ZsMWWYMtR6gWQjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=synopsys.com;
	spf=pass smtp.mailfrom=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=Oqon1Ye2;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=IHTxel7k;
	arc=none smtp.remote-ip=148.163.158.9
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22424606A332;
	Thu, 19 Nov 2026 10:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22424606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=Oqon1Ye2;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=IHTxel7k
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ9Qpow2057691;
	Thu, 19 Nov 2026 02:06:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfptdkimsnps;
	 bh=Irxf5ZrU6z48pdJiHvUPN47tl5DPe2pMGpMl6QeotBk=; b=Oqon1Ye2EcKa
	V5r7mxJ7yDix1JlLdPYmpizINlJgWx+uGvjbdI/Kj/yvYa9EsCgH1cEXfVUjkxMk
	4lxtcDk1PBM2czjahxMF4TZ1fp8oGnpSpJh7SY1/n6DaO/Z/1fHPtT/o7hnxVo0K
	8dOdXiRcvhjlVGu7WNWbkqsTg+RYZQ0Q9E43/v0E2XBPKtv13wn8RHZey6tMa6jk
	rff6sKl/4mJmNBgNb4mePL4PryL21hyXkX1a4fQVikgVzfRBmLQss/IvbXhY2K60
	UroDTnIKfU1cZSRENQBvjlFcAItsJV5360PiBy48wt5OIV0uEintoxbNSjB7Lw9f
	OZ2dHzIsWw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4j1ny430m3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 02:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1795082796; bh=l6/ITx5NGdX5TCjCcTwzbGuTYQ65TrEC+hIQ4gWDo3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IHTxel7kiuR2i2MfWBuG01YsalhVzk4qN3ldKDEs4oUo8btZPOvaikn6sX3eRkgir
	 +MdWeEfPlpS+lG26p/zwTib8EugVYGt+K3T3KbvZ2JEJ/IddmDwOZ/LYcqJFiUWvb+
	 J9U4sAu4l5XfvsZG3KppkegHUOtmAPvQsjAyeFNVdVQC5pR+VJcG79sh5GRWTM8dbe
	 NLGIv5q6/ziYQBQYPiTkA73ta9kRMulZEh67JTph1I2SEdmVUNGXMwrIQFQRTTIzet
	 /TwnBK4B3zbPwt0fP9QHR9gYMiooeEtc7R/77xigiYCr/r2/nqHdDhYm9off4riEu6
	 f+IWaWzvC+UEQ==
Received: from mailhost.synopsys.com (eudc-mailhost1.synopsys.com [10.213.161.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3E1B940517;
	Thu, 19 Nov 2026 10:06:36 +0000 (UTC)
Received: from prakriti-VM.internal.synopsys.com (unknown [10.150.11.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mailhost.synopsys.com (Postfix) with ESMTPSA id E95D7C17D3;
	Thu, 19 Nov 2026 10:06:31 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From: Prakriti Sharma <Prakriti.Sharma@synopsys.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org,
        Siddhant Kumar <Siddhant.Kumar@synopsys.com>,
        Prakriti Sharma <Prakriti.Sharma@synopsys.com>
Subject: [PATCH 4/6] spi: dw-g2: Add SPI-NAND support
Date: Thu, 19 Nov 2026 15:35:11 +0530
Message-Id: <20261119100513.433044-5-prakriti@synopsys.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261119100513.433044-1-prakriti@synopsys.com>
References: <20261119100513.433044-1-prakriti@synopsys.com>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PMeaavqC c=1 sm=1 tr=0 ts=6afeca2d cx=c_pps
 a=8EbXvwLXkpGsT4ql/pYRAw==:117 a=8EbXvwLXkpGsT4ql/pYRAw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22
 a=jIQo8A4GAAAA:8 a=FwB_d8l4rIcrMzUYsCUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0MCBTYWx0ZWRfX8hRkgKoiE44n
 oNNjDOHLzhi5d4jJo63arKLTbusjQQ06Vro5Jyi+twL00luosStLdfx2dKhLFCah6R3pHucyrhn
 DfOXmBiFgaBbAcJVbe0snUHA88kxx9fhP51pBVKkpklhT+50yTxR3lUEJMG91KOm2DdMeKtQhPV
 UgMfBcpQjwlQScFx227OItIpVYojmgGlxBzEzIcNxuwAdKjCKra1bSkI1NOLnjNwABsxSoRReLP
 HpBKMOqwJZXzk0ANa+5//5220172lycnfveSSkN7npv10na4O1rGafOJicX1SsRs+lpiPWnwcQC
 XGURp2QS3wBFUm/FGNqld6q/DDvEZ/EJUAsfOXoLD6EWkSVYvxmhtuM2l2dKSW6RdHjfM1Q6bbs
 w8gvrWzEJRQuZ9nYFp+Tv3PM19Mf/C/urSqXypgnDv91X+X2h6XDqyLfy7INEETdRFX1FQmboi1
 tE7uxSKYkUjCo98M8UA==
X-Proofpoint-ORIG-GUID: yUV2B4cMDdJmIWrr1831eJh8siVoz4K6
X-Proofpoint-GUID: yUV2B4cMDdJmIWrr1831eJh8siVoz4K6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0MCBTYWx0ZWRfX+UkMSnSYQclW
 ThWUqNqhgrNKlDDj/ez1wFpwpOSLDFEqnwy8WNb5F6yduYBh7tiUUCgkSbPMCaXx87PbtCACLuJ
 RSdzWzVnmPr+1g71EAF8NT1ai1e/Qw0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 malwarescore=0 suspectscore=0
 bulkscore=0 clxscore=1011 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2611040001 definitions=main-2611190040

Handle SPI-NAND flash in the same spi-mem path as SPI-NOR.

NAND uses a 2-byte address and program-load writes land in the page
buffer, so short operations such as JEDEC ID and status reads take
the register path. A short delay after chip-select assertion, plus
barriers around that write, keeps the ID read ordered on this
integration.

Tested with a Winbond W25N01JW SPI-NAND flash.

Signed-off-by: Prakriti Sharma <prakriti@synopsys.com>
Signed-off-by: Siddhant Kumar <sidkumar@synopsys.com>
---
 drivers/spi/spi-dw-g2-core.c | 370 +++++++++++++++++++++++++----------
 drivers/spi/spi-dw-g2.h      |  20 +-
 2 files changed, 277 insertions(+), 113 deletions(-)

diff --git a/drivers/spi/spi-dw-g2-core.c b/drivers/spi/spi-dw-g2-core.c
index c640d6a19260..a94d4a7870df 100644
--- a/drivers/spi/spi-dw-g2-core.c
+++ b/drivers/spi/spi-dw-g2-core.c
@@ -262,9 +262,13 @@ static u32 dw_spi_g2_get_frf(const struct spi_mem_op *op)
  * dw_spi_g2_get_tt - Determine transfer type from operation bus widths
  * @op: SPI memory operation
  *
- * The transfer type (TT) field in SPI_CTRLR0 defines which phases use
- * multi-line mode. TT0 = standard (1-1-1), TT1 = data multi-line (1-1-x),
- * TT2 = addr+data multi-line (1-x-x). TT3 (x-x-x) is not supported.
+ * TRANS_TYPE in SPI_CTRLR0 / XIP_CTRL controls only the instruction and
+ * address phases.  Data always uses the enhanced mode set by SPI_FRF in
+ * CTRLR0 (or FRF in XIP_CTRL).
+ *
+ *   TT0 (0x0): instruction standard, address standard  (1-1-x)
+ *   TT1 (0x1): instruction standard, address enhanced  (1-x-x)
+ *   TT2 (0x2): instruction enhanced, address enhanced  (x-x-x)
  *
  * Return: Transfer type value (0-2), or -EOPNOTSUPP for unsupported patterns
  */
@@ -272,29 +276,37 @@ static int dw_spi_g2_get_tt(const struct spi_mem_op *op)
 {
 	bool cmd_m = (op->cmd.buswidth > 1);
 	bool addr_m = (op->addr.nbytes && op->addr.buswidth > 1);
-	bool data_m = (op->data.nbytes && op->data.buswidth > 1);
 
-	if (!cmd_m && !addr_m && !data_m)
-		return DW_SPI_G2_TRANS_TYPE_TT0;	/* 1-1-1 */
-	if (!cmd_m && !addr_m && data_m)
-		return DW_SPI_G2_TRANS_TYPE_TT1;	/* 1-1-x */
-	if (!cmd_m && addr_m && data_m)
-		return DW_SPI_G2_TRANS_TYPE_TT2;	/* 1-x-x */
+	if (!cmd_m && !addr_m)
+		return DW_SPI_G2_TRANS_TYPE_TT0;	/* 1-1-x */
+	if (!cmd_m && addr_m)
+		return DW_SPI_G2_TRANS_TYPE_TT1;	/* 1-x-x */
+	if (cmd_m && addr_m)
+		return DW_SPI_G2_TRANS_TYPE_TT2;	/* x-x-x */
 
 	return -EOPNOTSUPP;
 }
 
 /**
- * dw_spi_g2_is_reg_op - Check if operation is a register read/write
+ * dw_spi_g2_is_reg_op - Check if operation fits in TR (transmit-receive) mode
+ * @dws: Driver state (provides runtime fifo_len)
  * @op: SPI memory operation
  *
- * Register operations are single-byte commands with no address (e.g.,
- * RDSR, WRSR, RDID). Data must fit within the fixed-size stack buffer.
+ * Routes operations through TR mode when total transfer size (cmd + addr +
+ * dummy + data) fits within the FIFO. This avoids RO mode with SPI_CTRLR0
+ * (enhanced SPI framing) which some platforms don't fully support.
+ *
+ * Limit is min(fifo_len, compile-time buffer size) to stay within both
+ * the hardware FIFO and the stack-allocated buffers in reg_op().
  */
-static inline bool dw_spi_g2_is_reg_op(const struct spi_mem_op *op)
+static inline bool dw_spi_g2_is_reg_op(struct dw_spi_g2 *dws,
+				       const struct spi_mem_op *op)
 {
-	return !op->addr.nbytes && op->data.nbytes > 0 &&
-	       op->data.nbytes <= DW_SPI_G2_REG_OP_MAX_DATA;
+	u32 total = op->cmd.nbytes + op->addr.nbytes +
+		    op->dummy.nbytes + op->data.nbytes;
+	u32 limit = min_t(u32, dws->fifo_len, DW_SPI_G2_REG_OP_BUF_SIZE);
+
+	return op->data.nbytes > 0 && total <= limit;
 }
 
 /**
@@ -483,49 +495,132 @@ static void dw_spi_g2_reg_op_setup(struct dw_spi_g2 *dws,
 
 static int dw_spi_g2_reg_op(struct dw_spi_g2 *dws, const struct spi_mem_op *op)
 {
-	u8 tx_buf[DW_SPI_G2_REG_OP_MAX_DATA + 1];
-	u32 tx_len;
-	int ret;
-
-	/* Validate data length fits in stack buffer */
-	if (op->data.nbytes > DW_SPI_G2_REG_OP_MAX_DATA) {
-		dev_err(dws->dev, "reg_op data length %u exceeds max %u\n",
-			op->data.nbytes, DW_SPI_G2_REG_OP_MAX_DATA);
+	u8 tx_buf[DW_SPI_G2_REG_OP_BUF_SIZE];
+	u32 tx_len = 0;
+	u32 echo_bytes;
+	int ret = 0;
+	u32 i;
+
+	if (op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes +
+	    op->data.nbytes > sizeof(tx_buf)) {
+		dev_err(dws->dev, "reg_op transfer too large: cmd=%u addr=%u dummy=%u data=%u\n",
+			op->cmd.nbytes, op->addr.nbytes, op->dummy.nbytes,
+			op->data.nbytes);
 		return -EINVAL;
 	}
 
+	dev_dbg(dws->dev, "reg_op: cmd=0x%02x dir=%d data_len=%u\n",
+		op->cmd.opcode, op->data.dir, op->data.nbytes);
+
 	dw_spi_g2_reg_op_setup(dws, op);
 
-	dw_spi_g2_transfer_begin(dws);
+	/* Build complete TX buffer: [cmd] [addr] [dummy] [data/zeros] */
+	tx_buf[tx_len++] = op->cmd.opcode;
+
+	for (i = op->addr.nbytes; i > 0; i--)
+		tx_buf[tx_len++] = (op->addr.val >> ((i - 1) * 8)) & 0xFF;
 
 	if (op->data.dir == SPI_MEM_DATA_OUT) {
 		if (!op->data.buf.out) {
 			dev_err(dws->dev, "TX buffer is NULL\n");
 			return -EINVAL;
 		}
-		/* TX: [opcode] [data bytes] */
-		tx_buf[0] = op->cmd.opcode;
-		memcpy(&tx_buf[1], op->data.buf.out, op->data.nbytes);
-		tx_len = 1 + op->data.nbytes;
-		ret = dw_spi_g2_xfer_fifo(dws, tx_buf, tx_len, NULL, 0);
+		memcpy(&tx_buf[tx_len], op->data.buf.out, op->data.nbytes);
+		tx_len += op->data.nbytes;
 	} else {
 		if (!op->data.buf.in) {
 			dev_err(dws->dev, "RX buffer is NULL\n");
 			return -EINVAL;
 		}
-		/*
-		 * TR mode: each TX byte produces one RX byte.
-		 * Push opcode + nbytes dummy 0x00s, receive 1+nbytes,
-		 * discard first RX byte (echo of opcode phase).
-		 */
-		u8 rx_tmp[DW_SPI_G2_REG_OP_MAX_DATA + 1];
-
-		tx_buf[0] = op->cmd.opcode;
-		memset(&tx_buf[1], 0x00, op->data.nbytes);
-		tx_len = 1 + op->data.nbytes;
-		ret = dw_spi_g2_xfer_fifo(dws, tx_buf, tx_len, rx_tmp, tx_len);
-		if (!ret)
-			memcpy(op->data.buf.in, &rx_tmp[1], op->data.nbytes);
+		if (op->dummy.nbytes) {
+			memset(&tx_buf[tx_len], 0x00, op->dummy.nbytes);
+			tx_len += op->dummy.nbytes;
+		}
+		memset(&tx_buf[tx_len], 0x00, op->data.nbytes);
+		tx_len += op->data.nbytes;
+	}
+
+	echo_bytes = 1 + op->addr.nbytes + op->dummy.nbytes;
+
+	dev_dbg(dws->dev, "reg_op: tx_len=%u echo=%u\n", tx_len, echo_bytes);
+
+	dw_spi_g2_target_enable(dws, dws->cs);
+	dw_spi_g2_enable(dws, true);
+
+	/*
+	 * Write TX data to FIFO with TFNF polling.
+	 * Although tx_len is limited by dw_spi_g2_is_reg_op() to fifo_len,
+	 * we still poll TFNF for safety and to handle any hardware quirks.
+	 */
+	for (i = 0; i < tx_len; i++) {
+		u32 timeout = DW_SPI_G2_TIMEOUT_US;
+
+		/* Wait for TX FIFO to have space */
+		while (!(dw_spi_g2_readl(dws->regs, DW_SPI_G2_SR) & DW_SPI_G2_SR_TFNF)) {
+			if (--timeout == 0) {
+				dev_err(dws->dev, "reg_op: TX FIFO full timeout\n");
+				dw_spi_g2_transfer_end(dws);
+				dw_spi_g2_controller_reset(dws);
+				return -ETIMEDOUT;
+			}
+			udelay(1);
+		}
+
+		dw_spi_g2_writel(dws->regs, DW_SPI_G2_DR0, tx_buf[i]);
+	}
+
+	/* Ensure all FIFO writes complete before CS assertion */
+	wmb();
+
+	dw_spi_g2_cs_assert(dws, dws->cs);
+
+	/*
+	 * CS settling delay for NAND flash:
+	 *
+	 * NAND flash requires a settling period after CS assertion before
+	 * data transactions can begin reliably. This is a hardware timing requirement.
+	 *
+	 * This is specific to NAND flash behavior where CS-to-valid-data timing
+	 * is more stringent than NOR flash. The delay applies to small
+	 * register operations (reg_op path) which are commonly used for:
+	 * - READID (0x9F)
+	 * - GET_FEATURE (0x0F)
+	 * - SET_FEATURE (0x1F)
+	 * - READ_STATUS (0x0F with feature address)
+	 *
+	 * Note: Only applies to NAND (detected via DT "spi-nand" compatible)
+	 * to avoid performance impact on NOR flash.
+	 */
+	if (dws->is_nand) {
+		/* Force a register read to ensure CS assertion propagates */
+		(void)dw_spi_g2_readl(dws->regs, DW_SPI_G2_SR);
+		usleep_range(10, 20);
+	}
+
+	dw_spi_g2_wait_idle(dws);
+
+	/* For TR mode reads, harvest RX FIFO after the burst completes */
+	if (op->data.dir == SPI_MEM_DATA_IN) {
+		u32 rxflr = dw_spi_g2_readl(dws->regs, DW_SPI_G2_RXFLR);
+		u32 rx_got = min_t(u32, rxflr, tx_len);
+
+		/* Ensure RXFLR read completes before reading RX FIFO */
+		rmb();
+
+		for (i = 0; i < rx_got; i++) {
+			u8 val = dw_spi_g2_readl(dws->regs,
+						 DW_SPI_G2_DR0) & 0xFF;
+			if (i >= echo_bytes &&
+			    (i - echo_bytes) < op->data.nbytes)
+				((u8 *)op->data.buf.in)[i - echo_bytes] = val;
+		}
+
+		if (rx_got < echo_bytes + op->data.nbytes) {
+			dev_err(dws->dev,
+				"reg_op RX short: got %u, need %u\n",
+				rx_got, echo_bytes + op->data.nbytes);
+			ret = -EIO;
+		}
 	}
 
 	dw_spi_g2_transfer_end(dws);
@@ -615,14 +710,17 @@ static int dw_spi_g2_indirect_read_setup(struct dw_spi_g2 *dws,
  * @dws: Driver state
  * @op: SPI memory operation
  *
- * Reads data from flash using RO (receive-only) mode.
+ * Reads data from flash using RO (receive-only) mode with enhanced SPI
+ * framing via SPI_CTRLR0.
  * Return: 0 on success, negative error code on failure
  */
 static int dw_spi_g2_indirect_read(struct dw_spi_g2 *dws,
 				   const struct spi_mem_op *op)
 {
-	u32 tx_entries;
+	struct spi_mem_op chunk_op;
 	u8 dummy_buf = 0;
+	u32 total, done = 0;
+	u32 tx_entries;
 	int ret;
 
 	if (!op->data.nbytes) {
@@ -635,35 +733,67 @@ static int dw_spi_g2_indirect_read(struct dw_spi_g2 *dws,
 		return -EINVAL;
 	}
 
-	ret = dw_spi_g2_indirect_read_setup(dws, op);
-	if (ret)
-		return ret;
+	total = op->data.nbytes;
+	dev_dbg(dws->dev, "indirect_read: cmd=0x%02x addr=0x%llx len=%u\n",
+		op->cmd.opcode, op->addr.val, total);
 
-	dw_spi_g2_target_enable(dws, dws->cs);
-	dw_spi_g2_enable(dws, true);
+	/*
+	 * Split into chunks no larger than dws->fifo_len so the RX FIFO
+	 * never overflows. Each iteration reprograms CTRLR1/NDF and
+	 * re-issues cmd+addr with the column advanced. A single
+	 * >fifo_len request leaves the controller idle (SR.BUSY=0,
+	 * RXFLR=0) after the first FIFO worth of data, causing an
+	 * RX timeout.
+	 */
+	chunk_op = *op;
+
+	while (done < total) {
+		u32 chunk = min_t(u32, total - done, dws->fifo_len);
+
+		chunk_op.addr.val = op->addr.val + done;
+		chunk_op.data.nbytes = chunk;
+		chunk_op.data.buf.in = (u8 *)op->data.buf.in + done;
 
-	tx_entries = 0;
+		ret = dw_spi_g2_indirect_read_setup(dws, &chunk_op);
+		if (ret)
+			return ret;
+
+		dw_spi_g2_target_enable(dws, dws->cs);
+		dw_spi_g2_enable(dws, true);
 
-	/* Write instruction */
-	dw_spi_g2_writel(dws->regs, DW_SPI_G2_DR0, op->cmd.opcode);
-	tx_entries++;
+		tx_entries = 0;
 
-	/* Write address as a packed 32-bit value (one FIFO entry) */
-	if (op->addr.nbytes) {
-		dw_spi_g2_writel(dws->regs, DW_SPI_G2_DR0, (u32)op->addr.val);
+		/* Write instruction to DR0 */
+		dw_spi_g2_writel(dws->regs, DW_SPI_G2_DR0,
+				 chunk_op.cmd.opcode);
 		tx_entries++;
-	}
 
-	/* Assert CS - controller begins: sends TX FIFO, then receives */
-	dw_spi_g2_cs_assert(dws, dws->cs);
+		/*
+		 * Write address as a single packed value.
+		 * In enhanced SPI framing (RO mode with SPI_CTRLR0), the
+		 * hardware extracts ADDR_L bits from this write.
+		 */
+		if (chunk_op.addr.nbytes) {
+			dw_spi_g2_writel(dws->regs, DW_SPI_G2_DR0,
+					 (u32)chunk_op.addr.val);
+			tx_entries++;
+		}
 
-	/* Receive data via polling */
-	ret = dw_spi_g2_xfer_fifo(dws, &dummy_buf, 0,
-				  op->data.buf.in, op->data.nbytes);
-	dw_spi_g2_transfer_end(dws);
-	dw_spi_g2_controller_reset(dws);
+		/* Assert CS - controller begins: sends TX FIFO, then receives */
+		dw_spi_g2_cs_assert(dws, dws->cs);
 
-	return ret;
+		/* Receive data via polling */
+		ret = dw_spi_g2_xfer_fifo(dws, &dummy_buf, 0,
+					  chunk_op.data.buf.in, chunk);
+		dw_spi_g2_transfer_end(dws);
+		dw_spi_g2_controller_reset(dws);
+		if (ret)
+			return ret;
+
+		done += chunk;
+	}
+
+	return 0;
 }
 
 /**
@@ -676,20 +806,26 @@ static int dw_spi_g2_indirect_read(struct dw_spi_g2 *dws,
  * @dws: Driver state
  * @op: SPI memory operation
  *
- * Sets up TMOD=TO (transmit-only), standard SPI mode.
+ * Sets up TMOD=TO (transmit-only)
  */
 static void dw_spi_g2_indirect_write_setup(struct dw_spi_g2 *dws,
 					   const struct spi_mem_op *op)
 {
 	u32 ctrlr0 = dw_spi_g2_build_ctrlr0(dws, DW_SPI_G2_CTRLR0_TMOD_TO,
 					    DW_SPI_G2_FRF_STANDARD);
+	u32 spictrlr0 = 0;
 
 	dw_spi_g2_controller_reset(dws);
 	dw_spi_g2_target_disable(dws, dws->cs);
 
+	if (op->cmd.dtr)
+		spictrlr0 |= DW_SPI_G2_SPI_CTRLR0_INST_DDR_EN_MASK;
+	if (op->addr.dtr || op->data.dtr)
+		spictrlr0 |= DW_SPI_G2_SPI_CTRLR0_DDR_EN_MASK;
+
 	dw_spi_g2_writel(dws->regs, DW_SPI_G2_CTRLR0(dws->cs), ctrlr0);
 	dw_spi_g2_writel(dws->regs, DW_SPI_G2_CTRLR1(dws->cs), 0);
-	dw_spi_g2_writel(dws->regs, DW_SPI_G2_SPI_CTRLR0(dws->cs), 0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_SPI_CTRLR0(dws->cs), spictrlr0);
 	dw_spi_g2_writel(dws->regs, DW_SPI_G2_TXFTLR, 0);
 	dw_spi_g2_writel(dws->regs, DW_SPI_G2_RXFTLR, 0);
 }
@@ -699,8 +835,12 @@ static void dw_spi_g2_indirect_write_setup(struct dw_spi_g2 *dws,
  * @dws: Driver state
  * @op: SPI memory operation
  *
- * Writes data to flash using TO (transmit-only) mode. The controller sends
- * instruction, address, and data bytes as a continuous stream.
+ * Writes data to flash using TMOD=TO (transmit-only).
+ * NOTE: CS is asserted before SSI enable for NAND compatibility in VDK.
+ * This non-standard sequence is required because:
+ * 1. Controller reset in setup clears FIFO (can't prefill while disabled)
+ * 2. Enabling SSI before CS causes 0x00 transmission from empty FIFO
+ * 3. NAND Program Load requires data immediately when CS asserts
  *
  * Return: 0 on success, negative error code on failure
  */
@@ -709,7 +849,7 @@ static int dw_spi_g2_indirect_write(struct dw_spi_g2 *dws,
 {
 	u32 tx_total = op->cmd.nbytes + op->addr.nbytes + op->data.nbytes;
 	u8 *tx_buf;
-	u32 prefill, pos;
+	int ret = 0;
 
 	if (!op->data.nbytes) {
 		dev_err(dws->dev, "Zero-length write not allowed\n");
@@ -721,52 +861,36 @@ static int dw_spi_g2_indirect_write(struct dw_spi_g2 *dws,
 		return -EINVAL;
 	}
 
+	dev_dbg(dws->dev, "indirect_write: cmd=0x%02x addr=0x%llx len=%u\n",
+		op->cmd.opcode, op->addr.val, op->data.nbytes);
+
 	dw_spi_g2_indirect_write_setup(dws, op);
 
-	/* Allocate and build TX buffer: [cmd][addr][data] */
 	tx_buf = kzalloc(tx_total, GFP_KERNEL);
 	if (!tx_buf)
 		return -ENOMEM;
 
 	dw_spi_g2_fill_tx_buf(tx_buf, op, true);
 
-	/*
-	 * Split enable sequence:
-	 * Enable SSI (without CS), pre-fill TX FIFO, then assert CS.
-	 * FIFO pointers are reset while SSIENR=0, so writes before
-	 * enabling would be discarded.
-	 */
 	dw_spi_g2_target_enable(dws, dws->cs);
-	dw_spi_g2_enable(dws, true);
-
-	/* Pre-fill FIFO to capacity or total size */
-	prefill = min_t(u32, tx_total, dws->fifo_len);
-	for (pos = 0; pos < prefill; pos++)
-		dw_spi_g2_writel(dws->regs, DW_SPI_G2_DR0, tx_buf[pos]);
-
-	/* Assert CS - transfer starts */
 	dw_spi_g2_cs_assert(dws, dws->cs);
+	dw_spi_g2_enable(dws, true);
 
-	/* Refill FIFO with remaining bytes (if any) via polling */
-	if (pos < tx_total) {
-		int ret = dw_spi_g2_xfer_fifo(dws, &tx_buf[pos],
-					      tx_total - pos, NULL, 0);
-		if (ret) {
-			dw_spi_g2_transfer_end(dws);
-			dw_spi_g2_controller_reset(dws);
-			kfree(tx_buf);
-			return ret;
-		}
+	ret = dw_spi_g2_xfer_fifo(dws, tx_buf, tx_total, NULL, 0);
+	if (ret) {
+		dev_err(dws->dev,
+			"indirect_write: xfer_fifo failed: %d\n", ret);
+		dw_spi_g2_transfer_end(dws);
+		dw_spi_g2_controller_reset(dws);
+		kfree(tx_buf);
+		return ret;
 	}
 
-	/* Wait for transfer completion */
-	dw_spi_g2_wait_idle(dws);
-
 	dw_spi_g2_transfer_end(dws);
 	dw_spi_g2_controller_reset(dws);
 
 	kfree(tx_buf);
-	return 0;
+	return ret;
 }
 
 /*
@@ -778,9 +902,46 @@ static int dw_spi_g2_indirect_write(struct dw_spi_g2 *dws,
 static bool dw_spi_g2_supports_mem_ops(struct spi_mem *mem,
 				       const struct spi_mem_op *op)
 {
+	struct spi_device *spi = mem->spi;
+	struct dw_spi_g2 *dws = spi_controller_get_devdata(spi->controller);
+	bool op_is_dtr =
+		op->cmd.dtr || op->addr.dtr || op->dummy.dtr || op->data.dtr;
+
+	/*
+	 * Detect NAND flash by checking device tree compatible string.
+	 * This is used for VDK timing workarounds.
+	 */
+	if (spi->dev.of_node) {
+		if (of_device_is_compatible(spi->dev.of_node, "spi-nand"))
+			dws->is_nand = true;
+	}
+
+	if (op_is_dtr) {
+		/*
+		 * DTR requires enhanced SPI modes (Dual/Quad/Octal).
+		 * Reject standard-width DTR since it has no practical use
+		 * and the hardware doesn't support it meaningfully.
+		 */
+		if (op->data.nbytes && op->data.buswidth == 1)
+			return false;
+
+		/*
+		 * In DTR mode all phases must agree on DTR — reject
+		 * mixed STR/DTR within a single operation.
+		 */
+		if (op->addr.nbytes && op->addr.dtr != op->cmd.dtr)
+			return false;
+		if (op->data.nbytes && op->data.dtr != op->cmd.dtr)
+			return false;
+	}
+
 	return spi_mem_default_supports_op(mem, op);
 }
 
+static const struct spi_controller_mem_caps dw_spi_g2_mem_caps = {
+	.dtr = true,
+};
+
 int dw_spi_g2_adjust_mem_op_size(struct spi_mem *mem, struct spi_mem_op *op)
 {
 	if (op->data.dir == SPI_MEM_DATA_IN)
@@ -846,15 +1007,13 @@ static int dw_spi_g2_exec_mem_op(struct spi_mem *mem,
 	dws->cs = spi_get_chipselect(spi, 0);
 	dws->curr_spi = spi;
 
-	dev_dbg(dws->dev,
-		"exec_mem_op: cmd=0x%02x addr_len=%u data_len=%u dir=%d\n",
-		op->cmd.opcode, op->addr.nbytes, op->data.nbytes,
-		op->data.dir);
+	dev_dbg(dws->dev, "exec_op: cmd=0x%02x addr=0x%llx len=%u dir=%d\n",
+		op->cmd.opcode, op->addr.val, op->data.nbytes, op->data.dir);
 
 	if (op->data.dir == SPI_MEM_NO_DATA)
 		return dw_spi_g2_cmd_only(dws, op);
 
-	if (dw_spi_g2_is_reg_op(op))
+	if (dw_spi_g2_is_reg_op(dws, op))
 		return dw_spi_g2_reg_op(dws, op);
 
 	if (op->data.dir == SPI_MEM_DATA_IN)
@@ -943,6 +1102,7 @@ int dw_spi_g2_init(struct dw_spi_g2 *dws)
 
 	ctlr->setup = dw_spi_g2_setup;
 	ctlr->mem_ops = &dw_spi_g2_mem_ops;
+	ctlr->mem_caps = &dw_spi_g2_mem_caps;
 
 	dw_spi_g2_debugfs_init(dws);
 	init_completion(&dws->mem_done);
diff --git a/drivers/spi/spi-dw-g2.h b/drivers/spi/spi-dw-g2.h
index 1106be0af7b6..3091697238d7 100644
--- a/drivers/spi/spi-dw-g2.h
+++ b/drivers/spi/spi-dw-g2.h
@@ -186,13 +186,8 @@ static inline u32 dw_spi_g2_addr_len(unsigned int addr_nbytes)
 	return addr_nbytes ? addr_nbytes * 2U : 0U;
 }
 
-/*
- * Maximum chunk size for indirect reads.
- * 64KB allows efficient large transfers while staying well within typical
- * controller limits. The FIFO (256 bytes) drains continuously during
- * the transfer via polling.
- */
-#define DW_G2_MAX_CHUNK		256U
+/* Maximum data chunk per spi_mem_op. */
+#define DW_G2_MAX_CHUNK		(64 * 1024U)
 
 /* Timeout in microseconds for polling operations */
 #define DW_SPI_G2_TIMEOUT_US	200000U
@@ -222,7 +217,13 @@ static inline u32 dw_spi_g2_addr_len(unsigned int addr_nbytes)
  *   - etc.
  * Larger transfers use indirect read/write with FIFO (up to DW_G2_MAX_CHUNK).
  */
-#define DW_SPI_G2_REG_OP_MAX_DATA	15U
+/*
+ * Maximum total transfer size (cmd + addr + dummy + data) for reg_op
+ * (TR mode). Must fit within both the TX and RX FIFOs. Each FIFO has
+ * fifo_len entries (typically 256); we use a compile-time cap here and
+ * check against the runtime fifo_len in is_reg_op().
+ */
+ #define DW_SPI_G2_REG_OP_BUF_SIZE	256U
 
 struct dw_spi_g2_cfg {
 	u8 tmode;
@@ -259,6 +260,9 @@ struct dw_spi_g2 {
 	struct completion       mem_done;
 	int                     error;
 
+	/* Flash type detection for timing workarounds */
+	bool			is_nand;
+
 #ifdef CONFIG_DEBUG_FS
 	struct dentry *debugfs;
 	struct debugfs_regset32 regset;
-- 
2.34.1

