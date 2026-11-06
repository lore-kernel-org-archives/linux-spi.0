Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977323;
	b=g8EYcqNGY+y+KeNuGUyh6drqkiQhZEDgNKZGY0/rICnWwxHoG9zjl6N8ie9mlWhqTjO9
	 Tz4J6K1r6/sKsiaeouMcImmLzBBgI4hxLjceMxPrb6B52gnG0dUfVlh4Q3d23ZTwAR98q
	 r4aRBUogKPVvjcQPK0HHhWvVH3pZh+67UKRPe4/I1Q5vSu5Jsxvpk6tw/2Lg4eYGARMhI
	 eDp+0WgBCYCVLkF4bqYNeVgSMbxWySYKCvMINFf9j4Fh04Z8nQJD22UpNdSmQGXM7G6+J
	 u7y7tg6mWSMLsFAIcSi94Boh6q+KXbpBemhTpPpAB6UCVInbjh9I/L2ltDed2xVmKpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977323;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=HlociWaNDzzeC8BLa8/D5GL8aGJf60PlW6/5yMs6E8s=;
	b=CczUesGWhgJ6TaeOEKE9JLSkmgmPHCPcmSap5Z0w7yDV6DeXvnY+EVzJ1KTdFe5D8G/d
	 HUKuVN459BlzsU3JCxzh3oo2Bi/adavNJANPmO4Jol3ZqDFEQcy8JMC7vPzxOpY4f83EM
	 nAALXzCGb8Mhecul2ngZC7xXsORhhrsQQ6pzo+fjBH0EUEmn6Ceux7ILKP8MvNifGsr6B
	 SBPljUZZxp47zMYPLLDILNOAE39lRUhezsRjCfqqBZU5VRn6ayRszDuVUu4lrPw+OX47+
	 508QKgSONmaBt6Hol6y4+WaTGIvbqWJDAk4cgoOr75P/f+JM1G2tp29pACKCMUYbBxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="iZ/UQQAe";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DGj3oWaB;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000DD606A326
	for <linux-spi@vger.kernel.org>; Fri,  6 Nov 2026 15:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 000DD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iZ/UQQAe;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DGj3oWaB
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F01eI1039367
	for <linux-spi@vger.kernel.org>; Fri, 6 Nov 2026 15:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HlociWaNDzzeC8BLa8/D5GL8aGJf60PlW6/5yMs6E8s=; b=iZ/UQQAeqrHkG5vL
	lNrYWvcY90y67fqv57165Xs47wsGnng1jcRRb7gM4WnmBgo4WI02fP0s0fhd5npO
	PVCGclDEss6jd8b54NGD0Oee1DKlJghR2NcpybQJxq2/o1nCNcbw0XzyF+W80r8W
	/Cg0FPzBJ9rbdGb/P81mjY1HS9xZ9Z/4JXsiEyA0anRatyDiJ+EyM+E7DNi7T6iJ
	UO8HBrJLsgRFUDjXWL66aWJNviHQcuxVl831KNGrb63e/EwLESZ/rJGg5Ph6b46f
	VXdU1VFPr04RQgy8jWsDY2qun3NfaMgi/REjdTQSZRXUO9KeGtMQDZJtOVjm6OAm
	7jZGXw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9uan9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 06 Nov 2026 15:02:02 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc7361c62b9so512001a12.3
        for <linux-spi@vger.kernel.org>; Fri, 06 Nov 2026 07:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793977321; x=1794582121; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HlociWaNDzzeC8BLa8/D5GL8aGJf60PlW6/5yMs6E8s=;
        b=DGj3oWaBfB1vsWOaKlwXlcPydRW5Z1D8De6NRZKW3WxoxA12EEuQ+QaRtLlIyEXs9p
         v7qpdN5DojAOeWVBnS3kzwn1QOiourUzhfE9lHQieUIC/6ve+VAiNafD5AHhxu0u45Gb
         79Zat26Tvqo1mmgwhEQr+SlwSv8dTW17mw7V6un7z1NtU4lwhQm5veN0hjBFy+myfg2Y
         5Lp5T3XgbJ2PWiRezhHiHNK8lrOo3t2Mb/TYAja2kcYn7jf2d8Oa8iBhasrYuxS/x/NX
         3HmjwCfEjkxHqn5KnkDTNt5G7OaZLEA9qkpPh+lyFp1Uvob6vb6vgtgbsYXVeXiTnBMV
         9hjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793977321; x=1794582121;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HlociWaNDzzeC8BLa8/D5GL8aGJf60PlW6/5yMs6E8s=;
        b=ma338PPz6xTh4PEK6eq/fAecieKceypcDjZVG084pw5lMaofP/w0fC3KfmImGgfKAc
         i1qKhy5jG+x9W2SXxjjwa0JEu7sCRhgb/8k7t6TF1BvVybNtABqrxlhtKNoPgpfp5vhM
         XIl2X/xEkFqiDBmJjgLRNi5ZhATBagIeBT8V0jVvpTlpUW6+dDoTaDcHxyOy0XRFnvbn
         J6G5ffNbNg2xXLaaw0SM0rEoH9bPs5PiMFCsyzLPxjlu+OOSFRR4bSnfowNOstlLf7XO
         2oBDZQTiulIY594VS7rTeSGb2pvOJ2f6WKLuzkObDJyhqKngE2i7TFvwNq4Ap1E4Td6g
         ccIg==
X-Forwarded-Encrypted: i=1; AL+hErGm0VqmOdDYzBGahzHCmRBlMVfxsCWy2Ima0M38+DaLbjXq43/ZIfPOyktyRp/Le3+TRhl+opWZi9k=@vger.kernel.org
X-Gm-Message-State: APuU4Z+y8oWP2yK/X/RF+0i1gR2slp5YpoIfjV7swMbtBbPJmD3cBxX8
	xtya45luy1OdUTre4fsUh6NmylYDroCrOfP6doGWnnB8H/e+IRy/69fq9ucCaCcW3C+4ryM1797
	pMxijO/MD3iseCxjUS9Jv4q/i3z8RdoDqfiFHHAlOs7uS9/eXH6a5aWYKZSBg6A4=
X-Gm-Gg: AYBFou0YmE6WRdqNH8Pzn4U3+JGZX2STS0t+o0Bp+l8r/nU+ARyKeeEglOo0he7kNGl
	hbxUdsJ9TspJuFvR6lyjiDl7hKc9q8hTTLyp3gbNaXwSbd4rRiOWros9NuFs6htoYIVc2ENgvOm
	y2vL3mkkuUGISG1JzNGmzHYUyaibusTxMAY0wSU0nAagizO4X1/y0m/ygDFQnyWHnHHKk6NG7rE
	sncefKWdwJxSEgb+aEDIMVhWnfodyl6hWKwVIpZi3FODaBEghhwtbD+uRbxFdpAvpvsS4c2Xg2j
	MxhBt+rMlTdTHl49geG2w3TB3QnujLxId/Usd3xTs4yKr3vYwl0Z59EndbdVY3l16qs3Txga5LW
	zYE183aPP3PDm531MuICHsxugEMG9fIatb3QdkVg0RSqt5XSKeKooiiVEp3TVBhzR6LOAfLWdS1
	I8Ss0uMxBW
X-Received: by 2002:a17:90b:4d01:b0:3ad:25f6:1dd0 with SMTP id 98e67ed59e1d1-3b0db69f38emr2998843a91.11.1793977321197;
        Fri, 06 Nov 2026 07:02:01 -0800 (PST)
X-Received: by 2002:a17:90b:4d01:b0:3ad:25f6:1dd0 with SMTP id 98e67ed59e1d1-3b0db69f38emr2998788a91.11.1793977320530;
        Fri, 06 Nov 2026 07:02:00 -0800 (PST)
Received: from hu-jseerapu-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc1bc1e6sm100032a91.0.2026.11.06.07.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:02:00 -0800 (PST)
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 20:31:19 +0530
Subject: [PATCH 1/6] spi: spi-geni-qcom: Add transfer_one_message() support
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
Message-Id: <20261106-qspi_upstream_series-v1-1-21f43042dd60@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793977309; l=12551;
 i=jyothi.seerapu@oss.qualcomm.com; h=from:subject:message-id;
 bh=GV6mYXrRMN5D8EbEOyheV6OV01uzAGb3j2KVOI1zyIQ=;
 b=Fj+gonexSzqVJ9IL7LNr1HyRd9I4OF2t8Hus+y9IVeK7lWWQadN+oc67sTquHxnoJvKgsY7Cn
 cMAqXkHBSrdDpuK8tNb4nnwzmsyrBpeuP6MOkBR+Uapx+boTvEFykEm
X-Developer-Key: i=jyothi.seerapu@oss.qualcomm.com; a=ed25519;
 pk=9vafyYsia0OnBKWSEwhmWe3hPVQfI2T1xOs5dPaFvEo=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1OSBTYWx0ZWRfX1EUmuZAkFQcC
 w3ZE2WaCW1ElETTv5QQricc7eJziFvp6LhhWFl25mPzv59DKRCYViwT1aHERlOfKaZ5aeBFcAxp
 5A2WQJiFHx+mBUmvFJpHCU5pz7v8lmQ=
X-Proofpoint-GUID: dyrghy1m-3E56GSMGVNB425c2r9Juo_0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1OSBTYWx0ZWRfX0bjLjIthcZeH
 vbKNsFZQINSRWGY98Nt5i5CrGea6BnDecm9Jr2mCoRtSYdYbVoTCbzHWCr1RpUli3DG99WohL/G
 qFdBMRn/mfAvxjvGiu4OX1GR08koD2zg0q86fGKwdYo09G++6RFrfsh2PregMwgHjQTvI0LIy+Y
 srCm9vPyIHkZluo2/UehZq6ARIoxzDUarrSKndBPVmxWgPQY/xiW+4AMYCgYdamYHo5mjotLrJX
 uBACgldXd2LY5U6O5B3VKsK7fRyLj/1HdroJ4z3Of7JZIcVDI3xO/oB9uKgjWT+hdg3AfEoUqgx
 Nr/l2+l196aKSpvBBSPAAd8OundlyYINZuZ8ebeOP2L0A0LbUVYzyY1rMb9SSDIAfyNYBbtm61+
 WbXpVYPQkIFJiO1Ssy2xebYiHoeRm8HOXYiVUu2VyAOeHmIhbOOoYwjfYRIpjZvaZmyr0DoiJFB
 uz7R3kt394mjz44dcIA==
X-Proofpoint-ORIG-GUID: dyrghy1m-3E56GSMGVNB425c2r9Juo_0
X-Authority-Analysis: v=2.4 cv=ZIZCCn7b c=1 sm=1 tr=0 ts=6aedebea cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=JThQf_oUxqckihrRH7AA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 bulkscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060059

The GENI SPI driver currently relies on the SPI core's default
transfer_one_message() implementation. Adding Quad SPI (QSPI) support
requires driver-managed message sequencing. In particular, GENI QSPI
reads require combining a command/address TX phase and an RX data
phase into a single hardware command.

Add a driver-specific transfer_one_message() implementation, retaining
spi_geni_transfer_one() as an internal helper for programming individual
transfers. Handle completion, transfer delays, errors and DMA buffer
synchronization at the message level.

The custom message handler must also provide the GPIO chip-select
sequencing and delays previously handled by the SPI core. Track the
selected GPIO and its timing and polarity for device switching.
Invalidate the cached selection during setup and preserve the software
inactive delay for native chip-selects.

Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
---
 drivers/spi/spi-geni-qcom.c | 247 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 224 insertions(+), 23 deletions(-)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 6c57f8309a3b..25c03096ee23 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -6,6 +6,7 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/qcom_geni_spi.h>
 
+#include <linux/acpi.h>
 #include <linux/clk.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
@@ -13,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/log2.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/pm_opp.h>
@@ -106,10 +108,14 @@ struct spi_geni_master {
 	struct completion abort_done;
 	struct completion tx_reset_done;
 	struct completion rx_reset_done;
+	struct completion xfer_done;
 	unsigned int oversampling;
 	spinlock_t lock;
 	int irq;
-	bool cs_flag;
+	struct gpio_desc *cs_gpiod;
+	struct spi_delay cs_hold;
+	struct spi_delay cs_inactive;
+	bool cs_inactive_level;
 	bool abort_failed;
 	struct dma_chan *tx;
 	struct dma_chan *rx;
@@ -400,23 +406,23 @@ spi_gsi_callback_result(void *cb, const struct dmaengine_result *result)
 	struct spi_controller *spi = cb;
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
 
-	spi->cur_msg->status = -EIO;
+	/*
+	 * Record only failures. msg->status is finalized when the
+	 * entire SPI message completes.
+	 */
 	if (result->result != DMA_TRANS_NOERROR) {
 		dev_err(&spi->dev, "DMA txn failed: %d\n", result->result);
 		trace_geni_se_regs(&mas->se);
-		spi_finalize_current_transfer(spi);
-		return;
-	}
-
-	if (!result->residue) {
-		spi->cur_msg->status = 0;
+		spi->cur_msg->status = -EIO;
+	} else if (!result->residue) {
 		dev_dbg(&spi->dev, "DMA txn completed\n");
 	} else {
 		dev_err(&spi->dev, "DMA xfer has pending: %d\n", result->residue);
 		trace_geni_se_regs(&mas->se);
+		spi->cur_msg->status = -EIO;
 	}
 
-	spi_finalize_current_transfer(spi);
+	complete(&mas->xfer_done);
 }
 
 static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas,
@@ -511,7 +517,7 @@ static int setup_gsi_xfer(struct spi_transfer *xfer, struct spi_geni_master *mas
 		dma_async_issue_pending(mas->rx);
 
 	dma_async_issue_pending(mas->tx);
-	return 1;
+	return 0;
 }
 
 static u32 get_xfer_len_in_words(struct spi_transfer *xfer,
@@ -926,7 +932,6 @@ static int spi_geni_transfer_one(struct spi_controller *spi,
 				 struct spi_transfer *xfer)
 {
 	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
-	int ret;
 
 	if (spi_geni_is_abort_still_pending(mas))
 		return -EBUSY;
@@ -935,16 +940,206 @@ static int spi_geni_transfer_one(struct spi_controller *spi,
 	if (!xfer->len)
 		return 0;
 
-	if (mas->cur_xfer_mode == GENI_SE_FIFO || mas->cur_xfer_mode == GENI_SE_DMA) {
-		ret = setup_se_xfer(xfer, mas, slv->mode, spi);
-		/* SPI framework expects +ve ret code to wait for transfer complete */
-		if (!ret)
-			ret = 1;
-		return ret;
-	}
+	if (mas->cur_xfer_mode == GENI_SE_FIFO || mas->cur_xfer_mode == GENI_SE_DMA)
+		return setup_se_xfer(xfer, mas, slv->mode, spi);
+
 	return setup_gsi_xfer(xfer, mas, slv, spi);
 }
 
+static int spi_geni_setup(struct spi_device *slv)
+{
+	struct spi_geni_master *mas = spi_controller_get_devdata(slv->controller);
+
+	/* The core deasserts CS after setup, possibly with a new polarity. */
+	if (!(slv->mode & SPI_NO_CS) && mas->cs_gpiod == spi_get_csgpiod(slv, 0))
+		mas->cs_gpiod = NULL;
+
+	return 0;
+}
+
+static void spi_geni_set_cs(struct spi_device *spi_slv, bool enable)
+{
+	struct gpio_desc *cs_gpiod = spi_get_csgpiod(spi_slv, 0);
+	struct spi_geni_master *mas = spi_controller_get_devdata(spi_slv->controller);
+	bool level = true;
+
+	if (spi_slv->mode & SPI_NO_CS)
+		cs_gpiod = NULL;
+
+	/* Release a previously selected GPIO before switching devices. */
+	if (mas->cs_gpiod && (!enable || mas->cs_gpiod != cs_gpiod)) {
+		spi_delay_exec(&mas->cs_hold, NULL);
+		gpiod_set_value_cansleep(mas->cs_gpiod, mas->cs_inactive_level);
+		spi_delay_exec(&mas->cs_inactive, NULL);
+		mas->cs_gpiod = NULL;
+	}
+
+	/* Preserve the software inactive delay for hardware-controlled CS. */
+	if (!cs_gpiod && !enable && !(spi_slv->mode & SPI_NO_CS))
+		spi_delay_exec(&spi_slv->cs_inactive, NULL);
+
+	if (!enable || !cs_gpiod || mas->cs_gpiod == cs_gpiod)
+		return;
+
+	/* DT polarity is handled by gpiolib; ACPI uses SPI_CS_HIGH. */
+	if (is_acpi_device_node(dev_fwnode(&spi_slv->dev)) &&
+	    !(spi_slv->mode & SPI_CS_HIGH))
+		level = false;
+
+	gpiod_set_value_cansleep(cs_gpiod, level);
+	spi_delay_exec(&spi_slv->cs_setup, NULL);
+
+	/* GPIOs belong to the controller; do not retain a spi_device pointer. */
+	mas->cs_gpiod = cs_gpiod;
+	mas->cs_hold = spi_slv->cs_hold;
+	mas->cs_inactive = spi_slv->cs_inactive;
+	mas->cs_inactive_level = !level;
+}
+
+static void spi_geni_dma_sync(struct spi_controller *spi,
+			      struct spi_transfer *xfer, bool for_device)
+{
+	/* The core maps buffers with DMA_ATTR_SKIP_CPU_SYNC. */
+	if (for_device) {
+		if (xfer->tx_sg_mapped)
+			dma_sync_sgtable_for_device(spi->cur_tx_dma_dev,
+						    &xfer->tx_sg, DMA_TO_DEVICE);
+		if (xfer->rx_sg_mapped)
+			dma_sync_sgtable_for_device(spi->cur_rx_dma_dev,
+						    &xfer->rx_sg, DMA_FROM_DEVICE);
+	} else {
+		if (xfer->rx_sg_mapped)
+			dma_sync_sgtable_for_cpu(spi->cur_rx_dma_dev,
+						 &xfer->rx_sg, DMA_FROM_DEVICE);
+		if (xfer->tx_sg_mapped)
+			dma_sync_sgtable_for_cpu(spi->cur_tx_dma_dev,
+						 &xfer->tx_sg, DMA_TO_DEVICE);
+	}
+}
+
+static int spi_geni_wait_for_xfer(struct spi_controller *spi,
+				  const struct spi_transfer *xfer)
+{
+	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
+	u64 bits, ms;
+
+	if (spi_controller_is_target(spi)) {
+		/* A target cannot predict when its peer will supply clocks. */
+		if (wait_for_completion_interruptible(&mas->xfer_done)) {
+			dev_dbg(mas->dev, "SPI transfer interrupted\n");
+			return -EINTR;
+		}
+		return 0;
+	}
+
+	bits = (u64)xfer->len * BITS_PER_BYTE;
+	ms = div_u64(bits * MSEC_PER_SEC, xfer->speed_hz ?: 100000);
+	ms = min_t(u64, ms * 2 + 200, UINT_MAX);
+
+	if (!wait_for_completion_timeout(&mas->xfer_done, msecs_to_jiffies(ms))) {
+		dev_err(mas->dev, "Transfer timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int spi_geni_transfer_one_message(struct spi_controller *spi,
+					 struct spi_message *msg)
+{
+	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
+	struct spi_device *spi_slv = msg->spi;
+	struct spi_transfer *xfer, *next_xfer;
+	bool keep_cs = false;
+	bool dma_synced = false;
+	bool started = false;
+	int ret = 0;
+
+	xfer = list_first_entry(&msg->transfers, struct spi_transfer, transfer_list);
+	spi_geni_set_cs(spi_slv, !xfer->cs_off);
+
+	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
+		if ((xfer->tx_buf || xfer->rx_buf) && xfer->len) {
+			reinit_completion(&mas->xfer_done);
+
+			/* Synchronize buffers only for DMA; the SE FIFO path uses CPU access. */
+			dma_synced = mas->cur_xfer_mode == GENI_GPI_DMA ||
+				     ((xfer->tx_sg.nents || xfer->rx_sg.nents) &&
+				      xfer->tx_sg.nents <= 1 && xfer->rx_sg.nents <= 1);
+			if (dma_synced)
+				spi_geni_dma_sync(spi, xfer, true);
+
+			ret = spi_geni_transfer_one(spi, spi_slv, xfer);
+			if (ret < 0) {
+				dev_err(mas->dev, "Transfer failed: %d\n", ret);
+				goto out_err;
+			}
+			started = true;
+
+			ret = spi_geni_wait_for_xfer(spi, xfer);
+			if (ret)
+				goto out_err;
+
+			/* DMA errors and target aborts are reported through msg->status. */
+			if (msg->status != -EINPROGRESS) {
+				ret = msg->status;
+				goto out_err;
+			}
+			if (dma_synced) {
+				spi_geni_dma_sync(spi, xfer, false);
+				dma_synced = false;
+			}
+		} else if (xfer->len) {
+			dev_err(&spi_slv->dev,
+				"Bufferless transfer has length %u\n", xfer->len);
+			ret = -EINVAL;
+			goto out_err;
+		}
+
+		msg->actual_length += xfer->len;
+		ret = spi_transfer_delay_exec(xfer);
+		if (ret)
+			goto out_err;
+
+		next_xfer = list_is_last(&xfer->transfer_list, &msg->transfers) ?
+			    NULL : list_next_entry(xfer, transfer_list);
+		if (!next_xfer) {
+			keep_cs = xfer->cs_change;
+		} else if (xfer->cs_change) {
+			if (!xfer->cs_off)
+				spi_geni_set_cs(spi_slv, false);
+
+			spi_transfer_cs_change_delay_exec(msg, xfer);
+
+			if (!next_xfer->cs_off)
+				spi_geni_set_cs(spi_slv, true);
+		} else if (xfer->cs_off != next_xfer->cs_off) {
+			spi_geni_set_cs(spi_slv, xfer->cs_off);
+		}
+	}
+
+out_err:
+	if (!ret && msg->status != -EINPROGRESS)
+		ret = msg->status;
+
+	if (ret && started)
+		spi_geni_handle_err(spi, msg);
+
+	/* Return buffer ownership only after DMA has completed or been stopped. */
+	if (dma_synced)
+		spi_geni_dma_sync(spi, xfer, false);
+
+	if (ret || !keep_cs)
+		spi_geni_set_cs(spi_slv, false);
+
+	if (msg->status == -EINPROGRESS)
+		msg->status = ret;
+
+	spi_finalize_current_message(spi);
+
+	return ret;
+}
+
 static irqreturn_t geni_spi_isr(int irq, void *data)
 {
 	struct spi_controller *spi = data;
@@ -979,8 +1174,6 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 
 		if (m_irq & M_CMD_DONE_EN) {
 			if (mas->cur_xfer) {
-				spi_finalize_current_transfer(spi);
-				mas->cur_xfer = NULL;
 				/*
 				 * If this happens, then a CMD_DONE came before all the
 				 * Tx buffer bytes were sent out. This is unusual, log
@@ -1005,6 +1198,9 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 						mas->rx_rem_bytes, mas->cur_bits_per_word);
 					trace_geni_se_regs(se);
 				}
+
+				complete(&mas->xfer_done);
+				mas->cur_xfer = NULL;
 			} else {
 				complete(&mas->cs_done);
 			}
@@ -1025,7 +1221,7 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 		if (dma_rx_status & RX_RESET_DONE)
 			complete(&mas->rx_reset_done);
 		if (!mas->tx_rem_bytes && !mas->rx_rem_bytes && xfer) {
-			spi_finalize_current_transfer(spi);
+			complete(&mas->xfer_done);
 			mas->cur_xfer = NULL;
 		}
 	}
@@ -1057,11 +1253,14 @@ static irqreturn_t geni_spi_isr(int irq, void *data)
 
 static int spi_geni_target_abort(struct spi_controller *spi)
 {
+	struct spi_geni_master *mas = spi_controller_get_devdata(spi);
+
 	if (!spi->cur_msg)
 		return 0;
 
+	spi->cur_msg->status = -ECANCELED;
 	handle_se_timeout(spi);
-	spi_finalize_current_transfer(spi);
+	complete(&mas->xfer_done);
 
 	return 0;
 }
@@ -1116,8 +1315,9 @@ static int spi_geni_probe(struct platform_device *pdev)
 	spi->num_chipselect = 4;
 	spi->max_speed_hz = 50000000;
 	spi->max_dma_len = 0xffff0; /* 24 bits for tx/rx dma length */
+	spi->setup = spi_geni_setup;
 	spi->prepare_message = spi_geni_prepare_message;
-	spi->transfer_one = spi_geni_transfer_one;
+	spi->transfer_one_message = spi_geni_transfer_one_message;
 	spi->can_dma = geni_can_dma;
 	spi->dma_map_dev = dev->parent;
 	spi->auto_runtime_pm = true;
@@ -1129,6 +1329,7 @@ static int spi_geni_probe(struct platform_device *pdev)
 	init_completion(&mas->abort_done);
 	init_completion(&mas->tx_reset_done);
 	init_completion(&mas->rx_reset_done);
+	init_completion(&mas->xfer_done);
 	spin_lock_init(&mas->lock);
 
 	if (spi->target)

-- 
2.34.1

