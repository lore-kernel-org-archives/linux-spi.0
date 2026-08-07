Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA6E47011F
	for <linux-spi@vger.kernel.org>; Fri,  7 Aug 2026 10:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786098600; cv=none; b=JUXVYmT5TA2SAFENlNxVnk7Vnr1eUJHVgp+NXKHMJ84kBlzDRpk0UM1cv1ug2VF2ETAoig77n+0jNN6XJtRZB3cr8fPAd/wBw+jXZJ4xprUVg3B8e4NrznRfSmdKEw3CPpWNG0IytpnSpbOIT9T8Yq+E/i5Qo9awm6IVhUz+XP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786098600; c=relaxed/simple;
	bh=njcYR6m1kVS2NgkNl2yY8aEZfR25fem6Vj0aYE8NnBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SnSiChtnNYT/uhJxfHtacwp3Vovdn0IDs18RTtjMLWcBplEVss8lv65ERJ5ogunbP8QLPr+9kw9vVHvUAExsfiX5PcDbp+HmRop7Fq7lV6uWo6A0p9ahzViZn3i5zeCfSAf1Y8f8HwgdXdIpgWWTG6znDH6O10p0c4vJqF0wmIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyrV+Rti; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyrV+Rti"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e347638adso3615701a91.0
        for <linux-spi@vger.kernel.org>; Fri, 07 Aug 2026 03:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786098596; x=1786703396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4E+mVEpkDh0k8bNZJNbHh0uHQtIkBEm4hCBHMggYxlM=;
        b=iyrV+RtiJPMOfa8R1jFISLHNpMEE4ePksPm7bgra16xIdePdMz2jyRTeAB5Z+wKcbG
         NxJ7Q+01Onr6cDlfSjnTvk2pXedB8o3S80yXsT0q+fRx/tkq3lpQhx839zlSMhtqcBUu
         0Vu7cuLGiYUWOoOPndRC7EcZiB/mxQPl0ljQ69FnsvPaJpp0g1FWTjyY4Uwh+2bLWijY
         Lny4fyn9M8n+e5wqbDxSch0NniSe0UnFs+kuV8I7HI0JVx3ydFalFeh3SYlaXXIK0kX4
         6p9csVi1ZQxpmOGGjyk1yITDnptTDNTCfTZSI81Svz+Wn0Rqhg41hGTTFol7rNKiZDv9
         aWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786098596; x=1786703396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4E+mVEpkDh0k8bNZJNbHh0uHQtIkBEm4hCBHMggYxlM=;
        b=pwHh+motSlaB7qxMz05rGf/Vlf7oCnWKFkxw6l5yXGL0td+EYBhK6ByiKzVkvmWT4M
         m/RfXMriCMhlvvENGAendmcRLVhuoo/u7351a+p+HhPwi7U+6rcoHhMxI1Rym9oM0lV6
         eZE0jh86qYTtSX0Diz1fuEzlOwEHXIynWU5PpSrNNdTajTOK2SNSvwanG4L8Q7ki9wkt
         azNJmscwkByjeHvIdelGBGeja21aKYyRp+1nhLucnT7P1afSIuw2EZj6HFZUs4FrYlXe
         bChMNwJaJFTLC55xkN3WATGsmEsTdgnAqNek4FhZ36mrwKCeoj2H/8m3qTGlBAC9yQ5V
         vG+Q==
X-Gm-Message-State: AOJu0YwpXvx6TODJPgciXKYsFTDOeWH8TvQrrUtbznYVl3ToYf0WMLHn
	1OFQCVa/dnj7gr/rD4oD/ZHOYtOGUkvQNqBz+vuzxpGtFANxFVNGtFy6k+qwlw==
X-Gm-Gg: AR+sD12NbKckSycVWfM5Ils0Vy70kbRS/YaR51Wry2SGWcWM14Y11n7PSgNpE2Rhjc1
	BV48NfJNGbiGDZNnoNHJQswZdp1F1PPoVcwU1KREo86guH0NFUMIQioTbCElisxuao/I8479egY
	OEJIcVJLtbJyt0cSsYZrYuFXwvq6i6TRlTuX321xhiqHRiYst2+UVVHFwywXM+/G2bB6gNKCx+3
	2Ytnzgj323nBqFUKl5Y/VhhVeoab3HM5Uo31QBe7Ne75tVqwvffOEp+Ygfs1t81J5YLYA9O+dM9
	dRyMurJIhn8v+zPvItrXbpValJeVO56k2MF7lGlUjGd0aAQhHaKksp41X32hEzOHbTxXhfz92aW
	qoGFmNNmUymYnnrBSF2Yr8bRiCdClDzSfoas3UR6/c7nLqR5ufR0zH5ImxPeqLwt/ViFMnVUSkY
	PdaS0soFHCdVJG/A78DtA0dX2+jnYTeGasxg8UlO4UDTqjjuZ+G3b29GHTpj34XPepheN9BamyC
	jAVb2b6mftdIerz3XYqrKgCge8qTJprj30SuOw8ZtR1YdHsLxmYMd5l68jv7a5NPHZfHkR+jmpo
	z3GI
X-Received: by 2002:a17:90b:57c3:b0:38e:bfe:81e9 with SMTP id 98e67ed59e1d1-3903c5589e0mr24025142a91.1.1786098596171;
        Fri, 07 Aug 2026 03:29:56 -0700 (PDT)
Received: from phuc-desktop.. ([183.91.15.56])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-390b1389e1fsm1133614a91.0.2026.08.07.03.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 03:29:55 -0700 (PDT)
From: phucduc.bui@gmail.com
To: Mark Brown <broonie@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	bui duc phuc <phucduc.bui@gmail.com>
Subject: [PATCH 2/2] spi: mtk-nor: Propagate errors from IRQ request
Date: Fri,  7 Aug 2026 17:29:31 +0700
Message-ID: <20260807102932.45785-2-phucduc.bui@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807102932.45785-1-phucduc.bui@gmail.com>
References: <20260807102932.45785-1-phucduc.bui@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: bui duc phuc <phucduc.bui@gmail.com>

Treat a failure from devm_request_irq() as a probe error instead of
continuing without an IRQ after only reporting a warning.

Return the error through the existing error path to ensure the driver
does not continue with an unsuccessfully requested IRQ.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
---
 drivers/spi/spi-mtk-nor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-mtk-nor.c b/drivers/spi/spi-mtk-nor.c
index 6b9a5d728549..c1e15246120f 100644
--- a/drivers/spi/spi-mtk-nor.c
+++ b/drivers/spi/spi-mtk-nor.c
@@ -905,6 +905,7 @@ static int mtk_nor_probe(struct platform_device *pdev)
 				       pdev->name, sp);
 		if (ret < 0) {
 			dev_warn(sp->dev, "failed to request IRQ.");
+			goto err_disable_clk;
 		} else {
 			init_completion(&sp->op_done);
 			sp->has_irq = true;
-- 
2.43.0

