Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522580;
	b=21yETMD6xqbu/opOC/N+VLXSw4eILnNCCRiNZ1u68DOab2l6kbZLJG0PHBbbGTzo43xs
	 5X7sV9WBXtqHqWvgT1Cb2SnX8pdskQV2udO4/BuzAxYWIRYlGQiAghMnwD6sdClfwDzgt
	 nlX/STg+0vzE0H4WM73hrJqxC2OxVKM8h1cf52tjeODy15GJ/DJtjJgzuOXc9FamzVDXa
	 Zb1Ya+2qGps5JTmHZvaaOLb/OcFHL3wPSjn1EjFZtxiCuSm+x5FzymYgqto6PQIyANhCB
	 AeQSzfTr+IDHukpY8uXPnv5Y5dZEU5r7mbNlA7y+f1zn1BK3Ohy9Iuqfoe450ecif5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522580;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=ZsGGYXWDuEAPZyeN8P880JLDy4GjUNE8fC94ZgoIpmM=;
	b=lJPKQy4B+3bDvaLHUVr2Wbpu7p9fGwuIAL/Bn1lPVjHqFITTkAGOO/FFopMMdJdpBe6i
	 DqdCOGWEjKggt3h3GtWMSNr9auutD9LRhOwU9M1YiRqti204HjDZ9NVFInd9Oli+1kS0E
	 Cr2/JbVlK5WdIG6JZIZ6ebja0Qtoai7oIFdAJ7AaLknM+sCNxrBZe6JhBWXD6Wz/qclG6
	 fY6FpxJfnvbeub0rHEMGZdYCazHUAsA3kpSLyghzEwhjzMhCz7x1cMFefHG6gkx83WlnW
	 3Gvt17QzqH0i3ALWAKRxj5TQnDexUoKRdF9dIJzxNzHT6TRIHLuxmF/J9E+rMhd5leg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DLywCx7V;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="HTo/7HJA";
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60602606A326
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 12:16:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60602606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DLywCx7V;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HTo/7HJA
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOAuPas636820
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 12:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZsGGYXWDuEAPZyeN8P880JLDy4GjUNE8fC94ZgoIpmM=; b=DLywCx7VIF2etErr
	6/pg/2IJDYM2z4mJ0hQ4hcgCsPlCa3TtUijIegMrSptOT4gF1l0Yg+lTcfJ+DuXg
	uQuADbfcHe3sbS6B32qwvvNNOpe1IuXxrYe796vilRKuGD1MAAZ8TDr3gP/grFIx
	NnQp2Olb/saku5yjsaWCP3cWtAvbzStHGk/I/DZc1/RyGjbnVhoGqIM8KbN8YVg+
	biDZSlGGtW4FTyXbNj/gG+GurOMyDS5lTYQeOL/PhLxJERv5fACAzOBs1RW/iH68
	Vh61/I1CQ+VdiDRYSMFhd6TXk/ei5DyDYpOFAbTWUBsW4WIp/s0R12+AIxtGG9Vc
	HeL4Ug==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j54rphm9u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 12:16:19 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-8b32efd7ec4so4678833b3a.3
        for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 04:16:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795522578; x=1796127378; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZsGGYXWDuEAPZyeN8P880JLDy4GjUNE8fC94ZgoIpmM=;
        b=HTo/7HJAEFaRVK5Wvgiol6t7ZENfcCUcfL3F+CIFFqe8/dHFqUqxwYOGMotOn5SL3K
         /LS8eKx9Zz6P2O4oogUu5pGK7imz4XUc8F9J7wcghHUohuDysurE+uXUzP68kMiRlxJq
         wu/ut8eiIXbbzNn9d+QO85S/vstmFZMGS0CvuPQkLhe2Q4z0TOhnQPQ3gM1vqDMqLULO
         hq21wWptutn5NxBxZgRHe80xlEHhDmlMSC2jR+FyP15gs452n6XFWV7iA6fTYrVL9cB4
         bf946A7QfzYgTva7jjAoYjQpQAa7fhfi5TWv55gZFVSHmNldDPz0jtIW2epoxE9wbwot
         YDsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522578; x=1796127378;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZsGGYXWDuEAPZyeN8P880JLDy4GjUNE8fC94ZgoIpmM=;
        b=KN3dv+p6FHGrddhXZ1zzGsXFVPyFt4WHlgdsGS3uPlFDmkc3pqYLtQ8BI+ugBrdNFr
         MycptI4NUYrTOj3oFnHCZ9WMFiw4aJaOn8H21pwA+ktvwtedybhbMQ9ILhVoCQdCH2Qj
         2trS1pXb3Qkd3cL3bFSHxa4te67a+N1TAAABnQG72i6sdSo4qFM/7eliVDOhZPTJeQ+O
         jmML1UMe2jZqGRDOV1i+apt22BNmaskKdJtFwz2zdOrZ+BIj5whlZfTWNiomFhZ4yyOT
         xrUh+5Ox2bK+QzJnJAVDPj6l8dkIONLoIH+r3SAkrjjksMfHollTyGXBwUrQMTwzOAOg
         MiZg==
X-Forwarded-Encrypted: i=1; AL+hErHNS6zjSpQH2lzilbyIvA1Gl+zO6aVR/Nqh0tN51bzTJLnrf1tySTRFq/6eU1vc5J228H0N8jPzHrE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hBbelG1eUMsO66CxoBWVRoTs+u8R0UgnmFS4kqKPojnjx0TTV
	BB5MBVy4Mj/icSejYPKi6UEmaCCgmsrhth4IancoK5F/JVWTIjU98rRNYwJF/RYUaPs2jNwJHQ2
	A7uNgBPj9Ssl4gYKUtvekt05U0ratpgo4vMEgBnzYZMOstFplY8D1DVmHhy6RH7A=
X-Gm-Gg: AZFdTZfm4+/hL+NIsdrnT/8nfKjeMlLs5kdiyXi6m1VRd0zTfnOOW8/KbKWf2NRrGQJ
	Ww6wzYLl1kHoR1zxwFbfP4jCn01Nr2cB3kdPmt6QVsAdgvTeodcpIwi/mMBbVvApzM9an1lk+zj
	w+6UQKTKiglUd7l6KGbfRFDG1sA5fE+AhmNP7EgHBnaFi4XkL6c/SVef7uRvAQgdbrkdfUqmE96
	aSp5fVc6a3sitJulahN2H0ngTCC3o3jRQgHZppIbY5UDvqRVkNYhVLPGOrWAK8Xf1P/VwN/I7q8
	pNVcx7C5c3/U22i/ydkIuvT04vD67Fgqb5vS1Kjd/Im1Wnh+kstAOsRdPNflHG7fFXyRp5tWAKR
	ukY702X3vWV8IfFzTJWJ+Z2WSd6dxWCM3hhN46V/dCwwuqUKQi+zNe6l2pjjofJYdeUeRVv5DjE
	Ap57AIwpw2
X-Received: by 2002:a05:6a00:44c7:b0:886:5938:cdd4 with SMTP id d2e1a72fcca58-8c87baccf21mr12944496b3a.19.1795522578376;
        Tue, 24 Nov 2026 04:16:18 -0800 (PST)
X-Received: by 2002:a05:6a00:44c7:b0:886:5938:cdd4 with SMTP id d2e1a72fcca58-8c87baccf21mr12944474b3a.19.1795522577871;
        Tue, 24 Nov 2026 04:16:17 -0800 (PST)
Received: from hu-jseerapu-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c8706844a0sm7245572b3a.1.2026.11.24.04.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:16:17 -0800 (PST)
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 17:45:23 +0530
Subject: [PATCH v2 2/6] dt-bindings: dma: qcom-gpi: Add QSPI protocol
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
Message-Id: <20261124-qspi_qup_upstream-v2-2-cd69894107c8@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795522563; l=1017;
 i=jyothi.seerapu@oss.qualcomm.com; h=from:subject:message-id;
 bh=EEx2Qf9ht9RV2ShxIZ5R8hgTYqT6216fgvKWmMYEzDw=;
 b=MgqTwicYRlvJgrM+Ti/uoSQignoLBWDzOxIHDD22f7YmBLV3491zS+retoQpIsYP5p+DKHrhf
 mKE2Qd6sMgCCVjhNsFOTSJZT/LrZ8iIqqNAz5nUPLgwvYkHYqWm4gyL
X-Developer-Key: i=jyothi.seerapu@oss.qualcomm.com; a=ed25519;
 pk=9vafyYsia0OnBKWSEwhmWe3hPVQfI2T1xOs5dPaFvEo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0NyBTYWx0ZWRfX67j9NLmoGEz8
 MiSJZV9GPtEG1hOHVLCtGVcmfbx6YrMpyeX6oJ5dQo92V6hobTAp3D1lQ0LcjdG1AlfTXfW1Yrs
 f8bvwaDo90iqePJp80AIiUrRg6rlvasQT241wx6C3r7TVfAeQGst/tW9NiCW7slyXwhXEbhdYyL
 D709X7+fvndE5FGHIcjzPW7LuRi+sPxy9VtymPaFCQS29pMdiEf+f0aZ2aGmEs5Zx24y7QS1TiR
 JxN6UFGaqz9JmipCPkSa8KuhmHwv3Pm9DFw2Wh+PJxvsgZsVp3xni6c2ec4qHbyOx9CYH1VAE68
 fxQG/5ychzMt4283C4UXExh6cJto/nuEnFdHLk6IXpZ/1G1iiXqDATCOoxRZ/HmnjJd97g2zB+1
 CL9O7/Lc8YLAPVhRgRWSG9T9vuU4uOMUC/99J1kIGgiVYYmE8U3onDqXxYIgFSqIAQBbzzch1JL
 boxs/cZF2+SJznyj15A==
X-Proofpoint-GUID: BE6SPV-emNhtoPMwKobdTAkicFpO2LW1
X-Authority-Analysis: v=2.4 cv=MvbHeGae c=1 sm=1 tr=0 ts=6b058013 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=XDCUMzA_0XyrBmuHy_cA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0NyBTYWx0ZWRfX2lwNdAGb7JKe
 6CKMl+X+QjtP5yf2U4NeX9F7N9SbjDDdgap04/8WDkwpGFuQ/tl2UxTdV8f6ME6Zpyct27DgZUb
 6bSCNpGTSuiNzb5U8lzzNLPftxygkXA=
X-Proofpoint-ORIG-GUID: BE6SPV-emNhtoPMwKobdTAkicFpO2LW1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240047

Qualcomm GPI DMA supports transfers for peripherals using serial
protocols such as SPI and I2C. The third argument of each DMA specifier
identifies the client protocol so the GPI driver can configure the
channel and generate the appropriate transfer descriptors.

Add QCOM_GPI_QSPI with value 6 to identify QSPI TX and RX channels in
the dmas property. This is a DT client identifier, independent of the
hardware protocol encoding used by the GPI driver.

Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
---
 include/dt-bindings/dma/qcom-gpi.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/dma/qcom-gpi.h b/include/dt-bindings/dma/qcom-gpi.h
index ebda2a37f52a..50fdfc5fd9a5 100644
--- a/include/dt-bindings/dma/qcom-gpi.h
+++ b/include/dt-bindings/dma/qcom-gpi.h
@@ -7,5 +7,6 @@
 #define QCOM_GPI_SPI		1
 #define QCOM_GPI_UART		2
 #define QCOM_GPI_I2C		3
+#define QCOM_GPI_QSPI		6
 
 #endif /* __DT_BINDINGS_DMA_QCOM_GPI_H__ */

-- 
2.34.1

