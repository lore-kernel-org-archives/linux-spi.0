Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A140641161A;
	Mon,  2 Mar 2026 15:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772465764; cv=none; b=um/jD3pVHX8l54BQAW090dMKB5qymYyQN+d08dcqkwDbSU7j+x6pvNaBI6rvX+CX5QQjNrhBsrWgo2dqXAP5Fb0LQZwZMsFu7v7x1Fm1OPPYrsowSrRRhXNovHMzHZ4H+JIS/bftJUF4XF/LvB+kIrDkSbXyNdVnhrcDtGObIaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772465764; c=relaxed/simple;
	bh=GwfYq0+TY5ANRavFRxvs9n8sWwS/ZEOhNTjVOS3rCpM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dQBUXF/imTPFgu0xQKrPT+qGDi0UICmVl9woS8k4QsbFxteAc+Q+ztJPcRVXDtOQ2cqQqBqxmtfFQ00MnT0W/zuSY09hrRmByVQIxKSYJztJFEFVceCEGXseTM74UxjfZzxbj8L18KtoLHVAQnzHxh9sga3nQeA4bYPtgKBSvI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QO98pFpC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QO98pFpC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C753C2BC86;
	Mon,  2 Mar 2026 15:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772465764;
	bh=GwfYq0+TY5ANRavFRxvs9n8sWwS/ZEOhNTjVOS3rCpM=;
	h=From:To:Cc:Subject:Date:From;
	b=QO98pFpCvITBwuapY2ZRNtWBp5puOOg3BmSnLz6RcO7v7C/JuQiyKCVZqVE0oTEU5
	 e3nxrAN/Hbc0QzINb7QP6bnCEgBIr87S7Lpkm2Yi/B4uAjyRi22irijTr4wHlL3aL7
	 Mfl9Zk0BdFuYK3yIzvN+0UiOQJBrk1R86JTYO9fYjI3WVJqu7WbSLqX+Dk5hWtAc/h
	 0uQ4Y6NB1ALgwXd9RPXLkp7yHQq672qDjaceY29eRIXm6v7kBQ9qSO83vuNgmZ0qYb
	 3und91Gb+dPaJgpxQYwO1wN6eBnRrQOvVH6cShRvCsLfBMpXUpEggUTq13KNowzw+e
	 S7aw5dXVPIIVQ==
Received: by wens.tw (Postfix, from userid 1000)
	id 117AE5FCAC; Mon, 02 Mar 2026 23:36:02 +0800 (CST)
From: Chen-Yu Tsai <wens@kernel.org>
To: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej@kernel.org>,
	Samuel Holland <samuel@sholland.org>,
	Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-sunxi@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] arm64: allwinner: sun55i-t527: avaota-a1: Add SPI NAND
Date: Mon,  2 Mar 2026 23:35:55 +0800
Message-ID: <20260302153559.3199783-1-wens@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is v2 of my Avaota A1 SPI NAND enablement series.

Changes since v1:
- DT bindings (Krzysztof)
  - Moved "allOf:" block after "required:" block
  - Dropped "type:" from child node in conditional block
- Collected tags
- Link to v1:
  https://lore.kernel.org/linux-sunxi/20260227175157.2339758-1-wens@kernel.org/

This series enables the SPI NAND found on the Avaota A1 in Quad SPI
mode. The SPI driver already supports Dual SPI and Quad SPI, but the
bindings need to be updated to allow it.

Patch 1 updates the binding to allow Dual SPI and Quad SPI on the newer
SoCs. It also allows describing no TX or no RX available.

Patch 2 adds another set of pins for spi0 on the A523 SoC family. This
set is used for the SPI NAND on the Avaota A1 board.

Patch 3 enables the SPI NAND found on the board. No partition layout
is provided at the moment.


Please have a look.


Thanks
ChenYu


Chen-Yu Tsai (3):
  spi: dt-bindings: sun6i: Allow Dual SPI and Quad SPI for newer SoCs
  arm64: dts: allwinner: sun55i-a523: Add pinmux for spi0 on PJ pins
  arm64: dts: allwinner: sun55i-t527: avaota-a1: Add SPI NAND

 .../bindings/spi/allwinner,sun6i-a31-spi.yaml | 29 ++++++++++++---
 .../arm64/boot/dts/allwinner/sun55i-a523.dtsi | 35 +++++++++++++++++++
 .../dts/allwinner/sun55i-t527-avaota-a1.dts   | 15 ++++++++
 3 files changed, 74 insertions(+), 5 deletions(-)

-- 
2.47.3

