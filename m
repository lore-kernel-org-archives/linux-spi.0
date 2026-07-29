Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6667D24DCF6
	for <linux-spi@vger.kernel.org>; Wed, 29 Jul 2026 05:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785304722; cv=none; b=kEHk7YtlcYR3S2QIQmEXwhX8BYazjpg/rWOQZriBijOHveQmPKmK5To7c5b4Chwg39eKbM8P5hJx7Et3G3j4H1SGbur5YtiMWJS938mp+rn+5dluZY9ex4yFQdAxp8O+RXOuW6cW5kIhP8zzm7FWgTgdMI8wt5PdPTM7yW0DOKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785304722; c=relaxed/simple;
	bh=C+64bWeQTHtbkwL+F4hgpPVKezOvLvAkwlnPz5LvWmw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=MzExWK/bRTtxR3B1NUwBH6UEG7MLbnkP+8o6U7/WeJLQDxqhMrYY0FZ8pDVAK+PsKVTMp0AmTR7AM1Vd67YGtvfZszYnE10B+6bk6XDaXL3GWmPnoE4msQjl6McXGXzzStkfA9Mld5Aebp1BetTt23E3k5XtSFc1uC5jycVtdAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acqcmxhF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acqcmxhF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04E21F000E9;
	Wed, 29 Jul 2026 05:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785304721;
	bh=TczdgwhTOWByzBr2Pwt6wlUWzPWcUcKyq6P4Yn92y40=;
	h=Subject:From:Date:To;
	b=acqcmxhF95qln/x4GBLt7Dmyrp16gmRgMZz9bh6hvtOncFoUbeYevm3s+pbKH2JMr
	 wbJY1RhtvIAPMMhnEWAoenHo8t3TODXaP+xxZo1Cu3ulUgoKPkyyVraq/IRDP5Qpu9
	 vPxGKetD4InkLw2P52qHkxx1ErNpEcqwKqAkW7NbO29cT//6pbC5Vpjlc9GjR43lS0
	 3MQQAP2sbBrSR3qqp8l1seEMOxROUs2D3BWM542bjdXviTK5e9biw1TXq2ZG8r5UHp
	 chuTncdckC9dRHpHMQpaDbL1ykzLhSCaZ76mx1iJHq0jJqlTK98LxbRa5G8JqJjWSk
	 du45ZIEPFuWtQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 961FF3924A67;
	Wed, 29 Jul 2026 05:58:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <178530468524.2465457.2174908097479319744.git-patchwork-housekeeping@kernel.org>
Date: Wed, 29 Jul 2026 05:58:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: sprd-adi: Fix probe succeeding without registering the controller (2026-07-29T05:35:43)
  Superseding: [v1] spi: sprd-adi: Fix probe succeeding without registering the controller (2026-07-26T07:22:21):
    spi: sprd-adi: Fix probe succeeding without registering the controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

