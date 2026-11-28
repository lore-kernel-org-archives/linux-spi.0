Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795875298;
	b=sjweiDTFLFBr6G80elGE7Fyxd/D0MqqkZN0c6U/Rje7dShMAmiDGC5P1Y03d9cVrCgWS
	 hn3Olzzzv47UmuA8Kzt/8JfxQrHIfhHwMF0lk5j13sUYtt17F81ZxKp7nKbtEXeMQCWYS
	 RuYPjeRexJDnffnzpZVwtKnMlth6jilO/cz9Vls+yQvDt2q3kocBkMo3yyu8B+lYhk27B
	 z9Btm6AbPbc1cBJhZDQbjNS3eI8ECxv2ccKWbKfgfgmsKj4ODlaL8ZlrQwyIUaW/KdRgV
	 tIUPUyRuo+2F/4nI0fA4oImyfnbWc2nw6dOr01YSkS6BsOD/SzijKv3nCqSeZ7a5o/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795875298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ovt3whWqdaT1jywj9I1uBt0fMRtj7mzqaOeqp3btgZw=;
	b=Ps36RxYDMDbcMqXxnja0JuKYNul5wpY3+PkU4pHRAsu2Qa8WaB4Bwy48cmTS1VAyQMtY
	 MXmCnGRQLBXZppFcixKFeyszK3A4B/S+Q45qiQSc5oS2ucZrFkvYsV1DuZ8xef6F/d9rT
	 nGAcxR7MMcgOXe2faNKFe8LDvqBdyzqqmkDMiud+XvFPMs2v0ZeL25J0Iy4w7psgBzT7j
	 hqMSRqiNexPTUXsAdQSdoF++XRJ4GC7qkXIcPTQ0A1xRqMXPcc9vLyaBlWwUoCnBeGAro
	 Kd0OEt/IISJVQ0h1O6ZJaKhcWiplwwKw0XZsXycc7cODkDYN+pRVRB41yNH0zfcae8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Au4OlAHX;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E2C606A321
	for <linux-spi@vger.kernel.org>; Sat, 28 Nov 2026 14:14:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13E2C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Au4OlAHX
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-386ab9ab619so12797757eec.1
        for <linux-spi@vger.kernel.org>; Sat, 28 Nov 2026 06:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795875296; x=1796480096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ovt3whWqdaT1jywj9I1uBt0fMRtj7mzqaOeqp3btgZw=;
        b=Au4OlAHXVW2FgPmm/PstlnjukmVJ+URrrz2s3dg4vqKaWMjWdwSBcpigNqEuHkIVpT
         VEeGf8Rfe3DdIw+EpOsb3vpEmzUQMVNGwN2UsHrotFwHqV6kPHXuRZOzFNOzHdmrQoPv
         tlOY6NgLsJFLCduku4kTERHOY4mPputPiCdbQ8Ot3zTQbunvBTqxllGFcCPzb1S8xGfK
         iASsJC6i6bavpe0CN6KZ56xbgbGdhUH0lKJB6IHqgedlO+u//VIY06UbJ1GyYCb2IP/6
         wyaIOK45vT57YhAJxt8I5q9RsfbsCE1nuIgR4x/L6w9o1gHML0ZC3VQv1OP+HT1Nw7OE
         MRQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795875296; x=1796480096;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ovt3whWqdaT1jywj9I1uBt0fMRtj7mzqaOeqp3btgZw=;
        b=x61l8vrXMJDF5v9oIX/r4JfGEc8/MfhZJW6f3Z6n44QJ6hUHn81M6KXGAsqBOZUvo4
         z3/XStTkViUwH4V81/hzm47R6x8sbQ9JvzCie+EiKrct2UNDkwsPeSSgT9FMq5fpBHXq
         77g+mtPazqTPAann8JnZ1/QgAn+tabzUuSXXtWNlDuptMwNbu+Ck/Z0YDl6k2v/HHweH
         Qyo0AMsfIHt9bIGGtG+iAgPgC5E4y8KrG3v0TSRHMlwFb7Z8AyjYYWigVUZhUVAdJDpE
         eQUSyPkCnaiiVT/mkzYG0Y61dkf1Mn0aigsZJIKTCKQYqfDLAqw2f2AUdqpD0mQHBR9Q
         KGlQ==
X-Forwarded-Encrypted: i=1; AL+hErGgUYsOWuoi0uf+3UjomG3HPelCIYLSa2ZQFwUOIkahILsOMFzm/Y41xCjth/RGSvTlIxkKf4R23Ag=@vger.kernel.org
X-Gm-Message-State: APuU4Z89aSic0njZ442k8tH1VRZNrUFX04iEZzvqtOO02zTq1Da1l2co
	fawGtwB7dtadVtxl5YvLM1cpGqI8Xjhj4nRBKFTXso8N1m364mYN90Ig
X-Gm-Gg: AZFdTZefpcAg2SPIBqYucMcXuzVCKhpdqMQRV7s0h+pqlqEEbHETfm/EmR81XbxXdA5
	HOK6BbFo9YAQeWixOxP4/PtocNOF6hS9Rsy1PpRiQTdyp+JQfznBSvqpIgPyjti8cqmf94oa0fw
	kXu7YJEbexQv7s5MlzRl94TI/URz85BuANBYZsQ9djNOd5LKS6g7KeMMHMGPBHf+zB8YC4T+i6e
	MV6hLNAzNo3hXCZC/HuZgwjcCXUx+/RYxAhI80FTwehQKMWNMd9fco4svqSspEHCw+dau9/VK6i
	eUQvH0gv7t3XEvE1JxRMvu9NnqblsQvuJuA0aRFWTTXzyKnq/RTpSo7T07itYdkwpVyMCM27KdZ
	Pp3k9Lluc5Vi0Nb/KXnkInV+Z5cBnDB3pNwc0u36esPlXE01lID26Wn25RTwE/wMlKB/Axc630K
	rx84zcoRcq8DOuD0Rhtl51s3KFCngxEY+fiYF6v4MbYlkevUgjJJiQDFsFOeqGcqG5PMy2V55Iu
	yZ3awDGkjC4hkYYTfE0yjDiD3vwc0MOTyklgOpCt55PXtzYwfGqLD2uSPA2RaBpKgdh7ZUu/ZIZ
	C2HroeNpVAkqNux/XNW7kHTW3gBPGGccckED7SwmmHgVb51CjJCiyLr/zMFFJzqVtdzbyDvJS2a
	5T97d3uVzN0nFf8DiRWTNoCd4L44I
X-Received: by 2002:a05:693c:6010:b0:385:849b:7899 with SMTP id 5a478bee46e88-385849b7adamr31917186eec.4.1795875295880;
        Sat, 28 Nov 2026 06:14:55 -0800 (PST)
Received: from localhost.localdomain ([2405:201:301c:f8cd:241f:982d:147f:bf76])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e7f59sm87185893eec.6.2026.11.28.06.14.49
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Nov 2026 06:14:55 -0800 (PST)
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
Subject: [PATCH 0/6]  arm64: dts: mediatek: Add MT8189 Skywalker based Tarkin Chromebook
Date: Sat, 28 Nov 2026 19:44:24 +0530
Message-ID: <20261128141443.13065-1-sinha.aryan03@gmail.com>
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

This series adds initial support for Tarkin, an ASUS Chromebook (CM1405,
CM1406) on Google's MT8189 (Kompanio 540) Skywalker platform.

It builds on the MT8189 base support from the Genio 520/720-EVK series
and adds:

 - an MT8189 compatible to the MediaTek SPI binding (same IPM design as
   MT6991) and the six SPI controllers in mt8189.dtsi, needed for the
   EC on SPI0
 - a label for the MT8189 watchdog, so Chromebooks can disable its
   external reset like Geralt and Cherry do
 - the Tarkin board compatible
 - the Skywalker platform dtsi and the Tarkin board dts
 - Tarkin in the ChromeOS hardware prober, for its second source
   trackpad

- Tested on an ASUS Chromebook CM1405

Not included yet, since the SoC side is not upstream: display, GPU,
audio, USB, UFS and PCIe.

The Skywalker and Tarkin device trees are based on the ChromeOS kernel's
mt8189-skywalker.dtsi and mt8189-skywalker-tarkin.dts.

This series depends on the Genio 520/720-EVK series [1], which adds
mt8189.dtsi, and on what that series depends on:

 - MT8189 system and base clock controllers v6 [2], applied to
   v7.4-next/clk
 - net/stmmac: Add Mediatek MT8189 support, v5 applied to net-next
 - the MT8189 pinmux header [3] and timer binding [4], still pending

[1] https://lore.kernel.org/linux-mediatek/20260924-add-mediatek-genio-520-720-evk-v3-0-2ec5c80677d4@collabora.com/
[2] https://lore.kernel.org/linux-mediatek/20260904-mt8189-clocks-system-base-v6-0-5df247f56938@collabora.com/
[3] https://lore.kernel.org/linux-mediatek/20251205064357.13591-1-ot_cathy.xu@mediatek.com/
[4] https://lore.kernel.org/linux-mediatek/20250825033136.7705-1-zhanzhan.ge@mediatek.com/

Aryan Sinha (6):
  dt-bindings: spi: mediatek,spi-mt65xx: Add MT8189
  arm64: dts: mediatek: mt8189: Add SPI controllers
  arm64: dts: mediatek: mt8189: Add watchdog label
  dt-bindings: arm: mediatek: Add Google Tarkin
  arm64: dts: mediatek: Add MT8189 Skywalker platform based Tarkin
  platform/chrome: of_hw_prober: Support trackpad probing on Tarkin

 .../devicetree/bindings/arm/mediatek.yaml     |   4 +
 .../bindings/spi/mediatek,spi-mt65xx.yaml     |   1 +
 arch/arm64/boot/dts/mediatek/Makefile         |   1 +
 .../dts/mediatek/mt8189-skywalker-tarkin.dts  |  62 +++
 .../boot/dts/mediatek/mt8189-skywalker.dtsi   | 453 ++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt8189.dtsi      |  86 +++-
 .../platform/chrome/chromeos_of_hw_prober.c   |   4 +
 7 files changed, 610 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8189-skywalker-tarkin.dts
 create mode 100644 arch/arm64/boot/dts/mediatek/mt8189-skywalker.dtsi


base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
prerequisite-patch-id: 7aeee7d452186b3bc1c11722b7ddb7dfbae7d396
prerequisite-patch-id: 7f2d960cde2f0e0a307721150e83b7b05b9a60d7
prerequisite-patch-id: f383e7157010179243963badff8c663d0ca21592
prerequisite-patch-id: 742dfe3c56d88bad5dbdae49b34ecf8639db1bdb
prerequisite-patch-id: 9c9c64b8b3879f230ba18a0d11cbeb584ce2977c
prerequisite-patch-id: 7b1af194800ee6075aeb7933e2b55ac57e1dc5e2
prerequisite-patch-id: 8c8e59354c22f2fa141599efaddc1d28da97c910
prerequisite-patch-id: 560ea66d94464ee05a72499d1bd8adb3830fe9d0
prerequisite-patch-id: def65116008ad75bae741bacc67552227446449d
prerequisite-patch-id: 226e61bec983c3cdd39a64d0b5aa64994c6873c4
prerequisite-patch-id: 988df54e8bb41d0cc56104398da9c8f669eef878
prerequisite-patch-id: 9a3f954e6efaed40f57a23e721505f5e2abf538e
prerequisite-patch-id: ac2ae94b727d7e4f2576601e09ed481248e6c099
prerequisite-patch-id: 5cf430a386ebd823b14ad79aa05e8b723510f2e8
prerequisite-patch-id: 49a0b4ca405cfbc9854dea09df664f60c7467fb9
prerequisite-patch-id: 998d0587e6bb0ee244afeb5344cd3e9438d933ca
prerequisite-patch-id: c23a23ce86063191e84218c496151104c270bead
prerequisite-patch-id: 9c596a2b6b48b1c646e2aa6fdb12c2fc853f44f2
prerequisite-patch-id: f0978bcc3be8c1986a00e41aab540c911508ae07
prerequisite-patch-id: 8ce69ea826d8ebdb9103dab20941b018a10ef230
prerequisite-patch-id: 7f544c1d5400bb2f6e964f53eeaacb52878bfce9
prerequisite-patch-id: e2027aa2ac9d98bc9bc577dc0ef5bcb664380c51
prerequisite-patch-id: 29b5901b08e6c967da57d83d90fdcac50657e4ad
prerequisite-patch-id: 4442d5bd4b04a393301f974a3aaeabef7a693aac
prerequisite-patch-id: c6be163e56e8187c47e4ee6adbab4c7877b5b5e9
prerequisite-patch-id: 12f43414850b4a72ba37967ff7f765e426abd9e5
prerequisite-patch-id: 9b00d856ced9bea88911a5af4d5e5dd003e66b15
prerequisite-patch-id: 967e506aa16b20c211cb74080f83e38a7dffecd1
prerequisite-patch-id: 2943831ea7bc0c4075580adf69e033f9057f4b19
prerequisite-patch-id: cedfd27a6d86ef771ea29570d7aeaa1de6700d76
prerequisite-patch-id: d71281b728b70a0c3e6628fcf667df5fce81f2de
prerequisite-patch-id: f08f0f9abf6ddb4856e6f83f09afbd9a6bd58c69
prerequisite-patch-id: 547ff4e2a908f87e94fff37f8e0a5cd7b6a06deb
prerequisite-patch-id: 3b288113483ca2c4181fcc1141f03c4dfc05c43e
prerequisite-patch-id: a7497035d432d4454a9e9ddf09b4dbef89a060ed
prerequisite-patch-id: 26b2574fc9d0ead6e8ab193fca387cf6e816dce4
prerequisite-patch-id: 29c372cf76fc379b8fbc48a1418ab7be81fc9a72
prerequisite-patch-id: cbb095d95655a5f03ec66e163313544cb6f684ef
prerequisite-patch-id: 85b0f64a1f172ffb61a5c2f1f312c6e1b9413162
prerequisite-patch-id: e72c5ab13c8fd89d6ccb022ce6c8d6ebc9400a3b
-- 
2.46.0

