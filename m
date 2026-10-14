Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B2C3B8405
	for <linux-spi@vger.kernel.org>; Wed, 14 Oct 2026 05:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791957491; cv=none; b=fXtOIc24n311Pq4zPaBIbghI3s+tIx439O62v621Yi8vHDp6+6tyX5smvGOsBYik2pR7nJztrHUp3ikZAjsrFvuhWI1VRIi03qxq1FxQS4snKuoMh8nzJAjWAm55G1jsF+vq/FwC5DSGJr1JEwpmpQBKh7jMw3IZjkSr3ArIssk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791957491; c=relaxed/simple;
	bh=N6A+iaOhPKKCaza/w5Mlv5VXLtKzG7t0kNWm8qkMtYM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=O8q/GcTUGpU+Dtv0H2lUUd5ZAaAUsCHNuzJaL5eJR1weTHZGwefMrrCR5QkXdh3iQ8hygomIcuuRd3a6Pv4R1qRLXimxudtFHBRZfepeMuZ7Es8iJC39ZnoH3SP3GGzKFonkALeh2J83uFDJoub00yx4eOpYUM+Fd1h0l8NQ7Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SO6So0Z1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SO6So0Z1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840B91F00893;
	Wed, 14 Oct 2026 05:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791957490;
	bh=OBT0BeVf2oKqhhebFpixXUJdis1QcdCI7T3tY35DZhs=;
	h=Subject:From:Date:To;
	b=SO6So0Z1hAN/jv2/4WSJhcEARBUWDta5L1LOSGl3XcwSepq/mG7EzBtKUc3zsDjpS
	 eTCaxYY47ozz6AnKS2hO+/hU7CWj1DLjNV/WZH+x+MyRZQ3HlJ6DWsKrzefRg6iDLZ
	 tRArAwHj46EiOOWrnXPg//vaa7lDToHp2ylqTrMFLyWFSKzNKp4tfyEsoYCyIpNbNu
	 0WO6kJo2LYnAZaDemF8mxfw1CUMiduV9poxty1+SgSiWPi06xzg7Piv2hVQ7HGVe3g
	 ONbXtxQNi3MdCp1SPF7sYygFHqMDEJcaw03/N2UEReC9OH5mLaTjjBU3V97kW2MRX2
	 BDbaatzxxXFZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 776873926243;
	Wed, 14 Oct 2026 05:58:10 +0000 (UTC)
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
 <179195748917.1628570.18032915779266592986.git-patchwork-housekeeping@kernel.org>
Date: Wed, 14 Oct 2026 05:58:09 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: omap2-mcspi: handle DMA setup failures (2026-10-14T04:56:17)
  Superseding: [v1] spi: omap2-mcspi: handle DMA setup failures (2026-10-13T14:20:04):
    spi: omap2-mcspi: handle DMA setup failures

Checked 199 series in 2.81 seconds.
This project currently has 16750 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

