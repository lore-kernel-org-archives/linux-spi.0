Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794841125;
	b=1Ll0FS+eM0TmaSLQDvQZHwg0Mj1biEM9ezGf2pAd8g9pyJrPXOhUPWW/PoGmA92AjlD1
	 w1uJyxRizkBa3B1erWmnFL5R83bytGEaqRwlIToHM9FlItkfCtST4sOhMi0ketxT+SAUm
	 g+hGc25W2SjdVZz3FPFq0YRn5f71vEsDtCnSaPyRKhmYESIJwyAMvfRg0z2T9IOcuzeW3
	 9j+At2rpbVmQs9AL+KDOGAaWCqg6l3qarSLHPjAYLke9SXA67nwOVZwhyvlWI/32TvZY/
	 ECQICRiW3MmcVwKZKcSFu034FyOkHdsO4VpAiB7dy7LEnKffW5XZpN3c2MOT0drRybA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794841125;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=z9S0upqxqir/n4lAASYgkwmPM4n7M9Fs1Y6X7m17GgU=;
	b=RhIGQ9iqxX5BtIIY4IpbdqPgtwhhGwP8u/OfwDdawR1BphyHKKsa7dPsNpp+HTcMhG/M
	 6IJcaDsUH0hhmhm1HE0n+5V2ZBwR2Xv6teUwORLvKZX76N/y/GWqZ+5WKiO85KshLYSOQ
	 6BA468f3NsCw13iyUjOEc9eSlhPmeDjoM6/BgZCGP88ipyKnS2eyo1XRANI4awQYFb51e
	 VL3S2Uph3VPrh7oJS9g45EsIajMfic6nCRMO+UYqeJetFRrqnyUU0oxFOMumiTEMRrHmt
	 hMXEAPbp6L+jy3XlMQXia9wimovstOqcFxEdHt8UAdhbeCahoDtnFQpIwtUfQF3lWig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WSPSHjdN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3A2A60A2608
	for <linux-spi@vger.kernel.org>; Mon, 16 Nov 2026 14:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WSPSHjdN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01DA1F000CB;
	Mon, 16 Nov 2026 14:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794841124;
	bh=z9S0upqxqir/n4lAASYgkwmPM4n7M9Fs1Y6X7m17GgU=;
	h=Subject:From:Date:To;
	b=WSPSHjdNtn7HuDnbO4K2a4RGvy2OaHqUCOWhlMlp/PDqkxn2MEqMNiq+1BDhhDIR9
	 hK+kluMxAX66Rm39eL96/9T3Av/aLL/vqZznrMePn/jhtqoQwK+5HLCKDIAEuZCm2P
	 7X0v7msnO8PSGkTqOv+LYTwGV19drV1amNSiWJ3DnPT+2o0698z/Xm+oy+sRjNmo1O
	 bcc6axT4Fv1wgeCk3E1lSovoMITvNrIlOENzBaWpk7uXByNPf7O94cjnj/LIQ6LUyr
	 NRaFBhZFJCDE8/0mlEUyEnl0Jzg1e4msQAagJL9iBld981VPvHd7MJ2Cbq6Esf7bKQ
	 hGAyaHm8eo+aw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B4477380046E;
	Mon, 16 Nov 2026 14:58:44 +0000 (UTC)
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
 <179484112333.3693569.10868792257721297386.git-patchwork-housekeeping@kernel.org>
Date: Mon, 16 Nov 2026 14:58:43 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: cadence-xspi: Fixes and ACPI changes (2026-11-16T14:49:03)
  Superseding: [v3] spi: cadence-xspi: Fixes and ACPI changes (2026-11-12T14:30:45):
    [v3,1/6] spi: cadence-xspi: Properly handle errors in .transfer_one_message
    [v3,2/6] spi: cadence-xspi: Reconfigure to STIG mode before SPI message
    [v3,3/6] spi: cadence-xspi: Inform SPI core about size transferred
    [v3,4/6] spi: cadence-xspi: Drop useless cdns_xspi->cur_cs
    [v3,5/6] spi: cadence-xspi: Rework resource discovery
    [v3,6/6] spi: cadence-xspi: Add workaround for old Marvell firmwares

Checked 219 series in 3.67 seconds.
This project currently has 17084 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

