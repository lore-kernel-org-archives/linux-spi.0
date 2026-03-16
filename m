Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8123502AC;
	Mon, 16 Mar 2026 07:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773646567; cv=none; b=gIc6qxVqK3q3mReT1PNqVIPyGf7p34ShpzbWcQpFjp7xcNC7XxRniRWN/RvJLQlGB0jajMWPlhLuuH31Q0fzys7WKzmrPIhA0lrByLMAOcqf+dyefXrAVT4wYsICM6P+HH7GmpaSBeqqw+M9vHTFuiXKTDqIvpqjrk5RXwzci5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773646567; c=relaxed/simple;
	bh=pURDc7OaFVz+/BW3jfbaFBTr8kmIx1bSO7X67TBUrs4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y7K2Yvr5tQhIJyF4AjTsqPraGYa9D3xYTnc++cBiBT6mq/1G79kcex2gPAESWG7zQ1nPivZRPsh6Necd7Whuvi6z20nKZgwyRrJVz9txHa1AAbflhlhk624dyARQnrKfFwNh20TBKkTPm42Samy36NtKbFMHwJ7S4Ra7t3Y7Nyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=WFWZVrz+; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="WFWZVrz+"
Received: from francesco-nb.corp.toradex.com (248.201.173.83.static.wline.lns.sme.cust.swisscom.ch [83.173.201.248])
	by mail11.truemail.it (Postfix) with ESMTPA id A5F9D20205;
	Mon, 16 Mar 2026 08:35:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1773646556;
	bh=wOZMuNw1ZPDjvWEnM8CHFX9oZa0bb/YAzydxqZOFIME=; h=From:To:Subject;
	b=WFWZVrz+AQ89/V0rHugUQl+N8FMOgV/Dq7hJpTJ5G5bDgnfjcu/IZx7+78VOpNTuG
	 n3IukDslWwVDUymQfLRI08tmt8/4rpSxk18N7CQUUq736ljwtxudUEji8+xFKgWcbm
	 mMjldYeBgZtqc011/8P4d/6gkaYtss5r/HmvzBXu8eFoSSYxCe2SYyrk2Fwr34ffpy
	 dKqTrBFH00fXTLXty3hlcNUiLfzuIoMKIqVlRfj670WFhFQUWzJ61X5xKbfdSvoPDQ
	 mFvAwA9gc2/J16/xxNRGDNDXI9ZLOUkD8l0HdJQP6R0DuwzdyUj3UxnM3ppIemIbhh
	 vRDfKMd+Lw2fA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mark Brown <broonie@kernel.org>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Subject: [PATCH v1 0/2] spi: Add data loopback OF compatible
Date: Mon, 16 Mar 2026 08:35:42 +0100
Message-ID: <20260316073547.11437-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add "spi-miso-mosi-loopback" OF compatible, that describes a
single wire loopback between the two data signals, MISO and MOSI.

This kind of setup can be used for testing the SPI functionality.

Link: https://lore.kernel.org/all/20260310133254.GA51497@francesco-nb/

Francesco Dolcini (2):
  dt-bindings: trivial-devices: add spi-miso-mosi-loopback
  spi: spidev: Add data loopback OF compatible

 Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
 drivers/spi/spidev.c                                   | 2 ++
 2 files changed, 4 insertions(+)

-- 
2.47.3

