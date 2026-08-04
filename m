Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3263B42A7B7
	for <linux-spi@vger.kernel.org>; Tue,  4 Aug 2026 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827835; cv=none; b=qlD4RRdQTj8BNg4mg/Yur4IocydtBdYTbYJ231xlBUqeCwr9vv8OZRi0Emn82JfnDz6pVPvZeHk0ncDFKbDrMAHwXknLRmVX4oPLkxvEeKtDAL2pymn+nDi3r5fV/WnSNUrIAkPRmU39gAt/RLwfG5fieBavNoxg9bx+h0p3SqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827835; c=relaxed/simple;
	bh=NCCwN1szetFQ6aTYWDyorxmsLSJn745QpATW7kLPexk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kDSXP5wGGQ50l7FBJ6OyOUBX8n/2ZWfDCow4OVlqdZE08Y7UMrPVYA4U1hyBV5sDKrDoc25PqAMTw+3/mfp4rk+QG3NDqgVs/OIi5EqcSFsw0T5jh5sUuEIFgl32DffrIOuhUbZlzGZlkf+DSV8NDsproFGyJArWaU3x2c5nAsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VypR0j+M; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XjnmY9kc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VypR0j+M";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XjnmY9kc"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67416sVC2028025
	for <linux-spi@vger.kernel.org>; Tue, 4 Aug 2026 07:17:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZuMU3HRIoQauvAlgNljZqe/VSI9nMSTFSr9/NCqpk0o=; b=VypR0j+MjGJRAhGR
	rEZZb9um11lUSFhqBe1s3ZEVMvHATOuLoMrWUaNmwIrzzpOV+/RKGw+yowL3n8bi
	pyYRb1rvIP+iTD4+pUY+kd9XpsQe99gjObuNv39hVG2hg+PPmbRtQaOGVEbNl+cO
	Sj7QXJgtuqwgJp6Bh9noXUk/bn6gMGcTp4/nuRvp95NYmY0pY/T8J2+x0sP73iI4
	o4+mEVsO7ZIdAN0G9KO+2V1WS3zL7u98/lP+CSxJ3BjIEBgjsM7GNT5Limxr3B3V
	3OZ0w5SAmHbaBm9PxvOQEn+N6K9urqSL7R3Bjbim82ua/jAcH19X9xlPFt6sykM6
	vyQfrg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fu2syj08n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 04 Aug 2026 07:17:13 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52827090cc5so8515441cf.0
        for <linux-spi@vger.kernel.org>; Tue, 04 Aug 2026 00:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785827832; x=1786432632; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZuMU3HRIoQauvAlgNljZqe/VSI9nMSTFSr9/NCqpk0o=;
        b=XjnmY9kcOIw6s63Ps8qdru7c25hjhhrBEySn4KkeGp08bvpCj3q/kWyeIIbdQgNE0X
         BtXzBNsKq27/JTWTuNbsXcvRzSBc9ePZ0TZFxGKsBqDWZr/08JFdzvytVEFHjkyRI79v
         A7PyeW0a+PpG3vE/+4MA8bl5Vhlz3MBWqYCDdadMnkMJKAB2ur99xJPqlUcooYhMVVgH
         HpAUN2QdCJkkznW+1B4yiqE6IwYh7a84Tapt7c3pLTcb+r79f/08Na+3q4vEKu6jOlCx
         sXluXAL7Tg+L/diOvCaWbwpJjMu/EaId6DMm/GYK7qDq3ybh+slYAa/2m1kG3gxSIlo0
         VtOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785827832; x=1786432632;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZuMU3HRIoQauvAlgNljZqe/VSI9nMSTFSr9/NCqpk0o=;
        b=PQ+/l532jM9gwglgvwS4Ct7mLhtPAG8LPS4/G9vlLfTE/oLTR6jM+3pJKB5goBgQdJ
         S9+vxv6LmkQcxgd0GMayi6+wGJ19CbaKdh6/VAUrDWgnykcCCQX0Hv1cMi4F9DaGRYzs
         +KuR2aS7H9zwbQk9JHGzWW9g7tMMmp3/Kzh3psyHTRRvhYx03Gp/H4e21K8Al82HcRGY
         pzSHDh3QvP/d746DxdhGuOpxrznQLPBn7DpyzU9PyGoPOKwm5qCKElFl1dJIZpkx5KDL
         rTPn/qLxo6up13TmkLnVHb85ocPTYWgPbRFYrkns9noWvTW9tRgbyG1Vl1IsR00krNK0
         nvKA==
X-Gm-Message-State: AOJu0Ywaw7F3Fv6GIthx6zw3GOOBNtAG3fq0FwGh0CHKkniugezDCwfP
	jfnuqAWiADS+poW7H44JxMlr5oDydSEUHmbmpuL8HhK3tI6ddYT8mZLWJhytEO3wOo8fKpw0C7k
	CfFTqyAD453MAuzHGtnwxuog0QjoChPZfxHflanJ6p9BC1QEqp3nn7U6DdpttqKo=
X-Gm-Gg: AR+sD11KjGJfXkq6/C7ka5BJMVwuvystjDWqtQGU/A1Z7A02imswtNYCQamLjQJ8gEY
	Yk1pPaoOEGVLcuO5US9OzNGuvAaaR+iabSdfczwc+Kl8Ri5i1JDlbwKiA6zABiylMa9N1E515i8
	azGCww4dX7y4kU/9dykawnoJjagKdSCrfy7Ps8OLaghha/nOKn1HWYA6nzsmYhsXaULDyJo4lRh
	xVV4QjIHqkWothWODkuQSULv3AD6ZnoaYBLzzkP6GCzPQIp+Dxfw0Olx1DQPUpEuTTkn73CgD5X
	P4/dch/b8SHUwwH/85oiRbUu+3Ut28uCKVwv3VgosXP4blmaAYHdhxNCPjxtAbt5QjXZNCYurYQ
	Cp56xvuY18a3u7/IZYMWeDdZE
X-Received: by 2002:a05:622a:4d4a:b0:516:35fe:5524 with SMTP id d75a77b69052e-52cd3356ed3mr49122321cf.5.1785827832334;
        Tue, 04 Aug 2026 00:17:12 -0700 (PDT)
X-Received: by 2002:a05:622a:4d4a:b0:516:35fe:5524 with SMTP id d75a77b69052e-52cd3356ed3mr49122031cf.5.1785827831945;
        Tue, 04 Aug 2026 00:17:11 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b8d04fsm420265975e9.3.2026.08.04.00.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 00:17:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 04 Aug 2026 09:16:58 +0200
Subject: [PATCH 2/5] spi: dt-bindings: marvell,armada-3700-spi: Drop
 redundant num-cs
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-spi-num-cs-v1-2-4ccb13dcc7b0@oss.qualcomm.com>
References: <20260804-spi-num-cs-v1-0-4ccb13dcc7b0@oss.qualcomm.com>
In-Reply-To: <20260804-spi-num-cs-v1-0-4ccb13dcc7b0@oss.qualcomm.com>
To: CL Wang <cl634@andestech.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kousik Sanagavarapu <five231003@gmail.com>,
        Vladimir Moravcevic <vmoravcevic@axiado.com>,
        Tzu-Hao Wei <twei@axiado.com>, Swark Yang <syang@axiado.com>,
        Prasad Bolisetty <pbolisetty@axiado.com>,
        Karthikeyan Mitran <kmitran@axiado.com>,
        Michal Simek <michal.simek@amd.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=977;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=NCCwN1szetFQ6aTYWDyorxmsLSJn745QpATW7kLPexk=;
 b=kA0DAAoBwTdm5oaLg9cByyZiAGpxkeyiitHJEq4rXOCGBWHGfJ2hH1hlqt4FC4VbI26K+8ZKP
 4kCMwQAAQoAHRYhBN3SYig9ERsjO264qME3ZuaGi4PXBQJqcZHsAAoJEME3ZuaGi4PXrEcP/3RI
 FOJNWAVk9Gn1G3HJNpDwNSNFxz5Vvg00cI4fzYwqELVzjKrQPMd1RqbFkOlRTo7ugCGm/ziPjrH
 4xiCDceOmh7Y7lMTZKSsCupr0rpSoJSHm1EWRv7txe26AtQfdloWkZ1irga3Dup8hKFOHSZIj1Q
 bHfe4QWL79S4zcLTLOIfweTkYSZNYRtIjg6A3hzL6YgrNy79qvOnSagJPqkz0MJPu9egGIe8VKW
 zVUdlL0VOZ0IXUe4eng7OhnDC9P2kGPDmIYQICCDG68gZXNW8gIUFbTMt8ib0k1dixTp5i/zvM2
 eo+Jn1dwdftmXZ68NDJTHks6vIdCBNXVUX/bSKy95ZQoGhI5HevtNv7ADVV5TTeTkjruEAYKUen
 4vsKR+OEkVZTHq2+TDwZ+kQEZY7hDXkT6q5NEDMkQox4x5sHPP82u1HewddLCFmz3tfCYkJQu+U
 x2EXsn8RM9knYJoy9Fpy8P/0oPcdU5nGQTMWA38B+E+qsJFq+sl8Tl8fuHV4OBrAEFX6/XHTZ+C
 LBDQYTh8LrHJ3P3TkPTXYisijSbqFG0YbiciBFjZXAXTw7DIe+EZbhroejuaBKL+rqXO7ZzCjLh
 X4Ca9wiVp0uKir8UbGmRI12LJAUzzhjA5eL9WQhM6op98MAapK+VtCTPh3WcWnf1R7kwOvGtxam
 lTEap
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Authority-Analysis: v=2.4 cv=TIh1jVla c=1 sm=1 tr=0 ts=6a7191f9 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=h_P405bTkPm-sLWfBjsA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1NiBTYWx0ZWRfXySb+0k5H3+qu
 r40yWc6hYFO899IU7qFY5mSro1CfpJ9DmZo8yrCM+hMnLMoCnwBC4ob92UUUQYtikK33AmyGIk7
 bWyWiJy6YD4XuGM/7mSDGqn64H4Rrko=
X-Proofpoint-ORIG-GUID: 7iEXC7lyRqNH4-VYFNmsmAC01EnVPgeD
X-Proofpoint-GUID: 7iEXC7lyRqNH4-VYFNmsmAC01EnVPgeD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1NiBTYWx0ZWRfX1n1NaizkEibX
 9DXA/ujXFziooGkoF+oSrTeVsq7unVY9JbPFBwdPIUyvXsp3S72WWSU6SyGmigl94TvseaVmhiH
 ZEuMqaCnF+OyRK6IgoiWpf1e/Jtdj7iLwVUAyfmJ/BJbSMI0l4Av1IFj8FWubVIx04JaWLWSoVL
 tdwKFOCuHsH4yD9n19voMAHWNuEuEwGIj/0t6rkCYGXr7kXWExeVxNU3vtS5RK15H/lj4iYSQV7
 1aWW5IXTcJtPr679xwturbUXzpzTnwPO74yqL72jeiLa+ep9cgI+u6qPkXMqiGjmAkQfb/+G7XH
 r2YVTtiyUGIt1pD2vwScDOBu3Az86m0nAQxxmPNlapCaLUv0nLQYwOtTZIMTejj8vu0QWQ6yboK
 oJwqqDjIWG8DSl6ZksjgNXOSEcnWQ2OGgecAJGv8K0tkIrFrh1YlEtGVbjOX/F+CYB+M9CJ8cZT
 1qLehLsX85CvtAj6VrA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 malwarescore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040056

'num-cs' property is a single integer, thus the binding should not set
maxItems.  This could be replaced with proper min/max constraints for
values, except that such constraints are not known.

spi-controller.yaml schema already defines this property, so its
presence here is redundant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/spi/marvell,armada-3700-spi.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/marvell,armada-3700-spi.yaml b/Documentation/devicetree/bindings/spi/marvell,armada-3700-spi.yaml
index 61caa1d86188..75437c46e65a 100644
--- a/Documentation/devicetree/bindings/spi/marvell,armada-3700-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/marvell,armada-3700-spi.yaml
@@ -28,9 +28,6 @@ properties:
   clocks:
     maxItems: 1
 
-  num-cs:
-    maxItems: 1
-
 required:
   - compatible
   - reg

-- 
2.53.0

