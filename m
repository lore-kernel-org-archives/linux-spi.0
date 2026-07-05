Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDE42FDC20
	for <linux-spi@vger.kernel.org>; Sun,  5 Jul 2026 17:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783272470; cv=none; b=jerl1MDrRyowMk6pKT4XOn87dc8XS/cee/sKweijigq/lKIdiL1tq/Rpbe8ADyPOdTv8NO0Cs4prHlAwzGs8AQW8NpCqT8knsq/HbLm488ejfjB/zfS5z5HWyfhwI5WywdmxLFTBOn6pAqq38nsftKd53OwzeNZJBePRFhAxPAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783272470; c=relaxed/simple;
	bh=1ckByE3uUm4+13CyO4IfazSyNongagIAQn3OAZKxYyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNqcZJW3Bso1SG7D8qYIlVgbu8aOZIUIq2/qasqZYp7KONfUJgY1BDKJujWwAJxxw3LLiyllc0MUfBM5zFF5z8OhRdfEOOH52t3XWAHgzDWh418qNuLWJID8K1gQM6Hf4jHdloxLSBgOeYOaW2ivFckeyYhnLUI1eOmwqbb2Png=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vh80yE49; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C1sTR4oU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vh80yE49";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C1sTR4oU"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6655rsO1697833
	for <linux-spi@vger.kernel.org>; Sun, 5 Jul 2026 17:27:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=HF9WtXRXAlT
	adjq8s83xC7TKFqWceOgFFMrFL2GF828=; b=Vh80yE49Vff3BEWs1rf8TEA9T/L
	jhPsBMITQJ/OjCBf3j4bCIiKE4pTHIKhWeCOtm4+VyGqslGWbUQN4CNf6S5nKRaP
	/uLP9f9fzAAAIuNz8FAUcBrycw90YgjRAstGmUjr3MoA0JluEj6eZCavK8tZFQ5Q
	7imZ1MKsusVZYyXDUaTyz0kwW1qGjCdZYyZtun+iKRZ5Jmtk4lcNj+aSoBNHmeBH
	4Qewv4LrKMqX7EfWEe66++X0iPCcCLbkKPEmq0dHzLxNrnH7f5fms9UsEyaCXvgd
	cvCS0HWPAnOO5/znFPYqGL6JYyKOJ9s8L3L8EJD4BqNITFOZbKoh69/Acfg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6ubgjxqv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-spi@vger.kernel.org>; Sun, 05 Jul 2026 17:27:48 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e53b8a302so209694385a.1
        for <linux-spi@vger.kernel.org>; Sun, 05 Jul 2026 10:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783272467; x=1783877267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HF9WtXRXAlTadjq8s83xC7TKFqWceOgFFMrFL2GF828=;
        b=C1sTR4oULN0BGsi4d/RWxLvnGA3u60z2Bs3zxGQGunYtFASBl7rtAvztjaGD36MPhV
         GCLPilERJrjRJ5Ac4cYsVdjcNoCO6437l106A14cBIJqW9vZ4neQNmFfVX3Zz/0Fwc3V
         5BZ3W+81yMyiw3CSv80i1KOVI4c00PujRdybFcjUs6M0mtG7Wbo4vr3MHH+xwXnLjbo7
         DiWPbhLhBHpBUXTIoY0An1TxCEgnDu6SlJxn4srxJPxJnmhvHnSlBb0SumxNGasPizKS
         6i8Q6cbewbzULB9sfYCkz9OuFjtIU2SG6Zjxv81JPaddwG1uuMxwAcvpF5Ky97OIaaYJ
         nh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783272467; x=1783877267;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HF9WtXRXAlTadjq8s83xC7TKFqWceOgFFMrFL2GF828=;
        b=errF4xVZVVGkek7eV7jeGDqsrw1U4W3QDLvFD/YHAFp8JAj3g56wTZTEgYHbdzTwJ4
         f3EyJO+ScFKbb1xmKv9l2eidyYKj0e/D1wTAA8TBE/rwRmMtBMzSlOT4swSEjxeub0Cp
         mBr/blqPUMQaoOtN02NMvs5WJhZAGya/++ZAw+lbD7bFlbyBUbGKT/w7pPhHmTAEqbiR
         kjlaiX3+wY6WWQXRbjiRWlUuVe3V78908O8IEX6Tkom/sOVTS5cTerNSWz0Xs2rObM7+
         Ykr8VHXWXn+nf4Zz0VllXeoGNxpF6ENOLHnKQWoekIUeo/9Jf+D5hTe6klCNO6drlQxJ
         apIQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq5ja9OIiawgoXSSxEncIGFZfcAGNuAkY/bOaBZ3fDKQoLxG413Z8Ggq9JD+S0qBoNZO5SqoWetUOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGXKMnaDApPVn8Mp49ivxvSSy4EKrywdYQVvV04EesHOtTje1Y
	CESNsQgYa0OqFiHIz82TlpgmYugnzn5qiIPlxsTzIscIyrzBfDbSVsCfGf1QY4UyRJpVWllUNRm
	EsSvThxdnYCOpOct06ttsxbSj6aFP6shoyWko4YJeemoDkUXQtHgr1Jnoe/orMVk=
X-Gm-Gg: AfdE7clSJf/zfCdc3T4mo5RMM7vpzYxIlTP4xTxlzaNO/I7E9DokJ87Y7JhxJZhwVHh
	KWD7gJ5jCEH5gZbYDo5pnsLN/McVH0Kt0bDKenH7hJbsuorTuU5/xL5Ft2cKUs3MrLXVcqw2z19
	m6IKtyBCP2Rz4kPMaBWtd1Vcu127OfigvuHNJ5/A4SqbN2x42LvUPgOFHw/O03D4wc3Q8Vim+lR
	CqnRIktuRpZ7POvPb1nGLeyqXfNjrxBj37ppmaXGFrtGb8R2zynuPflP2maAwVen30IHMJORJ6d
	NY+Wik7+QrwMvOIWqNOzIPNG9Gb4Twe0ANiSFpj7qXfoIAJcSK80ZUO+A+VSwgldCYWllvSjOJY
	UMGUJH+HyuzwMf82TumSh9OQ9Bfk=
X-Received: by 2002:a05:620a:400a:b0:915:cb40:f76a with SMTP id af79cd13be357-92e9a4812a4mr1050010685a.39.1783272467277;
        Sun, 05 Jul 2026 10:27:47 -0700 (PDT)
X-Received: by 2002:a05:620a:400a:b0:915:cb40:f76a with SMTP id af79cd13be357-92e9a4812a4mr1050008385a.39.1783272466859;
        Sun, 05 Jul 2026 10:27:46 -0700 (PDT)
Received: from quoll ([178.197.223.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493ccd9d620sm229444375e9.1.2026.07.05.10.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2026 10:27:45 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH 2/3] spi: atmel-quadspi: Simplify with dev_err_probe()
Date: Sun,  5 Jul 2026 19:27:39 +0200
Message-ID: <20260705172737.120095-5-krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260705172737.120095-4-krzysztof.kozlowski@oss.qualcomm.com>
References: <20260705172737.120095-4-krzysztof.kozlowski@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1362; i=krzysztof.kozlowski@oss.qualcomm.com;
 h=from:subject; bh=1ckByE3uUm4+13CyO4IfazSyNongagIAQn3OAZKxYyU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBqSpQK6l3LukC0wyfKsa+dMt6N5yvXjrcYvrX2U
 621CTxv4L2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCakqUCgAKCRDBN2bmhouD
 13NDD/9+d+CJ4gsPmE6CmOi+fzWNBREdLX8K4wy3t9N2V0+CFKV6990jcxmBbFXnJsSAJxRpZ6/
 yfvJMoi9PZsV9Bzv3H53o/Mg0XQiZMR4e4H7Lhqp1GJFnl/bZfWDYHck7lkVQEZuFhbaS5KVent
 3wQBb8GkSs1KUi8mgWPozh9fq2VSb4hZwIpIX4jD/VfCf0pVmWVVQEmWhFZN/rGYMlf5TqrE5X7
 Oi6a2R6cMBurV8mWt6FhuEh0l4uWigVauxUp0GNGhMXV4GxkU8Y2hQvpVWuMU4ENZ8Qigx8JXQ9
 XbGEdn/rdjBKsAxKwR3CM6O8CRVolW1qVT3Xocmz1CMhg0Yrlq18VCMA7uMaXoin7zbN077s2ZR
 KRKV6AEZnXgHrDmx3IvNlyuWQg4bYLWxXwgWg0r0j39zqpnru9h43gCfomMFdI7IJmvaGGRxPIX
 t+KWrqFeB15hhtA+yzSYomrFqN6lvfNnKb+Fq+jUmx7QPhkGdwxaJytgG0TZn4d5oIXOMgKzdxE
 YfGuVRerEJD244AxP/Z7M3AxWj2k4Q36t1/3VDhcmmzRf7DuY7FMA/4fi4KXR81cVTEhwv1w8LW
 JwL/Psq8IISi6DZJyw2rrgC1KKpzqqCA8k5f3K1lCOtNq0bZBjxb9TjyhlLKFE0JVOUTg4cf8hh QkEXHcAnppIqClA==
X-Developer-Key: i=krzysztof.kozlowski@oss.qualcomm.com; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDE4NyBTYWx0ZWRfXzSCkRm2PGZeg
 nmS6PxswRQpflRGMdxgWmy2sX2+H5NUgQRUhL2L+lh3pX/EZvY87bdF/e4H7wXMs2J6tRHqNh1y
 Gb9eoL4ZfP+TT55U70lSVCIoR/wIuQc=
X-Proofpoint-ORIG-GUID: NejDoiNKQHsvn3SuI8XDARXZJXHlFDXt
X-Proofpoint-GUID: NejDoiNKQHsvn3SuI8XDARXZJXHlFDXt
X-Authority-Analysis: v=2.4 cv=FJwrAeos c=1 sm=1 tr=0 ts=6a4a9414 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=N6niishs+lR9UBL1FN3Qrw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=pmzHFExtw_ipNMRAmtoA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDE4NyBTYWx0ZWRfX1oayx118mpeG
 XPOPQDnz0piHzTZgHC7oZCMMlgAw2weNfccF7JpuTVhgDdP6kxBCl2Ub96qajTRNoAFgakmpgIi
 LUf60roFSxdnEmSq6aGe4dkWMqk3jKRXaXcLYcE5DskQ+VOn6l/i+ndgDZHbHMAMi4MioMogmpZ
 6BsJSaCxXioVtS8VG6J+dnlj/S6VV++0OKeOwYpbg6NHXQXzqi2iAKbe4+2L2fA2kLAB8ldbOaX
 PWrQXWl+yp87PvvSyYkOGz8CfA+QJqPUGro8x9N7qiq+59f1ZTS0ip+Unt9Hm/P2wetQru//r6Y
 ZurCR9AaRqN/TB7MTzgfbS/wjz4TarJ9U/kpMsrVXZtJaVO9a/+ec/5m/CF93HXhSdkHk1HSwcT
 +EuKVEy3WpX05OwbPpl9DPpp2BSiyEd+KQ9gc3v7hRWdGKQKbzogjHWRcz8qP56OI0dLmx35MaO
 usuSn6OHfUs4Bj2/u8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 spamscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050187

Use dev_err_probe() to make error code handling simpler and handle
deferred probe nicely (avoid spamming logs).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 drivers/spi/atmel-quadspi.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index 8d9c77f5de43..e3a4697fabce 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1413,20 +1413,15 @@ static int atmel_qspi_probe(struct platform_device *pdev)
 	if (aq->caps->has_qspick) {
 		/* Get the QSPI system clock */
 		aq->qspick = devm_clk_get_enabled(dev, "qspick");
-		if (IS_ERR(aq->qspick)) {
-			dev_err(&pdev->dev, "missing system clock\n");
-			err = PTR_ERR(aq->qspick);
-			return err;
-		}
-
+		if (IS_ERR(aq->qspick))
+			return dev_err_probe(dev, PTR_ERR(aq->qspick),
+					     "missing system clock\n");
 	} else if (aq->caps->has_gclk) {
 		/* Get the QSPI generic clock */
 		aq->gclk = devm_clk_get(dev, "gclk");
-		if (IS_ERR(aq->gclk)) {
-			dev_err(&pdev->dev, "missing Generic clock\n");
-			err = PTR_ERR(aq->gclk);
-			return err;
-		}
+		if (IS_ERR(aq->gclk))
+			return dev_err_probe(dev, PTR_ERR(aq->gclk),
+					     "missing Generic clock\n");
 	}
 
 	if (aq->caps->has_dma) {
-- 
2.53.0

