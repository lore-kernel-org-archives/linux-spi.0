Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8563AA500
	for <linux-spi@vger.kernel.org>; Thu, 14 May 2026 06:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778741155; cv=none; b=e3Sfl+o/5a6L7VHfs7WbIU7b/2T9jO3tEvsg556kQq3kXEeqFxW60qyTK+U6BGRl8TiqLrolMwNvMXmR9ro/eFPmU1OrETEf+Gl7YDT/CGLG5+wklEXs8WpGcuMpxhHTwR37GFY4wB/OO/LT74fW0UcXDG0fKpKCcqyR0CL87zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778741155; c=relaxed/simple;
	bh=3IVpNrCnL5iyLexlh1ItaHWNOFiQFPAlQFdXWVl4ay8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z/82rJt8zkwYW5ldwHyhvRUmx6igrq41aB/dW1cfxxQTHF7W1Z0dsEh999IEvXKMNDt3f6YzEtOuuuKLawZw19aHoh2fs0s2UxtI/R1eEyKCJelpob96DYDjL8GQELXAS9YqbyoE15rYQuHDSz2HSZLxpa5e1uAmanRGszvKgnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TI83Zwyw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=a6jVW5TZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TI83Zwyw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="a6jVW5TZ"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E3UBtI3430141
	for <linux-spi@vger.kernel.org>; Thu, 14 May 2026 06:45:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6oG2Gr7C3LtHCj7Uu1Su6emNGQ/dJWK61lrcIhPPutY=; b=TI83ZwywBsZcbWcN
	SA+mCluD0eNd6+MkU+zZbUFKNbFGem9+vyzHJqOgBagxBrpqwtnT6ZCy6mrQ8szM
	Tu7lRF32rxA/XkNyP5744v8X9cDhhwkzKAlDWiEwB/Q9guxRFqkLkIZtRh0tpLfP
	e9VNzJNEYZ/n1dxTONcICAdLe4AAK/cNr0RvxmTfM2I2PMtmX2U+O7cAWCd7odFk
	CTmxPxGIMDjsl25ABiVpFIXbu+sz/F9PKr8lThORgExtBzdBWY4tCZclcHC/Lh7e
	EWk8n2cMqOnrvoCLI9ydVCxCJrMQno1QNSj8pzlKJqMuIM5G/4U+67lIZNoFRWgu
	F+ePTQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4qmcm10u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Thu, 14 May 2026 06:45:53 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2babbeff9e4so89897615ad.0
        for <linux-spi@vger.kernel.org>; Wed, 13 May 2026 23:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778741152; x=1779345952; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6oG2Gr7C3LtHCj7Uu1Su6emNGQ/dJWK61lrcIhPPutY=;
        b=a6jVW5TZK42+YzQrQkIlvGdVLt/4H4IcK+8r0AmYoIopghBvBCzVLPUlEjrSDyNTkS
         KL5mbgb1p1uDb9kyge0qg9pqQx2cqZeNXJCX84gRkyxxJCECmPfpYmJYHbD9/PgQ1hyR
         aw7s04Kyy059i06EHdJRBt0/PLa2PAwPuuYj2RdICcQ/b/VR3ZypdQtRytqZXunRnRmQ
         MiZsJ/YE/e0VWfnsComqrRXQ1lz6GSyPoZ2cVHyS93TOU7YzVuWTQRRrf1ezgFoBa7LQ
         Y4OwHNzItKu61xjogmEhlH0laUnlvSEKrPxJemQVrUYQK6it7G1wcnbPGBek/XLNWoiO
         +Blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778741152; x=1779345952;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6oG2Gr7C3LtHCj7Uu1Su6emNGQ/dJWK61lrcIhPPutY=;
        b=GUW2bn26Q9y6I70lwbFBjwJrebaca/dojwe2mTolq9CWEIdtcH9TFqXEjYiN/6yMOl
         GGms2O820bKKPLzRptPyjgJyikJYD9cLsPDCSNQ+eaFFNbREO0mxw5BiXxxaJKZB05s+
         ++2x9W8DxCKPyUz34OcY6Lt6zWXHPoy0gLLbZGVU3/zmF7Gi+wTIPMgJABCuOSIBUHkz
         AnAoGXtybxAaphjs47zTmi27cXvPvKm6AtQojXpFJTzZkOPtFqATgxNTSzVJig1PS3Y5
         dFBWYHQtcJervEzrAtNhWVHhrC0+BF1GMX3n4Lqzl1aFvjK2GAfxOaDA+axMoYw8IQBz
         lzDA==
X-Forwarded-Encrypted: i=1; AFNElJ+YXavdxiqzfVscScUFGIHvVPAKnXUfTznyBaOvLL0ZbyQ3xuTJDxilI9QdNlH7sYJNszypdVH+IEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAdfPaDF2HoMML6fKiMFNG5ne96xr/C6r8NLZtqJf2H2CjfbXf
	qun36YMBvLB9IvWjgNPGHthf/vE/cJI3R99bXlu2x7CvxQ1iEnvdtcGx8zjPNWY2euz+UdyNBpf
	6ILJDZF7WT6NSOk66i3f4IpnACBTrrdKQqDyF5XY2dAwRd7v6CA8cl4GmqultV54=
X-Gm-Gg: Acq92OHDwplNIaJB7evyQPJ1jLLh5yNUUDDw8M6CG4R5+plpk7taxf6m0i2QgR0UlkT
	g8DMyWqI/rInpGsllYIKA3eRg266X/dz6YPvqnKTwEgHlPBs8gAGSfcMpnH68ZP0FAB0+lNKE4j
	15rf1qsmFF2uHZxv4bm5SV9stZTkNvqHlgxrysHC92ZN0BCyS72B5KvledWfBIfSe875wSMTe/I
	DkqJh9okyEnTbktprecbUO/HgT40XvQT4FOkN4iwqMEgHl6rNT6Tr7b6NoybKmDu3pViEdoIDXI
	dNQ9NpYaOSB2X1p9MoJyJv82a0DNluS0DB7W6FD7FEm4y9tVkjGeB3U9MHcMQBZ8FKzaOiJE0ko
	1BmYQkF9EHZM88DM6COU3IIvVFKOywKrQaJ4qbTO2VF2tZ4VgwyqGzL6b75AqsDBkkrpJfSIrXB
	4Zh8lKSoT+Kn/r9eEI3fOGIGSYo9D6z7VVm49AsxETUXW9OP7xJlA=
X-Received: by 2002:a17:902:cf01:b0:2ba:792a:18ac with SMTP id d9443c01a7336-2bd52b815b1mr23287095ad.30.1778741152456;
        Wed, 13 May 2026 23:45:52 -0700 (PDT)
X-Received: by 2002:a17:902:cf01:b0:2ba:792a:18ac with SMTP id d9443c01a7336-2bd52b815b1mr23286715ad.30.1778741151975;
        Wed, 13 May 2026 23:45:51 -0700 (PDT)
Received: from hu-varada-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5cfe49c9sm13387685ad.49.2026.05.13.23.45.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 23:45:51 -0700 (PDT)
From: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
Date: Thu, 14 May 2026 12:15:31 +0530
Subject: [PATCH 1/2] spi: dt-bindings: spi-qpic-snand: Add ipq5210
 compatible
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-ipq5210-nand-v1-1-cbdd7492e826@oss.qualcomm.com>
References: <20260514-ipq5210-nand-v1-0-cbdd7492e826@oss.qualcomm.com>
In-Reply-To: <20260514-ipq5210-nand-v1-0-cbdd7492e826@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        sadre Alam <quic_mdalam@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: XZM19bIS7We-iMqcrS6WroZNJtxwvX6S
X-Authority-Analysis: v=2.4 cv=Hu5G3UTS c=1 sm=1 tr=0 ts=6a056fa1 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=sDV5ar4kFRZnHXHNo84A:9 a=QEXdDO2ut3YA:10
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDA2NSBTYWx0ZWRfX0ArUEJ8fLaBG
 NyZp/WExBHFprIsD+rCPNrmO1DESgb7mifAJbOBYbA9Was4xs6FjQxFa+tL0ImWFEpLoiaVvtJh
 dXKk4S/0Ra37sTPPxc/LOJA9ZcqlNjnMOYuU8ouEsgPS7W7vp+Zl+Q13xapYGWKl1015B5F5Vya
 jpnwGlOsnut+FHw4stZfLOV5AUuYb2aaAqMes4hgZgx2WEdC7/LlLgMfTDHi+Pj050+PraJ1Hf0
 R9TfJq5A59RYDf1MYMtz54jTNiksI7QIoWqo9i/36VnuL9gOga6j1OR3GPKZIQvZmacEzUpQKi1
 fCrNxaDBUPoV4oa2JNEZAPRKFuHQnq+4jWSC3jGJj93v+UBrj0wU4H47QUEeaHeRrEvqOTJZcOR
 o+FkBqhqV3rQPpx7cVZfBJmzmiZuwsVWEJm6slyqG77FMVIsG2OChBdFY7UO4HRrKhCFrTH2/n2
 8RLHHdHkGa/mEHu/fAg==
X-Proofpoint-ORIG-GUID: XZM19bIS7We-iMqcrS6WroZNJtxwvX6S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140065

Since the QPIC-SPI-NAND flash controller present in ipq5210 is the same
as the one found in ipq9574, document the ipq5210 compatible and with
ipq9574 as the fallback.

Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
index 7d0571feb46d..829da22537d4 100644
--- a/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
+++ b/Documentation/devicetree/bindings/spi/qcom,spi-qpic-snand.yaml
@@ -25,6 +25,7 @@ properties:
       - items:
           - enum:
               - qcom,ipq5018-snand
+              - qcom,ipq5210-snand
               - qcom,ipq5332-snand
               - qcom,ipq5424-snand
           - const: qcom,ipq9574-snand

-- 
2.34.1

