Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563A223EAB8
	for <linux-spi@vger.kernel.org>; Wed, 10 Jun 2026 10:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781086824; cv=none; b=qyK/67msRmUwXj0UYwWGQE9/OIvdoGALjVmq9s9HnZqSbgdQykhI87ekRj7FcxUO9M9ACb6jZh7nPX+noFNiybzDA/REHXE45/gwtAwDpWdC1BlLByBUNS9c4lOLpxCI+cqo40hEigArQ0cO6ay3Jt+EjXCDti1SoCiq06sDhbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781086824; c=relaxed/simple;
	bh=7MN5D6Ama9onT+T/WKlC4la8cNe4yLpkyCkJeR1SP5M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=L1o0U4Drp1NHBxP8jpawfqLUeyfX+KpgxXYvgh57nqbpFjsf5j7QhFM885raWC27VRRQEJZteyYCoQmgUuyLztVQaxtpKS2LkA5DmhxHKvkEft1aWwRlV1SZkO7MKgy2z6TYRoNd2j1mOn4seU2/LiToJL1pdW233QCtm3QCSwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axi7fmXQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axi7fmXQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02E8F1F00893;
	Wed, 10 Jun 2026 10:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781086823;
	bh=tnRZ9HkauCOdmnyBqSG+tr/ENaJhe3z7UjxZQUs7eMY=;
	h=Subject:From:Date:To;
	b=axi7fmXQMhWmoMLtyEXn0t2clpjNHZ2Go0D7mrlpjwXQj8K6Frew5Uy87CaEYb6p0
	 1+xFrGgJGG4sCRXkMubt2vcD4SipPkSR9djJ7pRgIGFKxnY1eiFPNvRiHdwreMc7Zb
	 qffIxS8a8o11h8esZCo8IlHKEfguMJdo3d9pqaIxXHhhfow2zl/HFM+1b5xVBW6gr4
	 FmkLP1ygxKUuriKYU4F15LmKirNjAITVrYYwXToIP/WTW+3lYU2Gpas17JHPDqPZnC
	 PzPR90r5urWpL6i0ptVIkGsN07TLtEaKDSSqOxH//iShX4iVyGfqHudV/Ai1L1ngrp
	 LmT0xP/7u6Lwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C27B3930BB5;
	Wed, 10 Jun 2026 10:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <178108682059.2960614.11270223649204644502.git-patchwork-summary@kernel.org>
Date: Wed, 10 Jun 2026 10:20:20 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: meson-spifc: fix runtime PM leak on remove
  Submitter: Ruoyu Wang <ruoyuw560@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1108281
  Lore link: https://lore.kernel.org/r/20260609052647.5-1-ruoyuw560@gmail.com

Patch: [v2] spi: dw: fix race between IRQ handler and error handler on SMP
  Submitter: Peng Yang <pyangyyd@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1107724
  Lore link: https://lore.kernel.org/r/20260608095849.3446-1-pyangyyd@amazon.com


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


