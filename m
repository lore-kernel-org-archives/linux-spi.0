Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522595;
	b=zNplM/ryfTTtFM/zFA3zLb1I9E2jxcTzm9w9a06vKucB4SVaeD7fWelItFUVK+1LFD8/
	 QA/wuFGpy8OTTP9CudJT7e0j6CZTntlme9R7Z+fGSjhnmY04BTPvnW74Rl32FPZb7hJKu
	 rqiiT5aXSsNQJSyqeYXD30J8efKYnQNJ4ZsCDAI0eRhCJg5NoUP0Mp0qTkcbgHw5xKj2J
	 F9W3pvjdbzsNuDkfmdBMF3SDfTOC8R5wHVnh+HhHn4lrRzyZFh1q76eH3wFB9Aq1oZSy4
	 isCTCANc96QMoThkJy6oBmzRtsOTs0+xMKGInN4GNh+H13tOrTCtWy6lf7t5iC4pYoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522595;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=WZg4Ou0qm95abbmdARxKRie/3fTGXUgMeoAOpNZ8jkc=;
	b=gTDFIq3knuichey6M3mOZGDsgn4QXfcx8I5nDg6ZfY6lL1KTCQhmxWtLy3zbFvtcvOLS
	 Ahp+HL2k03Ojsk39fYNAKkSUQoI9Y27m8CgHduJsWg9K5pSw9/vsFcpdhTUu6lxZFvwnR
	 /Is1EzDPudIq2ZvByGHzHQ/ElX2m3smZpbNno1mhSHYKIhi9fkZwBtaSEQee3NHZ5oPLA
	 XQTsWn3ZiK8uDK2heHqTKvGI0BxD5FMjNnYLHFtj37l3IQxdrQIZl7CDMSx6jzaJ4RCPL
	 fjdj6k6Y0orqxrR18HIBf/T2/XGNoHD1JJob4W5cDdG4R8A4kJg94MPabcXJVswVx7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gpLeKnHB;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=krJx9cTc;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FF1606A31E
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 12:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0FF1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gpLeKnHB;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=krJx9cTc
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOAucj91025356
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 12:16:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WZg4Ou0qm95abbmdARxKRie/3fTGXUgMeoAOpNZ8jkc=; b=gpLeKnHB5zae52Ev
	ZZvvL1US9ny1DqHyeBYnvUgnD6BY/cAGvQaQY1dhRDv7CeJenbz0/sbGudVneGCU
	XETi4z37ITez/wd5vc/UK//KPZ7OBsV6TFnmnvDoXmnQbdDUU4cyb43NQLPCEPC9
	Pm4xwYvi3tUpQu+BagihZbX/vnJpjrBTZWraiPsm7HariWsJ/8kD3T467Yy4aE6l
	64quk5yM3N4OvKP0XCFPhUWa6TiRJqNbxo4gDzJQMcravJfIGejt7KQTAy7v4lb7
	SOz9tmO4Q2nbUBKjQo6FWRfCP3JO7dl8xdesp8dmEj/vwCKMbfNlo0FkG85gl1o8
	qiFJjw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yyt2mqf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 12:16:34 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8a0592d4539so5076283b3a.3
        for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 04:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795522593; x=1796127393; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WZg4Ou0qm95abbmdARxKRie/3fTGXUgMeoAOpNZ8jkc=;
        b=krJx9cTcX6VysrClS+33E7RBES+SpurfapR9+dmJBe7cIEXOx6uxLVx0/t10f4WPY9
         aThurtvuw+rCjriuajcidUeThkZb06hBSI5q6g25Jqcb7/oNArLTRYLBweTKgl+p+jGX
         ApNB1fQsV7hwrTwUKtCfWu62ZkHJHIY1Sp3ZxJbgt45Urj0t84v8sCz1hYUH/IcJtGY/
         0xa98R5mRdO/ZG/Tx4EZLdhvTT3Rr+U1rRkRSLROgnMqFgJs7LvgKRPUY4/V++HPhp8V
         wdKwkRC5AbVdsdQPhGfgR7/HfotvUGllyYrnVUZ/BtqtSyJTdAEHq851y/o/YmLJuFKW
         jaLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522593; x=1796127393;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WZg4Ou0qm95abbmdARxKRie/3fTGXUgMeoAOpNZ8jkc=;
        b=1FZX/BlhBOfzegeVS4rjvVTh1Mw5so9JQvRAFkfn/KOA/yzh8fMW03PbwIAgF091zB
         sNFBd9jLCKCh59D3g/B95hKuyIa+GJ0KBrY/4C7VnrtKQ6vrCWM879oYajFr09CBW1nJ
         52EQ/RcAO8MrybRprMJXJZV/VUwgJld9ArAS+Uvt1rXyEZOMqbZm/qRUzU8LU+P0tsw2
         QxSF8AmzcgLS51Ji5msyWbR+uIbOKfoSzRyp7UjNiZMZGKewwpb4Edxz2+vhh2BDBBod
         pKqI397jyqiJYzInV+uFHvZu7SD2oDmVOBmBGc6hVx33Nq8C+/aXQhI17Bk5WGNhfZ1s
         iPGQ==
X-Forwarded-Encrypted: i=1; AL+hErFS5zX077/NFEQoYfqlwwWKIHWNXvgEqsAQWXigHFPalnlcTBB/4bWeSJxNArwxiMBv75ixNrapDW0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8tXt8bXRF+6FO4xkdVNpiARKVUijroLYpT6kJUY6i3Hk6Cs5U/
	RJ7mvroReOGJNDFJKxBMDOuuFj5ELO06sIchD/5/nJzpiv9EHJOGuiUu5b7iwMGe9lLZkKPe7u1
	r9ne0nJsL79KKZ/kOGT2qF9G8PTEzcGe4Vz5smQmYRI63MPYkgYYq90uD234Xu0I=
X-Gm-Gg: AZFdTZcnMTy5+7CBFkZf3jZmMeNLV+IC4QgGU6evAmPLwuvU9gHdTqltLryiG5zQ9Ag
	MTR4Aj4JKMy2+YaJsbfP/VuXNSr/Z+o7AQFEhrZ+Zv7IRXa+UASVMu/5CmEOBQwuf6pVAGa0wyW
	9dJLPUcKCIEQQo5AkqSdNweEngOZubP09raS4F6SF4jj3gWP2yaoyTCPeDeqPbRkpK1G4MnNgtp
	F6GzqZU698czoCMiu7R+Z8RsDLdTR8T41MIBmJfxSrVbD2Bg/fs3BrzPB1qv26PSo/Oer3f4WS/
	8fg5OrXawUrmH3NdIRsyN1MT+3EupgTHnGDEba7lnuYlboKY5NK7nkbYvZaQCS0IUusUxc8seZz
	l8vDbvJU05jX+xtT7rYhIgzh+H9p6ik1AxWF1sNicqntH736e0LfOSrp9G9ooH37NRTlXKWXx30
	EV5N5g2aFf
X-Received: by 2002:aa7:9316:0:b0:8b1:1410:ac5a with SMTP id d2e1a72fcca58-8c87bdb43a3mr12426141b3a.13.1795522593191;
        Tue, 24 Nov 2026 04:16:33 -0800 (PST)
X-Received: by 2002:aa7:9316:0:b0:8b1:1410:ac5a with SMTP id d2e1a72fcca58-8c87bdb43a3mr12426124b3a.13.1795522592673;
        Tue, 24 Nov 2026 04:16:32 -0800 (PST)
Received: from hu-jseerapu-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c8706844a0sm7245572b3a.1.2026.11.24.04.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:16:32 -0800 (PST)
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 17:45:26 +0530
Subject: [PATCH v2 5/6] dmaengine: qcom: gpi: Add QSPI protocol support
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
Message-Id: <20261124-qspi_qup_upstream-v2-5-cd69894107c8@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795522563; l=7979;
 i=jyothi.seerapu@oss.qualcomm.com; h=from:subject:message-id;
 bh=JZlztrmcHaS1DdxCDsT8jQs/w09XAiC0IM0iGjr15sU=;
 b=d4NbGGwnm3gPKm8s7d+m57fSPqikkLUgJigEAiGIN6Xjwz3vlQPzAk03oa5YGLH+teTy9Pvee
 sh33loJX+2HDWYpCDIZO3zFIv5zsh/F7bUbGOhoJVovOup+wzdxt2re
X-Developer-Key: i=jyothi.seerapu@oss.qualcomm.com; a=ed25519;
 pk=9vafyYsia0OnBKWSEwhmWe3hPVQfI2T1xOs5dPaFvEo=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0NyBTYWx0ZWRfX+wANyNJoK8+i
 6wYg6vxmUCo3aMQ9ypD6nzpuCa1k/k+JPG2ZJBwYgdYQPub8maw8SONB2dhaidcbWOaaFQMt8Pw
 5eTDE6ZQLk52ZeIABWZNu61BV5ldXys=
X-Proofpoint-GUID: r-7-4x8ZaM04BI0vc8m15QBjJ0QedfHb
X-Proofpoint-ORIG-GUID: r-7-4x8ZaM04BI0vc8m15QBjJ0QedfHb
X-Authority-Analysis: v=2.4 cv=W9OtxhWk c=1 sm=1 tr=0 ts=6b058022 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=Q_YMRLC3c4VJkHlJM2QA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0NyBTYWx0ZWRfX9P5Z+tqAR8Gh
 CEaDW6ISjPBuQGApTnfdOBFffUUtbYm8KdOSYFtlKLh5e1l/mpXKmzIxdiGl5aGor5mAYBNyWUe
 lCGf9QkIN78f/cOsFxvVwBmRt3FyQmrBeIDk2oGW1SBXleBj4SrfakU0sHGkhEaCx0NPOenQMv2
 b88H8YARJBfJJG2Tag1szjUnAgGJgkXk1C31y/2cCHREyeIvgRkV2atBdiOsJD2pW8djJTOQrFj
 tBXwQSb1KsuWOaCFOEiaz7jhxSCjx+sVXzuH6Oy2Ko/VOE5YEn0M5MmZhV5fdbO2NxD6WjEwp0J
 GudcjnbM/DStCvyiArXRxHhj8POAtGakjKUqmU5zR0jZ23Fx9LRp7agS59PVJYE7sZ4yDQ5VlFj
 WDe3113RNk4rxY/9fB7Kt9rG9eCNtvdOKH4ucsjiNwH9/gdGQ4g3O1nH3lWgwN9Z+VOcX5faeXp
 tTyZCkBYL+HTSfj6xVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 bulkscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240047

QSPI reuses the SPI TRE format but requires protocol-specific handling
for GO TRE fragmentation, transfer mode selection and dummy cycles.

Translate the QCOM_GPI_QSPI DT client identifier to hardware protocol
encoding 9 when programming the channel's SCRATCH_0 register. Retain
the DT identifier for protocol-specific driver operations and leave
the existing SPI, UART and I2C hardware mappings unchanged.

Add QSPI support to the SPI TRE generation path and extend
gpi_spi_config with transfer mode and dummy-cycle parameters. Encode
dummy cycles in CONFIG0 and select the QSPI GO format for single,
dual and quad SDR transfers, preserving the existing SPI encoding.

Add SPI_TX_RX to the shared DMA interface for sequential TX-then-RX
transactions. Enable RX end-of-transfer events for QSPI TX-then-RX
commands so clients can wait for both DMA completions.

Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
---
 drivers/dma/qcom/gpi.c           | 32 ++++++++++++++++++++++++++------
 drivers/spi/spi-geni-qcom.c      |  1 -
 include/linux/dma/qcom-gpi-dma.h |  6 ++++++
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index f2a2f653cc0b..59d9a393120e 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -36,6 +36,7 @@
 #define TRE_SPI_C0_CS		BIT(11)
 #define TRE_SPI_C0_CPHA		BIT(12)
 #define TRE_SPI_C0_CPOL		BIT(13)
+#define TRE_SPI_C0_DUMMY_CYCLES	GENMASK(21, 14)
 #define TRE_SPI_C0_TX_PACK	BIT(24)
 #define TRE_SPI_C0_RX_PACK	BIT(25)
 
@@ -48,6 +49,10 @@
 #define TRE_SPI_GO_CS		GENMASK(10, 8)
 #define TRE_SPI_GO_FRAG		BIT(26)
 
+/* QSPI GO WD0 */
+#define TRE_QSPI_GO_FRAG	BIT(22)
+#define TRE_QSPI_GO_MODE	GENMASK(31, 28)
+
 /* GO WD2 */
 #define TRE_RX_LEN		GENMASK(23, 0)
 
@@ -206,6 +211,7 @@ enum CNTXT_OFFS {
 #define GPII_n_CH_k_QOS_OFFS(n, k)		(0x2005C + (0x4000 * (n)) + (0x80 * (k)))
 
 /* Scratch registers */
+#define GPI_QSPI_PROTOCOL_ID		9
 #define GPII_n_CH_k_SCRATCH_0_OFFS(n, k)	(0x20060 + (0x4000 * (n)) + (0x80 * (k)))
 #define GPII_n_CH_k_SCRATCH_0_SEID		GENMASK(2, 0)
 #define GPII_n_CH_k_SCRATCH_0_PROTO		GENMASK(7, 4)
@@ -482,7 +488,7 @@ struct gchan {
 	struct virt_dma_chan vc;
 	u32 chid;
 	u32 seid;
-	u32 protocol;
+	u32 protocol; /* DT client protocol identifier */
 	struct gpii *gpii;
 	enum gpi_ch_state ch_state;
 	enum gpi_pm_state pm_state;
@@ -1264,6 +1270,7 @@ static int gpi_alloc_chan(struct gchan *chan, bool send_alloc_cmd)
 	u32 id = gpii->gpii_id;
 	u32 chid = chan->chid;
 	u32 pair_chid = !chid;
+	u32 protocol = chan->protocol;
 
 	if (send_alloc_cmd) {
 		ret = gpi_send_cmd(gpii, chan, GPI_CH_CMD_ALLOCATE);
@@ -1274,6 +1281,10 @@ static int gpi_alloc_chan(struct gchan *chan, bool send_alloc_cmd)
 		}
 	}
 
+	/* Translate the DT client identifier to the hardware protocol encoding. */
+	if (protocol == QCOM_GPI_QSPI)
+		protocol = GPI_QSPI_PROTOCOL_ID;
+
 	gpi_write_reg(gpii, chan->ch_cntxt_base_reg + CNTXT_0_CONFIG,
 		      GPII_n_CH_k_CNTXT_0(ring->el_size, 0, chan->dir, GPI_CHTYPE_PROTO_GPI));
 	gpi_write_reg(gpii, chan->ch_cntxt_base_reg + CNTXT_1_R_LENGTH, ring->len);
@@ -1283,7 +1294,7 @@ static int gpi_alloc_chan(struct gchan *chan, bool send_alloc_cmd)
 	gpi_write_reg(gpii, chan->ch_cntxt_db_reg + CNTXT_5_RING_RP_MSB - CNTXT_4_RING_RP_LSB,
 		      upper_32_bits(ring->phys_addr));
 	gpi_write_reg(gpii, gpii->regs + GPII_n_CH_k_SCRATCH_0_OFFS(id, chid),
-		      GPII_n_CH_k_SCRATCH_0(pair_chid, chan->protocol, chan->seid));
+		      GPII_n_CH_k_SCRATCH_0(pair_chid, protocol, chan->seid));
 	gpi_write_reg(gpii, gpii->regs + GPII_n_CH_k_SCRATCH_1_OFFS(id, chid), 0);
 	gpi_write_reg(gpii, gpii->regs + GPII_n_CH_k_SCRATCH_2_OFFS(id, chid), 0);
 	gpi_write_reg(gpii, gpii->regs + GPII_n_CH_k_SCRATCH_3_OFFS(id, chid), 0);
@@ -1728,6 +1739,7 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
 		tre->dword[0] |= u32_encode_bits(spi->loopback_en, TRE_SPI_C0_LOOPBACK);
 		tre->dword[0] |= u32_encode_bits(spi->clock_pol_high, TRE_SPI_C0_CPOL);
 		tre->dword[0] |= u32_encode_bits(spi->data_pol_high, TRE_SPI_C0_CPHA);
+		tre->dword[0] |= u32_encode_bits(spi->dummy_cycles, TRE_SPI_C0_DUMMY_CYCLES);
 		tre->dword[0] |= u32_encode_bits(spi->pack_en, TRE_SPI_C0_TX_PACK);
 		tre->dword[0] |= u32_encode_bits(spi->pack_en, TRE_SPI_C0_RX_PACK);
 
@@ -1745,7 +1757,12 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
 		tre = &desc->tre[tre_idx];
 		tre_idx++;
 
-		tre->dword[0] = u32_encode_bits(spi->fragmentation, TRE_SPI_GO_FRAG);
+		if (chan->protocol == QCOM_GPI_QSPI) {
+			tre->dword[0] = u32_encode_bits(spi->fragmentation, TRE_QSPI_GO_FRAG);
+			tre->dword[0] |= u32_encode_bits(spi->qspi_mode, TRE_QSPI_GO_MODE);
+		} else {
+			tre->dword[0] = u32_encode_bits(spi->fragmentation, TRE_SPI_GO_FRAG);
+		}
 		tre->dword[0] |= u32_encode_bits(spi->cs, TRE_SPI_GO_CS);
 		tre->dword[0] |= u32_encode_bits(spi->cmd, TRE_SPI_GO_CMD);
 
@@ -1759,7 +1776,7 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
 			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_LINK);
 		} else if (spi->cmd == SPI_TX) {
 			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_CHAIN);
-		} else { /* SPI_DUPLEX */
+		} else { /* SPI_DUPLEX or SPI_TX_RX */
 			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_CHAIN);
 			tre->dword[3] |= u32_encode_bits(1, TRE_FLAGS_LINK);
 		}
@@ -1792,7 +1809,10 @@ static int gpi_create_spi_tre(struct gchan *chan, struct gpi_desc *desc,
 		tre->dword[3] = u32_encode_bits(TRE_TYPE_DMA, TRE_FLAGS_TYPE);
 	}
 
-	tre->dword[3] |= u32_encode_bits(direction == DMA_MEM_TO_DEV,
+	/* QSPI TX-then-RX commands need a separate RX completion event. */
+	tre->dword[3] |= u32_encode_bits(direction == DMA_MEM_TO_DEV ||
+					 (chan->protocol == QCOM_GPI_QSPI &&
+					  spi->cmd == SPI_TX_RX),
 					 TRE_FLAGS_IEOT);
 
 	for (i = 0; i < tre_idx; i++)
@@ -1850,7 +1870,7 @@ gpi_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
 		return NULL;
 
 	/* create TREs for xfer */
-	if (gchan->protocol == QCOM_GPI_SPI) {
+	if (gchan->protocol == QCOM_GPI_SPI || gchan->protocol == QCOM_GPI_QSPI) {
 		i = gpi_create_spi_tre(gchan, gpi_desc, sgl, direction);
 	} else if (gchan->protocol == QCOM_GPI_I2C) {
 		i = gpi_create_i2c_tre(gchan, gpi_desc, sgl, direction, flags);
diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 0a15e75051d8..631908522957 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -69,7 +69,6 @@
 /* M_CMD OP codes for SPI */
 #define SPI_TX_ONLY		1
 #define SPI_RX_ONLY		2
-#define SPI_TX_RX		7
 #define SPI_CS_ASSERT		8
 #define SPI_CS_DEASSERT		9
 #define SPI_SCK_ONLY		10
diff --git a/include/linux/dma/qcom-gpi-dma.h b/include/linux/dma/qcom-gpi-dma.h
index 332be28427e4..d2d659a075f9 100644
--- a/include/linux/dma/qcom-gpi-dma.h
+++ b/include/linux/dma/qcom-gpi-dma.h
@@ -11,11 +11,13 @@
  * @SPI_TX: SPI peripheral TX command
  * @SPI_RX: SPI peripheral RX command
  * @SPI_DUPLEX: SPI peripheral Duplex command
+ * @SPI_TX_RX: SPI peripheral Tx-then-Rx command (QSPI read transactions)
  */
 enum spi_transfer_cmd {
 	SPI_TX = 1,
 	SPI_RX,
 	SPI_DUPLEX,
+	SPI_TX_RX = 7,
 };
 
 /**
@@ -33,6 +35,8 @@ enum spi_transfer_cmd {
  * @cs: chip select toggle
  * @set_config: set peripheral config
  * @rx_len: receive length for buffer
+ * @dummy_cycles: number of dummy clock cycles for a QSPI transfer
+ * @qspi_mode: QSPI bus-width/SDR-DDR mode for the GO TRE
  */
 struct gpi_spi_config {
 	u8 set_config;
@@ -43,10 +47,12 @@ struct gpi_spi_config {
 	u8 word_len;
 	u8 fragmentation;
 	u8 cs;
+	u8 dummy_cycles;
 	u32 clk_div;
 	u32 clk_src;
 	enum spi_transfer_cmd cmd;
 	u32 rx_len;
+	u16 qspi_mode;
 };
 
 enum i2c_op {

-- 
2.34.1

