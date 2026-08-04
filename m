Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2867942AF9D
	for <linux-spi@vger.kernel.org>; Tue,  4 Aug 2026 07:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827837; cv=none; b=A+tLk5QF/o/JZt4Osqt4jokikItRqKIiG2RjaqZlHwWORcExCsMwgMibFav6CTB33mEl1umLuYC4iLn8zgNiev5QHY7MIwSd/B2EOI4f2q5NwRIC123j/92t/mfS5FszEtkaUVclgMN3lMK1TYD1Xi8wy1ooMZ9lpZZaRSE06W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827837; c=relaxed/simple;
	bh=WInEgTRazKi1bnlKIV6gud1U41TmUr3uidmStQ8pne4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YJWLFnD7OwfYO7wLFmcGii5Q9Gm9YcZ6mYQgKFKEgX1uaKnV04pRYN1kR5y0o/X9WbQwXD6aUBIZiONFcQnGgEkONu1xXxkKY7NIxZ3WVDHHMmMJ60EkPAg4eStqQ+PU5NzHdlZHk7JRTc126jBFUK7jNJ2VcfwBtuQmA7XMprQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CXiPuX2s; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SP0/KbbX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CXiPuX2s";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SP0/KbbX"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674181VX2284493
	for <linux-spi@vger.kernel.org>; Tue, 4 Aug 2026 07:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JeGckGAtU2mBLl8s4aGiYH7rSeNEpn0PkB09bYxAUWA=; b=CXiPuX2s/89AYhpy
	2QSuJq5nmOgj/EecpJq4bb7CzZ5YNO29lTKakdlQryXtbYs6WxOiMtB16ghW0i9Q
	PXDokzH9VN16EWq+efj3M8WK9Gb5cbzS8jwhGVak9ve4O0/p7RcPu5/buWrG3DaY
	8uDb2oddpp5st9lt+fPjXyrLvK6yd7G/AqNd++TlPGA09JsF/B7UOetA+tkjITIA
	vG3gOPAvzDCBiMbWcNjENkWQHn+VGw5U530obFJB95WGuY8/ANOgQHpdPOqnBkb1
	wo2CS7cgfP9iY7Wricm1hczUxKEC1ni6HBOzSpXVLmMGW6jAUzptsdDTmeZZFoG4
	U4Px0w==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fu5hqsd46-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 04 Aug 2026 07:17:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-52b4f6ac06aso69886901cf.1
        for <linux-spi@vger.kernel.org>; Tue, 04 Aug 2026 00:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785827834; x=1786432634; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JeGckGAtU2mBLl8s4aGiYH7rSeNEpn0PkB09bYxAUWA=;
        b=SP0/KbbXOsE4ybQCXloInLOPb/E414TdHjSOyYjVp/RNvU/2XJHnwOs6+xeGATRTmk
         CR73u+aOhVYKAYkKRFBCFMvOLqOYEKxOwiSX/TpIzMFUxQ3pcGJF7aIVlzHIR8xMv1Rw
         HLRiCP1YqwagB2GA2R4YuJ87Us4v1PLUq59FvNb77GKFaJy8AhUqmPENsQTwuQhvNTVi
         25URqQ3YZVEQnCJTypRedyTPrwYXHlMlx6Qrn82QwUEAjC/BT2OIFJBPsSHqcq83mThd
         oy99w0N89gcuEPZvMATgBxl6Bj+g+gle7qqumzVNJlZqutz5qlQZYmspvMiM0qAe+ix4
         AAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785827834; x=1786432634;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JeGckGAtU2mBLl8s4aGiYH7rSeNEpn0PkB09bYxAUWA=;
        b=g/LNrHftgEN48anhie97EgmdnU/VmDVltLc+ZL3J3/mx6luM90TTr1QUO7vg4wsPbU
         sILo0nCnBgKAi3kMDUGeq5yFRptlq54TIOVE7q4hWI7UNwCMbt+3xOYyIaDntVlGRo5H
         X+6USa0Qmcjf0QmaHBvvI5MsSvewNLJpiFv73SZmGp7tv2C8bhBqn21zapd27aLpmlWz
         uLMilb9vKtvT7RLkB5Nbna0W7Ayvdo1dUJTsD4eIx+wQxRw+HH8yGI1kvAiTCs7IeuMv
         4aQFKmjBtyAjFfNuOdQEvk+NC5/ZkBW8N+xmAw8ks32kINkuIJutWfHnEU7I+GoFFTmS
         fVwQ==
X-Gm-Message-State: AOJu0YxtfXkKXyWg2fLkflfjrZr22bTt72Cid5TszghTvmmYx0PFc/9Q
	GRmsQO8BD1Ytt0vlKGHTp0Zi9AjWKN1t4x8AOFW4MgQ37M0tFFV3zJfr0dm68mW2UM73n526Mgx
	hvKPBLlcm/fadc4fR00I07Z99Uu7OZSfLT0EFrP3i/wA/0GrvcaI2aUb27QuV688=
X-Gm-Gg: AR+sD11GipXC6N8omsXqPkQKvcyTj8tmGlzbwRX5mBTxMfHaX/lENjIg6cMdUESF8WS
	F7H9IIPsIki8JOoAqq/kfjzi2Udjcqvbw+HQxxEA5U8kFAiq7CujBeTpCDw+yl/PBn2hvj4ErOD
	QaF9Fq9c2ZAP0jMZ7ZVgr9sElQdEMuyCQqTwZDh3eDweAJ/E8aGp7DnL4MJgllF0CIWs59sdMvt
	ChYYxJp64ioH7fR4RRpy1xO3RNbNxSB+UzcyMqwxALheihrKq1fF5CqlujBdyI+42i7p5iVcf8+
	8YY0a6zsa2jvmX+sr/3zvYfoz8WBS1nxGLR4mcDC/B7xoX/9wPet8LVrOKw5mXmMcyRT0ZNjn18
	z4UCpL3tsjivTf/Ki9iN9u4ZB
X-Received: by 2002:a05:622a:5595:b0:51b:fd82:22dd with SMTP id d75a77b69052e-52b566af237mr277720001cf.15.1785827834396;
        Tue, 04 Aug 2026 00:17:14 -0700 (PDT)
X-Received: by 2002:a05:622a:5595:b0:51b:fd82:22dd with SMTP id d75a77b69052e-52b566af237mr277719731cf.15.1785827833975;
        Tue, 04 Aug 2026 00:17:13 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b8d04fsm420265975e9.3.2026.08.04.00.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 00:17:13 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 04 Aug 2026 09:16:59 +0200
Subject: [PATCH 3/5] spi: dt-bindings: axiado,ax3000-spi: Drop duplicated
 type/ref
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-spi-num-cs-v1-3-4ccb13dcc7b0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=822;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=WInEgTRazKi1bnlKIV6gud1U41TmUr3uidmStQ8pne4=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqcZHt4dXqcY7dKQHz9rLoIIymozNceaLW8siy4
 E3lkXhNbwOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCanGR7QAKCRDBN2bmhouD
 1zYpD/9OR2DVZGOVqQbA0kbXFA13Ja511qlxI0xkmyZKhih3Sdzcab9fYmwvHcKeTck5PYZiu4E
 UyEaeWzO0sKRhrq42QK+q+a/LluO8UAHaPKAPXiXF4Bsnd2pyKqGvvBnNCle0UdFONEyp7pAkfs
 lRvBsG7ZRpki7brUZxt6SRCdY5Y60CQujodnsVhemcBLvHn1VgpkyoJnXhZYc399ANWWGet7ZRO
 p/wt1A5Ph6utv7FDcCrL4QMtBOvEtZUUOJpc8aCQT53l6HTiRK1uS1tgYr5/GvbbPkjF5aVK/+5
 7XeGGu0DjHNuAI0Wfkuzusw48uLaKZ/eteo/9FLZ8eqmG6b2Luc7y/COUPGW3MtdoWEAIPVzz2o
 3Kars9T1bUt4X7MFcPsC+/JcgSgE/KhQcB22gzfpiGuyNFPQ3Kdao38LeHjZmGLNOOZwn30Ll9K
 VjauAHQb7SeC83Hi7Z1ZwqIH+/xIALFCd2tivfsYNtMBeRiyMjqxuMmYNyIt3A+d6DE7eQ1RNqz
 Q9ZmBuN0u7ndFc+oX4UV9Hjq3mFJ0E8JV2K5lHiGq1RJyEVVccvNxXNAVbdrt5WwghliuV7rEZy
 uSAW6dWo/Pel0Xt5okibP4D0aZ8iDA99CcvMsCskDdufmO6J0TOTVcWNLsxggwB4ZsXaNL8TRs4
 DPbUNrRMxd3BviQ==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1NiBTYWx0ZWRfX4XS7KmAYzAVY
 LDJ5Xv/u8gPbmFN9lQ2GhU8brHCMOZ6XLrtB6Hibnq68OJvK6TzO37WYXKoXXtibw342kcKOGam
 Ga3/xL7RQoSEsTxsYgvZViubEc6W5Mc=
X-Proofpoint-GUID: jfjvZP0hFpHKAouob38qCKvJGmfrEm3Z
X-Proofpoint-ORIG-GUID: jfjvZP0hFpHKAouob38qCKvJGmfrEm3Z
X-Authority-Analysis: v=2.4 cv=EoniaycA c=1 sm=1 tr=0 ts=6a7191fb cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=tRHPAiqlqGnVGwjNgokA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1NiBTYWx0ZWRfX1Bh4Y3+5OZA4
 uy5ilJZs64ulCfpB2QSaLhFmbJj6Xq5C4G+LvzDLtmmNVkWfhtAaKVtr1UGxh6XHwp5uIOyWslZ
 dwXMV5T04Ma+G7yx9WQV9907qn22+QipN1BZ+UwaFSk24CiwP+9GB9tY37Q39gINDrxPDRMQ0zg
 scgfc5gQ5ivXgK5UMGpmXfXmbTHb1nQBLpZr+KuV5j0Y9TyRIXiDMywqTmiDX8q0tEtV6N5RMG3
 ZhZeVLroP3c/XonhSoySyuiA8Gz2+3jrKEok7XZXqPOwkfwp86xfFWozsc9Kv209G8fg3p6tCSb
 MsD+CdKQivG93xfjVqjI7VulVkG0KkEePPo2VOQJrNlD+qMAHui2mnLPkhgBhkFU0u9EQ7Ru/A7
 Ds+nhmYzHTTvEw9jmj8K8vEgsRYvV9BFBEJcbK9g2fzvUVpHG+ZNe+ittHE+ZV4ZtFDkzv6MJWZ
 LqMkAe6K/H2ucWSshtA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040056

spi-controller.yaml schema already defines this $ref for this property,
so binding does not have to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/spi/axiado,ax3000-spi.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/spi/axiado,ax3000-spi.yaml b/Documentation/devicetree/bindings/spi/axiado,ax3000-spi.yaml
index cd2aac66fca2..be258c1f36b1 100644
--- a/Documentation/devicetree/bindings/spi/axiado,ax3000-spi.yaml
+++ b/Documentation/devicetree/bindings/spi/axiado,ax3000-spi.yaml
@@ -37,7 +37,6 @@ properties:
   num-cs:
     description: |
       Number of chip selects used.
-    $ref: /schemas/types.yaml#/definitions/uint32
     minimum: 1
     maximum: 4
     default: 4

-- 
2.53.0

