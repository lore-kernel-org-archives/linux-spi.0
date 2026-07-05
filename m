Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991E42F9D98
	for <linux-spi@vger.kernel.org>; Sun,  5 Jul 2026 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783272473; cv=none; b=Jh06UtEYNiMbv5k2qgZMs+HvXLidBiy6frU9oO+F8Vc2NcsHVufrCT3m0kU0VpkLC54DXUwQf+P6wfSZ6I9itrB6juHIoBzJcFq/Al7k4akr7Gu/+286S1CSMZDUyPCu70xQ6AdOpUJ8wDPv7WZaIqJZ9boR4tHohozijUeun6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783272473; c=relaxed/simple;
	bh=P9J10BvKEZJOZAosLxhYRgf4Uk95X2HaNsxkX+MKIEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sir1MVs71RHPqaj/fOz4T6ozFhGzVzn/v4kqKvNuby5tfSpwsmnq7wE3OXUvGraEeGgxEffOH93ucq/UroLWrLKxR0eLXTBYDH1lyhpIzjG09+rCrJdf7j81hQfFAlXHPnXen/AH1F3RpqACN8tSJqFLwG1itc+zCHmEdREkRbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ngjoLA+V; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PIzGWDVa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ngjoLA+V";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PIzGWDVa"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 665ExFHo1855043
	for <linux-spi@vger.kernel.org>; Sun, 5 Jul 2026 17:27:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LekL4u7UoLo
	aBqxCsrILgyphs2DOspCL4oBgT1QVx+I=; b=ngjoLA+VIsMByzoAOfko7Hf1Spx
	j5p91xhhDcXfVqrwdNmLgGZB1qznQaHCewddvPZ3ONAn9VpWBbfgk9oZgKE1rcNY
	m23aKQvB9a3Ja+yPJhsRcK8XOF6+zCzKQHmTzbfoJrFLRQS1J4/apv+WVK2Lozc4
	l8Idj7JKseLxLZgzsWQjPbHqs+IwwcRV+Ol6GXfBteCFZ8w0ySBv1DJulpA88csY
	MEeeSrFBlFLySyQBemrRe+g5JsQ4727R6p3U0DkdECowBobHvzvb59JNWmtFIBzY
	3LUQ7pOABF/XaoMq3eVcLZerClichvKCP9/zPfDYXm3O+Tkzj9xEE5UmYTQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6uf82xvv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Sun, 05 Jul 2026 17:27:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e53b8a302so209697585a.1
        for <linux-spi@vger.kernel.org>; Sun, 05 Jul 2026 10:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783272471; x=1783877271; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LekL4u7UoLoaBqxCsrILgyphs2DOspCL4oBgT1QVx+I=;
        b=PIzGWDVa9rRVtg2/o7b/NJBG0d9UU5gMTLgW1JJsCuqRgnYnaihpjHkSuP6Pw0kMQ5
         /dNx+a/T9d6VIepk4LlGK4+F+CZbq5NnDvV+qlSsJLi6dhh4OpXumjmf5jLAfG9ofZ6l
         z+uJ2HlnO7+yU+pMsOLXXtUCt6aWRCbz7Mqsz1BcTyLFhjhLntcOu7A7nPZfxHOQuW9C
         t1BfvCwULy2gWp/+2NizcKMv27sCLPNCc5d24ytAuAymKpphmCooruYPfLh6zvTXrMVG
         dPkVqpeeb/fhfNB99cagUH5voj2ygTY9lRWN9m9f2JbhhfojJBYAeC1wSDDifSifVGjr
         Cx3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783272471; x=1783877271;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LekL4u7UoLoaBqxCsrILgyphs2DOspCL4oBgT1QVx+I=;
        b=CuhHIW/AuY7A8+Qb8qsUTn+ctdcKE+XebPuO00Jw9xLdBMD7aAO6dt0IVSeQOqj66e
         hFVGvl+jd12D/ncuZSmoN7ZePpj69yk+rMPPKkYPcLqfS6PAsoPmKGrvI4zaqy+tfsTw
         1qerr7iBr1EVs+LB2cwuivIS6AG8q43hM4OSpeeobUOJXYtZUt9tfXwlifKaAEwQwqMZ
         8fnQvsEM0jvnhzhz2XPck1g1gW30rR9UC+gwtnpOwnibeZ4SEauwnpf6jkoSTO/yKw5z
         mA/8Dh/E3/uYKLoDS4T2LABwUxMW0zY96u8rcGwBEzAlxCxZ3ZpdaEp6GWqSiVWvENnX
         4tBg==
X-Forwarded-Encrypted: i=1; AHgh+RoNmE8bqsJJxLx/gLMnJe8enZJN2hsmMTJfX2RKJ57Ai+9e1JpsPJu0oLnZEgGe6xOpnAYvmQg6RYI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXNYf2y6EoKzJfkKd8ek7s7kEinjOv7tFKJ61re3iJhMVC+Ebl
	IBrnO6axqoH4VCBkotx/dF2nBfy6zjArWVkkPkqbOcwAgUEbTMdBuy18bL5XtBoUMHgjJYcH6y5
	v56NPhlE8LCWkDTQasxLZ8S+8urTZfvujYQULB9uDBN5+b4MbrZyKFbKQE7NA3qc=
X-Gm-Gg: AfdE7cmRO8VW+u0O5QV/3ErDlqzon1g+1Hf/6rqpfvuz+qXexK9JDOkaEqPSFG/xvPc
	PqKYbJ085Ig8XO6WnVnBGUm+rTIbygT16onKdKd1Euncl0jy2KXCQVouV/v4vUzXQv1rFjW5xYD
	jDR5UmmpE8LgvMYkoGHaEUW677ohLEX7ahXwuSBEEXNfZw9V3ugIgAWGW+LoD1GKowmiVOgdu/w
	sXgaaVoV1jLf7GXby5ZSH0oUN9Rdl7IhJqSzHB2RBuXyw9aH7+Kq9PqcDPv4Y12DAU4Gu1Nzi9o
	NiLhsSu0p35e2moN+cYKeEGosCxtQ/ykggtnOaBKSFOTG/MKQyfNV4CTz6xDCPNkY9lIGhWqaay
	TKfNVHb8mWWPZ9JXy7ZKNGAcLbP4=
X-Received: by 2002:a05:620a:2988:b0:92e:520f:1631 with SMTP id af79cd13be357-92e9a35b4a5mr972020085a.1.1783272470938;
        Sun, 05 Jul 2026 10:27:50 -0700 (PDT)
X-Received: by 2002:a05:620a:2988:b0:92e:520f:1631 with SMTP id af79cd13be357-92e9a35b4a5mr972017785a.1.1783272470462;
        Sun, 05 Jul 2026 10:27:50 -0700 (PDT)
Received: from quoll ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccd9d620sm229444375e9.1.2026.07.05.10.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 10:27:49 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 3/3] spi: altera: Simplify with dev_err_probe()
Date: Sun,  5 Jul 2026 19:27:40 +0200
Message-ID: <20260705172737.120095-6-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705172737.120095-4-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260705172737.120095-4-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1422; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=P9J10BvKEZJOZAosLxhYRgf4Uk95X2HaNsxkX+MKIEk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqSpQLfSnlXo4JfJU9hwN3doCMaejxtvCW34sVZ
 4AkbLoOGT2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCakqUCwAKCRDBN2bmhouD
 19TUD/0QvRhs6Dt01vGhm+TMph99zRD5BkkvBp1e5C2vC2Actyfln9bHa0TMebitH1c42u8ESuD
 vTmty3sMG3A3dtGQ9BdCQLz/PuSL2D9PQEEdpxX8Kws2xQcIG9g3KVOajfQI8Rm81Bn0lKrrZbm
 xaORM3xDeoJprFUAA7yvSBQVH4Wxcci/nL0byuXxy5KEOlbD1xKMBBIVdJEXWSZeLh2fyAk5Yk6
 lKzchcaPe6DPSHtqT43xwi846ICobGNU9kyrSky6YoRBoZKe/eFFZYh9iwTkZBO0jKdc6pEGyuE
 jw/63Hya4y8ZsWV4I5boChUPxUMR4HCwdN3P8JgvPgbg7RpT61K+rwfV/aDLVoIFJiX8UN/N6JV
 yPHRjy5ypwScVeap0gF3Oi2KQVer2IRupy8JChppkChQtNIRDLUMz32UbUo28MC2wqHSTkiNyYa
 iw//F20wrLrduVZ+gNI0SFuWh1pGOSBVF1yah1af9x4cObWyKeE+tnIJtD2GxBwCOlRtnoKw8I3
 EJ1hCA/2FvxJywZcsfma7sxap49P0zNizLsE1u0h/VyYFnrCi1hubv3KNPxlSvErv/f+dc1Ad0i
 1Hbpwd2sixN0ohmu7Ro/YBc+bvpgXkH3QNfyEL0FjbJcu0wCkvBxHVXE797bFw5oGAmmAp61gjW 2MsKfg83+qmWkYw==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Pru73mh-JX9n0v2XDn8eCNhdaxm4_Rqj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDE4NyBTYWx0ZWRfXzFp3FeVcsEPw
 Dfmrn/mKrs7hF1B5mMcTzRd2EzENJWkKu7a86aV1qaZAkT8rko5/+9sS12fq2VluCY0H8KwfqMZ
 qyR3ne9Q4NllcPtJ+5aJToXxQXSISRU=
X-Authority-Analysis: v=2.4 cv=Z4Tc2nRA c=1 sm=1 tr=0 ts=6a4a9417 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=IYC4nHEeTJBYaFFm7d0A:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: Pru73mh-JX9n0v2XDn8eCNhdaxm4_Rqj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDE4NyBTYWx0ZWRfX89LPkeD8dNP5
 TQZM1TXHo3+UKSoBkqJx7d99vkPztL5lWqaCYnSiSEuZ8UoX03a+Y2ABthb/R1/LZHwqWN11hUX
 PcKrqKquG8jA7Ip0ZAGmaN8IP7i92k/AZuWlrcRrv7GOVa4rz4CBtK8733tF/8pp+807rUrzHBa
 2eK+d37zLdIUICEx/kUWcUvMMRTkDuWHQeUUatYuJij7TJloI0Vkare4pRPybAFwuM69fuwcySL
 /o+BTj7N9ERdKSNGqnHpHu8SofY2xe2+t6+bm/UXwjZwOATMW26UGWhRUJFZFlpD/HRF+PuhrTO
 vKeWHmgXw7k+wjXe+uXYU92Ylja+pKzR4+p1tBWhtNVfGS6npvht0dckpZWbo0YBOr09bY1Ce3H
 pA/uru4z8XnX6KeudZdgCSasLBKmXUFjPGJ8XHM9m74ZDjTx+7e6ANJ0avAYuWh8Birk9ROOmFv
 wdVAFHgN4mTs87pCQJw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050187

Use dev_err_probe() to make error code handling simpler and handle
deferred probe nicely (avoid spamming logs).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/spi/spi-altera-platform.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-altera-platform.c b/drivers/spi/spi-altera-platform.c
index 3de7df73f216..4fe69ce9da16 100644
--- a/drivers/spi/spi-altera-platform.c
+++ b/drivers/spi/spi-altera-platform.c
@@ -77,10 +77,8 @@ static int altera_spi_probe(struct platform_device *pdev)
 		struct resource *regoff;
 
 		hw->regmap = dev_get_regmap(pdev->dev.parent, NULL);
-		if (!hw->regmap) {
-			dev_err(&pdev->dev, "get regmap failed\n");
-			return -ENODEV;
-		}
+		if (!hw->regmap)
+			return dev_err_probe(&pdev->dev, -ENODEV, "get regmap failed\n");
 
 		regoff = platform_get_resource(pdev, IORESOURCE_REG, 0);
 		if (regoff)
@@ -94,10 +92,9 @@ static int altera_spi_probe(struct platform_device *pdev)
 
 		hw->regmap = devm_regmap_init_mmio(&pdev->dev, res,
 						   &spi_altera_config);
-		if (IS_ERR(hw->regmap)) {
-			dev_err(&pdev->dev, "regmap mmio init failed\n");
-			return PTR_ERR(hw->regmap);
-		}
+		if (IS_ERR(hw->regmap))
+			return dev_err_probe(&pdev->dev, PTR_ERR(hw->regmap),
+					     "regmap mmio init failed\n");
 	}
 
 	altera_spi_init_host(host);
-- 
2.53.0

