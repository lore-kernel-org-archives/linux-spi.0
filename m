Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791502;
	b=zuSUyw3Io6t0tVF1eD+tqe1aOxjuEWwNOWldyOtmZKmWP0lWxmoMU36CLOVZsUsEjs7Z
	 omcU6YC5okXmtB1tyM7Ji2NMgtSmG+xyOWjphF/F64HcdXyw2gh5mLzpnepK60KftXS2w
	 OB7ZL4uV+DJSi+Mt50ZWfTQbRt8mzuGLYE+x4V8ItPXsa2G8hjnm9a+inGK2QGyMlkzUc
	 PxhcXw1QJLhpFHt/+wbVgywIKOIE17wiwltxj4R2G1dRFnyfaT8YAlkpTDKhRpBOZvio2
	 dM1b4LxRw6mwpVYhXxgloKmuQrxFwPHGITYA+AY1aBfQu6WcrLCT6JHudE6MKGYCBDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791502;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=Gou6o2fe+1wnUzZHluoLsVgPqpVGnTvBeDFD4cgVYjc=;
	b=054lwK8bE7M9WQW8ouSABU5eRIX9G3V2yTjLvTrKVHUI3fms9yKksRtk2PifY2HZBfe0
	 KOdHd5fX3JHqNy2Efa3xfiboX0nS1v7ZNT3mLRPzyhhyAKPvvzluwiyv8H1L7q8sQS321
	 IvhmEeeuEgymjKwPF1ZRSk/iNNRKqIxt3fRwtx4h8A9zhrlO0pYCKCm+0WmCNESWg3Ao7
	 Tr5ATrst+fe6/+xCh+ZmKFUO+RW3Pz6TKgomh3fxo7HX4uBDeyIqbnFywOqEF7ro575rL
	 8Yd/xN+0cagc9G9GmmmWRn/1X27TbH2KlOREWe0m4P5KwpyW3sHVNAMhrtuWuPSmY/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIIie6Li;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB1C606A31C
	for <linux-spi@vger.kernel.org>; Fri, 27 Nov 2026 14:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LIIie6Li
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BDE91F00893;
	Fri, 27 Nov 2026 14:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795791502;
	bh=Gou6o2fe+1wnUzZHluoLsVgPqpVGnTvBeDFD4cgVYjc=;
	h=Subject:From:Date:To;
	b=LIIie6LiHojPG5d1oZAIqmfEL5zKwTPov2JZcStMAntZ3Fn4ulCooHKUmTJyIVOni
	 tFj7pN320umPINO1DlzfcvtGu+pUnwb1h2dyabuRSGy1eLdpjy57gt0IYMfMWfBQbm
	 IvLc7xioOdotS4eyuuiC3b8X199NvoVpMbWhRiqiN3qtbtxBzfBP73Ljku7vi45x4y
	 11QPrjbEZeQHg/tEWhGbe12gyDC/LHM5KablN0c1cazRKcnWFmqaGGy11qgEi8knVB
	 KI81GLHUbL/mqvkXJoynKFT6CNWAGkBOy6TbijOO1mZsibDQCvaTh8SwuIITlFvCcX
	 T0PYlPMbfABMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 717A33924A49;
	Fri, 27 Nov 2026 14:58:22 +0000 (UTC)
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
 <179579150096.1043062.8553975461209194167.git-patchwork-housekeeping@kernel.org>
Date: Fri, 27 Nov 2026 14:58:20 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-mem: Express the dummy phase using cycles when relevant (2026-11-27T14:22:22)
  Superseding: [v1] spi: spi-mem: Express the dummy phase using cycles when relevant (2026-11-25T17:51:14):
    [RFC,01/16] spi: spi-mem: Handle a corner case while sanitizing ops
    [RFC,02/16] spi: spi-mem: Stop checking the dummy buswidth against board wiring
    [RFC,03/16] spi: spi-mem: Add support for dummy cycles
    [RFC,04/16] spi: amlogic-spifc-a1: Consume dummy cycles directly
    [RFC,05/16] spi: amlogic-spifc-a1: Fix a typo in a macro
    [RFC,06/16] spi: amlogic: spifc-a4: Consume dummy cycles directly
    [RFC,07/16] spi: cadence-qspi: Consume dummy cycles directly
    [RFC,08/16] spi: fsl-qspi: Consume dummy cycles directly
    [RFC,09/16] spi: microchip-core-qspi: Consume dummy cycles directly
    [RFC,10/16] spi: nxp-xspi: Consume dummy cycles directly
    [RFC,11/16] spi: nxp-xspi: Fix a comment
    [RFC,12/16] spi: rtk-nor: Consume dummy cycles directly
    [RFC,13/16] spi: sn-f-ospi: Consume dummy cycles directly
    [RFC,14/16] spi: stm32-ospi: Consume dummy cycles directly
    [RFC,15/16] spi: stm32-qspi: Consume dummy cycles directly
    [RFC,16/16] mtd: spi-nor: Express the dummy phase in cycles

Latest series: [v4] spi: fsl-lpspi: add atomic transfer support (2026-11-27T14:02:28)
  Superseding: [v3] spi: fsl-lpspi: add atomic transfer support (2026-11-27T12:58:27):
    [RFC,v3] spi: fsl-lpspi: add atomic transfer support

Checked 244 series in 4.03 seconds.
This project currently has 17262 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

