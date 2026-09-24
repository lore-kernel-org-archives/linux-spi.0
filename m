Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439EE385D78;
	Thu, 24 Sep 2026 05:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790229074; cv=none; b=iiaJYBfume6Y+axHO3fC7VV7WEpGB016v37ZXcCNJLpCp9A5eeyH6Y/G2kICMRfip9ghff+2bCyJKFrH+uvbljWYk8tPv+HQqT6f2wPUPA/RGTTwwiyEolOdGP9CW1QwYrcJi8/XeKNzS2axMZnRFzrpgjmdxEJ7hxCe9jd8uLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790229074; c=relaxed/simple;
	bh=J2rvWMrWhfMqJAxvspLLK2ASHYw7aRT+eq8Zg90zFtk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q56U1ZxzXZzetHmiys0YmkVHneX5KiyLq5QztbqqxvKAyo32RLQmr+4YiRVnnelv4tcyYCo6zgI3xjrUb53CCQoEZJqwUua/x+qttOv5JXBS/bQV1nxHbIJbJ85jYgKug+gcMzJdu943sfu7BqE9msXKrW+WKJqeH/Raz0ayujc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DstY5oTp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DstY5oTp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C02B4C2BCB3;
	Thu, 24 Sep 2026 05:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790229073;
	bh=J2rvWMrWhfMqJAxvspLLK2ASHYw7aRT+eq8Zg90zFtk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DstY5oTp1Vkt9K1FI1qHqfG6M1Gfl23cfKGRTkKXwM2ADIiSkL82yi4isvytH6AM2
	 McerR94eQqPixknmyHbu8A5rOEKZGTW4cBJ8wtMwetkgUbUUEM+ycqwJvnik8iNcie
	 HFqm/9+XvA3L/mwmjC+G/wLA1o/kHUBe7mV0TkmpSLpGPdALUHUxBvdwSCyweJVu/I
	 Bp7HRhQSwBsSs5of/0yL471gXTQcj+ZepY4TFOi93Ed0i86APYnHow0a+t8sQwylkz
	 uA/EakmK0zjgNhn6zBcfN33d6EBcKcTQ3Qg9kxjSivaRImwzi1DCTMiJQmHQfwWsMQ
	 W49SmhDsNBNzQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB153C98312;
	Thu, 24 Sep 2026 05:51:13 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v2 0/3] t7: add some nodes for Amlogc t7.
Date: Thu, 24 Sep 2026 05:51:07 +0000
Message-Id: <20260924-t7-node-new-v2-0-319d3c19b4b2@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEu6tGoC/23MQQ6CMBCF4auQWTtmWhXQlfcwLKAdYBJpSUtQQ
 3p3K2uX/0vet0HkIBzhVmwQeJUo3uXQhwLM2LqBUWxu0KRLumrCpULnLaPjF55qZZXpL7amCvJ
 jDtzLe9ceTe5R4uLDZ8dX9Vv/O6tCQi6Z6jMZ1VF3b6enH8QcjZ+gSSl9AbmULGOoAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790229071; l=1152;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=J2rvWMrWhfMqJAxvspLLK2ASHYw7aRT+eq8Zg90zFtk=;
 b=pk1EoyJAcbEiAZfM1ScQgUu79YaZw6QFQ0zRa71tyYhp1YfLQUuy2vnXEJLl2PpMw0YSbF2ah
 AVsUqKh0ENfDZuNFX3CqSwHkpYIjSzjIQMoEZd0H4WQK5h04/u4geS6
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
Changes in v2:
- Make some modifications according to the Sashiko AI's reviews.
- Link to v1: https://lore.kernel.org/r/20260920-t7-node-new-v1-0-e6e0840c1b0b@amlogic.com

---
Xianwei Zhao (3):
      spi: dt-bindings: amlogic,meson-gx-spicc: add T7 compatible
      dt-bindings: net: meson-dwmac: add T7 support
      arm64: dts: amlogic: add T7 peripheral nodes

 .../bindings/net/amlogic,meson-dwmac.yaml          |  17 +
 .../bindings/spi/amlogic,meson-gx-spicc.yaml       |  13 +-
 .../boot/dts/amlogic/amlogic-t7-a311d2-an400.dts   | 153 +++++++
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi        | 462 +++++++++++++++++++++
 4 files changed, 641 insertions(+), 4 deletions(-)
---
base-commit: a2530c83c458a503e55219966217dfd1c36a385e
change-id: 20260920-t7-node-new-381d1cf5d807

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>


