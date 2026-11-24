Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795522586;
	b=5ihftgYZxEjTg9TYAjHSRgiVWNntlYO2Q4zqF5OMSGU+3z+b34+RPBIbpFLgVXKqCMh9
	 XVHHPiOUxbV0/CWSab/PHG9CiqXB7Li/2aqOWuxPR5aT1WrgjT6RGQmoJqeTVSvX9mxjm
	 NMlAo0y+mMvho+tS8A7D/Z3zYidZPLgDmH/Gh6tzhzVOkgjC+v+XyocOaqY7jriUnbdTO
	 KaFnb589CWJelxj0fhthIwFWeAfyT/osAxzI1m+n6wDhePSgpnDao9sLWIMaHjw3GG4E9
	 UNa5KjR600fZjAQOqXW2QEquNRfJN3SDmAy8xa7ATGUOJ1CZfympdpLkn7LEJfp3mxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795522586;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=6MRwCGY3EIkm2Sb+ci3Y/6bF7HgSt7oRZHgHfupwS00=;
	b=cf9C/rJIdebbbACWP70qfFhMGoFOLZbZg3YkHCEHC1QVL2gNWtla49Z93RhGLkmiATh3
	 oueQa/ITbR/se+2yDwJFPzt+9jk2+1YrXTp2Qxgj5jWm0Bexse5D28Bkvsn4Q86shxB2X
	 V0eabsb5Y2jn37pmt5rr9R0spHO5/U+Ma/uxOabaYFcjN+k8RxvIqabmYyk3p6pCi8v/j
	 uyUbjXZmuXro1eZb/SCyuG4k/qy5roUNeRSVC2Q4vsynZFox+miDyocAoRtjHO3N4MwL1
	 fZoPOezWo8FND8OPNxHYnV2RmlaS+W7vVCN5hYg5meab8GhmSgpy+sPse6xasEc/w9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lPhv7E3Y;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ijeEuiq7;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78813606A331
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 12:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78813606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lPhv7E3Y;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=ijeEuiq7
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOAuZND3299618
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 12:16:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6MRwCGY3EIkm2Sb+ci3Y/6bF7HgSt7oRZHgHfupwS00=; b=lPhv7E3YmnPEk8qa
	4smohmy9wBKRAbB/cU7qwdF+X8P3rc1IpypwQb5GcjmXC8fKu1pfAgTKTP83T59H
	exAfVmLqi9cQuHeO97KcUoO8FDpAhWcc8aLj5BQMeA61DPwbDWdyeL9kDtSTDV7C
	yjBwrY774PC559i8tUM2JiSrBWpMTp7+xat+tO06EGVatTfpZwkTHsxdiPkXqqI9
	1ZrZQIP7K7coRt/N7PwIYg9tuthEOB+RcpMQYDCQRL5+Jvtx2G+RmAvENioEOkEL
	QasJoTCmpJfLJCIU7cOUAwh6ofd+kai46p6U36zMnmKlNEAqVuYQaGSDWJ2cCVe2
	qgrdUg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4yy12nnt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 12:16:24 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-89fb6a45c48so3414629b3a.1
        for <linux-spi@vger.kernel.org>; Tue, 24 Nov 2026 04:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795522583; x=1796127383; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6MRwCGY3EIkm2Sb+ci3Y/6bF7HgSt7oRZHgHfupwS00=;
        b=ijeEuiq7jbW3AojaiCBI7WVrxVWCC7Xyz+2V61JvkvolM3at5yfTgQMCW8bPfmsnLt
         ZEhhbLDlzpW44Xihe5whkqT9nnCDWH4wzaKEAf562ropQtdKBba5DVWoBBA8YycAciBk
         S6gI5Hm/ENHXVl7jT4Y9HSVF8OtQ7wWPPQme+cBZ8y+u2XhdQYmSJ1+J6d6VT8eRpgyh
         dcoFVSCiw5nwCnabxVFhdaY2vFlDA/KYeGAMYUVpJteqCKzRSX78r+lj1xu8zhWDyx2J
         KYVVxtiMygwwW6SjxGWpwR0hJ8iX8CdPHNBYFOxi6sJIdL3lSXOuCK0eZ3sxxoVAP7Np
         oh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795522583; x=1796127383;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6MRwCGY3EIkm2Sb+ci3Y/6bF7HgSt7oRZHgHfupwS00=;
        b=cNTq8T//6pSH+e2Zwp047XjyjJLwP6DTiEIQkUPe85iAwsn7pkD3gjode14iAKgrya
         pYY4ihSiMlhhBnzbag4AE7sVRjMVSbhY6NJBhpoRCAEYjOtEnlNFITCjPks/eIA5zhGy
         R0i7jpHfw0ikxBX96kXxa9MvHg6tkNng/ew0eWrrCXSHCBUWRHht+1OVozlcWiveysqt
         e1lvycLYK5MOc1NucIdDVs7qbr4jp0OKL9ck9d1WGGo0xxqHrG6sOvPmrFOUA6hdYiF8
         FOFodBsCek+2OEygjFtBpARLqzcXJHEZxEcykzx8CSTp2Yy/Cj0nCqMi16eCTxrVFeKb
         wWYg==
X-Forwarded-Encrypted: i=1; AL+hErH4b4JYVCk1MA8gSL54hWIz1TGGD/qDqH/U5vfPEq+Zm/0B9GkksMMCOtPsNoEbIITnqYYwfLmIsI8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+z/4X5vdjLRnn0ujGKksdArMqF5IGDFHfya5On39TObgxY2tl7
	sB/rdfj8/SRWKmrxwtjB9IEpjOqQfWQ8KuOf9+7HaH/SC4kQcek1m4EAkq6zPdeOpQPEg4KTMzZ
	W5g85ixJ8DqjzCkebBODlJlh7nDAZqq2feo8boXN9WIuwyS18NHtoNviMfI59lWk=
X-Gm-Gg: AZFdTZeFvuYu3ND+uCVo5/m9/xEwY+eJbtpPJ29XCzKBpiCykrBZMk4jxFwxSRBjsuw
	+5qBpVTmTygZ8k4KlnOVjb4H4FzQDLYaFuPHuEzTHw8XpHSYTmlak9VPafJSWTxxALZaQeY0NAY
	wYi/rovLSxoNRhqb8EaI2R08rgtIz2/FFtsI32byL0ueIS0dJ1ElVAnZOnc4IlRbNxyCh+t+OBK
	7PL2ZR1BU3QNaIq0Q3sgcexyeH3aUO29iXS89kwo9dHE/vK2mE0IIg3c7vM0hxteTr35+f03N+F
	5y911kVD8H5S1nB4dm4PwrlnSHWC1wCUkN/j6gaXeJlvhdCVWlkxhphGTNP4F78yyCMgBKo9b5E
	iYJsd5sMniRnLtR5316zaBoGn04mWngmi4SuEoqZzlB09ch/0ZbAcFoT+rmpnOIDmTnbDu1MCr+
	3oUkDvGIIc
X-Received: by 2002:a05:6300:8095:b0:3f9:a6b6:e173 with SMTP id adf61e73a8af0-4014d14a577mr12497084637.26.1795522583437;
        Tue, 24 Nov 2026 04:16:23 -0800 (PST)
X-Received: by 2002:a05:6300:8095:b0:3f9:a6b6:e173 with SMTP id adf61e73a8af0-4014d14a577mr12497059637.26.1795522582966;
        Tue, 24 Nov 2026 04:16:22 -0800 (PST)
Received: from hu-jseerapu-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c8706844a0sm7245572b3a.1.2026.11.24.04.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 04:16:22 -0800 (PST)
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 17:45:24 +0530
Subject: [PATCH v2 3/6] dt-bindings: spi: qcom,spi-geni-qcom: Document QSPI
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
Message-Id: <20261124-qspi_qup_upstream-v2-3-cd69894107c8@oss.qualcomm.com>
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
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795522563; l=1598;
 i=jyothi.seerapu@oss.qualcomm.com; h=from:subject:message-id;
 bh=wquPpfro8iDyDqLV7D69xsSCzyvDGmM++tbpNclpPwQ=;
 b=N3l5nqiq+539iw0mq033y0lWszIasIovNOKFVkYaPOZOh6w9Q3p13NNJ3jevhXXmkWjRhaMgq
 J0gD/S2lXt4Ct372gS3D8np8RqR+QN+4Ajgjx2cNhkp2CubyWGRZevz
X-Developer-Key: i=jyothi.seerapu@oss.qualcomm.com; a=ed25519;
 pk=9vafyYsia0OnBKWSEwhmWe3hPVQfI2T1xOs5dPaFvEo=
X-Proofpoint-ORIG-GUID: jye8xabuJ1R_lgS7zmhAwcUEOXWlWPvw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0NyBTYWx0ZWRfXwnThWoptmmS7
 OgLBPEOs0lJwy6bV8bvRu9XnrGBnDeR0JMhJgjwwfa9IKXwxBBcGR33ms7DKDzgefN5wXdYCveD
 +SDCtMVlhlr8j00pfI1t0xUmobYSums=
X-Authority-Analysis: v=2.4 cv=JYspPkKV c=1 sm=1 tr=0 ts=6b058018 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=yrtxUKLFhIMtdVcRTsUA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0NyBTYWx0ZWRfX3tKD5JVhYYW9
 qhV/D2TGLSXABaVvHsKtpic3Av4DddymAnBQ/VL5gEiPIqfscxzci2Z/aTdCNEWG9Q/xE5G1tXN
 S5YiI5/9q2JBe1LMvwkZrvnZG2Q1JKKogcHJDYVekv9nzjBcwidqRZVX0mTlkDsOqbYuYLXi0Fl
 tQNd+AR91mmr1tfjfW2N2efIxt01wGCMCGOTQfTx5RArsm6NSr6633g5Vi4mYESPFKgKWPbzzZQ
 do0UXGudsVyNgFwdyy/ckADSs67pCD14DeGrU4uQigjAENamwh8d7023Z9GgmqonX6M8E9B1qx6
 6st+/G7ZJoqHQU6B5SlPmNZM8EvPGmXN6Gf6JzRH7IeEpO03ETN6DzGIRIni5Y56d2ks5pfxfZ5
 o3aG05WLYU0vt+jP5TLukmt0ctKGxhTwtho39GrA5PcPHcGygFRkbH+/SaNJvUvZ1Pi2AJrJR+B
 WGVeJw1AbTzflv86mHw==
X-Proofpoint-GUID: jye8xabuJ1R_lgS7zmhAwcUEOXWlWPvw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240047

The GENI serial engine supports QSPI transfers using up to four data
lines.

Add the qcom,geni-qspi compatible to identify serial engines configured
for QSPI operation.

Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-geni-qcom.yaml
index 8d1c78701657..eb44f1fa96e2 100644
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

