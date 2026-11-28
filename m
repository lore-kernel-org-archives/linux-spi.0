Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795879014;
	b=RlM52JzqQTVqnuQ4Nn2wD0CV5ccq8Io5SAti0fCrcfYvXbHI82av01POpr00zpEyNHR/
	 izYjj4Q4P4T7PHFYDJthVrEId7YS4TG0jYu0QG8GOJh4NTwUyvd12wzek2N33ZbHJD+wq
	 dajiq+pmXQYg+d3IyotvLOJIKC9LuRG/SkEWIul39NugtTPm7tPVfTav5R7vQxo6IIM2q
	 M8F/IB9+JIlLCypON+vJTDNWBD4+FRvkHR9ts4jHAhzrrxrk0nN3CJXiw//okc4211jpA
	 uoO5MtTwYVVnVlAmW6KBUHYJfIgB+AUpW0tcAjxIDivtF0psu/p1VAl7HvYpLnOptmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795879014;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1FB6N3ZVeS2iXSTJX9cZqix9YwUql7fjHknIhnBZeO8=;
	b=kF3IH1guKSMC58cEuNQOp4lgQEfJ9y+BNNDfqqHTfi5yr1sdO/8lxGz8/PGhS4NcJYoA
	 /GJGkvh1VG5RNSkkpPbOlCV6FN3kGGEoV9KdEdI3LDyeKnGg1b7KZ/iKqaHAhvLeCWXNC
	 LGZa9VvOJIZ4+kcBxjPOdZPOQpbj5FhasNQQ8Jl24YndQdJcyONwWX14FER2YcTYOux6k
	 EtrQapxbGhGU9oodOCCBiWeoK/sMv2Ixz9IgxLENUTxWKSXZBXfN2fLcz6dzvmpbOy5Rw
	 kIWWSkSjOkfYnFDzlyX18sDZnj8XJDVi2wHb6MvjFREBUzwupd1S6Ua1wDkxktOBfww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RTAI1v6I;
	arc=none smtp.remote-ip=209.85.216.45
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171DD606A31C
	for <linux-spi@vger.kernel.org>; Sat, 28 Nov 2026 15:16:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 171DD606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RTAI1v6I
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3b41188c8b9so6068217a91.0
        for <linux-spi@vger.kernel.org>; Sat, 28 Nov 2026 07:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795879013; x=1796483813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1FB6N3ZVeS2iXSTJX9cZqix9YwUql7fjHknIhnBZeO8=;
        b=RTAI1v6ImNiBmtc0EHCMI2++E9uOOU+pBNG6woahNXDhDoMnfErZMYgNztUondWek0
         AwpeWg6bsv1gOOfotB0jSMBXVHjY1DFOWs4nx+fb/yQC3QYon2t/gnr5pwB5YEvgdpLn
         u825zw1vrc3i48yzo6iw/rv1KGGumukpnTjurYf19nL/8hqAXdJm3dhLa4pdDx4UBTZo
         5JByY+srjJCAqLGGawigeXsRILq+HMPpp4didpeRkjrGGoXW9RTkIaYG2B3Bvrjbw3sK
         wWihN7Gp4dIUZLzpyDPtY3Ex9VeY12YeC2drR4oiVSp+nY+vxaifP6eAxFlBmTkLuzBL
         jk6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795879013; x=1796483813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1FB6N3ZVeS2iXSTJX9cZqix9YwUql7fjHknIhnBZeO8=;
        b=wjIsNMN5SzbesQGrC70F1tCFoyjMqvKJNNYkWvVRIT6KmJsGahMVWxpcydtBFWKuij
         eSHUL4kT/Y4XWvdfir6Oc+3HJtSdlhtrcfL+mmH1dGVBK0rVVC7kAaxEuALXbQthyUJX
         bUgEfdKGVqpvwias8Q5gM2YN882e0/YT2cbWRHUULxY8nkFZ9ADjQPlbqIYDl9Yt/z+Z
         1O/g4oBLJBDkAb6Y7exlXnesD8oxH4QByFMvP6g7fJctQgCFEx3tSm72P3XNg1BA+XoY
         AMGngHmFUPM629e6O6JNweLy2Dq0ekMO6uPu5PVRodk+pXef2/7auWGXbhNGFbCqg/+s
         dqZA==
X-Forwarded-Encrypted: i=1; AL+hErHBa0LVUYITyuC0LCuM5PPrX/B6DQ1rhRPTF/qIOWMzlBgBpes48vomdaz3Q614pYE3LTif6YtoTOc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9InuibQiGiZKFSUb07gJflC00YE2Y0mEVxR3EW3Nfp7bHYOo7y
	F+QYvhe9jCx7lt8D1DWugsSMroB3TcDQgRPiutdrrlHISH+KgaFrA1xY
X-Gm-Gg: AZFdTZcSsoBwxc6+AdrE0Vtt+rqHrfHG8GLlsvySkjkgUCZL6gr6p4V7F7UIPKO1SXP
	6nTBmzR7NMUtTzY0REhN6AvRwXRJ/9HGVUE96bEZ+iSjISWt4PIJNSyPIJZi5jZLL0uP/r5FkK7
	xWa5esgKNt8mybg0+4xPvnlgf6qAvNCtOnEfbFpmpzTR8eYuX8rVX7VZkdsGQnlrTtxjmQ6b2k/
	GNMAPzuaSUnV7SqRwOScvyP5qIgCOoFS3c2quSe1uELA0ezJnliPP4phoXfGzgid5YU8qSgJ8de
	iA20KZQ6usYcTIdWVlcowt84t6tLLcTqbv2KhpxaU6hLh198a3ehmMiTuKeBJ6idI9c98Mp56Y6
	8/5BWnG6JNRIEe6Bevsm5hetPonFcOwp5nUv0gDarmiS7TYE39lH6ZEhx3NWR00BnAZezgyFfr/
	XcAYFR6mBJiAIOSKqRM/EwuvNnkd7gNC+1ksLc8D1T6mBbH7VVLfKYBYxIsiY0KVWs6VV/HxBFu
	zgrfe+u1q2kjOFxqx4Bq37Ck4LZRPdLy7c0dFPGPBX5d8a1U3U/LQ4tJCuyREnqRsCHcixqFDeW
	/dmFut3OwefPJ/+RuJi73RohXhr6eV29b6y/3/WzJQ2RT7n/7MXbMJcZl63JxC7mMfNBJHRHCek
	hMNBEZ9eEyVDSehB/p5JpPB58tm7/
X-Received: by 2002:a17:90b:268f:b0:3b0:d0c5:c110 with SMTP id 98e67ed59e1d1-3b41c95ce7fmr27156870a91.56.1795879013360;
        Sat, 28 Nov 2026 07:16:53 -0800 (PST)
Received: from localhost.localdomain ([2405:201:301c:f8cd:241f:982d:147f:bf76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b7a8c64sm19769280a91.3.2026.11.28.07.16.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Nov 2026 07:16:52 -0800 (PST)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Leilk Liu <leilk.liu@mediatek.com>,
	linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Aryan Sinha <sinha.aryan03@gmail.com>
Subject: [PATCH v2] spi: dt-bindings: mediatek,spi-mt65xx: Add MT8189
Date: Sat, 28 Nov 2026 20:46:41 +0530
Message-ID: <20261128151643.16934-1-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SPI controllers on MT8189 use the same IPM design as MT6991. Add the
MT8189 compatible with mediatek,mt6991-spi as the fallback.

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
Changes in v2:
- Sent on its own so it applies to the SPI tree, the rest of the
  series depends on unmerged MT8189 patches (Mark)
- Fixed the subject prefix (Mark)
- Link to v1: https://lore.kernel.org/r/20261128141443.13065-2-sinha.aryan03@gmail.com

 Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
index 3bf3eb1f8..34e833745 100644
--- a/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
+++ b/Documentation/devicetree/bindings/spi/mediatek,spi-mt65xx.yaml
@@ -41,6 +41,7 @@ properties:
           - const: mediatek,spi-ipm
       - items:
           - enum:
+              - mediatek,mt8189-spi
               - mediatek,mt8196-spi
           - const: mediatek,mt6991-spi
       - items:

base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
-- 
2.46.0

