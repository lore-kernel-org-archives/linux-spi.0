Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173833C9EF0;
	Mon, 21 Sep 2026 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985848; cv=none; b=SFRhFZ2sTHmD/0SKPudlabbIhHBRKw3oi2AdD/wXsbdYTDMk87LB5sBkJ7xoBUnbyHEvKteOVX/h633+r4G5MVwdV/wTbFN96r1UicFZhRWBlF5ktf+6RqDCgtWvG3tufM6LPowuBRo7y0WJeJPukcZpVstuK0ehxc9bBArE6wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985848; c=relaxed/simple;
	bh=iIuowXzeOPCff2NgpDNY7AnzrSvtvo0WU3eOtTczGts=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZwaSEQDVMa8romJm8cp5HTuVyH0rI4bUS8FacMFPFwFMcbNVAMddp0DvEiQ+yL4xuS/lDRFCkA/4Jx0/4ewzFhidVRZrGfoAbiI3gxY3fNf8Wb9SzS/I9gQ6epvyDJhgIOzNgw4KC+6+6rIF85ooHlJNRUkr5Z1NYUqxKb9E+s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=EXYS5Bbo; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="EXYS5Bbo"
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
	t=1789985835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yTymEAWaatS3hNs3NMCopMPpShJbhdwWnMcQrP+brXQ=;
	b=EXYS5BboGejYrW44OieqtnyMm94j2T21OKVrkkJehGm0rFzaqrNQxsrhOguVprPbxEBLcw
	Mk4bkb4Ee5H+e9fMmyWIqciwaZnnkRpdyX2YTU1miL5ZWxzObg/1YFMQtLC/h1m7uhlHgx
	KT9Qab/++IwVQdSJvr6fr2HNHmZq3CgAcIT86PPOPAPJBmW/eLxMJvlIsxeaQyudjBiY8A
	8JNEX7ZEl8zdTiya0aLRJSouD4/NRp3OaWvCz4TDbZJehR4p7s8B/yEsTB5QdQ90T7gruf
	f9miQHfCKVxN9NDFcPRx5aDbzgf1i1nnznhJi0rnMpXjXTj0JexPA4/H0f9iJA==
Subject: [PATCH v2 0/3] spi: Better specification for rx-sample-delay-ns
 and core parsing
Date: Mon, 21 Sep 2026 12:16:43 +0200
Message-Id: <20260921-spi-sample-delay-cleanup-v2-0-b460d572fd32@kontron.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NTQ6CMBBGr0K6dkxbjUZX3sOw6M8go9g2nUIkh
 LsLeAGXL3nf+ybBmAlZXKtJZByIKYYF9K4SrjXhgUB+YaGlPsmLOgMnAjbv1CF47MwIrkMT+gT
 GKi8PBqVujFjmKWNDny19r3/MvX2iK2tvNVriEvO4fQ9q9f64GRRIkHhE721jlcPbK4aSY9h7F
 PU8z19Re1dA0wAAAA==
X-Change-ID: 20260917-spi-sample-delay-cleanup-ab1d03ae02fa
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2964;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=iIuowXzeOPCff2NgpDNY7AnzrSvtvo0WU3eOtTczGts=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIWsji+xMTgs9+3mRV31iVn1leFaVUX9d9VGm9Zxcr/Puv
 HOZXPs7SlkYxLgYZMUUWaT4LV7bmsX6yB+rjoKZw8oEMoSBi1MAJpLIx8jQVNiqeto79mL4Z5vf
 8dwi3c/+fha21zxe+IrRiUH2lXUKI8NFtefTKmQ5plvuVWJpZkrR6DVen3E8dNfj74mZr/8IW3M
 CAA==
X-Developer-Key: i=frieder.schrempf@kontron.de; a=openpgp;
 fpr=1A0F38EB3D365D4C1FC67B5A69761B25107C8216

"rx-sample-delay-ns" has been a generic SPI peripheral property since it
was moved to spi-peripheral-props.yaml, but the core has never looked at
it, and what it is meant to describe has become blurred along the way.

It was introduced in 2015 for Rockchip, to compensate "boards with
high-capacitance SPI lines". The wording now in the generic schema came
later, from a description of a DesignWare register, and lost its
controller-specific qualifier on the way. It says what the value does to
the controller, but not what a board should measure to arrive at it.

Patch 1 says what the property describes. Patch 2 parses it in the core,
so that a controller driver can act on it without open-coding the
property name, and patch 3 converts spi-dw, its only user that reads it
from the peripheral node as the binding intends.

Deliberately not converted: spi-rockchip and spi-mtk-snfi read
"rx-sample-delay-ns" from the *controller* node rather than the
peripheral node, which contradicts the binding but is what their device
trees rely on. Converting them would break those boards, so they keep
their private parsing. The controller-wide default that spi-dw reads
from its own node is left in place for the same reason - it lives in a
different node, which is not what the core parses when it looks at a
peripheral.

This is groundwork for letting SPI devices declare their datasheet
clock-to-output-valid time so that controllers can move their sampling
point instead of forcing a lower spi-max-frequency, posted as an RFC at

  https://lore.kernel.org/r/20260303-fsl-qspi-rx-sampling-delay-v1-0-9326bbc492d6@kontron.de

Nothing in that work is needed to read this series, and nothing here
depends on it: the chip side is a separate quantity that composes with
this one, which is why patch 1 spends a paragraph on keeping them apart.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
Changes in v2:
- Fix the bindings patch subject prefix
- Improve commit message for patch 3
- Link to v1: https://patch.msgid.link/20260917-spi-sample-delay-cleanup-v1-0-0e4eddbfb1ce@kontron.de

---
Frieder Schrempf (3):
      spi: dt-bindings: Clarify what rx-sample-delay-ns describes
      spi: Parse the rx-sample-delay-ns peripheral property in the core
      spi: dw: Use the rx-sample-delay-ns value parsed by the core

 .../devicetree/bindings/spi/spi-peripheral-props.yaml       |  8 ++++++++
 drivers/spi/spi-dw-core.c                                   | 13 +++++++------
 drivers/spi/spi.c                                           |  9 +++++++++
 include/linux/spi/spi.h                                     |  9 +++++++++
 4 files changed, 33 insertions(+), 6 deletions(-)
---
base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
change-id: 20260917-spi-sample-delay-cleanup-ab1d03ae02fa

Best regards,
--  
Frieder Schrempf <frieder.schrempf@kontron.de>

