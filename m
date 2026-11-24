Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522601;
	b=45+eieYznGzzh84Ec13am8bFcNV0zd3OraJZW9LPicoPMjSK8h7fiK/ipPZ+P5txizNH
	 fGzVNuDCLJOKvE6Xqn1mlb7UrPvGDnxvi7nUAM5RTjTJ5mOfgmVT5MdCPhWhn1EAhffg8
	 ty8LpfPeyTf0VEe9A+jD34nuS++RdnqLfztqOCgXSndv1pOjt/+D6K0ls7KGyqtm/aph1
	 p6KxHDaPIQkraxICYa4GjBWr5Rsm5PxXDAWsX9JozkkAjhALxEP7sKggcRVHEd/xxDPSU
	 m3LFJG2pHDLM718CBJ0FXhALGag7fldh4eyp6VZdYxrOXX6uXO5883XNKUcoGdzXyZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522601;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Wl/yMnsgHbcfWltNGwf12AGxgVf092YP4bXDTGy/p/A=;
	b=ovlHTYllmAcViP5iLdyo7GiexqGCs/ZZqMfv4OYhngBje5vvStZgHR/LB0XaMm+zQ1Za
	 sijVhKT1PKc+oX1ZLQ8ysCddGBBHhGe5mzGaGrIF+sJtK1KAuS03NhvjGaKBe+b6QKz7G
	 /qm+ZUEuBC8mOPE6DrC0RZQwWsbrI9CraBm1QPIdQk2UCgLUcWf49dt3Eum+IkGO/rJEQ
	 i/S+rabBDXBK9rei5ApbAVODLJYfg4enFOciAF5LhcAHEcBuWnm5uVh6jUwP4eSDl5Bom
	 mWxKb6Gmz5oAi5ve+gHH0FIJbUl1wq74d5ofipuzqbixhf3XK8ECzbh2Q8Sd2b+hVWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jzBghQON;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QkJOORi1;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1F3606A32D
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 12:16:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA1F3606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jzBghQON;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=QkJOORi1
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOCDM4Q2848917
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 12:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Wl/yMnsgHbcfWltNGwf12AGxgVf092YP4bXDTGy/p/A=; b=jzBghQONb8KQdKrc
	ra1AN3R2zjN15e87Tsqpo5j862bVg6Oa4N2T2zLvAoJ7NnIv9pBZhyZMVId2V8eW
	SDtyJFoOfqJFn2Bon3fyUnSxePMHs4WyNIAauTMReWQimEGGHZnZkOuwhjKYX6/G
	G1bHKBCl9XSBFcKZAQJwI2WtvXaoM0Ifpo3AsuFyzu+YpgpCOanQLcRtuFbSromv
	gRwYvDaTciJjI2/kcJnQXy2ZHf6FrT+HnOsvCWb6VF2xzHVwD56Sp3iZm2wW+gSN
	mCyIFPXzWoTylw/Or0rvHvjIRi2Hd4elJ4zNDOGUWx+B6LJCtjYf2YLJ1iXaUyEc
	4evEwg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5ad7r0gj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 12:16:39 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a59717b0c0so3162475b3a.3
        for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 04:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795522598; x=1796127398; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wl/yMnsgHbcfWltNGwf12AGxgVf092YP4bXDTGy/p/A=;
        b=QkJOORi1BmXvEooD3t1f/Dn48Izr3+3vXP5V331Tme8XsWQ/e3yKqzMS8UNlqb/uv5
         6dT8Gu6rYH8EqYZy/iVUC1Cdzg+7vNrmJ+BIW9tAKJFEe9hWJXWmQVVNdrrLgH4LCp97
         rufeHS24cusN4UPpA4+Y73/C+S4xwoTchGkuyWxd2b6NQPASiLFrNKitBkqmEFx3WJ88
         Lpa7MDhbWZ9qR1JpZ41Uz8zlt7CguJrXbRg9j5kgmF3a63BjCpl3znx1Et7iMaMEhdA/
         +hJbWDaklK4C/qi4ZIEyu8Zoa6kigYuvA0ydUb0Tj6zOCw5jyY1X10Qfh2BcJj35wJNj
         47Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522598; x=1796127398;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Wl/yMnsgHbcfWltNGwf12AGxgVf092YP4bXDTGy/p/A=;
        b=lE2WRcvxm0DmavQLMGyYTNNVCYJ3IRdPkBMb+eHQPx/tU9/MLuPe6R2CNE2LSQg6F2
         fM2Y+K2fCBtw3e6+Yh0yFjecl8K7fJI8BoUATwItooLZTz276Ha33lXSGFcjJEEY5ine
         gZJh8fTrtzUbmg1Y0q7lScKCoG6jWs/zomGC167cdZ7VhUha3/QpXoXGSArEtGZ87TQv
         CyyByCNvcbwyM3aWyDUd39iNY051cAoA4BE0oBJW/2oxOW3TklqAFuM8UyKRs+6R0+ZX
         oEB9Z1tmVlYHF1r3N4KgsJpTgf1IsgNYJXyFQ1CpWmuqHqD13y4VkhxSKiR3EsiooLzW
         eu8g==
X-Forwarded-Encrypted: i=1; AL+hErHqfIUCZndOiV+KhkRJbnGVTX/Xf7SXSxuw062TLPVO3qDLNAk5Bxq3OceTUA41ZU2yNOoE7bTFvUs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9bSn4nsVcjgdc8xXdUGwgdJLuea2BoVQ4yMAMS2wcaQdjBZRb6
	rPm5EU4qwCRltV6xDHE2OdE6zGj7TGRxpXWTN9/1AqEXPabBL+v7EVxinFqBlo7GenyNQMcJ+zU
	kHEMLHUG+RgoOiM5tPOkfGS8dhosAfIXXoa9dJK1kK/d9dGJWYry1qBqCLyTCqSI=
X-Gm-Gg: AZFdTZc1u5Hg+92mLxkYUA2QpUAPZ+lpl9hB/jXMw1VctPWkCSTdUH2hQxxlS774bOH
	iqKaQGWlSOxKkEzohh/Fr7P4HHtknFqd53tOwrO32DGBL7vBm602OlKVTpMDt4T40NQmKTMp9mc
	5a6EWNyKS1WtcrFApvIho+Ts5lhuxLakJl3DkFpgHll6UG4EbM7mMyio6tXdmSbF+/g7MCi3i8Z
	I7hn+GYff+hTHYstKTPQVPqP++674Evy3nUvU6EnaQSkF5FJZByBbPPYODENRWW1JCzky4J5ilq
	OvKBW8jlMUCy/NnHKufwCTyicvYEc0sFS8Fr43eQMMYWeRo5DFR0wa7P/MOR1VxfzgpyoPgW8SW
	kbV2PK21rrC7Fxuk4HQQ/fba+xVOEfcCORw4J7UOB23sTcdx4cAVqdVG3wf1AKGVGEyTeA9uxCY
	sKEF5Z2vLj
X-Received: by 2002:a05:6a00:2d06:b0:8a9:95d6:31f4 with SMTP id d2e1a72fcca58-8c87c8605d3mr12316793b3a.32.1795522598172;
        Tue, 24 Nov 2026 04:16:38 -0800 (PST)
X-Received: by 2002:a05:6a00:2d06:b0:8a9:95d6:31f4 with SMTP id d2e1a72fcca58-8c87c8605d3mr12316762b3a.32.1795522597617;
        Tue, 24 Nov 2026 04:16:37 -0800 (PST)
Received: from hu-jseerapu-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c8706844a0sm7245572b3a.1.2026.11.24.04.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:16:37 -0800 (PST)
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 17:45:27 +0530
Subject: [PATCH v2 6/6] spi: spi-geni-qcom: Add QSPI support over GPI DMA
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
Message-Id: <20261124-qspi_qup_upstream-v2-6-cd69894107c8@oss.qualcomm.com>
References: <20261124-qspi_qup_upstream-v2-0-cd69894107c8@oss.qualcomm.com>
In-Reply-To: <20261124-qspi_qup_upstream-v2-0-cd69894107c8@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795522563; l=19167;
 i=jyothi.seerapu@oss.qualcomm.com; h=from:subject:message-id;
 bh=b4O51bksvwSGRGuT8mYSlWgLtexmFNit16EZPulKYI4=;
 b=EXp5pd1zxSbUUCDNcDed+DfLIvyX4kD9C9ahKVgImpoVxXqQw51UN9Dn5KsmPXTbjOKbh+fBc
 Y2dgP+LMuY2Dm/LfGy5tsUAhR7lYVMAqQcq96gTcb3Oin9oCTHrXNxp
X-Developer-Key: i=jyothi.seerapu@oss.qualcomm.com; a=ed25519;
 pk=9vafyYsia0OnBKWSEwhmWe3hPVQfI2T1xOs5dPaFvEo=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0NyBTYWx0ZWRfXy1BeFX0DKJRF
 67fKYkJblhlwiDi+dK8v8zMpqkVmGDa8r6N6FaTesoWkx6PMMRBYB3+1pVwXvozxYk+/S0G1YYu
 nT3Syp1ayoAodE/+BuzNO9wmnXImt1w=
X-Authority-Analysis: v=2.4 cv=cI51IVeN c=1 sm=1 tr=0 ts=6b058027 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=WfK9vUvZa93p8ZDr3I4A:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0NyBTYWx0ZWRfX2Z18y5qcOLcz
 v1qrwCX1APeerIhCCbDeY1ZCgcx18GfIfW79iPwvF4ixa96dfwpG8R2zzUe66+r7SNA6tuA9a8h
 fx8vJ727jnI5lh1k/og7xW0P7/I/UxFp4n9uEtUmiYpID9cbJfECZV/tEjhwiME+BJPQ16e/ey9
 s7krW9LlYhIWRDXRcwJVemwobj9oXY4osWyCajjcFig2ey971ASYk126/i3trtCBFsd8zM7kIfR
 QvZ6j9J9EFVPW0PSKOUaT1lwQ32L5raFR006CwpSUisaVeYo52ZgjFHur43nH1VaItNYRvB2rzy
 mfXB41ZAingnN3cAUb3D/BlvkUDvAJ3N5Tkyx4ZJ+dOQI8moC8L9yl0ibfMV1L5PUfcwAr5h6Ey
 HMOTP4zO/z9EudxcFi4bDyUmQmGjgkCean8V2CqhMWtqW58MraRJC8HoZu4JkEF+7eh6/VYn12N
 oK78TW8oEbwyr/PEWGg==
X-Proofpoint-ORIG-GUID: UEDvXpSPxHJk5Oe5ISb5vT9UMwUzmy8r
X-Proofpoint-GUID: UEDvXpSPxHJk5Oe5ISb5vT9UMwUzmy8r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611240047

Add QSPI support to the GENI SPI driver using the qcom,geni-qspi
compatible. Select the QSPI firmware protocol and enable single, dual
and quad SDR transfers. QSPI operation is supported only in controller
mode and requires GPI DMA.

QSPI read transactions consist of a command/address TX phase, an optional
dummy phase and an RX data phase that must be executed as a single
hardware command. Detect and combine the corresponding SPI transfers into
one SPI_TX_RX command before submitting it to GPI DMA.

Update message accounting, DMA buffer synchronization and timeout
calculations to cover all transfers consumed by a combined QSPI command.

Wait for both TX and RX DMA completions within a shared timeout budget
before completing a combined read. This prevents the RX buffer from
being unmapped while receive DMA is still active.

Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 269 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 214 insertions(+), 55 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 631908522957..c2f14554c4a1 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -70,7 +70,6 @@
 #define SPI_TX_ONLY		1
 #define SPI_RX_ONLY		2
 #define SPI_CS_ASSERT		8
-#define SPI_CS_DEASSERT		9
 #define SPI_SCK_ONLY		10
 /* M_CMD params for SPI */
 #define SPI_PRE_CMD_DELAY	BIT(0)
@@ -84,11 +83,20 @@
 #define GSI_CPHA		BIT(4)
 #define GSI_CPOL		BIT(5)
 
+/* Raw QSPI GO mode values encoded by the GPI DMA driver into the GO TRE. */
+#define QSPI_SINGLE_SDR		0x0
+#define QSPI_SINGLE_DDR		(BIT(2) | BIT(3))
+#define QSPI_DUAL_SDR		BIT(2)
+#define QSPI_DUAL_DDR		(BIT(1) | BIT(2))
+#define QSPI_QUAD_SDR		BIT(1)
+#define QSPI_QUAD_DDR		BIT(0)
+
 struct geni_spi_desc {
 	int (*resources_init)(struct geni_se *se);
 	int (*set_rate)(struct geni_se *se, unsigned long clk_freq);
 	int (*power_on)(struct geni_se *se);
 	int (*power_off)(struct geni_se *se);
+	bool is_qspi;
 };
 
 struct spi_geni_master {
@@ -123,6 +131,7 @@ struct spi_geni_master {
 	struct dma_chan *rx;
 	int cur_xfer_mode;
 	const struct geni_spi_desc *dev_data;
+	u32 dummy_len;
 	struct notifier_block panic_nb;
 	struct gpio_desc *ready_gpio;
 };
@@ -418,27 +427,50 @@ spi_gsi_callback_result(void *cb, const struct dmaengine_result *result)
 	if (result->result != DMA_TRANS_NOERROR) {
 		dev_err(&spi->dev, "DMA txn failed: %d\n", result->result);
 		trace_geni_se_regs(&mas->se);
-		spi->cur_msg->status = -EIO;
+		WRITE_ONCE(spi->cur_msg->status, -EIO);
 	} else if (!result->residue) {
 		dev_dbg(&spi->dev, "DMA txn completed\n");
 	} else {
 		dev_err(&spi->dev, "DMA xfer has pending: %d\n", result->residue);
 		trace_geni_se_regs(&mas->se);
-		spi->cur_msg->status = -EIO;
+		WRITE_ONCE(spi->cur_msg->status, -EIO);
 	}
 
 	complete(&mas->xfer_done);
 }
 
+static u32 get_xfer_len_in_words(struct spi_transfer *xfer,
+				 struct spi_geni_master *mas);
+
+static u32 spi_geni_qspi_mode(const struct spi_transfer *xfer)
+{
+	unsigned int buswidth = xfer->rx_buf ? xfer->rx_nbits : xfer->tx_nbits;
+
+	switch (buswidth) {
+	case SPI_NBITS_DUAL:
+		return QSPI_DUAL_SDR;
+	case SPI_NBITS_QUAD:
+		return QSPI_QUAD_SDR;
+	default:
+		return QSPI_SINGLE_SDR;
+	}
+}
+
 static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas,
-			  struct spi_device *spi_slv, struct spi_controller *spi)
+			  struct spi_device *spi_slv, struct spi_controller *spi,
+			  struct spi_transfer *tx_rx_xfer)
 {
 	unsigned long flags = DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
 	struct dma_slave_config config = {};
 	struct gpi_spi_config peripheral = {};
-	struct dma_async_tx_descriptor *tx_desc, *rx_desc;
+	struct dma_async_tx_descriptor *tx_desc, *rx_desc = NULL;
+	struct spi_transfer *last = tx_rx_xfer ?: xfer;
 	int ret;
 
+	/* QSPI receives data only as part of a combined TX-then-RX command. */
+	if (mas->dev_data->is_qspi && xfer->rx_buf && !tx_rx_xfer)
+		return -EOPNOTSUPP;
+
 	config.peripheral_config = &peripheral;
 	config.peripheral_size = sizeof(peripheral);
 	peripheral.set_config = true;
@@ -449,20 +481,21 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
 		mas->cur_speed_hz = xfer->speed_hz;
 	}
 
-	if (xfer->tx_buf && xfer->rx_buf) {
+	if (mas->dev_data->is_qspi && tx_rx_xfer) {
+		/* Combine the command and data phases into one hardware command. */
+		peripheral.cmd = SPI_TX_RX;
+		peripheral.rx_len = get_xfer_len_in_words(tx_rx_xfer, mas);
+	} else if (xfer->tx_buf && xfer->rx_buf) {
 		peripheral.cmd = SPI_DUPLEX;
 	} else if (xfer->tx_buf) {
 		peripheral.cmd = SPI_TX;
 		peripheral.rx_len = 0;
 	} else if (xfer->rx_buf) {
 		peripheral.cmd = SPI_RX;
-		if (!(mas->cur_bits_per_word % MIN_WORD_LEN)) {
-			peripheral.rx_len = ((xfer->len << 3) / mas->cur_bits_per_word);
-		} else {
-			int bytes_per_word = (mas->cur_bits_per_word / BITS_PER_BYTE) + 1;
-
-			peripheral.rx_len = (xfer->len / bytes_per_word);
-		}
+		peripheral.rx_len = get_xfer_len_in_words(xfer, mas);
+	} else {
+		dev_err(mas->dev, "Invalid transfer: no tx_buf or rx_buf\n");
+		return -EINVAL;
 	}
 
 	peripheral.loopback_en = !!(spi_slv->mode & SPI_LOOP);
@@ -472,6 +505,17 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
 	peripheral.pack_en = true;
 	peripheral.word_len = xfer->bits_per_word - MIN_WORD_LEN;
 
+	/* TRE_SPI_C0_DUMMY_CYCLES in the CONFIG0 TRE is an 8-bit field */
+	if (mas->dummy_len > U8_MAX) {
+		dev_err(mas->dev, "Dummy cycles %u exceed hardware limit %u\n",
+			mas->dummy_len, (unsigned int)U8_MAX);
+		return -EINVAL;
+	}
+	peripheral.dummy_cycles = mas->dummy_len;
+
+	if (mas->dev_data->is_qspi)
+		peripheral.qspi_mode = spi_geni_qspi_mode(last);
+
 	ret = get_spi_clk_cfg(mas->cur_speed_hz, mas,
 			      &peripheral.clk_src, &peripheral.clk_div);
 	if (ret) {
@@ -480,18 +524,17 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
 	}
 
 	/*
-	 * Set fragmentation to keep CS asserted after this transfer when:
-	 *  - non-last transfer with cs_change=0: keep CS asserted between chained transfers
-	 *  - last transfer with cs_change=1: keep CS asserted after the message
-	 *    (e.g. TPM TIS SPI uses cs_change=1 on single-transfer messages to
-	 *     keep CS asserted across header, wait-state and data phases)
+	 * Set fragmentation from the last transfer consumed by this command.
+	 * Keep CS asserted between transfers when cs_change is clear, or after
+	 * the message when the final transfer sets cs_change.
 	 */
-	peripheral.fragmentation = list_is_last(&xfer->transfer_list, &spi->cur_msg->transfers) ?
-				   xfer->cs_change : !xfer->cs_change;
+	peripheral.fragmentation =
+		list_is_last(&last->transfer_list, &spi->cur_msg->transfers) ?
+		last->cs_change : !last->cs_change;
 
 	if (peripheral.cmd & SPI_RX) {
 		dmaengine_slave_config(mas->rx, &config);
-		rx_desc = dmaengine_prep_slave_sg(mas->rx, xfer->rx_sg.sgl, xfer->rx_sg.nents,
+		rx_desc = dmaengine_prep_slave_sg(mas->rx, last->rx_sg.sgl, last->rx_sg.nents,
 						  DMA_DEV_TO_MEM, flags);
 		if (!rx_desc) {
 			dev_err(mas->dev, "Err setting up rx desc\n");
@@ -508,11 +551,15 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
 					  DMA_MEM_TO_DEV, flags);
 	if (!tx_desc) {
 		dev_err(mas->dev, "Err setting up tx desc\n");
-		return -EIO;
+		ret = -EIO;
+		goto err_free_rx_desc;
 	}
 
 	dmaengine_desc_set_callback(tx_desc, NULL, spi_gsi_callback_result, spi);
 
+	if (peripheral.cmd == SPI_TX_RX)
+		dmaengine_desc_set_callback(rx_desc, NULL, spi_gsi_callback_result, spi);
+
 	if (peripheral.cmd & SPI_RX)
 		dmaengine_submit(rx_desc);
 	dmaengine_submit(tx_desc);
@@ -522,6 +569,11 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
 
 	dma_async_issue_pending(mas->tx);
 	return 0;
+
+err_free_rx_desc:
+	if (rx_desc)
+		rx_desc->desc_free(rx_desc);
+	return ret;
 }
 
 static u32 get_xfer_len_in_words(struct spi_transfer *xfer,
@@ -649,17 +701,27 @@ static int spi_geni_init(struct spi_geni_master *mas)
 	proto = geni_se_read_proto(se);
 
 	if (spi->target) {
+		if (mas->dev_data->is_qspi) {
+			dev_err(mas->dev, "QSPI is not supported in target mode\n");
+			return -EINVAL;
+		}
 		if (proto != GENI_SE_SPI_SLAVE) {
 			dev_err(mas->dev, "Invalid proto %d\n", proto);
 			return -EINVAL;
 		}
 		spi_slv_setup(mas);
 	} else if (proto == GENI_SE_INVALID_PROTO) {
-		ret = geni_load_se_firmware(se, GENI_SE_SPI);
+		ret = geni_load_se_firmware(se, mas->dev_data->is_qspi ?
+					   GENI_SE_QSPI : GENI_SE_SPI);
 		if (ret) {
 			dev_err(mas->dev, "spi master firmware load failed ret: %d\n", ret);
 			return ret;
 		}
+	} else if (mas->dev_data->is_qspi) {
+		if (proto != GENI_SE_QSPI) {
+			dev_err(mas->dev, "Invalid proto %d, expected QSPI\n", proto);
+			return -EINVAL;
+		}
 	} else if (proto != GENI_SE_SPI) {
 		dev_err(mas->dev, "Invalid proto %d\n", proto);
 		return -EINVAL;
@@ -705,6 +767,10 @@ static int spi_geni_init(struct spi_geni_master *mas)
 		fallthrough;
 
 	case 0:
+		if (mas->dev_data->is_qspi) {
+			dev_err(mas->dev, "QSPI is not supported in FIFO mode\n");
+			return -EOPNOTSUPP;
+		}
 		mas->cur_xfer_mode = GENI_SE_FIFO;
 		geni_se_select_mode(se, GENI_SE_FIFO);
 		/* setup_spi_params assumes that these registers start with a zero value */
@@ -930,7 +996,8 @@ static int setup_se_xfer(struct spi_transfer *xfer,
 
 static int spi_geni_transfer_one(struct spi_controller *spi,
 				 struct spi_device *slv,
-				 struct spi_transfer *xfer)
+				 struct spi_transfer *xfer,
+				 struct spi_transfer *rx_xfer)
 {
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 	int ret;
@@ -950,7 +1017,7 @@ static int spi_geni_transfer_one(struct spi_controller *spi,
 		return ret;
 	}
 
-	return setup_gsi_xfer(xfer, mas, slv, spi);
+	return setup_gsi_xfer(xfer, mas, slv, spi, rx_xfer);
 }
 
 static int spi_geni_setup(struct spi_device *slv)
@@ -1004,30 +1071,46 @@ static void spi_geni_set_cs(struct spi_device *spi_slv, bool enable)
 }
 
 static void spi_geni_dma_sync(struct spi_controller *spi,
-			      struct spi_transfer *xfer, bool for_device)
+			      struct spi_transfer *first,
+			      struct spi_transfer *last, bool for_device)
 {
-	/* The core maps buffers with DMA_ATTR_SKIP_CPU_SYNC. */
-	if (for_device) {
-		if (xfer->tx_sg_mapped)
-			dma_sync_sgtable_for_device(spi->cur_tx_dma_dev,
-						    &xfer->tx_sg, DMA_TO_DEVICE);
-		if (xfer->rx_sg_mapped)
-			dma_sync_sgtable_for_device(spi->cur_rx_dma_dev,
-						    &xfer->rx_sg, DMA_FROM_DEVICE);
-	} else {
-		if (xfer->rx_sg_mapped)
-			dma_sync_sgtable_for_cpu(spi->cur_rx_dma_dev,
-						 &xfer->rx_sg, DMA_FROM_DEVICE);
-		if (xfer->tx_sg_mapped)
-			dma_sync_sgtable_for_cpu(spi->cur_tx_dma_dev,
-						 &xfer->tx_sg, DMA_TO_DEVICE);
+	struct spi_transfer *xfer = first;
+
+	/*
+	 * The core maps buffers with DMA_ATTR_SKIP_CPU_SYNC. Match its per-transfer
+	 * synchronization for every mapped buffer from first through last,
+	 * including transfers consumed by a combined QSPI command.
+	 */
+	for (;;) {
+		if (for_device) {
+			if (xfer->tx_sg_mapped)
+				dma_sync_sgtable_for_device(spi->cur_tx_dma_dev,
+							    &xfer->tx_sg, DMA_TO_DEVICE);
+			if (xfer->rx_sg_mapped)
+				dma_sync_sgtable_for_device(spi->cur_rx_dma_dev,
+							    &xfer->rx_sg, DMA_FROM_DEVICE);
+		} else {
+			if (xfer->rx_sg_mapped)
+				dma_sync_sgtable_for_cpu(spi->cur_rx_dma_dev,
+							 &xfer->rx_sg, DMA_FROM_DEVICE);
+			if (xfer->tx_sg_mapped)
+				dma_sync_sgtable_for_cpu(spi->cur_tx_dma_dev,
+							 &xfer->tx_sg, DMA_TO_DEVICE);
+		}
+
+		if (xfer == last)
+			break;
+		xfer = list_next_entry(xfer, transfer_list);
 	}
 }
 
 static int spi_geni_wait_for_xfer(struct spi_controller *spi,
-				  const struct spi_transfer *xfer)
+				  const struct spi_transfer *first,
+				  const struct spi_transfer *last)
 {
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
+	unsigned int num_completions = first == last ? 1 : 2;
+	unsigned long time_left;
 	u64 bits, ms;
 
 	if (spi_controller_is_target(spi)) {
@@ -1039,14 +1122,24 @@ static int spi_geni_wait_for_xfer(struct spi_controller *spi,
 		return 0;
 	}
 
-	bits = (u64)xfer->len * BITS_PER_BYTE;
-	ms = div_u64(bits * MSEC_PER_SEC, xfer->speed_hz ?: 100000);
+	/* Use single-lane timing for all phases as an upper bound. */
+	bits = (u64)first->len * BITS_PER_BYTE;
+	if (last != first)
+		bits += (u64)last->len * BITS_PER_BYTE + mas->dummy_len;
+	ms = div_u64(bits * MSEC_PER_SEC, first->speed_hz ?: 100000);
 	ms = min_t(u64, ms * 2 + 200, UINT_MAX);
 
-	if (!wait_for_completion_timeout(&mas->xfer_done, msecs_to_jiffies(ms))) {
-		dev_err(mas->dev, "Transfer timed out\n");
-		return -ETIMEDOUT;
-	}
+	/* Wait for all expected completions before returning buffer ownership. */
+	time_left = msecs_to_jiffies(ms);
+	do {
+		time_left = wait_for_completion_timeout(&mas->xfer_done, time_left);
+		if (!time_left) {
+			dev_err(mas->dev, "Transfer timed out\n");
+			return -ETIMEDOUT;
+		}
+		if (READ_ONCE(spi->cur_msg->status) != -EINPROGRESS)
+			break;
+	} while (--num_completions);
 
 	return 0;
 }
@@ -1056,7 +1149,7 @@ static int spi_geni_transfer_one_message(struct spi_controller *spi,
 {
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 	struct spi_device *spi_slv = msg->spi;
-	struct spi_transfer *xfer, *next_xfer;
+	struct spi_transfer *xfer, *next_xfer, *last_xfer;
 	bool keep_cs = false;
 	bool dma_synced = false;
 	bool started = false;
@@ -1066,6 +1159,54 @@ static int spi_geni_transfer_one_message(struct spi_controller *spi,
 	spi_geni_set_cs(spi_slv, !xfer->cs_off);
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		mas->dummy_len = 0;
+		last_xfer = xfer;
+
+		/*
+		 * Combine a TX phase, optional dummy phase and RX phase into
+		 * one QSPI command.
+		 */
+		if (mas->dev_data->is_qspi && mas->cur_xfer_mode == GENI_GPI_DMA &&
+		    xfer->len && xfer->tx_buf && xfer->tx_buf != spi->dummy_tx &&
+		    !xfer->rx_buf && !xfer->dummy_data &&
+		    !list_is_last(&xfer->transfer_list, &msg->transfers)) {
+			next_xfer = list_next_entry(xfer, transfer_list);
+
+			if (next_xfer->dummy_data &&
+			    !list_is_last(&next_xfer->transfer_list, &msg->transfers)) {
+				/* The current client supplies the dummy length in cycles. */
+				mas->dummy_len = next_xfer->len;
+				next_xfer = list_next_entry(next_xfer, transfer_list);
+			}
+
+			/* Ignore the TX buffer inserted by SPI_CONTROLLER_MUST_TX. */
+			if (next_xfer->len && next_xfer->rx_buf && !next_xfer->dummy_data &&
+			    (!next_xfer->tx_buf || next_xfer->tx_buf == spi->dummy_tx)) {
+				last_xfer = next_xfer;
+			} else {
+				mas->dummy_len = 0;
+			}
+		}
+
+		if (last_xfer != xfer) {
+			next_xfer = xfer;
+			for (;;) {
+				/* A combined command cannot change timing or CS between phases. */
+				if (next_xfer->speed_hz != xfer->speed_hz ||
+				    next_xfer->bits_per_word != xfer->bits_per_word ||
+				    next_xfer->cs_off || next_xfer->dtr_mode ||
+				    next_xfer->word_delay.value ||
+				    (next_xfer != last_xfer &&
+				     (next_xfer->cs_change || next_xfer->delay.value))) {
+					ret = -EOPNOTSUPP;
+					goto out_err;
+				}
+				if (next_xfer == last_xfer)
+					break;
+				next_xfer = list_next_entry(next_xfer, transfer_list);
+			}
+		}
+
 		if ((xfer->tx_buf || xfer->rx_buf) && xfer->len) {
 			reinit_completion(&mas->xfer_done);
 
@@ -1074,16 +1215,17 @@ static int spi_geni_transfer_one_message(struct spi_controller *spi,
 				     ((xfer->tx_sg.nents || xfer->rx_sg.nents) &&
 				      xfer->tx_sg.nents <= 1 && xfer->rx_sg.nents <= 1);
 			if (dma_synced)
-				spi_geni_dma_sync(spi, xfer, true);
+				spi_geni_dma_sync(spi, xfer, last_xfer, true);
 
-			ret = spi_geni_transfer_one(spi, spi_slv, xfer);
+			ret = spi_geni_transfer_one(spi, spi_slv, xfer,
+						    last_xfer == xfer ? NULL : last_xfer);
 			if (ret < 0) {
 				dev_err(mas->dev, "Transfer failed: %d\n", ret);
 				goto out_err;
 			}
 			started = true;
 
-			ret = spi_geni_wait_for_xfer(spi, xfer);
+			ret = spi_geni_wait_for_xfer(spi, xfer, last_xfer);
 			if (ret)
 				goto out_err;
 
@@ -1093,7 +1235,7 @@ static int spi_geni_transfer_one_message(struct spi_controller *spi,
 				goto out_err;
 			}
 			if (dma_synced) {
-				spi_geni_dma_sync(spi, xfer, false);
+				spi_geni_dma_sync(spi, xfer, last_xfer, false);
 				dma_synced = false;
 			}
 		} else if (xfer->len) {
@@ -1103,6 +1245,11 @@ static int spi_geni_transfer_one_message(struct spi_controller *spi,
 			goto out_err;
 		}
 
+		/* Account for all phases and use the final phase's delay and CS. */
+		while (xfer != last_xfer) {
+			msg->actual_length += xfer->len;
+			xfer = list_next_entry(xfer, transfer_list);
+		}
 		msg->actual_length += xfer->len;
 		ret = spi_transfer_delay_exec(xfer);
 		if (ret)
@@ -1134,7 +1281,7 @@ static int spi_geni_transfer_one_message(struct spi_controller *spi,
 
 	/* Return buffer ownership only after DMA has completed or been stopped. */
 	if (dma_synced)
-		spi_geni_dma_sync(spi, xfer, false);
+		spi_geni_dma_sync(spi, xfer, last_xfer, false);
 
 	if (ret || !keep_cs)
 		spi_geni_set_cs(spi_slv, false);
@@ -1382,7 +1529,10 @@ static int spi_geni_probe(struct platform_device *pdev)
 		return ret;
 
 	spi->bus_num = -1;
-	spi->mode_bits = SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_CS_HIGH;
+	spi->mode_bits = mas->dev_data->is_qspi ?
+			 (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH |
+			  SPI_TX_DUAL | SPI_RX_DUAL | SPI_TX_QUAD | SPI_RX_QUAD) :
+			 (SPI_CPOL | SPI_CPHA | SPI_LOOP | SPI_CS_HIGH);
 	spi->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
 	spi->num_chipselect = 4;
 	spi->max_speed_hz = 50000000;
@@ -1516,6 +1666,14 @@ static const struct geni_spi_desc geni_spi = {
 	.power_off = geni_se_resources_deactivate,
 };
 
+static const struct geni_spi_desc geni_qspi = {
+	.resources_init = geni_se_resources_init,
+	.set_rate = geni_spi_set_clock_and_bw,
+	.power_on = geni_se_resources_activate,
+	.power_off = geni_se_resources_deactivate,
+	.is_qspi = true,
+};
+
 static const struct geni_spi_desc sa8255p_geni_spi = {
 	.resources_init = geni_se_domain_attach,
 	.set_rate = geni_se_set_perf_opp,
@@ -1523,6 +1681,7 @@ static const struct geni_spi_desc sa8255p_geni_spi = {
 
 static const struct of_device_id spi_geni_dt_match[] = {
 	{ .compatible = "qcom,geni-spi", .data = &geni_spi },
+	{ .compatible = "qcom,geni-qspi", .data = &geni_qspi },
 	{ .compatible = "qcom,sa8255p-geni-spi", .data = &sa8255p_geni_spi },
 	{}
 };

-- 
2.34.1

