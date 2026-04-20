Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9BA8BE9
	for <linux-spi@vger.kernel.org>; Mon, 20 Apr 2026 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776703874; cv=none; b=M7R7VKo5lP0IOsU7zEmbADthmQzhORzoM94prdEXOZ+0blRepSCn1xlos6ZJlx4oVRFofyXIrduVfRJR9Ebt/VUn8Ivkx4gqWN0TgvNFF7xX44r3+xPLrjovgSoBN9AvXNXmEzS6HIXqfybmuhisPhxgjmNEDh4FU1Yd9wCKeQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776703874; c=relaxed/simple;
	bh=AWogt2EEpp+VarUzuPBwKF1MNAmlhdHGP+MlwJOL99k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=XpcfPWXObQuL8I4kuaZn1/HR7J85vSX0pLpxjVEiW7hFKmK/OGtzuT5O1tsPjM0TAgahT5v9QdNvJovTg8WQ1AGVynuG6PlUROV0tuTBQOACTdUXkEnIC7T5mxtXTVK5TNPWZLTtgnEHYi6/RoI3quDTrqOqrbidhW/HJsUTWmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bLA7tsuZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bLA7tsuZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531A9C4AF09;
	Mon, 20 Apr 2026 16:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776703874;
	bh=AWogt2EEpp+VarUzuPBwKF1MNAmlhdHGP+MlwJOL99k=;
	h=Subject:From:Date:To:From;
	b=bLA7tsuZ1ysvoPyKRBm6NzJP4gEynXKZPbGjY2oiWkBFsMnce6Han/W1m7doXBqzI
	 yWLwbeZeeIug33VUTck9TIPqr5VIY0gYvYeat9lONr6RMAiL/R0fwqlTmZ8wvfauUp
	 zHySAfuI85lJSIDQNDfo7DaWmhZy7BuWYIlGtsHtBy28LDxCZNTQw0kIAMjXJgbITl
	 +FI8VPDQczHoLtOAg5fuN6osrepmVwV2gM+NWiAdhB28dEp8UcN09KiRqRBCTsVHtH
	 wCE9gAdY0Ad4GRr+41bXdBPCKLhzjaPyrhfDRBLfvqozr/3Dhj/Le19uhPBEwnYl8z
	 E2cj0qK/ms+Zg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 05D643930017;
	Mon, 20 Apr 2026 16:50:40 +0000 (UTC)
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
 <177670383850.1764181.12771219594506373783.git-patchwork-summary@kernel.org>
Date: Mon, 20 Apr 2026 16:50:38 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: fix explicit controller deregistration
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1081158
  Lore link: https://lore.kernel.org/r/20260414134319.978196-1-johan@kernel.org
    Patches: [1/8] spi: cadence: fix controller deregistration
             [2/8] spi: cadence-quadspi: fix controller deregistration
             [3/8] spi: mpc52xx: fix controller deregistration
             [4/8] spi: mpc52xx: fix use-after-free on unbind
             [5/8] spi: mxic: fix controller deregistration
             [6/8] spi: orion: fix controller deregistration
             [7/8] spi: topcliff-pch: fix controller deregistration
             [8/8] spi: topcliff-pch: fix use-after-free on unbind

Patch: [GIT,PULL] SPI fixes for v7.0-rc7
  Submitter: Mark Brown <broonie@kernel.org>
  Committer: Linus Torvalds <torvalds@linux-foundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1080199
  Lore link: https://lore.kernel.org/r/20260411192527.7F21E1AC58C1@finisterre.sirena.org.uk


Total patches: 9

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


