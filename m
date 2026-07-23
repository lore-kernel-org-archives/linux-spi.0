Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CB2477980
	for <linux-spi@vger.kernel.org>; Thu, 23 Jul 2026 12:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784808641; cv=none; b=Nc6AtYdsaAGH96dwsMrX8OmBFFgNhILpHAff0ZVsWQl8UenBmKLlXCZc88naDa7wUyXiLl5ee0F5ZgXjzSCT1Qj/LeB6G8bcR9wp1pFDD3xv7/q0js0DGwrar/KTurUrp6ezI9Zpp/mKL88u6nlvtGFZGhm2iQN+B2XtsU7VUWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784808641; c=relaxed/simple;
	bh=uxTQyuo3zV9Q4OsNEe4QUj+p9BzNWubmm+JMZq7K458=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=sRdptLpuadjwrmVtsfP8HllhGGXK6/bR4rnkIFSxVWHEFpJOtizG9GAHNNp2IqXvp+d+Cm0GoTZ7BEApFqcoPElUGPJjK0mp253rPOlt6JVS67UA3AwtfZzOp0ZFDhlCSZ5yu84ZDC1GOdKO0RXjvLo9q5vDH2KNdGsiUIeSDd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqsoAq8k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqsoAq8k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A031F000E9;
	Thu, 23 Jul 2026 12:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784808640;
	bh=NCfsp4ov1xt9JGwWVfkCpiu/lRDtkDVZDH6JeUiG2uk=;
	h=Subject:From:Date:To;
	b=OqsoAq8kQ8ydNiJyXacuuLMXxMczNlp1Vfhwn5ZUPp9v42X9/7C39sU/kDxaxFT/b
	 3bqujawR194T4muzGv8ZTyqbzJUu/0pDbySn0Yr8XDHi+GOz5A3S+mQYNw3HxcVrmt
	 P/1S5WoXdwlsE7R1TCR9NasarYL0jdTA3Sk4UZ/LeseM/RJySiJBA3gKhehMSGpaOg
	 Y8EN0TF+b8tyJsb90yIVYUtN02uxnO6Ak4Wij7EW9RL35HkoqBnU1tZ2Y5EN/+kq9H
	 4VK7diz52/QH5L/xP1BxylEVRjHBFu3c5Tv5XC5XBN3BOL1KsHuVOnGPkNh/yrw/Th
	 i9Y6NSNeG1nTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D3A90380DBFA;
	Thu, 23 Jul 2026 12:10:09 +0000 (UTC)
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
 <178480860838.2235721.8260154607138765217.git-patchwork-summary@kernel.org>
Date: Thu, 23 Jul 2026 12:10:08 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: spacemit: prepare both DMA descriptors before submitting
  Submitter: None <kr494167@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1132590
  Lore link: https://lore.kernel.org/r/20260722162444.11415-1-kr494167@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


