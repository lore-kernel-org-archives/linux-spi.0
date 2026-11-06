Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977352;
	b=WWBE7DENE/SAbMVZ0KlBvTClaBghP0Mt7uHdvyL3xdjwdp9Vw5BqZde6v2A1e7pIpHho
	 X8QtjGK9GBVDlneDSx/VhOXehi/K50Kka67UF+6RBnhvsWxqH1hauiZ6G24AEXPLUfHDO
	 qo42fIz89lR7xykRHO+u5zFnEqfoXbUDmS8aqTFEmU5DGNUpvpyKLAYs/Q2WXGMyMedOI
	 lNeMHYBOh893xRsi+oCFnteJcwS2+/sAthGzSEMhRKbIBADDNLrvG6Uct+AW1cs35dI1h
	 8+VLE53bxjmMnM+4ENSmRznat2/O0yw93keFFFRxHja2JhteiaVOAkQLfFAgJQMkQ1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977352;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ChCM4KxPrjMTdNbnLH7n5WxYrJFbMCImZ9zeZYBvHVY=;
	b=eaZzPUBU4bcGYJtixr/3IFJDmwGG2PqisLFn2bM/pRDlahHsUGR9iO8YcgAuBUvbHegZ
	 6ghMn787sxdWfhWWmp1GXdd0zqhGPvc1JD6wjgQ/4ZInuxIfLpBEZOxMtahTNMbuWQ/YZ
	 X2j7YlkA99P9w9wiczFogVTYqVNqUSAdNe69Mgb4Xk+9tb4mXFS+3LU/Y1k0tsHsLHRRB
	 fw1X1mSYUAzPk7JS4VExFW16ZDeuReNl3ZTHetlv9+4iddiKj0pDJ61feTSNK5ra2bo2Y
	 wfNixanVyRRkB9EhhGWmRukOQ4bjdTM5jvR+DK6G0+oj2XfM2txsNV/aUGIizemY67Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=comDCRDK;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zj4wOtvA;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931C8606D81F
	for <linux-spi@vger.kernel.org>; Fri,  6 Nov 2026 15:02:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 931C8606D81F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=comDCRDK;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Zj4wOtvA
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6ExqfW3324699
	for <linux-spi@vger.kernel.org>; Fri, 6 Nov 2026 15:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ChCM4KxPrjMTdNbnLH7n5WxYrJFbMCImZ9zeZYBvHVY=; b=comDCRDKplxItdEH
	G3NxNZMm5lgqmFrNArb8Qk7COsjmMhv6C1H5Ix9Ek/IC0mcH1Z/OqUyR9jUnyJDj
	7qB8NaRuoHkSC74Jdkbd7g/d7zMeGdV0YGNMPM8W79mpWmjuWj8gqTmn2cEMRB8A
	HS1jAFTLBuqgBLMQkw32avZQiTt+U+Gdmju2tCX1ErZ5pYCD3YUTj9/oI5aMHyPo
	dxJGGcZywLrjShJn5hayCjZKIvBxepam8xlPDHeTsr/3IwaiEzGN8fOBxOqQlHVb
	ajfOSYcaK0OjWklJsvc1TinX6CEiRTDOOYmm4dwXhkig7wNWNgEvGyk7aBzy1fOf
	pi0d2w==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9bb64-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 06 Nov 2026 15:02:30 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-cd65285537aso333169a12.1
        for <linux-spi@vger.kernel.org>; Fri, 06 Nov 2026 07:02:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793977350; x=1794582150; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ChCM4KxPrjMTdNbnLH7n5WxYrJFbMCImZ9zeZYBvHVY=;
        b=Zj4wOtvAISc6lXagreqo+RlwlYrMqrcGXupMk5St6uoqNdZEqjAIlNl4YAgdcQpmrD
         uUjhTK2ksEs0kOoOJoc4NNtGzhuVZF6wSF39haqDr/Rjrx26mDWjt73Af66xrt8oQ5+U
         fphvdtt7AwX6Bw8S3k4wVGmFJtm6IVS6aFMDJOpb24PBS+6rANq09pnVbp+wPgcsd9TY
         OhF3dz+vVQRmWP8RSLnJPeK/y/S+Shw4UkVLBt0jxL6iBJ8vkeNyFWEh4BSe7PL1nduB
         /aC+LXrlalPw3ANUyaW9VAwJ9NLHSA7rvCGFR5UskcpohnQWZtq8BmTAwo+4e9R1TCHB
         zmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793977350; x=1794582150;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ChCM4KxPrjMTdNbnLH7n5WxYrJFbMCImZ9zeZYBvHVY=;
        b=atj/em/W8QE047na+R0QoVihrUIN71Mp/Jq99rHRj3iGKDkY2jhyTQVG/1P2K89RE3
         MuR2PcRVeJ4ApIVVfVbR71AaaLtCbcguoXC5AACU4hLY+Nxc/eXw7kxKdQNRJonHBYD4
         2V2ufwAq53qGrTNktxApN+RABRH6KdTuk2s706Q2WMjZMpkGlI3vh5Wv2f1aS88ul7b3
         SyzTSdVm1Z2rq8emsX3sdkf+9ErO6H6ur2gAjl/Pnw+yBFqCQ0a9yljkfGqAPcQAukLo
         5RdukbOeGcjJ/3+8Lr61rKLPcXk1aMSHoSy1KNSlZz/bX0O8xxb3+bIeRBGg8bZx+3+u
         Du/w==
X-Forwarded-Encrypted: i=1; AL+hErHVAuVPoN132/K/y8H0cS6vYYwxhSTCGQ+TK1BvrozuxSUNVisvNeBw5YDlzpyqwYI17iEuvhHJflY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8oY1A4kjDGbE/NPry/fB3F80XWe/JJPVg8C3ctkVH4Kf+PCfDz
	rCmnChp2gaKathT+jaOe8Jih7UG+6K1GFJa/oiaRq4RbXx6kMn/l8ukLoxNcbdAiQ6sfcgRw0a+
	Z8bTSaSNinKXzm0sM70VyHaiIidlvC68ev5FieeLZYGcbRa6Ca4XZ+tDHVXAAtpQ=
X-Gm-Gg: AYBFou2+u1VEuP1PDHj29FEhLqoBmZCKiMeYptEOpShn/A8FJRUSeYUqOmT92XTympY
	QisxVmwyEQ7t38MUZduUL4Giq20gnnLj9YAWTGjc0B8NdAFOvE4I6U7s6Gbi3n3j2L47Y0P8BtE
	0DorCBoM5KrrSdAtecOFPAD2xjm4puxo64oLI1hQ9/q9tZJnih6CiivuNymepYXWDLoK8NUGMvQ
	/Ey/kBh3TvfZTb9ugWFwz0Gw7VYPIF6EKnrF51Tn8/V7VSKnS8AR2lx3/f/i0YnWL3LQh5MY0qF
	p+2Ylc83JPn1fkzFPkeun57HOxTfQZDtlsZhDjNPQuLOML0Gd6GVM7JjS5abbWDJRjySO8Ptgbd
	TBT3Dx9PDpBhw2cPw2DudJASyRfwpnSgxGQl/X+SKr5taVkWEqbAfU4tKSDv8RaV9UBhryboOAJ
	di0HMfBuWO
X-Received: by 2002:a17:90b:4b0f:b0:39e:4c81:6c5f with SMTP id 98e67ed59e1d1-3b0db6e5c68mr2679341a91.26.1793977349606;
        Fri, 06 Nov 2026 07:02:29 -0800 (PST)
X-Received: by 2002:a17:90b:4b0f:b0:39e:4c81:6c5f with SMTP id 98e67ed59e1d1-3b0db6e5c68mr2679277a91.26.1793977348845;
        Fri, 06 Nov 2026 07:02:28 -0800 (PST)
Received: from hu-jseerapu-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc1bc1e6sm100032a91.0.2026.11.06.07.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:02:28 -0800 (PST)
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 20:31:24 +0530
Subject: [PATCH 6/6] spi: spi-geni-qcom: Add QSPI support over GPI DMA
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
Message-Id: <20261106-qspi_upstream_series-v1-6-21f43042dd60@oss.qualcomm.com>
References: <20261106-qspi_upstream_series-v1-0-21f43042dd60@oss.qualcomm.com>
In-Reply-To: <20261106-qspi_upstream_series-v1-0-21f43042dd60@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Frank Li <Frank.Li@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793977309; l=19294;
 i=jyothi.seerapu@oss.qualcomm.com; h=from:subject:message-id;
 bh=TuPe5np4af7xdy4aKX5TBugQkIVzNf26QIdek/UHb+M=;
 b=VCRflDnNR7zT5Gvf7qe+TIxowIf8Lh7KEgxYRZYIVKr3n9KvjhySGDkYuaDzgHIA0biYWeCWa
 GJp5ZkohdXbC2f9QIpYffdpkFvM5vgXRUm2LX5v1vKHC51wsYuqHVY/
X-Developer-Key: i=jyothi.seerapu@oss.qualcomm.com; a=ed25519;
 pk=9vafyYsia0OnBKWSEwhmWe3hPVQfI2T1xOs5dPaFvEo=
X-Proofpoint-ORIG-GUID: haB-Wb2Q09LM5OzQdQJHWgRn10jZ4ulN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1OSBTYWx0ZWRfXwwhO1tnEx1AO
 +1zbrUyNEGWDmtKgnJDGibBuVKSAd/8IBYpQFDQJk/9jnj73KHYfXpq4oIWWNYZoowHxMUZgY43
 m2hFtKwFd8Df50LthEqd7L7iIpnYURqHM5csY9iVtamW61HD3JEZMJuto+Cbi0vvAuJDmaFGOMa
 k0WiarL31kPnwHU7yuOinGHYFgb7jm6x2jl1a55EJPozHPgSdLPBu2+1dp7riOGAEN4JGBadVRN
 gSliHk/L7BjczCwc88Ds6btf4WfDb3qIHOopvSltDUYOeSvbZejPUAXlznJ2DOMaCUodgAm6Wf7
 p82LTBF3kT+EgklXqAbS2gb511M0WJ3to6LaTK5jX7C1pdcAVkCs9x+i2VytmY+ReBgE1a4M9X+
 qER9qFuClJef0+6O9y2+wJNw2w5DnpSD97RgWQlHfetTaaw5l0IOTLp2ghuO8CSWfGL+x1bnwB1
 jD6WNq9xcGehKQ8hzTA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1OSBTYWx0ZWRfX0AK8BcgvrmjV
 6sSqc/2X87Y4ps/MGj5MBK45/hhzl3nM5Nvad5jkqZElbiN8KblFMrRuBAjb4YqnwbBNrjk/3os
 +WvOKi8OM8LPzw5WLOnAiSNDIJazlbw=
X-Authority-Analysis: v=2.4 cv=WMzqzXsR c=1 sm=1 tr=0 ts=6aedec06 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=WfK9vUvZa93p8ZDr3I4A:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: haB-Wb2Q09LM5OzQdQJHWgRn10jZ4ulN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060059

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
 drivers/spi/spi-geni-qcom.c | 271 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 216 insertions(+), 55 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index c2c3400b24c4..26dad85a590e 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -67,7 +67,6 @@
 #define SPI_TX_ONLY		1
 #define SPI_RX_ONLY		2
 #define SPI_CS_ASSERT		8
-#define SPI_CS_DEASSERT		9
 #define SPI_SCK_ONLY		10
 /* M_CMD params for SPI */
 #define SPI_PRE_CMD_DELAY	BIT(0)
@@ -81,11 +80,20 @@
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
@@ -120,6 +128,7 @@ struct spi_geni_master {
 	struct dma_chan *rx;
 	int cur_xfer_mode;
 	const struct geni_spi_desc *dev_data;
+	u32 dummy_len;
 };
 
 static void spi_slv_setup(struct spi_geni_master *mas)
@@ -412,27 +421,50 @@ spi_gsi_callback_result(void *cb, const struct dmaengine_result *result)
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
@@ -443,20 +475,21 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
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
@@ -466,6 +499,17 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
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
@@ -474,18 +518,17 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
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
@@ -502,12 +545,18 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
 					  DMA_MEM_TO_DEV, flags);
 	if (!tx_desc) {
 		dev_err(mas->dev, "Err setting up tx desc\n");
-		return -EIO;
+		ret = -EIO;
+		goto err_free_rx_desc;
 	}
 
 	tx_desc->callback_result = spi_gsi_callback_result;
 	tx_desc->callback_param = spi;
 
+	if (peripheral.cmd == SPI_TX_RX) {
+		rx_desc->callback_result = spi_gsi_callback_result;
+		rx_desc->callback_param = spi;
+	}
+
 	if (peripheral.cmd & SPI_RX)
 		dmaengine_submit(rx_desc);
 	dmaengine_submit(tx_desc);
@@ -517,6 +566,11 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
 
 	dma_async_issue_pending(mas->tx);
 	return 0;
+
+err_free_rx_desc:
+	if (rx_desc)
+		rx_desc->desc_free(rx_desc);
+	return ret;
 }
 
 static u32 get_xfer_len_in_words(struct spi_transfer *xfer,
@@ -647,17 +701,27 @@ static int spi_geni_init(struct spi_geni_master *mas)
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
@@ -703,6 +767,10 @@ static int spi_geni_init(struct spi_geni_master *mas)
 		fallthrough;
 
 	case 0:
+		if (mas->dev_data->is_qspi) {
+			dev_err(mas->dev, "QSPI is not supported in FIFO mode\n");
+			return -EOPNOTSUPP;
+		}
 		mas->cur_xfer_mode = GENI_SE_FIFO;
 		geni_se_select_mode(se, GENI_SE_FIFO);
 		/* setup_fifo_params assumes that these registers start with a zero value */
@@ -928,7 +996,8 @@ static int setup_se_xfer(struct spi_transfer *xfer,
 
 static int spi_geni_transfer_one(struct spi_controller *spi,
 				 struct spi_device *slv,
-				 struct spi_transfer *xfer)
+				 struct spi_transfer *xfer,
+				 struct spi_transfer *rx_xfer)
 {
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 
@@ -942,7 +1011,7 @@ static int spi_geni_transfer_one(struct spi_controller *spi,
 	if (mas->cur_xfer_mode == GENI_SE_FIFO || mas->cur_xfer_mode == GENI_SE_DMA)
 		return setup_se_xfer(xfer, mas, slv->mode, spi);
 
-	return setup_gsi_xfer(xfer, mas, slv, spi);
+	return setup_gsi_xfer(xfer, mas, slv, spi, rx_xfer);
 }
 
 static int spi_geni_setup(struct spi_device *slv)
@@ -996,30 +1065,46 @@ static void spi_geni_set_cs(struct spi_device *spi_slv, bool enable)
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
@@ -1031,14 +1116,24 @@ static int spi_geni_wait_for_xfer(struct spi_controller *spi,
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
@@ -1048,7 +1143,7 @@ static int spi_geni_transfer_one_message(struct spi_controller *spi,
 {
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 	struct spi_device *spi_slv = msg->spi;
-	struct spi_transfer *xfer, *next_xfer;
+	struct spi_transfer *xfer, *next_xfer, *last_xfer;
 	bool keep_cs = false;
 	bool dma_synced = false;
 	bool started = false;
@@ -1058,6 +1153,54 @@ static int spi_geni_transfer_one_message(struct spi_controller *spi,
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
 
@@ -1066,16 +1209,17 @@ static int spi_geni_transfer_one_message(struct spi_controller *spi,
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
 
@@ -1085,7 +1229,7 @@ static int spi_geni_transfer_one_message(struct spi_controller *spi,
 				goto out_err;
 			}
 			if (dma_synced) {
-				spi_geni_dma_sync(spi, xfer, false);
+				spi_geni_dma_sync(spi, xfer, last_xfer, false);
 				dma_synced = false;
 			}
 		} else if (xfer->len) {
@@ -1095,6 +1239,11 @@ static int spi_geni_transfer_one_message(struct spi_controller *spi,
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
@@ -1126,7 +1275,7 @@ static int spi_geni_transfer_one_message(struct spi_controller *spi,
 
 	/* Return buffer ownership only after DMA has completed or been stopped. */
 	if (dma_synced)
-		spi_geni_dma_sync(spi, xfer, false);
+		spi_geni_dma_sync(spi, xfer, last_xfer, false);
 
 	if (ret || !keep_cs)
 		spi_geni_set_cs(spi_slv, false);
@@ -1309,7 +1458,10 @@ static int spi_geni_probe(struct platform_device *pdev)
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
@@ -1428,6 +1580,14 @@ static const struct geni_spi_desc geni_spi = {
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
@@ -1435,6 +1595,7 @@ static const struct geni_spi_desc sa8255p_geni_spi = {
 
 static const struct of_device_id spi_geni_dt_match[] = {
 	{ .compatible = "qcom,geni-spi", .data = &geni_spi },
+	{ .compatible = "qcom,geni-qspi", .data = &geni_qspi },
 	{ .compatible = "qcom,sa8255p-geni-spi", .data = &sa8255p_geni_spi },
 	{}
 };

-- 
2.34.1

