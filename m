Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977335;
	b=SMlXTW23Ha8wrjIdn+JPyP7n8cQrErgEtK32Kd5hPLeWHdMPk6v6x6RpVpa0zCFpaZa7
	 vFQ+wWSk1PLV+8Yl2tX0x/T6Tk6PXpWd4DyjJIvyJuxwGQubmOx+mMs/jfFbyhyp3zEuD
	 TzeqjmRR3iPSkxjQzmjiYiSwiN8bSsOUtR8m7UqdH1ABSQuLDtMd/tqvPuF+6Rm0paUsN
	 c0dV3UhJiBOmv5EpNkzehTt73qUfQ4FOuXOuL1LP8TVZzw+1dyQXDc/Q65SdxOosFoN+V
	 aahH/AM+ow+SLmnChemGi7KJvAt55Fj0j59NOiQSxVHmHjvh3ReFDoVBnrYCmftqyyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977335;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=x3QLozfCyQOXqamzqmwUwQlpNil8HpltlRmIUwTug6E=;
	b=e4Bq0/bxbIka95DrU9YBLQdwabF5OFOOHAYClUAl3Q02Bo9aRGkxuSqZcVxcVDV018eN
	 Zro/FInaUNwkdtaOt59sZZmccydg1g2uM45mgiTRuafmO8SzsCHPtyeCwy9B10fW5KI7C
	 0fJ6xSeljg8p6cLm5uVhDBbV3/nU7dfLKgTBAXB6HhuDYwI477XJLlNHfb9LjOGvEvid9
	 1kqgm6UUhw88ElLjG2VAR/hxjlWHXEVpLx0eazEiIbTp9uI5pVqX+VEJiS1STyVmMMuYs
	 dSmZBU+I1ZphaGFRo2WW88LWx29HGCVZoB31jsOGc+cBeGrS9CMGe6NUk4hNCJ0M+vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xbh7m8ur;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dFRFfR97;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EB5606D804
	for <linux-spi@vger.kernel.org>; Fri,  6 Nov 2026 15:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78EB5606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Xbh7m8ur;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=dFRFfR97
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F061R1122030
	for <linux-spi@vger.kernel.org>; Fri, 6 Nov 2026 15:02:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	x3QLozfCyQOXqamzqmwUwQlpNil8HpltlRmIUwTug6E=; b=Xbh7m8urGrHgjcfH
	C9Jj0JDKyF6sex7I0ecYyn8uOXYx+Mq+2o+q4OVZsIrRVYm8lvV+6wjoFJ8ZO0Hw
	gnGiNk4ZEi/a1e04is8cN7Wd5Dq7bSLwQXAebb3nxwvttQ8QGHPeJxH7uKPdolIL
	j75jc2Y+SxwndaEORzmN6/SDKfTvbIf9cXwHSqTpZILgpvqnrL6bOFD6xRBK1YjL
	ZJtMTjD6SPQhm5L7U5qKKpnW2qn/gGNOFk1t+CYjPRvvn4N3XMDlwu5BkoTZmY+7
	RtcHSR9+2givifm7yIsvFpecrhf/4J0GOmDpOVnlCeN5OavnN/fzVN+XSII0GZix
	Hmhsug==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hs3p9u8y5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 06 Nov 2026 15:02:13 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3adc5b185bfso787617a91.3
        for <linux-spi@vger.kernel.org>; Fri, 06 Nov 2026 07:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793977332; x=1794582132; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x3QLozfCyQOXqamzqmwUwQlpNil8HpltlRmIUwTug6E=;
        b=dFRFfR97PwXagJjUT5minAkmriJNBERX/PaJgkLfAO7mE1R705aEVEog45g9SmGiFg
         C0/b7LSBhV1YDpRPhqyyd8z2oE4oyb8wbQYQ8JtRaUCKMDrDokYdrMIdjgEg0FfDDmLR
         qZdEpTSK5fqxWKbEW1/sTB62mhN1TWALuRqHHJOSNe/zq+8fS8UdN0rJCvHQCVFnCq/G
         HVjPw6YNEOD/nKFz9ROU68oqdmYAvzLFRAfeDXSxf+eZ7fq9lIIvg/m1cUK1cDpw6ZFu
         xWqLhoYidSQJrBWeFojkWXUOgryez6oJdXP/U9OUSvmMvCh7bLsw4cAQXc6zvxsS/JfV
         Pd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793977332; x=1794582132;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x3QLozfCyQOXqamzqmwUwQlpNil8HpltlRmIUwTug6E=;
        b=faQ7iXmZo4mpblsM4iInmWhuRramt1D673JRH+3UJxO/xynwUEtTt/iuAGrEtGJ3p0
         6TtcKPBUP/vA48OxQf4xdgnAn2XmAjReqDmjTwQ0qtj2CSgCtEwZO+p2R2yjDQcSbf6E
         6sjbZcYNM+QGaPIo0LbglaYd2xN/JFTcKuCcyXhOm4k7OZQmZ+IJbNDJEfWsg7ZF6Z/o
         dDLqoOBKbF02zUPEzJTP0Odld/FgA/Gs9C86wuCYnEPDjmAyt01vTVb71JK9RiMXlhcc
         zCQePphiWw64OFATjtOVxf8r4l6HuHvi8u4+kB/q6qs3Ce1HycvOTc7M/7dJBnLOxGUN
         VN3A==
X-Forwarded-Encrypted: i=1; AL+hErG0cLpODVPUqNA4nuQjp43bUuxudI5NMEpTWnlyTxAponq9oX2feavIqr4er7qPIYEjlxwKmht75tE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+MT5PhQxF0cH8FQIlRIERtMyICrtO8j1beVoS2yi7ullRAMmNU
	ZasgieKnLmKdlf1SLInQNsvdhYWRrqshNDjspYVkoXv4fMDvGpJ2NuOlCgceiCXEBllSnKxoq16
	ueKThHufQPSxwjXl+KJ8W19z1gzrrmOOs1hospcpIICxu6i46Duvqb1S59sFuvBo=
X-Gm-Gg: AYBFou1hlDdnD7kweDWNI0wV1+j9rY6EWfZ6Sc3czCsuUeD6SMTkSX/skJCs4RPcaQM
	1sXWDHRD9queoCB1/TgkEmm/kTnSdO1PLqHhT2RwgRKAA61V/rx0JG9gyDde+wr/He2iUOu4Hig
	z21JjrX0y+5C4BWgvTWvh5YWOOjHeHMGZZen/NTN0+mFGDjGxk89rileXVitEV9x6bEpGbNW3We
	Sx3yn9D8DIlYd5FSSG69xLYwBGYMJxaWet8ifhbu+KpJJRsgMMTQdxmGh2uNymU4OoDAQQJeq/o
	91pvPsVbILh8NLZiX1YZTO3hafc+K3tM4FxkOIwdBZp+XEjbBjqVesWi/7g6tBJCmgB33Yi50Pa
	hnxxl+FlSHLppVYwNBQV+4Ym6zmLoTDcluu9O543pP6LSitPi5/PpUr3qCh8HD1+Euj3urvzhsS
	MROd8rUnK7
X-Received: by 2002:a17:90b:580b:b0:3a4:b418:94ce with SMTP id 98e67ed59e1d1-3b0db5f6fc2mr2667448a91.1.1793977332432;
        Fri, 06 Nov 2026 07:02:12 -0800 (PST)
X-Received: by 2002:a17:90b:580b:b0:3a4:b418:94ce with SMTP id 98e67ed59e1d1-3b0db5f6fc2mr2667408a91.1.1793977331926;
        Fri, 06 Nov 2026 07:02:11 -0800 (PST)
Received: from hu-jseerapu-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0fc1bc1e6sm100032a91.0.2026.11.06.07.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:02:11 -0800 (PST)
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Date: Fri, 06 Nov 2026 20:31:21 +0530
Subject: [PATCH 3/6] dt-bindings: spi: qcom,spi-geni-qcom: Document QSPI
 support
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
Message-Id: <20261106-qspi_upstream_series-v1-3-21f43042dd60@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793977309; l=1658;
 i=jyothi.seerapu@oss.qualcomm.com; h=from:subject:message-id;
 bh=C58xMketS0t+z7bSIzaXbo2bSN49O8Fa6mvoWIRxlbM=;
 b=f9X8SstJaOTh1ZHqgsSboJwCtiukraMhFpa6kFNyRXhI0Nml5kv+MfcVpiY6beP6mpMSe9ePB
 g5MiXbB63ooDtkpJneWzUOrCzhZm/9MSz6TsCXjt2M5nAG0m68MBcuW
X-Developer-Key: i=jyothi.seerapu@oss.qualcomm.com; a=ed25519;
 pk=9vafyYsia0OnBKWSEwhmWe3hPVQfI2T1xOs5dPaFvEo=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA1OSBTYWx0ZWRfX2TCf6jupbPN3
 Cy4bo8PHH6H/ZvYLe3UCXIOIu/R399qPztpTdWGa4NuKObyxLMM2A3MLUkRZ3NfofsvY3Ejl+8h
 XC5Kbg1l+zVmOit5uZweBKwtg/6qx/s=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA1OSBTYWx0ZWRfX9HLgsfZXcaid
 nW8tkS/loiHBLnD9nD11wDHzajBBAlbz/hN1LYwje9LnJeF0DGga/VE8OQINR2Lx1S0WKXR+Oey
 DyfAkLmq4TUyLix2QR6qS35879C3lWxtdOEDj19Cx/UzqsT0c9pRVmL232LNQOzNdoUH+5AtYFV
 OKb4BvuVUHJjCXCHhO89UuEKAXe7S+xPQJ9PmGWUhHJYeCt90ibwKutA8KwBWmlDqQfFbXi9cCh
 XRI7iohy8BEJl6LC+j2IWBfxM6aqytzfb0u1SwXWuyjBKrAE4wctYgKhI+EEctDYg21PbKA+1CB
 gZWl+6VlLP1QESnqDI6KYasPuxOyMtFIgS5sKO1Ehw5vgnqN1rhfzW8ncl6gwXWpG+EU8XmTxbH
 nXh0z3P1hXV7k2fxNlv8mwJAHvW3DC3BYXrkzlzTFrUX4ZI7CEOpedfmmRVUQ9xLboBrxpzGLNO
 i2ZlOkkpZswE75uS+YQ==
X-Proofpoint-ORIG-GUID: hCZjjRS8oh9klN7oAjSzlQ4xj8veoRUA
X-Authority-Analysis: v=2.4 cv=f6Pdl+yM c=1 sm=1 tr=0 ts=6aedebf5 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=KUikZgbwDMKjgD0mul4A:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: hCZjjRS8oh9klN7oAjSzlQ4xj8veoRUA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060059

Add the "qcom,geni-qspi" compatible to identify GENI Serial Engine
instances configured for QSPI operation.

The compatible also allows the driver to select the appropriate protocol
firmware when the Serial Engine is unconfigured (GENI_SE_INVALID_PROTO),
distinguishing between SPI and QSPI firmware.

Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
index edf399681d7a..e568b67d077e 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
@@ -19,6 +19,10 @@ description:
   SPI in master mode supports up to 50MHz, up to four chip selects,
   programmable data path from 4 bits to 32 bits and numerous protocol variants.
 
+  The "qcom,geni-qspi" compatible string identifies GENI serial engine
+  instances configured for QSPI operation. QSPI supports transfers over
+  multiple data lines for higher throughput than standard SPI.
+
   SPI Controller nodes must be child of GENI based Qualcomm Universal
   Peripharal. Please refer GENI based QUP wrapper controller node bindings
   described in Documentation/devicetree/bindings/soc/qcom/qcom,geni-se.yaml.
@@ -29,7 +33,9 @@ allOf:
 
 properties:
   compatible:
-    const: qcom,geni-spi
+    enum:
+      - qcom,geni-spi
+      - qcom,geni-qspi
 
   clocks:
     maxItems: 1

-- 
2.34.1

