Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082797;
	b=zkdRIMgdqPXs5Wjr1v36tawxe/CqGabOB/OFZ1evfhpR0R3b17DzHbR2w11woB/YymyT
	 y28WshOqObXZ+9/AKkvAX+rR+3OzxW/whnu3ujb8+Tzx2scvUbEXOv+JQenNOdeRhvcnz
	 kjKVakkARH6GTGYFiI5dZWVWHJKxOhcB6vrAqQIIk0bfCa7u55+NhtbM07l8i782xh3hs
	 CTu3NyT+SmC0izcyq9ZChIYJo7O80orPBS9QJtolWfV2IEgPPKbitlfqzVOR5CP/RvJTm
	 jVS04li3w1CGkuCl/HX1ygfH5UAGzrJ1xSsq1Ydo+r3d2uf5HgLthy1o2e8yIhAtSoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082797;
	h=DMARC-Filter:Received:DKIM-Signature:Received:DKIM-Signature:
	 Received:Received:X-SNPS-Relay:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aTtiqGzEQGR0AAmdmFcSGau8M+nBcUoF7WkEcJQHE8U=;
	b=4r3sDwbLLUZhU8LcNDuo0W/hqD4M3xr0Qzcjp7kSbxHYC7oThwiH8eyHHNyMn2toC7E7
	 n/EKX0I5//HfBxQzcJpX98cKLaQtb2BkVNTdaJkbskaIb5v++lSyG9Es+5dkR/9soi1Ci
	 hIoKaAzV0XCvFytKSONLQ+vpkdDq61qC1NKB/8d//SaTfFS0UjODFa7N0sJnRC/C4HaRY
	 Aq8zqDS00ZnFFLphWPw+sIzJEqFL3lqoVt1RPQrlcI+i43Ucpbyg6GljdtlvJmvmO2Uik
	 /LeEAqtlmyhKO1KxQiu3YdKV7/ssywKlSXK6QWR7wpW4AtD88/NskHX55z1d+s5TUxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=synopsys.com;
	spf=pass smtp.mailfrom=synopsys.com;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=hd3VD4ss;
	dkim=pass header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=YrCrFan1;
	arc=none smtp.remote-ip=148.163.158.9
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAEB60A261D;
	Thu, 19 Nov 2026 10:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCAEB60A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=pfptdkimsnps header.b=hd3VD4ss;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=mail header.b=YrCrFan1
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AJ9QmMj2057543;
	Thu, 19 Nov 2026 02:06:32 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pfptdkimsnps; bh=aTtiqGzE
	QGR0AAmdmFcSGau8M+nBcUoF7WkEcJQHE8U=; b=hd3VD4ssg7XNF9o62PMJTCne
	lK8EdDk2JmcPvfxHJ7PSqyC/vjpJHZd05UnYkCRMSkXL+g5OuBvNUyTs7YlMzXS9
	LBBYhjguzHYZdA6ZBU1k3jfB3O7qgGINyCh4hHwuiJHhkQwPB+2Icc+RMcOx+fEw
	Zx4Guj352bkDBoOebpabCdtLL8uKuC4gaRELnF8wM4/k4bfoQV0UhkT9ud0ujirE
	pHBGES0WkipSdzrklonXiY3WOJqIjiMeRQKXsaGphNG9MFvZ0dfvvMGV4RjMB7Dt
	onVaOsVaD23UCiyPkbnS4y2pO0lWf7IrNpy2loPQ5Zu9n2NTwChPOXB8v6Neew==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 4j1ny430km-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Nov 2026 02:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1795082791; bh=mBenRHRJUnXm8YNmCXP7an5sHy+1d171rHPebd6K8/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YrCrFan1gKOlgDpGOOWzxYVfcPaKXTJyVgtnHSWV57sHoTSDM9WZk2pCQmFgO1ihP
	 5pvyLUhBR9zfJI9vhHvveiL/10yLQ0z3Fl1cKHoBsCfD9SZ2UvAIvXrE+JEm4KAvE3
	 DayklTY0cMgjutZ4l7VTppf6lYOoRbrGMCp+XFvTkEi3qVFJ/SUhEkc6SgrGylL61J
	 7sVL7lBztOEWyVjYwt1EIXoFlhl/Pb+77ROPCwmwoSlbK6nqdaobtR4/OQLdSdhfN1
	 5Ylkqj5EuEQTpk4fHBFDYKvzn5FOwbwXHniUcIl/hsxmkYtUBGM0W40ASLw32P7pHn
	 /j5sv05k8u26w==
Received: from mailhost.synopsys.com (eudc-mailhost1.synopsys.com [10.213.161.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id EECB5401DC;
	Thu, 19 Nov 2026 10:06:30 +0000 (UTC)
Received: from prakriti-VM.internal.synopsys.com (unknown [10.150.11.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mailhost.synopsys.com (Postfix) with ESMTPSA id 0DC08C17D3;
	Thu, 19 Nov 2026 10:06:26 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From: Prakriti Sharma <Prakriti.Sharma@synopsys.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Philipp Zabel <p.zabel@pengutronix.de>, linux-kernel@vger.kernel.org,
        Siddhant Kumar <Siddhant.Kumar@synopsys.com>,
        Prakriti Sharma <Prakriti.Sharma@synopsys.com>
Subject: [PATCH 3/6] spi: dw-g2: Add indirect read and write
Date: Thu, 19 Nov 2026 15:35:10 +0530
Message-Id: <20261119100513.433044-4-prakriti@synopsys.com>
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
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=PMeaavqC c=1 sm=1 tr=0 ts=6afeca28 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=zJRp6_cAMcgA:10 a=qPHU084jO2kA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tU_645BZ7FZt8VqRJtHG:22 a=jSPayVjLy6xbsuKauFBc:22 a=jIQo8A4GAAAA:8
 a=3j85gRDGZCOXlgO9E60A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA0MCBTYWx0ZWRfX2ooSalSPx8yO
 lKWkvdt5XNjIN2JVtCzyUSByhTfmpxuwuFUal2OLx/I6Ac3N3l2LjK3ODLSrWrjyy18gD7LyfFN
 P4Ow0DmsvZEpqJsXiL8nxf5MJRc+GE0xm8whFXofLHJB3HXYyirY902mgT99240YcqlyX0e9V8A
 V8ZmsQaMKf+TollzgI7mJHf2x5nefRV8a9VaHMjLBSV0etxEe1b4aJaJiTuFKsuIoGjae3UTnmV
 6J9voaR51qfm5d7Aks2VXssYy5Dxa+RSw7RgwdXGIvxv3R+2iTbQDhqNRrVYFw5d9VXHBi4V2OU
 JaH9MpreLJRL8DEWQ1cw+EpkNReIclgOC+bFBE3nrkDjFM2U+Znf5ZC9wwArL35vAab0uX+Tvw6
 7Zryy36RsaEKQW84RhWxKQEzdjYnEiL09th6UZUcFOZqJCvz1zbhD+RANrF+h818npnZriVD7GD
 R2kc89gcNClbN2Z6c4w==
X-Proofpoint-ORIG-GUID: MzHOMExRtb_NDpzHXuX0ckaAc8nPwnMx
X-Proofpoint-GUID: MzHOMExRtb_NDpzHXuX0ckaAc8nPwnMx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA0MCBTYWx0ZWRfXxbyIM0dryVAK
 bWm5DaJY2xl6VDxU/TSX7YbO6+mis8K6pg+RoKMIBZFWRKYqRg95EINCjNNKd/4nzBw9DtpCitn
 u0TQnyXIgPf6T+/9EQMy2nNNHDIH7rs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 malwarescore=0 suspectscore=0
 bulkscore=0 clxscore=1011 adultscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2611040001 definitions=main-2611190040

Add the FIFO indirect path used for spi-mem data transfers that are
not short register operations.

Reads use receive-only mode. Writes use transmit-only mode and send
the command, address, and payload as one continuous FIFO stream.

Signed-off-by: Prakriti Sharma <prakriti@synopsys.com>
Signed-off-by: Siddhant Kumar <sidkumar@synopsys.com>
---
 drivers/spi/spi-dw-g2-core.c | 242 ++++++++++++++++++++++++++++++++++-
 1 file changed, 236 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-dw-g2-core.c b/drivers/spi/spi-dw-g2-core.c
index 7b0928f67103..c640d6a19260 100644
--- a/drivers/spi/spi-dw-g2-core.c
+++ b/drivers/spi/spi-dw-g2-core.c
@@ -538,6 +538,237 @@ static int dw_spi_g2_reg_op(struct dw_spi_g2 *dws, const struct spi_mem_op *op)
  * Indirect read operations
  */
 
+/**
+ * dw_spi_g2_indirect_read_setup - Configure controller for indirect read
+ * @dws: Driver state
+ * @op: SPI memory operation
+ *
+ * Sets up TMOD=RO with enhanced SPI framing.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int dw_spi_g2_indirect_read_setup(struct dw_spi_g2 *dws,
+					 const struct spi_mem_op *op)
+{
+	u32 ctrlr0 = dw_spi_g2_build_ctrlr0(dws, DW_SPI_G2_CTRLR0_TMOD_RO,
+					    dw_spi_g2_get_frf(op));
+	u32 spictrlr0 = 0;
+	u32 dummy_cycles = 0;
+	int tt;
+
+	if (op->dummy.nbytes) {
+		if (!op->dummy.buswidth || op->dummy.buswidth > 8) {
+			dev_err(dws->dev, "Invalid dummy buswidth %u\n",
+				op->dummy.buswidth);
+			return -EINVAL;
+		}
+		dummy_cycles = (op->dummy.nbytes * 8) / op->dummy.buswidth;
+		if (dummy_cycles > DW_SPI_G2_SPI_CTRLR0_WAIT_CYCLES_MAX) {
+			dev_err(dws->dev, "Dummy cycles %u exceed maximum %u\n",
+				dummy_cycles, DW_SPI_G2_SPI_CTRLR0_WAIT_CYCLES_MAX);
+			return -EINVAL;
+		}
+	}
+
+	tt = dw_spi_g2_get_tt(op);
+	if (tt < 0) {
+		dev_err(dws->dev, "Unsupported transfer type: cmd=%u addr=%u data=%u\n",
+			op->cmd.buswidth,
+			op->addr.nbytes ? op->addr.buswidth : 0,
+			op->data.nbytes ? op->data.buswidth : 0);
+		return tt;
+	}
+
+	dw_spi_g2_controller_reset(dws);
+	dw_spi_g2_target_disable(dws, dws->cs);
+
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_CTRLR0(dws->cs), ctrlr0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_CTRLR1(dws->cs),
+			 op->data.nbytes - 1);
+
+	spictrlr0 |= FIELD_PREP(DW_SPI_G2_SPI_CTRLR0_TRANS_TYPE_MASK, tt);
+	spictrlr0 |= FIELD_PREP(DW_SPI_G2_SPI_CTRLR0_INST_L_MASK,
+				dw_spi_g2_inst_len(op->cmd.nbytes));
+	spictrlr0 |= FIELD_PREP(DW_SPI_G2_SPI_CTRLR0_ADDR_L_MASK,
+				dw_spi_g2_addr_len(op->addr.nbytes));
+	spictrlr0 |= FIELD_PREP(DW_SPI_G2_SPI_CTRLR0_WAIT_CYCLE_MASK,
+				dummy_cycles);
+
+	if (op->cmd.dtr)
+		spictrlr0 |= DW_SPI_G2_SPI_CTRLR0_INST_DDR_EN_MASK;
+	if (op->addr.dtr || op->data.dtr)
+		spictrlr0 |= DW_SPI_G2_SPI_CTRLR0_DDR_EN_MASK;
+	if (op->data.dtr)
+		spictrlr0 |= DW_SPI_G2_SPI_CTRLR0_INST_RXDS_EN_MASK;
+
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_SPI_CTRLR0(dws->cs), spictrlr0);
+
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_TXFTLR, 0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_RXFTLR,
+			 min_t(u32, (dws->fifo_len / 2) - 1,
+			       op->data.nbytes ? op->data.nbytes : 1));
+	return 0;
+}
+
+/**
+ * dw_spi_g2_indirect_read - Execute indirect read operation
+ * @dws: Driver state
+ * @op: SPI memory operation
+ *
+ * Reads data from flash using RO (receive-only) mode.
+ * Return: 0 on success, negative error code on failure
+ */
+static int dw_spi_g2_indirect_read(struct dw_spi_g2 *dws,
+				   const struct spi_mem_op *op)
+{
+	u32 tx_entries;
+	u8 dummy_buf = 0;
+	int ret;
+
+	if (!op->data.nbytes) {
+		dev_err(dws->dev, "Zero-length read not allowed\n");
+		return -EINVAL;
+	}
+
+	if (!op->data.buf.in) {
+		dev_err(dws->dev, "RX buffer is NULL\n");
+		return -EINVAL;
+	}
+
+	ret = dw_spi_g2_indirect_read_setup(dws, op);
+	if (ret)
+		return ret;
+
+	dw_spi_g2_target_enable(dws, dws->cs);
+	dw_spi_g2_enable(dws, true);
+
+	tx_entries = 0;
+
+	/* Write instruction */
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_DR0, op->cmd.opcode);
+	tx_entries++;
+
+	/* Write address as a packed 32-bit value (one FIFO entry) */
+	if (op->addr.nbytes) {
+		dw_spi_g2_writel(dws->regs, DW_SPI_G2_DR0, (u32)op->addr.val);
+		tx_entries++;
+	}
+
+	/* Assert CS - controller begins: sends TX FIFO, then receives */
+	dw_spi_g2_cs_assert(dws, dws->cs);
+
+	/* Receive data via polling */
+	ret = dw_spi_g2_xfer_fifo(dws, &dummy_buf, 0,
+				  op->data.buf.in, op->data.nbytes);
+	dw_spi_g2_transfer_end(dws);
+	dw_spi_g2_controller_reset(dws);
+
+	return ret;
+}
+
+/**
+ * Indirect write operations (Page Program)
+ * Uses TMOD=TO (Transmit-Only) mode
+ */
+
+/**
+ * dw_spi_g2_indirect_write_setup - Configure controller for indirect write
+ * @dws: Driver state
+ * @op: SPI memory operation
+ *
+ * Sets up TMOD=TO (transmit-only), standard SPI mode.
+ */
+static void dw_spi_g2_indirect_write_setup(struct dw_spi_g2 *dws,
+					   const struct spi_mem_op *op)
+{
+	u32 ctrlr0 = dw_spi_g2_build_ctrlr0(dws, DW_SPI_G2_CTRLR0_TMOD_TO,
+					    DW_SPI_G2_FRF_STANDARD);
+
+	dw_spi_g2_controller_reset(dws);
+	dw_spi_g2_target_disable(dws, dws->cs);
+
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_CTRLR0(dws->cs), ctrlr0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_CTRLR1(dws->cs), 0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_SPI_CTRLR0(dws->cs), 0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_TXFTLR, 0);
+	dw_spi_g2_writel(dws->regs, DW_SPI_G2_RXFTLR, 0);
+}
+
+/**
+ * dw_spi_g2_indirect_write - Execute indirect write operation
+ * @dws: Driver state
+ * @op: SPI memory operation
+ *
+ * Writes data to flash using TO (transmit-only) mode. The controller sends
+ * instruction, address, and data bytes as a continuous stream.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+static int dw_spi_g2_indirect_write(struct dw_spi_g2 *dws,
+				    const struct spi_mem_op *op)
+{
+	u32 tx_total = op->cmd.nbytes + op->addr.nbytes + op->data.nbytes;
+	u8 *tx_buf;
+	u32 prefill, pos;
+
+	if (!op->data.nbytes) {
+		dev_err(dws->dev, "Zero-length write not allowed\n");
+		return -EINVAL;
+	}
+
+	if (!op->data.buf.out) {
+		dev_err(dws->dev, "TX buffer is NULL\n");
+		return -EINVAL;
+	}
+
+	dw_spi_g2_indirect_write_setup(dws, op);
+
+	/* Allocate and build TX buffer: [cmd][addr][data] */
+	tx_buf = kzalloc(tx_total, GFP_KERNEL);
+	if (!tx_buf)
+		return -ENOMEM;
+
+	dw_spi_g2_fill_tx_buf(tx_buf, op, true);
+
+	/*
+	 * Split enable sequence:
+	 * Enable SSI (without CS), pre-fill TX FIFO, then assert CS.
+	 * FIFO pointers are reset while SSIENR=0, so writes before
+	 * enabling would be discarded.
+	 */
+	dw_spi_g2_target_enable(dws, dws->cs);
+	dw_spi_g2_enable(dws, true);
+
+	/* Pre-fill FIFO to capacity or total size */
+	prefill = min_t(u32, tx_total, dws->fifo_len);
+	for (pos = 0; pos < prefill; pos++)
+		dw_spi_g2_writel(dws->regs, DW_SPI_G2_DR0, tx_buf[pos]);
+
+	/* Assert CS - transfer starts */
+	dw_spi_g2_cs_assert(dws, dws->cs);
+
+	/* Refill FIFO with remaining bytes (if any) via polling */
+	if (pos < tx_total) {
+		int ret = dw_spi_g2_xfer_fifo(dws, &tx_buf[pos],
+					      tx_total - pos, NULL, 0);
+		if (ret) {
+			dw_spi_g2_transfer_end(dws);
+			dw_spi_g2_controller_reset(dws);
+			kfree(tx_buf);
+			return ret;
+		}
+	}
+
+	/* Wait for transfer completion */
+	dw_spi_g2_wait_idle(dws);
+
+	dw_spi_g2_transfer_end(dws);
+	dw_spi_g2_controller_reset(dws);
+
+	kfree(tx_buf);
+	return 0;
+}
+
 /*
  * ========================================================================
  * SPI-MEM interface
@@ -626,12 +857,11 @@ static int dw_spi_g2_exec_mem_op(struct spi_mem *mem,
 	if (dw_spi_g2_is_reg_op(op))
 		return dw_spi_g2_reg_op(dws, op);
 
-	/*
-	 * Bulk reads and writes are added by the indirect-transfer patch.
-	 * This patch handles commands and short register operations only.
-	 */
-	if (op->data.dir != SPI_MEM_NO_DATA && !dw_spi_g2_is_reg_op(op))
-		return -EOPNOTSUPP;
+	if (op->data.dir == SPI_MEM_DATA_IN)
+		return dw_spi_g2_indirect_read(dws, op);
+
+	if (op->data.dir == SPI_MEM_DATA_OUT)
+		return dw_spi_g2_indirect_write(dws, op);
 
 	return -EOPNOTSUPP;
 }
-- 
2.34.1

