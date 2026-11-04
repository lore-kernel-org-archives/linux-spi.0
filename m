Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801307;
	b=3e6B9zbJ20ci4BYiSuZNI29jMTcDgnP4hNYf1s52n7BHvzp0ueIroZb1yTFFODvtxaIR
	 AHGqbWpaEfy3sRQRVaO3hf5eRe+O5cb/NQsKbahOih6MtetK7OnklYO7kodvkRc3KgjP1
	 ULbASAQvXM0yznWk2qFmWVm2UoI90CRXHmfZp52gEuTFlRE12k2wzIlcgH0SfS7KL+ZOE
	 qrBWLLvVhpXD/mfNWsBbn05sMV+rAkW9aSfP/fltOhlkT3j9RABJyceOtP2hhNyZ4svjg
	 v/uMbkmJfeL+ivkpFxUPJ7ym+CIEPVcXvR/ckPxIQUtXjhRzq+B5CbjZ0KnlXT3QHEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801307;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=zot0p/bJWPo7oa0Gnp4k28/7YcYDzdg0GXScIZ3/7js=;
	b=lBlO9pFn/Ng1naOcPnAn93+wt/YPqT3SKSnLCOhVIgsviSApnKWwJuB2j6C0K5TAUxYh
	 dcfpiiOICzJ4YZ1oRMtUfbH2r7FsGicJHvy9ygO7Gp4SSuODUEW1ptzTiT2Nta+Louqai
	 lobfYRuwCUfqrNqPdl3GzS02V+NY+OtXD5z1jLPSCcpLYs9WaSdITjgwrZv4uox0l+Uvt
	 Hh7j3hE2VLPymWfbVY6wvJ7B4vUQU/ZlGze+BfISeiVEglWpKzKhopdr1eyzKmY4hVXJ5
	 ArGO7Dg0Ia62rXICO0WPdD0C/QZMjPiFkAu+NaPaGPYvfGFYlEPY4c+PveCkK7SR96w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qPu3MPFF;
	arc=none smtp.remote-ip=209.85.210.171
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA246606A326
	for <linux-spi@vger.kernel.org>; Wed,  4 Nov 2026 14:08:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA246606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qPu3MPFF
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8a06e79e152so463538b3a.0
        for <linux-spi@vger.kernel.org>; Wed, 04 Nov 2026 06:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793801306; x=1794406106; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zot0p/bJWPo7oa0Gnp4k28/7YcYDzdg0GXScIZ3/7js=;
        b=qPu3MPFFhU0BWwtGyqRZXHNJi51GUHxalGD0O/IywHF/g8VJphTlG2cN9eBFt2l6LI
         AYxGvhK+uQMoQwe/JS8N7yB5wtOQgW1cD0g3Y1GORKKZHsvnlMa0PDyeuTGaR7sXkqpO
         uX9QGPrePXmUZd8MstFZr/j2+zO7DHUT/HYlPWKqQA7KqYWTbd5G4afFXxuSCqHX5dRp
         uLxxWDZ1+vlkMudYLON0ybHJ2gyLPnG7y8zk00nmHLDytNFpPUEhLUL3RWFzjrUveMsS
         5vXG7acMVwC8JDgPgkbOuQynoohv8Ilr3go64jWdTqvLwxPo28qHkT6guCTjOqunkpr2
         cUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801306; x=1794406106;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zot0p/bJWPo7oa0Gnp4k28/7YcYDzdg0GXScIZ3/7js=;
        b=soN2osu9fp0Tdi5Sfg4bJCwzpxmzKKaF2WtB99Ct5HhFdXjN57rZLM0l2Yrc174PbL
         B0Rn2k5Gp+/IsrK43vD81obJMfYrYUiDVxJlD4uFgpkakI81zjoc5rnsGkETiH7XFpwA
         rO7cT4ZwCvGP7+JT/lZwX26oFJtR4yxgA9nWvjT82aULL/xBujtLZGywnuxK4l/Ods+v
         3TFjkJRP1VP9biVuKuMQbCJ2r4yIFy3FHfT4313wR6ESWOtqH3zEo7lQKrRpuHWM7GRB
         quYf5MlzhIRX/QYuj3kOVQajnfrEx7pqeb8aJwD9vQbfmDxmb46GhbZHcwnvhEOBHANu
         yrrQ==
X-Gm-Message-State: APuU4Z8iW6VaWOfRRV9s4JH8Z++CJf4LQG14T19poi0Dlw+BoARG22Ak
	ssXYvUteyI5zfAPW4zOnxnSCetECnSOIq1tV+2fjPxjQw+ENSPEpgoZwB08C9GvW
X-Gm-Gg: AYBFou2EUqrKqgwHdlI5G+7bd35PYfKIdAmxOpUO2NXUxwgyEayTpvKQSbsM2K1Zy1r
	A+3izLyb3q843WBKRrNK0sib36j47i8FTwF0Ime0V7VK9Czw+eXGv8qUWTpJKvfH3YmXubbdMh5
	2wdfkI4a7AkEP3NSoYwYtjW7r9QuRDL3KnDDAdvJbrbc1R9thZBUmzIngdgLxUci9UFDfq6U7dJ
	QROJw0ojC/VrEMj97CfIBRfmJVf6IOC5EOG12Fpd0lS9WOAXWwToPpi0+Qq7Sl1FbwWxD47/9rW
	yokiw41ca3gpJWpQLclKD+QFefGpAEVTHkyInaOCvPHwUvwlLDEuFbTS/mT2ikvbX5oAirE6D9v
	w9CXPAa5uTaqv4MsKmKOTfUL4Du32Zpqw+z+WfFey+sETg4p9pTI0tOvPiU9abYUc3bL9tjh6dS
	LHdVJyhaknq86jPLax13Ysvq6zwdu0J+stNjgq9Q4Gm6GB7mEeABRuOr11hgGHIDwYnmkWy49GU
	mNF7XAYY1R4ToSjD3QPHgv2aZkhUolbsQrq+3OuUsCKN+Y0NvimcPTfQ7mW5s12bhAewJCobf06
	1kuY8wRQ0AUpF9rzOIlUUys8EuTezm718nyli5Uf1ivsLggiNmdoiAGVegZrBvOzF/A40+E2yh5
	xXclOOtkH1xOjO0Zz28uXxJI=
X-Received: by 2002:a05:6a00:3a1c:b0:878:34d7:69b2 with SMTP id d2e1a72fcca58-8a9bffd63e3mr12245408b3a.57.1793801306022;
        Wed, 04 Nov 2026 06:08:26 -0800 (PST)
Received: from junjungu-PC.localdomain ([223.167.147.108])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-8b09ba508fasm990259b3a.48.2026.11.04.06.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:08:25 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Date: Wed, 04 Nov 2026 22:08:11 +0800
Subject: [PATCH 2/3] spi: ti-qspi: Abort probe when clock lookup fails
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
Message-Id: <20261104-ti-qspi-v1-2-c286943c22c3@gmail.com>
References: <20261104-ti-qspi-v1-0-c286943c22c3@gmail.com>
In-Reply-To: <20261104-ti-qspi-v1-0-c286943c22c3@gmail.com>
To: Mark Brown <broonie@kernel.org>, Felipe Balbi <balbi@ti.com>, 
 Sourav Poddar <sourav.poddar@ti.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@linaro.org>, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793801296; l=762;
 i=ustc.gu@gmail.com; s=20261030; h=from:subject:message-id;
 bh=U1vEy3+juZhyTrIqOxrRZ1JMnCL1ydXUqwk9hAcTFPk=;
 b=1xsyVh0DX1/bSsScN6Dkd6waeaAiNYoHU1ya1DzzvCp9qWG6F1BbUqxIV6L9D/XJj8MNY7ufN
 zELMF/ORmY3C4UeDn28s3Sfm0UXYzNkkW0LU4zeiMo279x6EmE8SO1p
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjDJtbnSeysEBjmOfNYqYUUDS6g7Tfov9W5oGngTBfo=

Return the clock lookup error instead of continuing with an error
pointer that subsequent transfers can pass to clk_get_rate().

Fixes: 505a14954e2d ("spi/qspi: Add qspi flash controller")
Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
 drivers/spi/spi-ti-qspi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
index 0cc8c2d52226..2026fbcbeb90 100644
--- a/drivers/spi/spi-ti-qspi.c
+++ b/drivers/spi/spi-ti-qspi.c
@@ -844,6 +844,7 @@ static int ti_qspi_probe(struct platform_device *pdev)
 	if (IS_ERR(qspi->fclk)) {
 		ret = PTR_ERR(qspi->fclk);
 		dev_err(&pdev->dev, "could not get clk: %d\n", ret);
+		return ret;
 	}
 
 	pm_runtime_use_autosuspend(&pdev->dev);

-- 
2.53.0

