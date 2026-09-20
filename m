Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB063E075F;
	Sun, 20 Sep 2026 08:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789892014; cv=none; b=sSBxMu/Gre4ztVlTsORRFUuLkUR3bSFv9Cgcps2jabBvrUOLQnS7Gz9bMuSJaRWrqKh0+zeGjYTviC+NCeBC8pHNBey6dsR4Fsf8iZiBU/+9ESViXcqmW92SlMUnJeRRBYQeUp6B/W1wRn5+CBNOrgLk2VQoc9x7/sT/sonfjzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789892014; c=relaxed/simple;
	bh=j5RR68P3oFMU6xBWGop7jkyP1ilGJ5YpBYsz7PL+Ntg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DXrusgLl4FO74xXMVC5otnKoFti0+iTut9m5irk6U2MhLkf2VDn2FkucikEQtVoOabcQl/rf4iPfo2Z3FugDy241ixdQ65C/rV0MgbUrHoq7qj2SlhcE9tLkFGzWoOnOSMpEXC32rsbEWxkOqUpUhNvbetZSBcNhv2Tsg0EGGYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YrpYUCpv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YrpYUCpv"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F068C2BCB3;
	Sun, 20 Sep 2026 08:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1789892014;
	bh=j5RR68P3oFMU6xBWGop7jkyP1ilGJ5YpBYsz7PL+Ntg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=YrpYUCpvA10GfQ1OkHQ82+oxc5qD46QVdJl4WizLcFtCpG7xs0v4lMOHt2a71ssyg
	 9YfA+g7mcYEflCxz8aGZXr0IxQyrsgBk6CBDTuyaEMig7pE19nqXAUrIQriCqFWA20
	 AErusxh07oup4Pkxe1U+jC2/HzBjYIfCJhEpDzIFU1l69Mx+psncfBRtNOwIU6oMm8
	 pUqEejk2ArBTWlMRhqcXcbvzonSpiJbiHtyY/DfoDZuC5HlPJWzx4ehFKonQXX750k
	 T04qL94d5yzA+LyuKBWx8jonWOerz/pv8IyjEoZTjdPnePrRivpZMgwEF2x/GE6Y5u
	 LJV6drbosWgpg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19365C982DA;
	Sun, 20 Sep 2026 08:13:34 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH 0/3] t7: add some nodes for Amlogc t7.
Date: Sun, 20 Sep 2026 08:13:27 +0000
Message-Id: <20260920-t7-node-new-v1-0-e6e0840c1b0b@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKiVr2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSyMD3RJz3bz8lFTdvNRyXWMLwxTD5DTTFAsDcyWgjoKi1LTMCrBp0bG
 1tQBYuqvEXQAAAA==
X-Change-ID: 20260920-t7-node-new-381d1cf5d807
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789892012; l=971;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=j5RR68P3oFMU6xBWGop7jkyP1ilGJ5YpBYsz7PL+Ntg=;
 b=w/B0pT+84delXXSkn73CrIlYgv9pNMM2ZLKx7STy3fQOX9ZHtHllLscpI1b9THGtFvvaggdmA
 WcW6BtbcpH9ChVWWGPP7xbV8p7rJR0+SleXRefz+oQLdAP4bmA7bW90
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Add device tree descriptions for the peripherals on the Amlogic T7
SoC and the T7 A311D2 AN400 board.

Add the Amlogic T7 SPICC compatible to the device tree binding. 
Add the T7 compatible to the Meson DWMAC binding

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Xianwei Zhao (3):
      spi: dt-bindings: amlogic,meson-gx-spicc: add T7 compatible
      dt-bindings: net: meson-dwmac: add T7 support
      arm64: dts: amlogic: add T7 peripheral nodes

 .../bindings/net/amlogic,meson-dwmac.yaml          |  14 +
 .../bindings/spi/amlogic,meson-gx-spicc.yaml       |  13 +-
 .../boot/dts/amlogic/amlogic-t7-a311d2-an400.dts   | 155 +++++++
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi        | 452 +++++++++++++++++++++
 4 files changed, 630 insertions(+), 4 deletions(-)
---
base-commit: a2530c83c458a503e55219966217dfd1c36a385e
change-id: 20260920-t7-node-new-381d1cf5d807

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>


