Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795875307;
	b=3lk49xmSNPLrSsLwOznjowqntQ7bUuA5jY8oyodQSKAlTfMEGtbpp27n8sCKyb7oxwau
	 ZfIxWUwHGce4ZnVMfIg09B8976WbHR+12ornh3XkEe0il4G2T6mA9DZvFez7DNHfdhA/u
	 cVIF++sVhSZYxoRcH7gtbdI6lEF26e34qoKefLdnIj8HmN3htas+AnERUSt47EBlT/ePh
	 4N2RDLYxvWPL57FJuH8/rwfXGCFObv2x20aJiPm+BMY2m/UUjIb1WAfPmfv2t47vO630p
	 CcA+kBo4uA0zRAK2kXXqYm0OSEaaA73VFwa4BA7+BuvwhkrJrJcUW6vQH6C9MggyLRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795875307;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=HJn84ZfJNZIuHrzv0CHcIfvwZwaHinXtB9Ojn/nATMM=;
	b=vOVdpu2zTj1mn/nL4FnuGiA36GyXuIDL/LLTcygaXPUhqWZ4CzY6QPzkFPJMdih+D08r
	 e7e90yWaMJWUBWacoULi/SPlxXDYcs7Xh4bF/abjL5RnYNMeoeS/hLXAx/TS0yl9+VJpH
	 lWUKPhlXL8h+Zh2KOV7eEO8fyIC9lHwGVQJAPIcxiEgifxMms3LzBDHxh0u1XyzH380zF
	 4mhYu3An62yvYgKUbQ7X4sO+9SZwc8iFyhINefwer93HhCHYbV3Wx24ZjACftdg1+YURQ
	 lg9CfClPEfMFSYn30L3ELgYTQhB2fYmCF23BPRGb/JgKu+ZeoUcLwNlWk0pkN6IWGUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="v/wuzQHb";
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB89606A31F
	for <linux-spi@vger.kernel.org>; Sat, 28 Nov 2026 14:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BCB89606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v/wuzQHb
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-386bd881d39so145308eec.1
        for <linux-spi@vger.kernel.org>; Sat, 28 Nov 2026 06:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795875306; x=1796480106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HJn84ZfJNZIuHrzv0CHcIfvwZwaHinXtB9Ojn/nATMM=;
        b=v/wuzQHbD8nfeNbSx0XGxb9bZ6T647gP1hj6dG+zdKBlNrtDRuqcefzv6m4RhGTP79
         mmGld9iGkATVHczfUZuNavM2051luVlacG1Ew1TnEjG8Y23c0xB+znir720ZIfWRwyAv
         waF2b2dUoI5zJdxTsg7npmXZ/RjLRHsXqX6yYCratmiQqj2BBrxJGELtRjZU5brjQTHV
         dyBlTVp0TRWcp3YI0AW/yuqcssP2oI4STazXV2aJN7hztjooODIvTL5R/gBsLfJQd6pW
         kE8I6rtafmaTT4yP9suCEN6tub6t3Z1e//qc94sXf9sRYivkN7dA7NWfm1TFIkxfnGmr
         6+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795875306; x=1796480106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=HJn84ZfJNZIuHrzv0CHcIfvwZwaHinXtB9Ojn/nATMM=;
        b=DgLde4bTwkYnGQ6rIBzYMgfi07WjzA370J+0PfMGHg1UH+S9jhibPWpDYWSwVdv4/A
         HIypfo0LWvDazERVRPkiTB1mKmr9GjuI6xBOED+ZnsNjCbYG97JBNcWBUdzLlGQ3xCP+
         g8EJlQeImJ799jUJUJQToc012XOLpQvb0H5A2xtcICY5Tsz3KlAjsWTG5eE+3xf6nJpL
         jmW90JufRQGfMGmfQtczf90aHy29IVAxwBTV83/poyT15YqH4qCXLlLjtugcK28yOWje
         xmomFLlICF3lZ7tFc7YHQOTQVCT4fiA1s6lih6OK6ejihStAwKQqc5Pl9u6A3GR0qezj
         QdIA==
X-Forwarded-Encrypted: i=1; AL+hErGabNisJbuWvb1kghW7ILcIl5bcgld7AnCCcvdiUj7cOCnv8BZhZf1Xtg9vfj2BJ05irIIXv3hHOv8=@vger.kernel.org
X-Gm-Message-State: APuU4Z83U69CUwp8i0qbFVIv6pMDHukTsrl2cP/zsj+iptPNFXv0bIuA
	UrL/IcbJIWE6iw5PeXvzhQ9XNGL7kqhMu8bDjhABf8MTrhMdNFz1VLPOkIpdVErzylU=
X-Gm-Gg: AZFdTZfkSS4ra6s9/6fQ5anK/sXYevq7x9p7ol29lFh0XAEeg32fH5CI+rV7e/+brnt
	srbQue0zJqMGttkwSgma+PyVuSroKY18vC77nnReRqYKGYW1xoYOKHyG3AoWV6OQwRzH+xLl/E5
	bwSuTUCZZeljtyu/bx7DLAsOoluf2hFjj4aRBOpFNeknNaukuMH1eMVMb/aoDx7YyeFjoreOB/T
	F6w/vDc2BXLLK19j2q8x7lt4cfDm+WNUI7HwRWIycRATSftMsShghXK0sSpzguZDisI/Y5kalay
	NfKShDC/riRgn9JC3v+qGCOIoXHSIU44K16BZ8UTwQFNbo3WQnd83nQR1x4gCjrQKJaJfI1OteA
	8lv6sQ9SFGnmsbno0XRQTYBxFSTfLAq6aofnc2bArOVvOoSo/eEFldxgztbo+u/X0cxuOAAUNZA
	79MiT0bRorJxWTBRiGfaDuBVyjPfHbK+FEtrOXz8X3nd8ygZlykqh8EZSGizcOzSyURFv6WO4yh
	4iEs5tGqwkw1+9lNEiGrpNGtIjLN5IQAumWgmDm00RW536w4eP65DLqZ3N7eHBxGAJczRLwFYkX
	7wueTNkcCfaeW2gZiM1DesZSrcRKbK2mfYxhEDT1hksmmfmZY2lrNMcKePhaW6mcu/nEC5bTdjo
	79LKrCezvqLtTI+9hR6yAkTKQPB+a
X-Received: by 2002:a05:7300:f797:b0:386:95e7:848c with SMTP id 5a478bee46e88-38695e79009mr24469794eec.7.1795875305781;
        Sat, 28 Nov 2026 06:15:05 -0800 (PST)
Received: from localhost.localdomain ([2405:201:301c:f8cd:241f:982d:147f:bf76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm87185893eec.6.2026.11.28.06.14.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Nov 2026 06:15:05 -0800 (PST)
From: Aryan Sinha <sinha.aryan03@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Benson Leung <bleung@chromium.org>
Cc: Leilk Liu <leilk.liu@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Chen-Yu Tsai <wenst@chromium.org>,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Aryan Sinha <sinha.aryan03@gmail.com>
Subject: [PATCH 1/6] dt-bindings: spi: mediatek,spi-mt65xx: Add MT8189
Date: Sat, 28 Nov 2026 19:44:25 +0530
Message-ID: <20261128141443.13065-2-sinha.aryan03@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20261128141443.13065-1-sinha.aryan03@gmail.com>
References: <20261128141443.13065-1-sinha.aryan03@gmail.com>
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

The SPI controllers on MT8189 use the same IPM design as MT6991, so add
the MT8189 compatible with mediatek,mt6991-spi as the fallback, the same
way MT8196 does.

The vendor driver's MT8189 data differs from MT6991 only in not setting
must_tx. That makes no difference here, the driver then just supplies a
dummy TX buffer for RX-only transfers.

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
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
-- 
2.46.0

