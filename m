Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AB94D1786
	for <linux-spi@vger.kernel.org>; Mon, 28 Sep 2026 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790603480; cv=none; b=MPRHf0dRKwJnjs2r4Y0Ma6Q2NgGjWPHVnxq8r2M7zsFfdVQmgUoLF3uodw3Zk+gTgCXOOsiyJ0gTm4C1xejGk7NHE7ro/4cyDu2MdoumpVlmJaM1CTXdPS+CxuAniAEzwiynwYT2v/GkvrGspp9DSNyRruq/cbmKE0ztIjPSH6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790603480; c=relaxed/simple;
	bh=4We1Vc+rKEZNjQozziGOXCElO8Gxw6R5LnOTS248lW8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=GdDzcFu+/hFTjxhjkqpCDh+jnuAiPCfhCXamV69ywuoLiqvnkKKf+ByawRBFYusk1tcVQ110cr+cPNimjLsq04tcoJAKfP7oqgpQv6jEYuW5llQdUCJzB2bZvWgb8dpAW3sQH+EyKAMOe0+9jPuRbMo16um0H019dDhNzZz6lcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k4aLYloc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k4aLYloc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D7D1F000FF;
	Mon, 28 Sep 2026 13:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790603479;
	bh=5BL8+AOQ96SLrP3h4U7v2/mYEz1CovZeVkwCZnOKZcE=;
	h=Subject:From:Date:To;
	b=k4aLYloc4n6h+gJTjzPNhjxGhQ+EDJizWN5H8M8xq07n0bEvHl2ayRd1M4bL1inzC
	 3YACc2gp9ZdK7QMKkkYgAjwX9CVxejyWu6hMe6sjCy8SrHdRBUXaje058HQ+yWA49F
	 adXrZCHqXvdHUY3sv83MVWJyNK/AcyODSQf0B3/WplGlYJj1Leo1DO6PWptlDdeeW2
	 q5vHn89WftVgfo6ohb1//uBSmjWpkpL3yswVvN5OPhesKenLYRBzt9CIxHDJv/paIo
	 vo775V8hOStv8c2kUQyvU7VOQNf05GT1SkhBoW0r3hY2Q2a+MAl8TKOkCSFYo/dXeR
	 cnaOhw7Fl4HQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C06E380CEFF;
	Mon, 28 Sep 2026 13:50:05 +0000 (UTC)
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
 <179060340369.3676962.11130569532810419948.git-patchwork-summary@kernel.org>
Date: Mon, 28 Sep 2026 13:50:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-qpic-snand: drop ecceng_to_qspi() macro
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1174793/
  Lore link: https://lore.kernel.org/r/20260927-qpic-snand-drop-ecceng_to_qspi-v1-1-993e9ec1c2d4@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


