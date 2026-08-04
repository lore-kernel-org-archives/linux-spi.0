Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C01C4399D1
	for <linux-spi@vger.kernel.org>; Tue,  4 Aug 2026 07:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827841; cv=none; b=TVRa9jLAOsIhLtYnQImk0EbNbsPoF3sbRjzUGuEiHO3m9e7zeDQF6PU42cXJUFflPXgiMfcmcbLQ3QcteDldvtD56MF1FHqtvJFQHUGFlbKjJq5sSwFSB+Dfa1WgMumlU2p20PWjiIkLRyhN8JUU6mrzU54X3eiKHhjJDOa6MxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827841; c=relaxed/simple;
	bh=vpjPOm3cj55xGdd/EOSoChfrcxstG3L+1v0CwT8/FC0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B+IKa4NSOmkHboI8XsjfJrFm0I6QX5h4xsGp03/SWRWj2LXijyisLBwOrdwzkrPV6Ho2nfnBqLUPq5lotey9taRtxec5pM7IOeLcSWlVz+yRhMUqNotrxyAQVtdSl/7p1NTCJwXqchrWaVUQ+5z29+T2T6qprpXiHYYdUoW9/pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b0j5J/bZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DBXorMou; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b0j5J/bZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DBXorMou"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67429xvE2204286
	for <linux-spi@vger.kernel.org>; Tue, 4 Aug 2026 07:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	jeq1FQZMP/z+KoXn/UwCyrFH24Dchmhq/uExQ74p/as=; b=b0j5J/bZZv12TD7S
	Fw8b4ovxRgHdkLZMufTZV+bK9ZhRd42bbSEIQPn9E085TreOJBeq2kzaTNsxPMC2
	Km0PBi10KW7cPwxp9pWUBM+CI3heGyzjI+W807WFGPpuXTUkN7sXvireXgbG8Mlh
	ylOFV0Y7FGpcgBdtGNS6uT9NGySWB3Hds1gZ1ENXX5f1vs2EGTPMUlDeDeRc3sZ+
	0mSGZVlo+093B+lETQv1j+jx8sm4l0C3kUYDsch0Aku6b5J4qPRAWxJkLvOO9VCo
	Rck6mLtGIOPOjkPBoXqaF5hGSSD/RI27rvPmMbRGK0ledu0zhgO1jYGqECjLF3mX
	f1/u3g==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fu72713fu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Tue, 04 Aug 2026 07:17:18 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8f000e221d7so45713736d6.0
        for <linux-spi@vger.kernel.org>; Tue, 04 Aug 2026 00:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785827838; x=1786432638; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jeq1FQZMP/z+KoXn/UwCyrFH24Dchmhq/uExQ74p/as=;
        b=DBXorMoufZ7V7y+7sMzAlaQ7+JDOYDPfTtShw5tNk4il34DhThUAnlnF0RVAGwuOcM
         o/Dh8nmqJuct1Ot9ZjQ6Hdt9pilJiE5PGfXkJy3fTBSU4Q9da8+0ozTFcpkmDepWYbuV
         mCb6HWl2ZkacQDXcGyaupzozrJarSnejQKHaRSJXffPSoowfCzmyqS2B7OeZ6qdyRpH+
         ZkLseA0DL4wWL29vYcyd4MMPAvlTRKuHWHZsaTxuI1XqRg2zGJliOLwTluGTZLmTaVyQ
         tt0Ota63J7wotuy6OtQZbKg/u6vdxX4LAWpZ7bJZ+c9Bs0Y1+iKZEOdojlUnd78HAchf
         McuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785827838; x=1786432638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jeq1FQZMP/z+KoXn/UwCyrFH24Dchmhq/uExQ74p/as=;
        b=AnTdVkgaiw3fgJprUWRy53xH4sEf72s5xHZxg3fKaB/DmtptRrdDnR3xFz3CcS2xKr
         9U/4h8347WKJrH0niH0vYE5KPjBQ2H0xryaJxPl6zdn6eJc6XftDmPDsnPHwZ6kSSHXc
         XSq4EAn+Uvud18HiWXFlFG+NX+5t0FpCNzd/sK6cJyOoOVD44z/8rwZOJRBsMyjEZWUp
         9QZQrP1djUyQMgtKoPcJ+WJziIqxUR2xgbwHR5P+NlM57OEtMMIuVawZpiGkt0SqziZr
         x7fJGpB2JNsng2G1dMZMtAQwy/iHPkQnqDNQxn1ravmmZvpd8QMURvjECjdXxNDgKZzD
         h4fw==
X-Gm-Message-State: AOJu0Yxj37macqagX9Gy8WPo1GoEsOtO8qezeL93uM+Nwwl8/INqC5xy
	HGZ+t7np8KpeBpiOkUrGrLbT/ofgyguEAkcv50Mxv17LtIsuEftKhBvQ+cto/V9Bc60uZeh8U7L
	7mXcb7myCInrbzKI9yhNNabc025Yh5iq6UOqjswXXlZavs0n3dfhFCKsnnaqTi3o=
X-Gm-Gg: AR+sD12z9G/DLJq4WZBoU+vtGR6yMgSxSmLKYQWNiDBdHJsQ1UetiE81nqarjU140oH
	thjWsugF83jpDWQpEesYdkfCk79mXTQpun8MzSFj3/863imHjfQLAoKFmtTZZbzqIL0eOu+MVLz
	Ee/dNX6mtlDE27UqMVlAj3sWLfGnwz64nXBKR5ZuTiysFEk7TzrTnAjSV+tYFt30LsJaQbH3eyT
	0XJB66ruisAynnLFmPLJMCczn3RO+IKpxJtRyAEr2QNveBlg/noWu7ur3nKaZ+ztZVKoIO/BRgM
	INg/lxA5Dj3qn1C4aCDTCLZCnJ2PSHJGn03g7qAlWtYGzKOMJgnUxqFyJgZBcUmDZg+ItVAaf4q
	0Mp3t7+nVzma0liYsVllwu0B9
X-Received: by 2002:a05:622a:5790:b0:51c:92a0:b2ca with SMTP id d75a77b69052e-52b56796944mr276102951cf.34.1785827838492;
        Tue, 04 Aug 2026 00:17:18 -0700 (PDT)
X-Received: by 2002:a05:622a:5790:b0:51c:92a0:b2ca with SMTP id d75a77b69052e-52b56796944mr276102651cf.34.1785827838082;
        Tue, 04 Aug 2026 00:17:18 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.214])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b8d04fsm420265975e9.3.2026.08.04.00.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 00:17:17 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Date: Tue, 04 Aug 2026 09:17:01 +0200
Subject: [PATCH 5/5] spi: atcspi200: Drop redundant andestech,qilai-spi
 compatible
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-spi-num-cs-v1-5-4ccb13dcc7b0@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=841;
 i=krzysztof.kozlowski@oss.qualcomm.com; h=from:subject:message-id;
 bh=vpjPOm3cj55xGdd/EOSoChfrcxstG3L+1v0CwT8/FC0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqcZHvKYyBX0HJqdTzsTetFJ/1SdRnFIw572j77
 MJ2k/QKLGyJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCanGR7wAKCRDBN2bmhouD
 16SzD/48sVjwnveKEw8uD21xQl6zoA8Ch2uI2VMORVCojyGpTpksje1CXf4XxyikjhGAcM2h3vP
 zmbUeFIqWIquuQiaQXVrKmZzEyG7sRsGwh3V6ZcfLMsmvUp9DGxmEKiUdtAGw9au6sv5Uld1TkY
 n6/ubG0Rqg0OlmciitI8RFE8XofIGYNmk2QCF0zXi7ssd7iFypUhqjeVkYAh7+1YcWv734pQGxn
 F2ffhH9qp431HaInw1u2RlOj4O6w8h347tfNjfAQZYl8MKsL4RcC/gJc6O4ZCs4CQxsWA4YwH3p
 vq/py70uI5YWZ1bOSjpO/kOPw9TG+qUfG7pNrFo10UcTv8IhjhfVt3drDpuGXP2lOpehhxRnGbp
 HlFMZXbnGGaDex8yGP+fVNoyEgGAr/Z21ZboHYjQGWOnswDCU3qgvriAjJEprsUDan2FQzEszH8
 Y9tRL6wsaciOWnvLOZEcKbiAYK+LsHfh0ptE6419EhsBF4NT1CED4hqWl+iEM+aYHRp4Yv7rUgV
 ka3M5Zal/fs3AnjmrA+3MObPbx/iTa6ZKEtMm5S4bXd/8pBhPT8hipdTJOnyrn5WC1GUhVQMwGp
 fq7S+FnoOS6mpgY2g9nuEvgiUW+4SG6LktSesv9EQpAFkD+tqSIIEktVbgF/E+XLe8DcAlKI0Q9
 XZb+s74PHUtB3gg==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDA1NiBTYWx0ZWRfX0iK9eEQdZiUk
 NditzjqqulPYf9eME171VzRThDBy23FYwiH5Fzj/bcfrfaVDxi973zP9vfIw0+rt0FuT/4zZh6Y
 1Tj5i0PZFpyaHLMltwYEY9yoB5TGPfo=
X-Authority-Analysis: v=2.4 cv=Z6Lc2nRA c=1 sm=1 tr=0 ts=6a7191ff cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=+bKQE0WJfmhK2875HamI0Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=9l9ugx5lC3ssAmPyifEA:9 a=QEXdDO2ut3YA:10
 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-GUID: b6JJmlZ4AVbOhb64MhAAgoNtz_CQnlqY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDA1NiBTYWx0ZWRfXzeay+gE1ty80
 AJzHTzci+0r/+03/weOg719zMzfsLX2dYhm9oFkbCE+HwpeUdSL5P7OajgNm3vHmWvwXPSoVQe2
 AALRooDarLtt51sx4RwUJSr226pP0kjMHLl+VCzX/exJdaTEC+UVfbJzNHs4okL8jQAQrYrfBPx
 5C2c6kcgo2ytKp44CMC7lfHcCPaJuWpua1oO7HK8VbDkpjjOt2VllmOHYbCld+eRUP76PM64caC
 pigCcC8mggG9EKD8XYEOpOaaAU8KdMdEICo1MNJ9K86ZWsGgKYpzaxa1jCGS3tug3+eL0BxVVke
 mBdN0Y2rPvMy8J20ZOtt/Oaqsu0OicvGVPK1T40Q4RJchUBal4WAqI6zuKEMZeqvkf0JX37vWvw
 k/aCU06UCCelYLnWRDlf+Zf5WrUogbi5Czw1XPCZE86cg+JHTpExk0vCXqEnYKVEi1SuQPQP3gj
 8QSs8W+nYUV0qUTrPqA==
X-Proofpoint-ORIG-GUID: b6JJmlZ4AVbOhb64MhAAgoNtz_CQnlqY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_01,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040056

"andestech,qilai-spi" compatible can only be used with a fallback, which
is already matched by the driver's OF device ID table, thus it is
redundant in the driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/spi/spi-atcspi200.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/spi/spi-atcspi200.c b/drivers/spi/spi-atcspi200.c
index b6ea8e556335..b532c58c0ab9 100644
--- a/drivers/spi/spi-atcspi200.c
+++ b/drivers/spi/spi-atcspi200.c
@@ -638,7 +638,6 @@ static int atcspi_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(atcspi_pm_ops, atcspi_suspend, atcspi_resume);
 
 static const struct of_device_id atcspi_of_match[] = {
-	{ .compatible = "andestech,qilai-spi", },
 	{ .compatible = "andestech,ae350-spi", },
 	{ /* sentinel */ }
 };

-- 
2.53.0

