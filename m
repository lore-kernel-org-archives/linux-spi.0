Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792439980;
	b=lLMjWNY6n8kjUIBPwUaV6HCoxvloU5IsuQ294XWA2X5baTileb+3JzMDUNq74rOHC+oW
	 JLmAxfNflIhXEMYEPkc9zsJHn/QmpWJeC2X26E5R9d+pUlNO4Nq1rhhG2ZAD839RpA1GK
	 TkWUNQU86YRShQ7N1Wmaik8cFABFDFVKV/YyJJeQkz/R9B2IPaouYUTEK6kLiLUImbStM
	 uLq8kNo92zxcjBfyQgysemxPmyDscs9ZeOftTbsX5w8ioYBC8mny7PBKTSxgRp1ckF3xI
	 VrCxzVOSSdjOMgDgPbPrDINJ2KMQWDA5m1XFrhOMcRQEyMf0VUCzuDXKa/IIYfupQfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792439980;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=Elx2qAb+q1kKoSW5khP4jMXoFYBvPZ0hx1jf+Nv0e0Q=;
	b=1Az0Q4SjeaSjB7gmlOVKReAnIAbnSBrcte73rbdoxdK3ixC5K2bx0ihkvMcLysk6JgEq
	 lTsO76KQRYgemVWMncYSKXisrqRb4wuDOaFW1mAReE142eJxFLei71A83hqa80QT9UC8v
	 AH94FuqDgji70KoQKN1JhUCogeEvKFRPHeVEzI+NiVS59t4IEeonIpxUi4riH6uAh0v7X
	 nUJ92z6K6Y0mqUMIHGrrkKEUUVEW3MqWNBSx5cx8pkho0y1nfxCDHnUenkWaCYBwKLPxL
	 e2UClRTlmWkuNhLYznU1vN1dUWzUwDN6R7eLhk1o6wnlEVgHLU39JtEh2VoAdZw2P8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJxZ0d0S;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E59606A31D
	for <linux-spi@vger.kernel.org>; Mon, 19 Oct 2026 19:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iJxZ0d0S
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DF71F000C4;
	Mon, 19 Oct 2026 19:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792439980;
	bh=Elx2qAb+q1kKoSW5khP4jMXoFYBvPZ0hx1jf+Nv0e0Q=;
	h=Subject:From:Date:To;
	b=iJxZ0d0StRhlJ7GxjSmBnDMLU9UC+KjD/oEGuyidXLuAByih4FmsE1gkgIENK618r
	 OB6qprSitQrC3dvWdXjhQl83P3eCgFrYAy3Ks9/iKokmX7vp4mz3nWdHoxw0aBPmcn
	 aR/tbj8JqP+eeDywZxcnhZh/kbrXyf6ND7fgC++J4jfDDXaVmAuNPhg9Kw+WdgV5yL
	 6kyNlV1pH1tHiN06ON9Yz9GLcJxGxamTxd+ZqJWbZejwC6Bp6mRc/X94bl2QjQ1ZIq
	 w6Vx3f1CRONFRic6P6PguDQ1JRTrKMAwcgG7q4NEpzEASWsmoNwKfVjFGj2zFy8Prv
	 YF1RrSz3Yi0dg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A4B43924A53;
	Mon, 19 Oct 2026 19:59:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179243997879.3295194.18313002773978037281.git-patchwork-housekeeping@kernel.org>
Date: Mon, 19 Oct 2026 19:59:38 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] Add spi-hid transport driver (2026-10-19T19:01:12)
  Superseding: [v5] Add spi-hid transport driver (2026-10-09T22:25:26):
    [v5,01/11] Documentation: Correction in HID output_report callback description.
    [v5,02/11] HID: Add BUS_SPI support and define HID_SPI_DEVICE macro
    [v5,03/11] HID: spi-hid: add transport driver skeleton for HID over SPI bus
    [v5,04/11] HID: spi-hid: add spi-hid driver HID layer
    [v5,05/11] HID: spi-hid: add HID SPI protocol implementation
    [v5,06/11] HID: spi-hid: add spi_hid traces
    [v5,07/11] HID: spi-hid: add ACPI support for HID over SPI
    [v5,08/11] HID: spi-hid: add device tree support for HID over SPI
    [v5,09/11] dt-bindings: input: Document hid-over-spi DT schema
    [v5,10/11] HID: spi-hid: add power management implementation
    [v5,11/11] HID: spi-hid: add panel follower support

Checked 201 series in 5.85 seconds.
This project currently has 16788 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

