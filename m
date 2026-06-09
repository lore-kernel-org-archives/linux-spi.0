Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ED8301708
	for <linux-spi@vger.kernel.org>; Tue,  9 Jun 2026 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781046622; cv=none; b=kazVY76a3Ug93g1/vdyIpzQKMUW7xNGq1v1tPmQzc7Jsq3P7WP4qlr2KdgQZE1X3FYQIxmpMQxNKtkiLyW528PyKTNeqvMoelN/D5zeWq5sQswm+BEtayeAPGM2F0e5QV0ecK4/Ty2xPzQSYdjjFH7L68P2f+X8Bv+2obDEqQBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781046622; c=relaxed/simple;
	bh=2TTTBuPaIzY494swhrCrVUFkGAESHrTlknccDxGQHXc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=MExu/9KM8oSuvb9cZsMF3esc3sqgcTVfHJT5/F6CU7Q2RoNMZChx5xqEvsNU0d5+nyhbXTg6On+Jirlr4PhX+9ReBJ0JWO7VM7lZRsrhbtW8U8kwppdt0F4WX8lGCsCFbpfpEhZjqk8T6DAC+q/43V0Fe1l3YiuieGDrmxPuHHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gElwni9B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gElwni9B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0D21F00893;
	Tue,  9 Jun 2026 23:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781046617;
	bh=4ye5SHPf2NheKhT+25YK9PUxb0QtW34TA5FENIlqnoM=;
	h=Subject:From:Date:To;
	b=gElwni9BHjpxFHE4GMsbWrepyyfBWhb8rK+Z0282UiNeOYr8dwfi8pJDBB9SojWkv
	 o8nuoN9ziRSoov0c0KHfUYQgmlqMyZgr8ZMVRVs6dXBHdjW/bno7K5dxYSzAouWQG+
	 o90GNU8buKdfkQwGlkpD+ofhQAUwGgMEJIbVYBui/JsEsf5Klmxbj7iuwAuKIRKalO
	 3bhd8+hy/jZkL6i3LjkHra7W7Q7WFoH6pnSJzZb6zgZLq/V98/O+Yp1I6H1oBUvlD9
	 3eMlL5HCDo0qI6keE/4p8EWtGq0rw2zUWbF+B1P2O14Qcy6oW1YucbAKTvsFyr3mSt
	 /JBwblrfhdXvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 961F83930A0D;
	Tue,  9 Jun 2026 23:10:16 +0000 (UTC)
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
 <178104661522.2741615.16012172221928175192.git-patchwork-summary@kernel.org>
Date: Tue, 09 Jun 2026 23:10:15 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: rzv2h-rspi: Add suspend/resume support
  Submitter: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1108101
  Lore link: https://lore.kernel.org/r/20260608202509.3651345-1-tommaso.merciai.xr@bp.renesas.com

Patch: [v2] spi: qcom-geni: Fix cs_change handling on the last transfer
  Submitter: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1108403
  Lore link: https://lore.kernel.org/r/20260609-fix-spi-fragmentation-bit-logic-v2-1-e18efc255563@oss.qualcomm.com

Patch: [v1] spi: Use named initializers for platform_device_id arrays
  Submitter: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1106230
  Lore link: https://lore.kernel.org/r/3fcd432a505bb1bb7f8ef0fba9162243200b3347.1780606153.git.u.kleine-koenig@baylibre.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


