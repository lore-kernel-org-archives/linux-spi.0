Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5C23783C3;
	Fri, 17 Jul 2026 07:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784274578; cv=none; b=YNdSk8cgmTmKeXtwXhUMg1XQyRn7vG0sm/5/ankPWyobDZF8T7soNcLlXB1VMnYBIi/YtJxgajnrN7cWGd8uc9JDV/Hz3pkRlcjVZ4Aur8Bx9KaN7D3ABzKDSZ5eIEo09Laf98JvguSFXkP4HoptTJpdJcX+wVno1XF6xEBay4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784274578; c=relaxed/simple;
	bh=hl4y02I9tA4u+DQHQqqO/xk7mXY4kQUgmqTa/x0JXaE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O4fQ5UG5nBzlxSu53biSrkcrMey7FA6ZYSWGAsgFyXkW8JLUrnFZFB1HkzjbxJxhl4gGig0jt/3FYz1kM8s98vITAgmafq0VzNoQpGnlmGPe8A0ZkJbbYGeTtONKEFsEan5Az3/tjAohva02fdwIQ9TzKU8cqyt03FmmMbFKIXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jv1GF3bJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jv1GF3bJ"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6ADEFC2BCB9;
	Fri, 17 Jul 2026 07:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784274577;
	bh=hl4y02I9tA4u+DQHQqqO/xk7mXY4kQUgmqTa/x0JXaE=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=jv1GF3bJTnz8aME1PSNqcIK970ID3TJFdrzvXhGOsalzm9MHOCJ53R438Gd75gJyu
	 twxoUpX5J7jyJTcnMGi8dyAZPozZluUIhhackvOEyobUf7wsBM3UwFblxvnRJv1eIf
	 0z3txs323o8SBbyZB5QUHqSPYVuaCLi4siDiV0kIeAFhYzpgMB0UYBztrQzYaygQDR
	 xRtETdtn6PVKcam7LB8ljHWSFyzjR2Kb43YdGVVwFrDGtHEqptiB40lb//Uy8xOvkk
	 SFt8wSFwDc01E3K3l39aStwn+lKybXN02e97LyNvIGtV3va3h2pqVYl/CH3y8hemRm
	 jTpFVSGAeQMjw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56196C44507;
	Fri, 17 Jul 2026 07:49:37 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH 0/3] spi: add support for Amlogic A9
Date: Fri, 17 Jul 2026 07:49:32 +0000
Message-Id: <20260717-a9-spisg-v1-0-2eeea77be19f@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIzeWWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0NT3URL3eKCzOJ03TRDy+RUAxMD40RTAyWg8oKi1LTMCrBR0bG1tQA
 yW0scWgAAAA==
X-Change-ID: 20260715-a9-spisg-f19ce0403a50
To: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784274574; l=813;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=hl4y02I9tA4u+DQHQqqO/xk7mXY4kQUgmqTa/x0JXaE=;
 b=ya0yNDSjGaGqYZuUAwyX5QW7AKAbiK0wPvRNHxKiKnT5Tfk7qIdIVPww5XU87USkzsRsxrvkx
 HEhWy/wo1iQAgAXRoUww+8OAHhTjukbMZm+eJ9Ia0HW6R74Ze6bU6uO
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Add bindings for A9 with some features, and driver for A9 base on A4.

Fix the incorrect keep_ss of the last descriptor.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Sunny Luo (1):
      spi: amlogic: spisg: Fix the incorrect keep_ss of the last descriptor

Xianwei Zhao (2):
      spi: dt-bindings: amlogic: spisg: Document A9-specific properties
      spi: amlogic: spisg: Add support for A9 controller features

 .../devicetree/bindings/spi/amlogic,a4-spisg.yaml  | 36 ++++++++--
 drivers/spi/spi-amlogic-spisg.c                    | 78 ++++++++++++++++++++--
 2 files changed, 103 insertions(+), 11 deletions(-)
---
base-commit: d0b5dd16226814e5c73ba8daf88d3d91c990a38f
change-id: 20260715-a9-spisg-f19ce0403a50

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>


