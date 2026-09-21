Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138F23C5DC5;
	Mon, 21 Sep 2026 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985847; cv=none; b=uuaTACkOdBCM6F0zUSTkmSkszZbp6tLcpSqry3Qq6qGhBpoUsS0pCIhIt1PMx6ffA31F/6rF1Z8/AKw0ZGeDyQYDUxAbZ1r+vkZ+trpu64C1XBFsgb3gPgDxjDpbyGKovDX/ynM/CMj0JXd3RWLMMyNLkPT1P1M3stT5VkAeNmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985847; c=relaxed/simple;
	bh=GacY+jMoFT8nvHAYb3gWh4H6aKjjn0Uux/cosswgUt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fb73kJVgGIm+9GDk5jLuFRAwotS7pnFdAfy39h8uaGxqPonygFjAzPd9jzZlIB6zMHuEX/fHltaJrDRwZ+BHgVfZj9hIu5uZKvB18fyq4AihNRgOJ2WIRtcwY7crFuN4DZ01lv+icdpKpfxQXW+gQyzRbciPOXx6BpThXXqE/bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=Dn2Ai9na; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="Dn2Ai9na"
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
	t=1789985835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+5kItn/dLA8g58laqBchtZJn0cTJ6aBuyxpWo3F+/g=;
	b=Dn2Ai9na/RuSGFC9OQUKmgxtv3Q7A38cSnV7c0hw/sP0PkYKDkks1x8uqZJ7l6jChn72QI
	e016oafrslm3pi1fI0tqG0aNwfNLz9E4kJ67fwdZ+nDGKU5a7rtnduq84yA6A0xR0WA1gs
	CovVSPvR17hS1TDc65XG59m2/PITGUp2VHOQCA0yCTCmnlvPw/y5IZeHomy3lTlonT9Klw
	2jPn9aJgxCQZoG83kofPlBGrwxJqUzd0PasjA5EcJRrPa40XGdygh4GjlwyPuvAbNi7hBP
	lnaHBmALz0dXyk/8WsnY5CdKIKTn8WP91nw01/2FJSGr+5F/E0E1a5WC/poCiQ==
Date: Mon, 21 Sep 2026 12:16:44 +0200
Subject: [PATCH v2 1/3] spi: dt-bindings: Clarify what rx-sample-delay-ns
 describes
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-spi-sample-delay-cleanup-v2-1-b460d572fd32@kontron.de>
References: <20260921-spi-sample-delay-cleanup-v2-0-b460d572fd32@kontron.de>
In-Reply-To: <20260921-spi-sample-delay-cleanup-v2-0-b460d572fd32@kontron.de>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2775;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=TlRhZ1qfD0/hQwYMH3NUSnheV4zFAnhEGcsyBBxk8ps=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIWsji9b0f2zdv3o0Ni6tc97psa3G+97TxNBDK1ofL1u9u
 2LVwnlqHaUsDGJcDLJiiixS/Bavbc1ifeSPVUfBzGFlAhnCwMUpABM5nsrwP3q7m3Bn4WqrZpHZ
 XGLeBb5TKrIVp+677OTYoBxQlLwplOGv+IaqTLFZnCWrdPrP9R9UPc/80W1h5K3F/1wVXigcOWr
 HAwA=
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216

From: Frieder Schrempf <frieder.schrempf@kontron.de>

The property is documented as an offset from the controller's default
sampling time. That says what the value does, but not what it is meant to
describe, and it leaves room for two readings: a delay that belongs to
the board, or a stand-in for the peripheral's own clock-to-output-valid
time, which has no other expression in a device tree today.

The first reading is the original one. The property was introduced for
Rockchip in commit 76b17e6e4923 ("spi/rockchip: Add device tree property
to configure Rx Sample Delay") to deal with "boards with high-capacitance
SPI lines", where "the controller samples the Rx data line too early".
The current wording arrived later, in commit 5ce78f4456a9 ("dt-bindings:
snps, dw-apb-ssi: Add sparx5 support, plus rx-sample-delay-ns property"),
where it described a DesignWare register and was qualified as such. That
qualification was dropped when the property was moved to the generic
schema in commit b658be56e867 ("spi: dt-bindings: Move
'rx-sample-delay-ns' to spi-peripheral-props.yaml"), leaving a register
description standing in for a definition.

The distinction matters because the two compose. A board delay is
specific to one design, while a datasheet timing parameter is the same
wherever the chip is soldered, so a mechanism that derives the chip side
from the chip would add to a value that already accounts for it.

Spell out that the property describes the board. Nothing changes in what
the value means or in how existing device trees are interpreted.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
index 880a9f624566..afcf9c41c058 100644
--- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
@@ -91,6 +91,14 @@ properties:
       The delay from the default sample time before the actual
       sample of the rxd input signal occurs.
 
+      This describes the board rather than the peripheral, namely the extra
+      delay this particular design needs, for example because of the flight time
+      of the clock and data signals between controller and peripheral.
+
+      Timing parameters of the peripheral itself, such as its
+      clock-to-output-valid time, are the same on every board using that chip
+      and should be described with the chip.
+
   spi-tx-bus-width:
     description:
       Bus width to the SPI bus used for write transfers.

-- 
2.55.0

