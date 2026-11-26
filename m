Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795723207;
	b=L5MvYRbOWwOnlfilxjNQiS7+jPqvSTP7sdqHHXg7CEjcrCgpJlBKWN3+mfArLEmJj3HF
	 l4mrqXZWDolbfvoUGR4HcECvyWBGgv29XwwW5Zw87ctgvuztIOtRPec/n2HVAd3ZinQGw
	 fTA74fjj4JlhAZmTKDZHKNa4H0QRmDDamzBKj4uEwgYnvLjX4TV5Dpj27GJu9uNPgRoZG
	 aK/mgEY6Gr6+hSiaaefMbqPdKE9OWdzaczK/wQ+O2aFSXyags/Wpwmu45JCvHcvIuDhOA
	 NbxxlHflhA8eLyMBwrVnEyy3u3Sk0kccHqwyVn5H/TdcdVT5B9Jk5zJboiF0yFZ3hOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795723207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=79wTU4rYdcJSPP1FHPyx9bUG5KoHh4lnw0LuJEpp6WA=;
	b=bWqdIeBHwtXkxhk+RCBTEdEOh6lsfzXZP68FYUrriKbLV8N+Z9FBotlkhqZ3ulBNQfIw
	 0idiOj321p94qFJ0lYmZxx+F5oDWkAGLkzm0Aa+atczWDu+7cK0lSCXtjCOjYaAM0qTah
	 NStYNKkhFuXRjSHGFCQAuhZKNYhnu4/l4eufLqJ/tylaCi87OWRxUVSNmoZgF5vfrGxcf
	 vrRUGc0zpSHzfHAP0gYTYv4hOk+4kKKKpXiyKPF0uQmccdRgpdsFjzW3E6oNB6yLaO0I5
	 fmYfvgJ/WbCAlgjMwcoQONKSFnUTUVIu+VyI8rTAS17D3Vsd9sJ0s2/BaPKndxUae1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iez8ec0f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C24606A321
	for <linux-spi@vger.kernel.org>; Thu, 26 Nov 2026 20:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iez8ec0f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C216C1F000C6;
	Thu, 26 Nov 2026 20:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795723206;
	bh=79wTU4rYdcJSPP1FHPyx9bUG5KoHh4lnw0LuJEpp6WA=;
	h=Subject:From:Date:To;
	b=iez8ec0ft7jd9a2zWugk2tPzQ7+uBzK1QKUQnJGiXKMHnE6d+T/WHZJRsjCTlBgTV
	 nyo4Rbjx8HZ6FGssgLffGYkUcGJF3KQz6yvF17bFuS3SBK9fkh8MINUNJfwX0ad3yV
	 xxw+GLDUhFjXA/H6Lfvgqy1Gg+75//K/Pj77KMjOjDefjV58QNfb686Q9uyG5mcpjx
	 r7Or9l0MW9dFvwFCoQ/gafpW2FDL1XmkVEAZ1pNeH5sz0fZeAYfngPNYBfT9pE/IqU
	 O75aD4tCLyCcINODlCs5n8Kf+2H/w4sBc+PrmlSHybs4KuHcT8dR1X/I9O5aS3CTCi
	 gpg0NlIN/hHWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AEAC93803325;
	Thu, 26 Nov 2026 20:00:06 +0000 (UTC)
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
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179572320528.593095.6295130988548052583.git-patchwork-summary@kernel.org>
Date: Thu, 26 Nov 2026 20:00:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-zynqmp-gqspi: Initialize padding in partial TX FIFO words
  Submitter: Srikanth Boyapally <srikanth.boyapally@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1222399/
  Lore link: https://lore.kernel.org/r/20261125-zynqmp_padding-v1-1-bc0f925fb898@amd.com

Patch: spi: omap2-mcspi: lock the DMA request bit updates
  Submitter: Markus Klotzbuecher <mk@mkio.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1222329/
  Lore link: https://lore.kernel.org/r/20261125161340.1218564-1-mk@mkio.de


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


