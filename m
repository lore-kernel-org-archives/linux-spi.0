Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D2AA3909A6;
	Thu, 17 Sep 2026 15:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659523; cv=none; b=pPXMc+9GJl/W4WozQfM4LVPfxBTqmmgXmR9FriPw9YcONOXQArtW+D8DehcLHXRE+jy+SoouQ0ze6SkYuLBr7W/E15/1JyPbILZ8Ami7K2C5jvFRqOVZ4zHIeGOY+PzFO0QvnTzfqEoXe8KGRny7sHf/VqfNqXDNy2VViWPEhWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659523; c=relaxed/simple;
	bh=GacY+jMoFT8nvHAYb3gWh4H6aKjjn0Uux/cosswgUt0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gi62TRlYG97QLoMCPHfbcxgtS6lqefQshLR3fVkLuQRLF0U2h1kWLdBvsfTGvkPPA4+kDUiYDBouBfwTdSKeUIYeD4nJleyhj9uAw6n3qIEuEmvZxnGz2pXzdcHyZBXROEYCNV9daHOrla2PUnN0eHOENiEqEz/EnVdzEtOth0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=F6H//oNa; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="F6H//oNa"
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
	t=1789659510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t+5kItn/dLA8g58laqBchtZJn0cTJ6aBuyxpWo3F+/g=;
	b=F6H//oNaO327ZdfV/rDbhljYdTbW5+MVBw8qvKjv5SwWq8PaibGgbOaaASQeK/2TKAPkNd
	o5dHFXh13HIc4v1jX2U9cD2zhb0wZ7EoTgb8c/mshnCVaZGDIHnzFB7iI60mnxjN7wCfWU
	ilJq4b8cAqeAfW7iMLwwf+bj6daT5nmoes6GykMNyw8irWXrTITs7wXmp8ZgfSRe6Kfi0q
	iEP94PX7zT8n1wYH5W2kZoKgmqS/HaVk87zZGE4/K5IXNlfVdGw0Jcd1EjSLxgQHqD83qt
	ZXz60xw/b3m/sQyB+jhFgo2V8qxxvYcox4+zyMzTV5GeLDp3RfHRYlhDwym2TQ==
Date: Thu, 17 Sep 2026 17:37:35 +0200
Subject: [PATCH 1/3] dt-bindings: spi: Clarify what rx-sample-delay-ns
 describes
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-spi-sample-delay-cleanup-v1-1-0e4eddbfb1ce@kontron.de>
References: <20260917-spi-sample-delay-cleanup-v1-0-0e4eddbfb1ce@kontron.de>
In-Reply-To: <20260917-spi-sample-delay-cleanup-v1-0-0e4eddbfb1ce@kontron.de>
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
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIWsNZ+nETV9LDq5L5uW0WVdyuvysleLum95a9/zqIzML1
 k8qeF/TUcrCIMbFICumyCLFb/Ha1izWR/5YdRTMHFYmkCEMXJwCMJGteYwM+2vPf+EJKH1xevrS
 EKaZje2996Lznd8kJ0zb4s8vXFr2g+F/bdOxKI+Lq4SbnhxnVjI39iwMKi7u3Tt33nWvtX79jUF
 sAA==
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

