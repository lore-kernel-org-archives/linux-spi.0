Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795875328;
	b=Ueibu6jNoK6VSMbLP++QwPLMZHQuOi3kyj+TSNY+zfhiqVWL6RCXFah0v89HP6b6omzS
	 FOEuD9QSnQ3z/7ddxSETfMxWccF5H75HRPQjQaxBANFWv1M3fOJOJPV4/ap2KQOa9gRa4
	 Lv/3vsvZ7Aep4euvQs1vdlQFJD7dOFRpqXB0P7T8bg1d3mkeQlqCyeUL3/hG+/MsJML2p
	 K8jDnkqtHk+pu1+Z3NVn4aUXjpHVlXMe1Mgy3IR7QkOJDkfzKjPpcZljBF/WB9E8t3Q8n
	 j2iQwtvzb0u2xq9nmGo533gPIpiVedf+zsEbiDA2uLGHzZoSynhQ+tC0nA4xG6JQtaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795875328;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vKok+0ThrlCjoRPesLMsSdjxyl9vGfxVogmiolLgcN0=;
	b=coUIhxKlBk9kmCTm38nGzj1cQhplcufEhtib8kS4PQDuzkP9Ni+3nPwxsw7ALhE/RdZ5
	 fc46jnAaR3ou2w5syAMQz/HR3/Wmo91ZL6TFtxEt12cjyLXGVPmy9hNf3IFUtx9K6ZSPU
	 j/2YU2AGqBGzxxs08tF7Bo0Hno20njSyjZgMdJ0ujUNjorvy/3Y+Dw5F+pciUoxK9vNI/
	 B9KDxFZzNB3jeHbYmMS4uEqU48G62jtBCzA0fZhuYQgbxpALtR73huspZh/Bf4BZWqrkG
	 nYxRoVRooX2czQ0KOmoTU7o1ylHuhnAwFSPu96fukrzDuWbP//F4ZVKsPTBP9I0NF+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=giKfUiKB;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691E9606A321
	for <linux-spi@vger.kernel.org>; Sat, 28 Nov 2026 14:15:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 691E9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=giKfUiKB
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3282db206d3so7907204eec.0
        for <linux-spi@vger.kernel.org>; Sat, 28 Nov 2026 06:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795875327; x=1796480127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vKok+0ThrlCjoRPesLMsSdjxyl9vGfxVogmiolLgcN0=;
        b=giKfUiKBEopfwSmoLT7DAXtnLN+3hUkjenmjNDx+C7G94TApoSR7lxLzVQ/v3W5I3i
         w+b1nIqLcjhpXP2d6ylJbcPc1tCpS5+GU+fS8Qaf421tS90YKVvkrY+8q4w4IRE2QKCU
         r7t3yIGEDOQxbIbT1nvekJV3vatYc9WsAtqBrrgznfKT12gi8HLO82lhRMscweRbJ9ca
         zIcSKBffW/5ZkUi/xmTe8Mai488HemAs8p92sVTXrWwVUMOlWB3pA4TDWCEtG8S8jWNw
         xv+2Wvdu9ZAuA8DX9vSZGAYfD8gocd++6mbC1ZCBXGoFDxmSJa6BDGTlmK9bDT6IMbBr
         ZyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795875327; x=1796480127;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vKok+0ThrlCjoRPesLMsSdjxyl9vGfxVogmiolLgcN0=;
        b=OU2lxneCnKVTRl3V0avEsqq2mJcjS2cTRvLNNsXXz7/bVlaKaO7grnxSBAqzdUnoUn
         vBcRb0aoKtl6G3ESuX4VM536M50rxqQVDCrsOY18hMW8BjF6lk+sm0L8VwPXFyCnwMtG
         5VaHSoxsW2hrcCuSFLR1HHOXOoLW62wQ4OthmzsEspJXtdAjNkTPBYZl3ro2vuHIbL63
         JSoDMUtt2772JZbtOt1x5sUTrCSGiSt5ybHwkAlnGDH55WODDISGeoJq/ptTGkvdhaKQ
         PbRzgUsQgBBVuwWqD99AN9OoGy1773TwtxZ0dLoK4VaSo7yXCjzFR7jYH+6OOBhYJqzQ
         8sEQ==
X-Forwarded-Encrypted: i=1; AL+hErFLTz85dawQ0tkHp097103ax+BAyGFp3ncowAmxaaKeBfOjRKF8zIshebZDIjkE12oAJ+V+L2DTKR8=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Kua5kPMtBYFaYWb9SgVqinQ3v0eGZp2gTljrrzo9SVnV5J4J/
	TryhbHN8wpn/lYLvxrn+aZzFzTqsa7dad6vSQUeqeOD7Jxvd3AsCxml8uVD/+pJvz/I=
X-Gm-Gg: AZFdTZc3sPXQFobfvam1tqzXeB9sFzhvbbjN5COCmAJDT/43Gt+ciO+Pwrf6B/rQyiX
	7S6diGVC3KHP4R0I4PE0NPp8ZYC/CvXGKnvtxaOSG3NI2fgCaOTzhqArj9fudHMgf3DKS8+0I9f
	1D09NPiLGowPpSuUz3V7Rfjdo0IXs6fJY2vdSr2rc4Y9ii+luE/diKezoIWVc7IeLy9Rt+BGLu6
	TdAd7jlXEbcSYRKyO6RcJOuLaCaFAD/1O90WlYyL7S+3on4d2rnj393WoCTVR4+Gn8/kg9MQ0tm
	Ws88rV3mcg3+HhcyK5dzBvufevxu2K6yISD4h5iqzV/xqzNNbfSHeVRccdWBY0qD+nAI62sKV1N
	YHq7sqvU92JSIIPZF4QdWWjaQxfuR1xGftsuBn8JAa3SzJQ84N9z9bHnHCi7REWYa0WuQsi8FG5
	bL3ogWW6Q+k0vys3vfhXC0xJawB/4i1XbCKEC3MxXai3daa5EBT0cygQPYwK11AxRcQVIAHqnkI
	e8zgKCvCN324gfwH0vwhH06w3zveMqlvrYfneWE6fRdhQ8FBQqWsQiqxiAj+2K+gtX546Ugf+VI
	QijEWZdaOZ64xEwEF7eUQUd7EURjNvxlqIxxQsjgeyk1cgfnHW7i3IVhrGX4Kfp2yPaAn928VzW
	czsfpsdu/TIDue4ThrKjYtrHttUJF
X-Received: by 2002:a05:7301:6405:b0:37a:cafa:6d78 with SMTP id 5a478bee46e88-3856ff54addmr30382725eec.33.1795875327352;
        Sat, 28 Nov 2026 06:15:27 -0800 (PST)
Received: from localhost.localdomain ([2405:201:301c:f8cd:241f:982d:147f:bf76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm87185893eec.6.2026.11.28.06.15.20
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Nov 2026 06:15:27 -0800 (PST)
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
Subject: [PATCH 3/6] arm64: dts: mediatek: mt8189: Add watchdog label
Date: Sat, 28 Nov 2026 19:44:27 +0530
Message-ID: <20261128141443.13065-4-sinha.aryan03@gmail.com>
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

Chromebook board files need to set mediatek,disable-extrst on the
watchdog, like Geralt and Cherry do. Add a label so they can refer to
the node.

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt8189.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt8189.dtsi b/arch/arm64/boot/dts/mediatek/mt8189.dtsi
index e0883da15..8c80a1b1e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8189.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8189.dtsi
@@ -1014,7 +1014,7 @@ power-domain@MT8189_POWER_DOMAIN_PCIE_PHY {
 			};
 		};
 
-		watchdog@1c00a000 {
+		watchdog: watchdog@1c00a000 {
 			compatible = "mediatek,mt8189-wdt", "mediatek,mt6589-wdt";
 			reg = <0 0x1c00a000 0 0x100>;
 			#reset-cells = <1>;
-- 
2.46.0

