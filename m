Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D8D43C7A1
	for <linux-spi@vger.kernel.org>; Wed, 15 Jul 2026 10:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784112636; cv=none; b=lQFCG21YaRrLO+6x0l68sLaKpB8bVcfvySvmvkNIkMYGWm/BgE6ULh04Wj6kEwHfeoNWwgGXcxXIQFoICQh9ld4m73TGJZslK1htZ2hWmoXsUn31hqhUHh0VwEh+wKFwe70DG8FUUcn6LZQu81H8NOMdAtSyxaykcf/NaXR4WWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784112636; c=relaxed/simple;
	bh=vpr9MfOf+0fMSNCOTakEBH3qIFwbOEeEXJjH22jdxI8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fg6hnUP1LwfgfXIE+1FxR8YLXlhr76TTcJUkze5D976xNSy9ZwI8Ckt9NxfuobMtdgFhYZW3H+r7cazrv7eUDX1CE4Hj7s6T0WGnvntYUIsiq12sCHVLqIne2RkcJZUsQZwtJ0/MWk7Vob/7QyC09ymj5W6MBAcNX/gEm2sQljc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6pyH5B3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6pyH5B3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65851F000E9;
	Wed, 15 Jul 2026 10:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784112632;
	bh=1hkdyivYJlHpGUyRXF4kruMENnjYEAfrUWtUS46KMZQ=;
	h=Subject:From:Date:To;
	b=K6pyH5B3rwfYnpheG51neWKZQUpgdmsgNwHHu5gtydAqB2v8+tvUhgQLb60QreM7m
	 E6S7LtAGTcMLBCo5GC4kS/P0DiTw+21Na2jWXb9g8DIVX+j1uUPVN/3K1oYwiWxzCH
	 aR47YRwNZVH6gE6CKvThZ84dEMYjBlZbIjWlKKvP3G7Uoer82uwEQkLlLpg4ygJWza
	 ZFIj8zcWUTXoQLziyvdAshJqmRWGI3F3fdPFvoqNfi5L9hnfpp4XhOjrxi3+iD3fCM
	 JkRtNUe2dkY7oqJ1o0QYC5HlCHVyUwFexNH7yN+UH6ljG+wTNAiathQxnjZWc2Yo+8
	 7OGJjrs6VGQlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C998393934F;
	Wed, 15 Jul 2026 10:50:08 +0000 (UTC)
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
 <178411260674.4011570.10105773065196713376.git-patchwork-summary@kernel.org>
Date: Wed, 15 Jul 2026 10:50:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [next] spi: bcm2835: make read-only const array pinctrl_compats static
  Submitter: Colin Ian King <colin.i.king@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1127580
  Lore link: https://lore.kernel.org/r/20260714164215.183809-1-colin.i.king@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


