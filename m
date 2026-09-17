Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F1B4C10CB;
	Thu, 17 Sep 2026 15:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659524; cv=none; b=myl44z/V4vkJMCGvnYcVW5O19JnlojrSmyjXtViAQlPIV9mQhBfSk2gKtHs4XvbpQh4jmtxk6PNNH1hLV+IJfzU8osgn9N9JB4o9Y9qNxaHAV4m4+phXXGkA6capSYcrkL8D3iMGBMhIJ+QLGI81JSzuY+fdLxa8CK3KJOSCJmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659524; c=relaxed/simple;
	bh=MoG2KKKCOb8i6jNykCKvYIGrUNKtrQQ7X8DDkYY4Mgc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=A2VRcTueq81WE5OSL9bDxk8m0SU2+jwSvvMLGLusIEmJhm/jZC8s3IazL9Pq/Xdom3EUX6XPTkDZeAaJLy5ZyQE0jQ+WzpNNdb6dv8zkIxksOrrp5vi0e2+eQrFs4sUu1tNllY/iQm9pKr31BBcAELMVXYl81yJiLdFk6mNccNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=r0OF0eSy; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="r0OF0eSy"
From: Frieder Schrempf <frieder@fris.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=mail;
	t=1789659509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t4lntru9GYBlyU5HcHrrBAQ9M2TehHHZ4GbaLqq2g98=;
	b=r0OF0eSy/h4tCFYjSCMMNcm3LNwiuIHFpXJJsAZdfg3o66KcKZJQxQo7e7hfSupEh4N9cc
	eqifjgtXxCwh5azk8AxLXzZFtRoO959L095SxFUP5BX0qcC+VYajdPkcCxTxCvgg7QtrEe
	66EQTnFlzAW32ajZMJQBQQ3CpkKsaxZQrK4eAe30HZkw8X5dxA1uFubD9flWMnHQfMvmx0
	8i+FmedFtBuzAIMX1zD6JvZqDydfWpSkVwLu65k1wYwRQz6WOgjV4eyqfru2RW3/MqWtPs
	BfPZTHXhS1/DUPkVCfKzSIBSej9+ey8Uibns3RSXLIMnfPotUkDIKz/qHhBuvg==
Subject: [PATCH 0/3] spi: Better specification for rx-sample-delay-ns and
 core parsing
Date: Thu, 17 Sep 2026 17:37:34 +0200
Message-Id: <20260917-spi-sample-delay-cleanup-v1-0-0e4eddbfb1ce@kontron.de>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQrCMBBG4auUWTuQRFD0KuJimvzVkRhDpxWl9
 O5GXX6L9xYyjAqjY7fQiKeaPkqD33QUr1IuYE3NFFzYuYPfs1Vlk3vN4IQsb44ZUubK0vvktgI
 XBqGW1xGDvn7r0/lvm/sb4vT90bp+AEvbMX58AAAA
X-Change-ID: 20260917-spi-sample-delay-cleanup-ab1d03ae02fa
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Frieder Schrempf <frieder.schrempf@kontron.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3071;
 i=frieder.schrempf@kontron.de; h=from:subject:message-id;
 bh=MoG2KKKCOb8i6jNykCKvYIGrUNKtrQQ7X8DDkYY4Mgc=;
 b=owGbwMvMwCWWWSatKlDTJMZ4Wi2JIWsNZ+mVGcFsxR+cHB97/C0smMajNNt2w6SF+VE183ICj
 4cJlOh2lLIwiHExyIopskjxW7y2NYv1kT9WHQUzh5UJZAgDF6cATETfnJHhS6JmwCYvxtitIjXO
 B403cYhJrd13g/965e4DAXOW2PY6MDJc27tq98YVBbOLYxatWRNZVbvmw2LGG0tD1u/s4rj5K+s
 0KwA=
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

The one behavioural corner is in patch 3 and is called out there: an
explicit "rx-sample-delay-ns = <0>" on a peripheral is now
indistinguishable from an absent property, so it no longer overrides a
non-zero controller-level default. There are two users of the property
in the tree and neither does this.

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
Frieder Schrempf (3):
      dt-bindings: spi: Clarify what rx-sample-delay-ns describes
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

