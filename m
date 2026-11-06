Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977339;
	b=GOSNUsTAKEY/SUtOcz69uvfXUiaQmFFHrImBx0uB0K+YrA9flbtFD50Q0A43gSumv0C7
	 C37FI7MWQTI6R7Pcq/358Nwc9+yTPW4ZbXAWsnz7jXIalWjfb1YNpztK7vqgOJfXXsoW3
	 TagKwF5UCatbq5PVMqK2xHQs/ofxTZy4Q/2yCq1znJ3GgNkrng3DSezGzyRLbHcGhXVED
	 ystuqQ0gP6YpbDok7OPdDvuOQciAck4inrOXq5BiixlYIQcrLRqQOlTc3X1V1N4SeHEei
	 8pj0dbXzbbmi93Tx6XyVaYSS4NpIYbNg3/PSN/xU7w3BMGH4TKsVv58tHllGKlTrbig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977339;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=fYU64DUDZCc6GipuvyAmFtgAHJCx6TUF0Ih1JIPFacc=;
	b=wofSdWKMGxppHoNJo7sK9ywo64jAdl3iJIuli4eCHFonb4XZK3zMH6DtWSbwGvEGXb9W
	 nTV8xZy/NV0TOPdBbgFoTabSXxVb45v4QeIlbK79A3VfEO7BCF1Sp0YHc6XqL1RWspvBO
	 7tZAi/uD/p5oTO4EGY77hTeuZHhBGcE0rjbCKZH2mpSDo2VX251lnYhUNCVZhmFagEe89
	 qZ0R8q67GJAvBVXLScHqZ2D8MuPemO/qELBpSyKYDaRc3etazPjlICbXssWzBMGFoowre
	 Bwbe7fb/nT9SgqTFPamMEZhAMKDo8FuN3WkPPOQHpXVmn+/W5OOgSdNQk3v+IqpwtUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SDZaldbO;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=a29Yh8cU;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE4F606D821
	for <linux-spi@vger.kernel.org>; Fri,  6 Nov 2026 15:02:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DE4F606D821
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SDZaldbO;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=a29Yh8cU
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6ExxMV3722899
	for <linux-spi@vger.kernel.org>; Fri, 6 Nov 2026 15:02:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fYU64DUDZCc6GipuvyAmFtgAHJCx6TUF0Ih1JIPFacc=; b=SDZaldbOmYwG9NEj
	hM8bmVDNFqSSe4M/Qe0rvTogB1uxI7CoLNtl0nHoSNhO2/lXxgR+NS0kohM4SeP8
	ZTTyMogd29tIx+VsK0Y1peZr5KeQ6zAeYxWBbQAtW03cSaGVqqyvmRGZry/Zsu14
	JD3u0XniyklpslbdRRBws8fC8HN9nqxSSklCOp3yYpDmGN4slK2p2vbVQtro6Y0f
	FjvWudy3MDjLg3a+tg8qpvx7L3H1LeauMZwclexb0vmVD1/IxAJ86XX+lGqz2rFT
	NwHX5qwFvmeb2jGM+xUNldas+5nAfCDNtusDBYFKxVxxV8yVeKO6pxMHcBuTaFcV
	ocpQuw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9k7ns-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 06 Nov 2026 15:02:18 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3abb4c24125so660737a91.3
        for <linux-spi@vger.kernel.org>; Fri, 06 Nov 2026 07:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793977327; x=1794582127; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fYU64DUDZCc6GipuvyAmFtgAHJCx6TUF0Ih1JIPFacc=;
        b=a29Yh8cU5DH5boyQ5JnEXfDmNLDEwuoLwWF7eZfcVoNKtcwFhIui1WhgUCp0pY/BY6
         QjoMBBTwvUa/Q6u8p+MxNAG903gsnOKapgxhwvV7zjD/HmD43n3CNmkmUgYt2nsPtc55
         /EIqORXvyUOWyhDfsCR1KSGFcrCfUca6mVxM026oy94A8gNZ1x07omgqwzmnS+zsNtxU
         GfwJ9V9HZzCl5AREfhFaIlSFZGRUXT68fVhYNFd51N3FW0ZX3jT+XZ+8N6ua49t0W+9b
         ZLYtW8PmjTSQUjypRFyEhoOlbWU0emeQmobKbbvwPaZDT91Dy2ggIjfTPMsHJ49wLrgd
         L3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793977327; x=1794582127;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fYU64DUDZCc6GipuvyAmFtgAHJCx6TUF0Ih1JIPFacc=;
        b=obL6HeGFvPnJnE7WnP+8aBboE3lKyk4di1rO5FhxUKEvWK0WV4UM7b/NYs1w4kZFxv
         tw499S2ykx4GBCjm3NNGj4q/Ls0NQbz7UfK6otpGbNK/EmBfJOvtQAT/JfWJLuw0fu0W
         KpjmH8tUMTkVXAH4VRDL0pUYxEIRYEKZW+HfIbjHmVsohE8YzKZvv0xYjQP72gSlZn/t
         jt2l3zvDimID8YOo0BCUVwXpy6/dWSL6OBemCy5LdlX3CB6mNUrRjIL/O7dOCc9VsAQ+
         ByaMvSEqs3JKRHLrd1ZPi7JW/Vqfvet1NnfJHiccBLM83Pb0xibpp+dClms+Z7LWoboE
         /Wgw==
X-Forwarded-Encrypted: i=1; AL+hErHC8eNIsQYjvdT+itIQIa8wiW1ne9P6wRnr/2YwB5Xl0Q5zaNqUKcW/6DoSicW5AKJ4l4o1LUFollw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8kS30EL1InThR1qyU+f1xw5LH0rscdrO7RaF5WGX0rgZ1UdXHq
	sC92PA0YAN8PhBKzDb/bf+c2g0goFsCOMvsKI4y/kSH2JO2FJMvEMNAZdsfZGO0PnwXArnwHoZn
	P/cGw7N2QWaxXf+P4xfdeLDp7RBEtmxkodDUyjEE2DMxy+s9+OAhGZXGHvEnA0mM=
X-Gm-Gg: AYBFou13ppXDKviSidsFpW1hCgrVDbkWf3ggN2CgxAD1pagfWq96VRoQ7qI0WfvD+AQ
	n2Wm/Ky5jGC62sJwejPMAxJ0tG1RUyTzO3ia7AAznxY7JjpoJfhNVd4IFTOWDH27vFBVQ2d/9/l
	IvQNxwJjhkQCBjTUdbDHhAHrCB8beF9/en7QbY7v+nRd5ZwkWbBytJ96qIP2be6u8x57IEMZgQo
	UBhcA2dfikcYvmafyVJF3fsyAS4LfKms0WXPJfp86TAm1plVDRboRN7TXh2xmM3iFqffavdZZ2i
	srdODEzYc+gEWv6m9MrCQa4KQFE4q3qYwiNDaTiqg6MCcB96fde0tiNyvEKKUAJws28FLuPeUTm
	DnByW+lj0J03akkHaXno1Wl3l5tYT9dHLOjOkD9EmZNCCbk5acnNoYwAxB4MzYrdZ9/Xi3ezCMB
	T/raGv0ZQm
X-Received: by 2002:a17:90b:54cb:b0:3b0:d070:3c4b with SMTP id 98e67ed59e1d1-3b0db6ffb8dmr2344795a91.33.1793977327099;
        Fri, 06 Nov 2026 07:02:07 -0800 (PST)
X-Received: by 2002:a17:90b:54cb:b0:3b0:d070:3c4b with SMTP id 98e67ed59e1d1-3b0db6ffb8dmr2344749a91.33.1793977326247;
        Fri, 06 Nov 2026 07:02:06 -0800 (PST)
Received: from hu-jseerapu-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc1bc1e6sm100032a91.0.2026.11.06.07.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:02:05 -0800 (PST)
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 20:31:20 +0530
Subject: [PATCH 2/6] dt-bindings: dma: qcom-gpi: Add QSPI protocol
 identifier
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
Message-Id: <20261106-qspi_upstream_series-v1-2-21f43042dd60@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793977309; l=856;
 i=jyothi.seerapu@oss.qualcomm.com; h=from:subject:message-id;
 bh=iJecahOznZMfSn1ZECEomSzUGcetmfIMkxUzE7I2o4s=;
 b=B5SY3JrN4UIDmzeORd0lh9riEKx7+MDEpI/r2Yb04WH6sz03eNKv/Py/s1LJ3p9cSHMUByaFT
 yK4pOmm/NlPAouJHsvCk8M/r3gq3qJbwpGP+ClC2qE9librYyE2HFba
X-Developer-Key: i=jyothi.seerapu@oss.qualcomm.com; a=ed25519;
 pk=9vafyYsia0OnBKWSEwhmWe3hPVQfI2T1xOs5dPaFvEo=
X-Proofpoint-ORIG-GUID: yO5mJYKDAVFxCPkj4DX9V65reKYEGKb9
X-Proofpoint-GUID: yO5mJYKDAVFxCPkj4DX9V65reKYEGKb9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1OSBTYWx0ZWRfXxsVVbTrHME4V
 UhXI7kpZTK4N50CQlUBy3TPeRw+fIv3zCBm8BBBRf+RFhgJyA+YJ1u7eZefdDMvPKE2XyNJ+fp2
 MktHzmyRhBHohSDW2kOsmAjmVfoAGug=
X-Authority-Analysis: v=2.4 cv=XvNvqlF9 c=1 sm=1 tr=0 ts=6aedebfa cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=htPuCn9dtfDBuPHNxMEA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1OSBTYWx0ZWRfX6O7lYc1qGe79
 dje95sIACWQD+fStfNoVoeC/oEODZtUU4S6TSf+mc7PpP90rWcX7pvp41DoRJMrWQlh0/hze+F3
 6NRvCOAwmWuE4DWmfI96DQRrEloAZ3/sD3jfeCOJ+EH/EqvHvvCFEZr8VzFQ3XgNu9rAWjAM5+a
 tieTsbuYxq/v7+mI/Jmsb0vKiaVutNMWCvuxu1FVHqV24sQp+IVh+jWq5Z7KictzVBiX9HJcNf6
 8WlhqCLUAmkH5IR9+kkTXeRgul+zm7WXpX4T8XiX7vHxlTV9M7Qn3y2LKCa2vW2dM+6uR0O2w9w
 +EhoBqA1bXXxO87Knw7ukXctKizGZ00xk57AKLJIxAnw3rTB4S3eXSDl4LU92hdWm8dZVzUHO5P
 FaVOnIy/XuToMXvKZIkoDQJ4ZLU4byBNyB0PvFYp/zUSnWW5uK1najxusGu8qf4Y6jEwu9Oc5u8
 R8kezRI25Pbngnkm1tQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 adultscore=0 malwarescore=0 impostorscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060059

Add QCOM_GPI_QSPI to identify QSPI (Quad SPI) channels in GPI DMA
specifiers. Its value, 9, matches the GENI serial engine firmware
protocol ID for QSPI.

This lets a QSPI controller reference its TX and RX GPI DMA channels
through the dmas property, using the existing channel specifier format.

Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
---
 include/dt-bindings/dma/qcom-gpi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/dma/qcom-gpi.h b/include/dt-bindings/dma/qcom-gpi.h
index ebda2a37f52a..68fc1414af55 100644
--- a/include/dt-bindings/dma/qcom-gpi.h
+++ b/include/dt-bindings/dma/qcom-gpi.h
@@ -7,5 +7,6 @@
 #define QCOM_GPI_SPI		1
 #define QCOM_GPI_UART		2
 #define QCOM_GPI_I2C		3
+#define QCOM_GPI_QSPI		9
 
 #endif /* __DT_BINDINGS_DMA_QCOM_GPI_H__ */

-- 
2.34.1

