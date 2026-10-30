Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793367070;
	b=zs2DZg8QBnVODbbKK32UJgXItyWBEZLrtZVRmoj2KbYBYIwbdt0Er7yrgnHH8j5kD/Cf
	 Jwm594yl8yUwJo3ccaf1PNxYbaQ7Zch+8kDeB9+8tSCgvuPVc/NKEouHDTjPIm97y25e7
	 mLng19j0Dav2NRMkaCNTcCdxe1JZMf6zoBwrTKte2bd3vWfd+X6BXbUjYw2KikPoI3IDW
	 vd+phF0u1QiNOgZYfxFmvJe7USvJf4P6VScjmeZMbUX2OQj86jZTy6EzcHRRsbNGl0kkE
	 /bjd2sQBqusPtkMYfFLrVQDW/cInyArHbOgk3W8Rzt/52o9tUsVm6ae2AAXqgJt0RgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793367070;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=UR4JTI9VQzJqFZB8kjqpLUWsRrNaJNk6gTj/t7aYhsA=;
	b=gezJaA+LENoyLQA2BRBUltlgXfQAuBEBDr354eUjs7HR8SWiX9okhBJmYyVHCm18LL+n
	 Mj6AkBwjiz1xW+VM/pToMjzhbQv9EJPvOzZ8nhVJSIudY+LD6WN9hjmYTBTLJdzQSYyMb
	 FcQVXq8UE5PLmu5MTSCz+cjKP9iw3hxAa9x6w7RQAB01mB9Xa8ec7klk+8qb5e46ntUKk
	 mRK/wCiMStDlICjDIeQ2d/UGMyBekfgy13S+Pid1j2NdsPBh3l7Naou8fr+3BTpKJXnLO
	 aRqIGvwct/7qlU+H4vhvE9e82+9qAodtTjDgniS1i+fMkgG8LPuGpEtqP5/sushLMUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g0lSEniW;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NZfdTYHH;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41FB606A32D
	for <linux-spi@vger.kernel.org>; Fri, 30 Oct 2026 13:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C41FB606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g0lSEniW;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=NZfdTYHH
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBGCfl3719680
	for <linux-spi@vger.kernel.org>; Fri, 30 Oct 2026 13:31:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UR4JTI9VQzJqFZB8kjqpLU
	WsRrNaJNk6gTj/t7aYhsA=; b=g0lSEniW6gquVXXpfOAY99DJUHOYnH1CQYc7zh
	7ilDpSevP4ENGSyIVmlBECy21yYDFq7A9G7Qcl49gOVULsUTr+YHadkD9VoRYO+M
	3vfc2d5QUPcH7S98ssSfvj9YmVChDGDA9Mzsp+1bifsNK2YtrpfvjnwzI1EIZZfB
	pePZ4gquLrsuJ2iHnUDS/gf4ExMnB+l+K17XeVQuFq3HmiYRmwq0RPGlwt4WuvIA
	HDDtPDyhLGxk0t+uJ69g9+o95/DHx76/Y2lPFbS47bysv5cedWtIPjDQgEEbZkcn
	AJzyYwYYbBqdI5dGDOe7W5qWI5aS/LtocNHY5yLjOmquEqLw==
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qu6sx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Fri, 30 Oct 2026 13:31:08 +0000 (GMT)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4fb73e868aaso1183069b6e.0
        for <linux-spi@vger.kernel.org>; Fri, 30 Oct 2026 06:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793367068; x=1793971868; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UR4JTI9VQzJqFZB8kjqpLUWsRrNaJNk6gTj/t7aYhsA=;
        b=NZfdTYHHo++kcIg1CIZrhJu4GdWHAkcrYE5m1l1Sm4jsLFY5Vr72g66usSEpzPVANz
         vK+KN/w0ILE/UzukYp2fKviplcxhye9Bt15LZHlogHy7Xe/DnjHzQVGzhpvQ3vu5++JS
         BBgKZrNQPOjuGTtwM1z0MA6CX617lbQ14XWMqJA76GbWUUxQvARBeOQyGxkhWpRNHeg3
         YbjFoATf91JBPwMjO19cd+nB4Fzn6zAKxJwIg35KbUoCp3ludATs/qpxjJ7lpULTlo3q
         PNd7vksGlb1CgeDR8DgoQrlUWTz+WmO/snjyvWFRpDLn2jpIH/A+rdGvMMYip3DlmP4m
         wlNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793367068; x=1793971868;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=UR4JTI9VQzJqFZB8kjqpLUWsRrNaJNk6gTj/t7aYhsA=;
        b=TB70Sc0Mnm4BIALL53OMlWPsJILISHS0YjsmaCZ4saiIHWzrVQOJU62j9bYiXYz/qf
         jlRAuFKvlU1MqPQS2LkFkNaLIXUMZzHiKx8+XJLVvLPAwdGvzEgoKyOSGBtFalzUPvn+
         w1p9lIdldArXFFgttiV6xfOfB7nWWzfq+OV5k2QGSonkAi7YERS8aXi7GeY973Z0jsya
         UjI15cDg8hPjUP1y5J/GHNzfWvylca6eRTn53Q7QZ+I/pgOVKb+m4w0jRXqhCKFwcCgX
         IzJINTT2MDRkPfiMIMp6Rvsyy32RGsC0Wqx5Od7XojJ44f5i1ekokFJTNgXEHYOC3MtE
         txaw==
X-Forwarded-Encrypted: i=1; AKwUvByNm3X1ai5b39Xo1jzTtKm6pHTs7uloIJ9bIOy78tPJ9fxz7RyiXcOg5411Vxh15dZsHVvsdhwZvzw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKUYe4XCnSj7bPPY/9Itw1BtOqPnw/9R0k/sAj0upAR8s06Z+uI
	LQUMuj2pRm4TDQ3ImtcgmA0FbGTIYNxNP7MIapYDA8CG26ENHn7t6mQzKvgyZfDEMbyq+KYs8Hc
	ziMfeDNUzcKWohMaL2O+kRyNxybUa+AY9LVv3WJcdmku3GN5ukBWlFiB0saaA7CU=
X-Gm-Gg: AYBFou2UtNHNcb+rk7r+GYL7Jj4/IIoEWZ+taQz+7BaXXFNOYFDwCbnvYNAhTzScxmr
	eQNk8HQBXf5pi1jDDn1oTx3ptVaZHsAOI97C5iUke/IKRqOzF/5LRJaAmh3NI9ibJ4JZqWrJEy0
	urW7Wkg9kW7dSIwIAzZBZcaMqRiFIi/DFibbLFNOba9/kfqAz9+SkIkYsfCD2u1ZZAGhcvBx6PY
	baRQSP5Mq3ntkiBIRJT5wSTuAAO8lpoYBKxxEPxPbfrEmrhQHZjvFLskKqIpZpG23RpCQpT4/LF
	1SceA2O0rPmtZwmXQA4wWQ+p+ZAJWDlO1X1B6AsTajIBdHWUq5tM9OZa9QAKVRQsVXarGC2UMOZ
	YRaJlkJAUdw8PebS09M0zooLH7Qulbnn23VWLw4H2wliy8nLWYzGQK+6couqc+MiQjtmUHvqGs2
	wNWu28oX/c
X-Received: by 2002:a05:6808:2512:b0:4ea:18f:64b0 with SMTP id 5614622812f47-5640decc459mr1809523b6e.67.1793367067540;
        Fri, 30 Oct 2026 06:31:07 -0700 (PDT)
X-Received: by 2002:a05:6808:2512:b0:4ea:18f:64b0 with SMTP id 5614622812f47-5640decc459mr1809490b6e.67.1793367067074;
        Fri, 30 Oct 2026 06:31:07 -0700 (PDT)
Received: from hu-jseerapu-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-5640fc49880sm1590884b6e.2.2026.10.30.06.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:31:05 -0700 (PDT)
From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 19:00:42 +0530
Subject: [PATCH] dt-bindings: spi: qcom,spi-geni-qcom: Document QSPI
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
Message-Id: <20261030-qspi_dt_binding-v1-1-5249111cf870@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAAGc5GoC/3WNQQqDMBREryJ/3YixxWhX3qOIxCTqLzXRfJUW8
 e6Ndt3NwIOZNxuQ8WgI7tEG3qxI6GwAfolA9dJ2hqEODGmSZknBMzbRiLWe6watRtuxXHLVCJk
 LkRoIq9GbFt+n8VH9mJbmadR8aI5GjzQ7/zkvV370/ttXzji7qTbLteDFVerSEcXTIl/KDUMcA
 qp937/TUFWbxwAAAA==
X-Change-ID: 20260916-qspi_dt_binding-8a1cb7a8772e
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793367061; l=1839;
 i=jyothi.seerapu@oss.qualcomm.com; h=from:subject:message-id;
 bh=6+euTVf3GCpORG+HjlXn9bEmx+HYlFRWqNiglrEVYlw=;
 b=mva44UfZGpfgrUarHZzaC7Pu9cJNQKZyiCLNo3tQeYQENvV6cTkzLY9rBi0xaV1uq10Gvtwi6
 9w++rqbasXbD/ZJpziP/1CkivrzIGzMDZy5LMokToF7uFxtSLiuu4b1
X-Developer-Key: i=jyothi.seerapu@oss.qualcomm.com; a=ed25519;
 pk=9vafyYsia0OnBKWSEwhmWe3hPVQfI2T1xOs5dPaFvEo=
X-Proofpoint-GUID: zZr0gL9McyznihdwFmDJyPqiK5Wlwv59
X-Proofpoint-ORIG-GUID: zZr0gL9McyznihdwFmDJyPqiK5Wlwv59
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1MyBTYWx0ZWRfX2lMDM5HljOet
 pPco2aJQDDPV7NXTqwx6I0LQ0X9kxarky0lNv5sgBZd1s7c8NwnJctMzSUhDCtf+UAm2a+C/ZI4
 3jj70pD3iBdIjmtUcHWywl/Uq2dsed/HtKm9Zsp9tAZwawkHJskzv/Y7S6dHNg+MUXd32YS6tYC
 h5YSFU67IU72wOCa6+Sm8adDZpuApubUkI5mSexpOZdijdoD7YuY0da+8JrGxIUd02sewc7RD5F
 jDda6c5EcEdSEfucDvOQU6+8MdqoWJxNVqF+c6Ifx3uZc+UdWPQ1EMmIhGL+ys632BoY1Jc+z89
 Lkdil9eqNhzKin4Q8aEJlNlE4Y8zyA68IJaDQLjQ312kv2o9S+B0PxMU0Vk36dGWKS2V8LEboXX
 sYttt6Vksh1EM4RCGY0XiRb2xgEiStkBd5MAMteCOEjJGinAe0qwRydMhANLWleVkzfn8TAHbQt
 zHLLNiEyN0ErD2h79iA==
X-Authority-Analysis: v=2.4 cv=dPgzC+Zb c=1 sm=1 tr=0 ts=6ae49c1c cx=c_pps
 a=AKZTfHrQPB8q3CcvmcIuDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=KUikZgbwDMKjgD0mul4A:9 a=QEXdDO2ut3YA:10
 a=pF_qn-MSjDawc0seGVz6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1MyBTYWx0ZWRfX4SiN3UVje1aM
 9Hd8i9QqTrDCPBRU9RDiGa2jkmVmUAtE0ivcuy31JDdcfoMphs0m1ZETBkneHX/719/ZozjylfD
 +4GZZQbXniiriaS/IheYAbiUmCMxC3w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300053

Add the "qcom,geni-qspi" compatible to identify GENI Serial Engine
instances configured for QSPI operation.

The compatible also allows the driver to select the appropriate protocol
firmware when the Serial Engine is unconfigured (GENI_SE_INVALID_PROTO),
distinguishing between SPI and QSPI firmware.

Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
---
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

---
base-commit: 7079a12d7506b07fb53b54a664bfad5fa9b16d70
change-id: 20260916-qspi_dt_binding-8a1cb7a8772e

Best regards,
--  
Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>

