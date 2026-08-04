Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A32429CD1
	for <linux-spi@vger.kernel.org>; Tue,  4 Aug 2026 07:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827833; cv=none; b=J4id/RpEZYHliwoLLByF+C9V59aRoMN2G0QH4keesYg9YEhwNcRUPQDi0Ys3JUUlQHvtL2cXb8n7zcB7S2qmiatxIFrYk9mdAEdWy0HcS9luHiDMCIa8ICTgGgpjIMnTKYIbq/VIMDufSAg54KPRl/o32PnjpYghD4Vg7FGSFEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827833; c=relaxed/simple;
	bh=Ad527kb12Z3lZcLhuWdL7Jn+p0bLRdofVSznveAon/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TFiyhnGR0ctEBqpTFdx4+rcrcIzF65NxbgobNnJ3Tmi49fWN8dcybEqsHMk3fZ7Ddr69ON5iVI9zzaPTy9lAs2X/CV4foO2b3ttWcyNnBHr+Vo8GT+kw7WObizD4HtUpil+aIFoM/7OkMKpEUm9Tj69ZaYWTN5WPgClFgMauyE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hFB7whlb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fVw2AS5N; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hFB7whlb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fVw2AS5N"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67417jYW2590368
	for <linux-spi@vger.kernel.org>; Tue, 4 Aug 2026 07:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kWy3QRbfgpiZXVTXkRg/bCJ1Xd5zKfwmvVKRPIl2Y/Y=; b=hFB7whlbLUFMu0+s
	MXOXwWacrqSJgEiDAFDirLrNXA5m4FoPWUZlFd6A4k38CV8tmQxbcGyzBlY0Du1n
	wNpKUpF7ZPVWlwQ6xlV9JY0QvY4MIse5oFkIrO2Q9dDhqY12iV7j/QY724mJKnW+
	of3zNPExayhKcL+urVogrUllh/RwC7D1FCX8tt95SRiCbuzLnB5qUT8YmaAofxNu
	5tl9puOk1Wx6m/gm1D6+6+yzFZhc4I0KNclz+Co4VCrWWEPHgKqxvp1P35jXzHQr
	6YMUqIstLvyTYAX6p+m+6ppwC9eGOnKxoV+Xc7cPxbNf6HGW1an7H529udyzZYKH
	URxbJA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fu3vs1qeq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 04 Aug 2026 07:17:10 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c20762d21so49310671cf.0
        for <linux-spi@vger.kernel.org>; Tue, 04 Aug 2026 00:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785827830; x=1786432630; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kWy3QRbfgpiZXVTXkRg/bCJ1Xd5zKfwmvVKRPIl2Y/Y=;
        b=fVw2AS5NzxZJIue7Rc3xn+TX8KQLKqYdmeR+JviXtrPTxBput19FYg85po0l8/WgQW
         4FyRsrSbQHuf507yNbpkJP6qo4R0h7QjVtHXSEXfnEcsGlfTQVJUetoNT/VhN8gp0Ygo
         3p5DB2EkAwnp65d5g2/e+jkAxBGGYsESrh2qtfFOTyhjZoi86tAoE3bYVAw5Y1LpLm/z
         zAUwa3+JFO0hbC1I5Ne7XHxCsZVUw4UKLs8mfddXM7I6BFBTefG5mnnNKdxEoN36T8Uz
         vrahQ4PWxt5LzSLRNwEnbtCL5LwTx2RkbJHCf7+F/8UtvXjmeNr0xGi/P3KHaaW56fho
         YTKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785827830; x=1786432630;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kWy3QRbfgpiZXVTXkRg/bCJ1Xd5zKfwmvVKRPIl2Y/Y=;
        b=RQuEnrz7r78yX9kPKnw9aAgoMbx2Nnj44HBrTKKyXI2ol7Dw1SponXBHEO+IsRul1j
         I/jEJePUNcfhGfr7fzVxN65fcGHw0qZC/gXQu72kDq0i2bizFnOwWCkO0vrGn0mfGLGm
         dIJ0wdeWvo3NmqV3vyQu4fAhgDF7N4bEV2Z9/552ZqvKPHpG6tTOhCKlsPSPHPvYJdZD
         ch1jWJGsvKrFmrFxaTlt9/jF1TeczoVThdG4TJDXv3lVMYuXxZbuM51cfVOQNdqwMc8J
         1kWaN8JLgO/WvkMwcrJBE4SF3soP/55pv0WfpgMPOqx/+CmCugJ8OWwq9bn2c6BVmIHt
         3hsA==
X-Gm-Message-State: AOJu0Yzk1/tAnYh1Hh7YrXHbpL1ZoInrLxGjwjd3INlR55S06oYtUTT6
	dUn9DnT2vnYJDCuulzS4axsoIHR38G3uuZQN6eA4jt2apdHJIVZCar1mp9VOB4vWhA2ZwqzjKEn
	t76n/+dUwbxklQTxRV7C36UM9NtKvXmRzRa5Hu7yazxcFNQsX3zUocRc/PyxWd/M=
X-Gm-Gg: AR+sD11qDdiJn9fNDSe0RYneFq2ojTnJw96aAtpV/OPGkt6fyJH4R7iCk7JgzfcfwRz
	l3XaVl3oOY58dIOZnK66JsptMOdQCEyVXGm1RSBbQLU9W0udkvVUK/SCuILoECItExZLS4+9ehv
	G9SfoEr9KVNFM+emY1vZm2tGsDXu3ndqPIw3YYYNbq+sHphEE6Sv3Uczw+It64LggNVu/LKah6e
	ks/0YhiwH4hdMkpV2YFh7L2wRb1zOXkwTt/WjvMGnZSlqqo/yWzkBqNSbRrLp+IHU3mvAXcRLSW
	SpNoXOl403Y8N1MgA7p4MuMIFzbW6vZTlToMtqDXkW8OKO5lhbmctBvPF2JVukuE+vOR/fxzvZ6
	7yRnexRpR1O9OHy46L8Cs1pLw
X-Received: by 2002:a05:622a:1353:b0:51b:fc67:c738 with SMTP id d75a77b69052e-52b56791b53mr239342981cf.29.1785827829788;
        Tue, 04 Aug 2026 00:17:09 -0700 (PDT)
X-Received: by 2002:a05:622a:1353:b0:51b:fc67:c738 with SMTP id d75a77b69052e-52b56791b53mr239342701cf.29.1785827829337;
        Tue, 04 Aug 2026 00:17:09 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b8d04fsm420265975e9.3.2026.08.04.00.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 00:17:08 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 04 Aug 2026 09:16:57 +0200
Subject: [PATCH 1/5] spi: dt-bindings: andestech,ae350-spi: Drop redundant
 num-cs
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-spi-num-cs-v1-1-4ccb13dcc7b0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1163;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Ad527kb12Z3lZcLhuWdL7Jn+p0bLRdofVSznveAon/k=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqcZHr/blxIVnjr0AiiUy5E/egu7DjbnwX90RrC
 IRNXRfLF3yJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCanGR6wAKCRDBN2bmhouD
 1/daD/wNVg9Q40+3KaYuIMq/uBIFIRh9d53piPOqtUbbmQ/b/woxP2rTZx0impr9LnPWn/nS5Pn
 mbGwnLiIDX6uN5iz3i/bzA6I0Kzfp3L4JqlTQamDg1PCWNqsCgmLlcq2eDVTA5m0BDrI+IQBL0Z
 CMoV08s669J1xnkYmb4gKZYc7qeB2vvpnWlEacJye1np/WwB2iqato4WtO61xceFUa7OuqSK+C/
 8NZ/6+i5K+UAxpkClM9IShKE1OXkgi1IKfiUbdz0KnzmcdxEgyyUaSQkm5P4PrNoLc3YObvfi4G
 NGAwqjmW1acNAoLza6JjQmO6q8ll5TdHkKK1bVoQwl86PGzT4NJxatE275U/k2j8DgGugC6jfLg
 pAPD5C1Vwp8OBHRlM8HQbJ9Cg3G/LVYc/uxeUorVnMy06Fe/aDV9XYzDZlstArUZlqENknfHMJM
 Xr3JN5BKeGF4eyPG5n9LPVcRo8lO0CzGVb9TvIE1ZBypo2kOsfW8b0gH7CCaSbJdtUL/ZE7S53K
 zp1A5E5uAfHxNlpjkEDlN9EYPYi4YJsej4elBB8b8fkfFZ71zYjU/TGraVa/TPAW/jn4LdIXfs9
 1TXL2ttx1Nk7/ltOYChjDnn3Z+LK/jSeFRUwcrd96pai4vlJHiPBR8VL29H903zbdPKkOmr4QpM
 /Bwp8ME87xXaMKQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1NiBTYWx0ZWRfX+F2v6x34yAzY
 CwOnZDSCMUBbI527tq93SxtBSx4+jIjSzxqWe2X2tjqXOaonwW9Wp8w7AXVr8oABqC8ljfAQXHs
 XLHKtYQFbIgGMvW87G50SUoZx9083/70yVarllUdU7Nkcyj1ilI56FShxY4sNfj1YjqKYDDA42E
 HsU9TcAeAC35gxyg66/JKKKoCYd9Pehmyez4Kxmh5Nnf00mmjxtgVRpbcaDQqq6yioK17RDJBRy
 JqqQ72JAyOqX6WkqbXFQdVnf8y5d5MWVxsfmJ1NBGH9brGsEQxtMoz5fbnmm0m9DYGB8KiQ3CAW
 OEWzCE6RRAw6iRx+FmKiZhiuKxzRwwDjT4+/T0PbN8JbQZKkGROxJO/qBCR/XdFUDFveYRjWk2E
 hcLZsoBJvo3gdMulct6FZD5w0PZqSl0mMSEnqYqHtDLapwIVrxw6PJbQYAvRQ2sM7uzej6lyBY6
 CQSBMFunXT3AzjP80xg==
X-Proofpoint-ORIG-GUID: 2YU8HQ3OUi-EZUrVMIBouLD5P5RCJsSP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1NiBTYWx0ZWRfX41bHAbwKc+vm
 prhPlMG9quRXse42ld25HzZ+0Su86ubnxpqwhkPr+zlZ/tqGwpRcXsZR8teMz5+hrXnLQKIKBNM
 87XBP/2zqKsg5PjGbwk5qnvhSDDmtYU=
X-Authority-Analysis: v=2.4 cv=EK82FVZC c=1 sm=1 tr=0 ts=6a7191f6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=qilZQbzIvi1Av5Pd9fEA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: 2YU8HQ3OUi-EZUrVMIBouLD5P5RCJsSP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040056

'num-cs' property is a single integer, thus the binding should not set
maxItems.  This could be replaced with proper min/max constraints for
values, except that hardware (as expressed in driver) supports only one
native chipselect, thus constraint of "const:1" would make the property
implied by the compatible.  spi-controller.yaml schema already defines
this property, so its presence here is redundant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml b/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
index 8e441742cee6..381042e07fd0 100644
--- a/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/andestech,ae350-spi.yaml
@@ -24,10 +24,6 @@ properties:
   clocks:
     maxItems: 1
 
-  num-cs:
-    description: Number of chip selects supported
-    maxItems: 1
-
   dmas:
     items:
       - description: Transmit FIFO DMA channel

-- 
2.53.0

