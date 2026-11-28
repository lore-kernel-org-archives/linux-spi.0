Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795875336;
	b=SOrYz0fzwN18S6laVw3vqrdLxwYZKvrxWCklYSRyAi56PT67xgtPdzlnrZq3yaHASp8W
	 07jzBMV2es6untP3USb9ZFtSS71iofz1/0FQqA3w6cU9E+fFbYv4dSkfH0H59FEKzXPwv
	 kIZgdCAGn3zRwdEWlNIizHKYpFQaNXZSu7ESod912g+OAKFiAjy0AFLUG71OAqKJDfg/V
	 TvnvtHuqyzcYR7MgnQSlCU3Z+6KUGS2l2DJI/Gc2br/sSkH+GdGnYXG212cHPcbNIAJ+I
	 ohvy0M5KsJOiFd4XYA2WN0haNl32SYfzZVBZekN0z1TcEBCS+OwrNabd6REhr0Gd5JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795875336;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=br8y1ax6OFKs5nz9DJGClVjlFiP1LYJ8/qThDtgJpY0=;
	b=wJ/MO67VFkLY6HrTOVj30VbBOxUCSQVCwzCBEVUGRuoc1EDZ3or48avQbeSyGc4ZBATC
	 9ZYZs4RPk+XR1fboi6Q4u5IvNP4PwJwO72MfVersqb/AtsKbcD8yhxcILN5ioYzsieHOi
	 tLxNjQauZ9ESkFxw9p59bU2bvSoHZMvdkRkUTbcZGjJA6rFY8g5csJU7Qo6hyjqlFSmBR
	 s4BzzFBtyEHkFSic7Xcev8b1vyi3SFAFz1hPvj5l3+Ww4fDyJ11Hn4pHA8URauvcG87CZ
	 BcxzDKLQuUsXUSrqFofe8qBb03kKEGlVgo9JCMls6kCG231dQkrvZe4/DMBCiVSW1/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u1DsrwTa;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93057606A326
	for <linux-spi@vger.kernel.org>; Sat, 28 Nov 2026 14:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93057606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=u1DsrwTa
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33fb4680717so6874500eec.1
        for <linux-spi@vger.kernel.org>; Sat, 28 Nov 2026 06:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795875336; x=1796480136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=br8y1ax6OFKs5nz9DJGClVjlFiP1LYJ8/qThDtgJpY0=;
        b=u1DsrwTaOKllraREGZcoVWCCXfcM/os898fEU8LPndQQVDHGEzlD5p7N2UyXdVPgQH
         RXIpWB1t7EgffrIl5qn0bhq7WQeAIXSV9+NxKYZWo1PTt+sJPH/ZbElXh0NRvhU6ScM4
         yaVlvvZ9t9Qa38Q/DRNDzSvQdfae6KzjJToK1mqtwQOjWv50VNzw7EAI9ZNgrQgObF3A
         l8Gl7FXBg65zpyhRluX2Psw7sWRRTAvta1JotOnAMwa1oG6FbPV8QK3usjYQ5R1KcOIA
         cjyWjW2EaonbZrKaGugZW9MdqYWhX5NrE7ahE8QBFDTnP1+0vSTpnrRV02uZVt9uewc1
         mG7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795875336; x=1796480136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=br8y1ax6OFKs5nz9DJGClVjlFiP1LYJ8/qThDtgJpY0=;
        b=24sjEN/R1DZga1DwJBBinKrJpzzZ/HEd4GNGE4poNs0Cv2aFu70CZCUgmJcj7pe0qc
         NP3wgLJHddQ1kBux8u1ZlMrKcXIdwzJYFAfDtGc3U94mQktWfjZAbf3u4gk8GORxg8jG
         KaGyIfLEnOBKsT9MmtmJPYC5f2DPvQg1P0xipIUDn3PGpAwhtdx3SMY2cIdK0M6fQqm9
         iO8bG6rxnrHpPNvjnFexFkXhpKO26bqxhB3iiNFYvHjp2wDOME405HSFq/foa/TpvaxS
         ns6x2STE2rnPB5HvfdQILhsENi+8ZicGIqLZi0h2E5iYAA8E7a7Gv5EoDPuXmzMDQQfL
         5gKA==
X-Forwarded-Encrypted: i=1; AL+hErFoFrrj0ffFjGIsbhVi6lxv4qSaKB4uzWlOKk55PzP+mlbggwICburdEybapgS6Z49DQVDhYFA7eyw=@vger.kernel.org
X-Gm-Message-State: APuU4Z9d0uaRcsTRyjhyQEgVaDO1i4sQGK4lJmocAR+HG6bo+aqB0pUW
	fq9BE6m4r5ozkuQKOdIGG8RH14ZVuXTZJAkr2RxSmItHzSI1LSgCceQr
X-Gm-Gg: AZFdTZe4iOGzU7bv8dx0q08fuoje586vEjl0rRfwJCTwC67IJWfuoEpo/qYEDZFcWhz
	uHqwbx4GRdou5LjyNT6sDVWs4cbR3P+FhfeTAlN3iQ9iZMMjdD/zDjyJvmDWwN7XsOXwUeei6iS
	0nLj+oS7U5VMx8omAPAefHQdELzp2uUhjpdsnl/l3GeKaj9gFNYJrcN+kmNrMVXYvKZulGYBSsU
	BCZHHKT/W8YH2SalSdLvL+MDd7R4KsC4TWh+Pk3JWCMvQ/HN5hDAMLvhBC66LLv4uTKagYn1llq
	cW3KXz44UJMIvAJM3zTd2jeqyyIkoYUAzBktbFXecVep6Lauh+XhI1I9Bz+xYEkvl5ES9i3S76W
	E8ErBry0jtXbNtefkP8dAodKGs3SDc5PTP/Q8DOeUiQtKgYKoUI3dy2S7bwQXa0DZnGiuiJvwkS
	N3l+0qvApzEFjBoZl5CXgR0h9sujt/YlSxL5ZiBwk/cTVklGaysAP47Zxy7IyybiIeO5UMIjGDW
	GXQb5ZC1/KB8uPJFm3XZ2qn2yWnc/gjOswVB88xgKzUdE45vzLxFzA2sWfXwUA3RUuM/HfxKGWk
	s3Ay9AVcTH/ObBVQv3J6P5KQ1N1UjSlm2JVjWWt+WoibBk2Eig7gfmlvg8uxu/k70FOXnZcVtLN
	43ZiBNOsYivUW7X/akH6ZmRAkXYjs
X-Received: by 2002:a05:693c:41d2:20b0:386:ebc5:4747 with SMTP id 5a478bee46e88-386ebc547e4mr5532315eec.11.1795875335508;
        Sat, 28 Nov 2026 06:15:35 -0800 (PST)
Received: from localhost.localdomain ([2405:201:301c:f8cd:241f:982d:147f:bf76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm87185893eec.6.2026.11.28.06.15.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Nov 2026 06:15:35 -0800 (PST)
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
Subject: [PATCH 4/6] dt-bindings: arm: mediatek: Add Google Tarkin
Date: Sat, 28 Nov 2026 19:44:28 +0530
Message-ID: <20261128141443.13065-5-sinha.aryan03@gmail.com>
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

Tarkin is a MT8189 based Chromebook from the Skywalker platform, sold by
ASUS as the CM1405 and CM1406.

Signed-off-by: Aryan Sinha <sinha.aryan03@gmail.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 5a4779d9b..700dc4293 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -390,6 +390,10 @@ properties:
           - enum:
               - mediatek,mt8188-evb
           - const: mediatek,mt8188
+      - description: Google Tarkin (ASUS Chromebook CM1405, CM1406)
+        items:
+          - const: google,tarkin
+          - const: mediatek,mt8189
       - description: Google Hayato
         items:
           - const: google,hayato-rev1
-- 
2.46.0

