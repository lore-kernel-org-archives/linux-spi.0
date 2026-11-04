Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801301;
	b=FHxhuOpnT3ecjy8PipplcRIv3/92/dogHa46xzqMd1waEjpGPk6NBHJpKlIbZrLsRoxn
	 ktQJMlwpInFncf2qNt/7jB+X7ByOa9fAPtvS/KkdyOMYhch+tYea7NPm6Pl+0iY5txAWF
	 4FKKKDYcp3Bt8nNczhdo8PZhmA08Dj0jgThCbtzi7Mmb92OeJ7EpZ1nZM66jzqjmmB1at
	 vlunDI52rlW7tQp7OYpVX5Gpkzo4dIKLfF3wpCUrAnE3Vvc1ZYiQ0uO8uZKSB0VPQArpC
	 wo4itvWslYVb0lJRt4vQLqSX7Mrj3dHhaRy1vgpAyamrNuCNfXj1Cw3cLTN32HCayWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801301;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=M3Hzv5kDhkXzamwAmpF1JE8azdda1/6idfHsuWT3Guk=;
	b=3tJyD0EwOfCBbhFuSohzAZSrRWTd+9CNjW/U1gU1SgFx3K25dU7saU11fMMfe/BhVOYy
	 7uq+Z2MqlqHR51DlVI1aA3NPrra5CK9d/2k8JEBQDCmriM0FVmBWjN4BNxioksRcYX4BA
	 WlImR+dl8xprUQTQm52snkUt7xJWPx3Cq5zjKX8ANVLtaUUqRlgLmtxWk67gNvg18Wsi0
	 qwmfxuMf3+vlip0Mdgs1QGasP2EsWqOqYjvmVXJSoNVSsQO5nVU1xG2vmeEelW6sZbrLM
	 cmXine8pNUztxsonOzmDIOYM/XgL3SxDNoq1xVeDRLrkK2e+/BjeyUnMhKmkNRmnePw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lc0ULAma;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92DA606A330
	for <linux-spi@vger.kernel.org>; Wed,  4 Nov 2026 14:08:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C92DA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lc0ULAma
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so374307b3a.1
        for <linux-spi@vger.kernel.org>; Wed, 04 Nov 2026 06:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793801300; x=1794406100; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=M3Hzv5kDhkXzamwAmpF1JE8azdda1/6idfHsuWT3Guk=;
        b=lc0ULAmafTcWMpNJAJJkxlVLaXiw0vRycCUzrspZhNdJl6rP19qwERwfFLeq1KGmjp
         q1C77h2mHDe23t2weD91eovzE9K6B/gc2cHLaTXu7exWrakUKVAYDePcMFoPJrLdONFL
         H3rP/1mqsPpem4Q/vqjVYch6rE4Jq4miBNnRE+rSvBFN1N8JC2YguEzMewvZIJLtbfFt
         3UVEXY0we/bS4e0vz+dz+wjn5S24SDn0FXi0SKX9pRPI56CXztCUTKiis9RtDglirXLD
         9emJFbGDH9S1y9R2EtjWHtaIpxUVYz9Ut4AiNon/870J1j5NJMcm7j619EqlhoYcJWuA
         f/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793801300; x=1794406100;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M3Hzv5kDhkXzamwAmpF1JE8azdda1/6idfHsuWT3Guk=;
        b=Ii29Z0ITBx0i1bfFNL4ZJIuehjaUh/NbXWl0i7fHd7Eo6uBLauR2w5DQ/kUPxCmfnc
         oemXHLCj+t7+rRMKZV7H5obgaDAkS72L9Zg8vt/Rxs0jPfspFiJrm+pADZ9+WtIONRyr
         70gSqXMFttjcaEADTPcEkd9v5H6LacXV2IVE8yrKpXVJbYrFL7fKnMVFY4H9OJGrdNqb
         JW+E+67tIquTWB/WDqzycM5+nVRwdrc8CfxlmFT/jYqongUfTR100wmNwmsBBmnbeLla
         zDNbLnxCo1r4O5Ov97EagwDMluGO4WGjWzN9usm62w52P71CZNMzrsM7FU6K90rKb8fe
         0KVQ==
X-Gm-Message-State: APuU4Z/V9bY1AVT9DcqE0VU9S0vW0Ccgc65iJRdNhAd1J4e23EryatWi
	wKDIkezDkJVDKLoAZTZ5k6F3k5D3xwnCR3mfpX9xDTR/UmY6kZeq/gX0C8aR/zC0
X-Gm-Gg: AYBFou23XIHHZxbntVsDZP4GL/rEqWcfzqnl2on66+xIi9vE4nmV3s7Xq+86bmmeB0V
	ouWRXSJ3f66h5miTl9+v3xT7zRFwbpnqPpnHw2JdDgEMYTt3IDhlXlNqmNqN2GTSEAl6qJbQ45q
	H+pkxYE0YA+FaWYTFgdn8bQPk30CniQihSdLe2n2qVyKvucBDeCJE/1Kv8ZzrzYlSgksa98eIVU
	tsEUo5rYER9UB1/FGNz4n5c960wxpcJ4mLlIDSeXCMhdXrXc08fmFenoqjcPcacnj457KgNZwxd
	W2qhe1dQdQwAscpaBRtAUu/Yu8TG1Xcv5nXzui4chLQRL/TYp5PEHcz3ufDAxNy+eIQA9GUirMe
	yOCWATYiQyOQ++mnNe9g40UAN5dKevldOR8Y7ID1QhdgNpvPS9U2N1p1STInBZwMLLs7OeJoqG5
	yqI1/wc9UeL2g3RdJeI02KUlcuhoR3PFB9aseF/vOh25hVUm7KC3xhEffGYCfbMTx0O1fJIBQ4g
	hbGyBuC29FausNO3M8w/856uJJp+LjRjFpJWRBqSdQHF+ak1EuaHL/PHDx3m2oUEX7xyn4thL+K
	bQxDX0WzcHK1w8HZDHA6RPfW20Es5fukrzKb0+g9snM/GlRhhvot4lUQ4Cp2Dy63pi+iBRjusqk
	ziIEu2yn9mK8tdyCswJvd7u0=
X-Received: by 2002:a05:6a00:12dc:b0:8a0:18bd:ddb0 with SMTP id d2e1a72fcca58-8a9bf71b34fmr9870643b3a.26.1793801299832;
        Wed, 04 Nov 2026 06:08:19 -0800 (PST)
Received: from junjungu-PC.localdomain ([223.167.147.108])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-8b09ba508fasm990259b3a.48.2026.11.04.06.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 06:08:19 -0800 (PST)
From: Felix Gu <ustc.gu@gmail.com>
Subject: [PATCH 0/3] spi: ti-qspi: three cleanups
Date: Wed, 04 Nov 2026 22:08:09 +0800
Message-Id: <20261104-ti-qspi-v1-0-c286943c22c3@gmail.com>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwMT3ZJM3cLigkxdQwvjNDMLA8NEC2NzJaDqgqLUtMwKsEnRsRB+cWl
 SVmpyCUi7Um0tANJDC0BrAAAA
X-Change-ID: 20261104-ti-qspi-183f6801a837
To: Mark Brown <broonie@kernel.org>, Felipe Balbi <balbi@ti.com>, 
 Sourav Poddar <sourav.poddar@ti.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Brown <broonie@linaro.org>, Felix Gu <ustc.gu@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793801296; l=561;
 i=ustc.gu@gmail.com; s=20261030; h=from:subject:message-id;
 bh=D3/LH8qAA0zBSfhisBUCO3o1cN3tFfKgYIe06BF6I/g=;
 b=gqWmuzlOL9ygJjGbIb3dN/2O2/ZQ25nad2bffTv1b0bo/ds/jBPKAO5SG0vYAKcqfzVj/aVT8
 nCh6ujmU/v1C/73uxeuK2Ub2zyT+stUS3+K1iyDjtLkPzkMbR/K5Yjj
X-Developer-Key: i=ustc.gu@gmail.com; a=ed25519;
 pk=fjDJtbnSeysEBjmOfNYqYUUDS6g7Tfov9W5oGngTBfo=

This series contains three small cleanups for drivers/spi/spi-ti-qspi.c.

Signed-off-by: Felix Gu <ustc.gu@gmail.com>
---
Felix Gu (3):
      spi: ti-qspi: Remove unbalanced runtime PM put on removal
      spi: ti-qspi: Abort probe when clock lookup fails
      spi: ti-qspi: Correct runtime PM error message

 drivers/spi/spi-ti-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---
base-commit: d6bcfc94eb4da6e089c5473970cd96727292fd97
change-id: 20261104-ti-qspi-183f6801a837

Best regards,
--  
Felix Gu <ustc.gu@gmail.com>

