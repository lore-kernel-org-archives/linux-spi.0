Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6427739BFE9;
	Mon, 20 Apr 2026 11:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776685560; cv=none; b=EwalZ+kOJqiIJComeJkFjEBjSIKxvT4J5XypJtkYjayBwqJDW34vpqByk0qySo5z3zfKRBeQHZyhax5jB5komoXvC+MSFGlm+oA9WFgfPP5LSlbzg/ObSs1Zd4j+YnFpj4rR+JzXrkwlbQCLtiFBSH9QWnefGT+54GzDwnP7QyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776685560; c=relaxed/simple;
	bh=fmCUluiOM4pQhqOBw7LaKvSLx/YkSi3y8NX3vRPUB+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I66IlbjRR/8XjgVWDBLL9Ze/vuwhxfPW8CJV8Mdc1mq/KKZ9zLSNAu0XLtORia0f77lNciRFBUnlj+z5Q9MwMUcdgJZYH3k1gX8wLA7uD56MEhf3zo3Q7ZXqGyzfsA6McqOxNgIG/k6FEtsqnwiOxfmZ8S5CA2MwPVp5Z5vSPKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=Cn17oX3X; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="Cn17oX3X"
Received: from francesco-nb.. (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id 753061FC8D;
	Mon, 20 Apr 2026 13:45:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1776685548;
	bh=bVVY4TQNa7JRVGxpjCbc/o+R/dODtLa+hMeOsdP8WnM=; h=From:To:Subject;
	b=Cn17oX3X6wd68Y+TY/j/J2iaHCN7RzftOYXIc2cjmo4WnAsvPLsCgTsRhy6u8pRDy
	 hNeinFJmmzc5qBt7OHdBiYNfYV9hLqJDhiHAu+Vtzz9xdHlnYRko8+swrYCazNScQ9
	 cJ9T4p2j7dO+JmxVOFkRBdkM/w9YTdRy8YTNa+yJFVhraTH03RnVeKXTeQTKAATX4E
	 QaUklMn1zXTeDzCy5SaVcxG4IP79pUuc2tSVGDiNcvXLzm6gSp6C8C7x15oNjlCdq6
	 MZPgnH0IviCQzmhBbQc/SwVixrU+6FSbOJW3dC5BpWV2HneAJuUbxvwiG5IjVULFqB
	 g5x+3Jv+Ix+WQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v1 0/2] spi: spidev: Add Toradex LAVA HAT
Date: Mon, 20 Apr 2026 13:45:34 +0200
Message-ID: <20260420114537.78160-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add a compatible string for the SPI loopback device present on the
Toradex LAVA HAT test fixture and add it to the spidev driver.

The Toradex LAVA HAT is a board used for automated hardware-in-the-loop
(HIL) testing, it provides several test-related functionalities, and
exists in multiple variants depending on the board it is mated with. The
SPI function is implemented with a loopback on the MISO/MOSI signals.

Link: https://lore.kernel.org/all/20260310133254.GA51497@francesco-nb/
Link: https://lore.kernel.org/all/20260316073547.11437-3-francesco@dolcini.it/

Francesco Dolcini (2):
  dt-bindings: trivial-devices: add toradex,lava-hat-spi
  spi: spidev: Add Toradex LAVA HAT OF compatible

 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 drivers/spi/spidev.c                                   | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.47.3

