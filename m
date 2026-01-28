Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127BA28642D
	for <linux-spi@vger.kernel.org>; Wed, 28 Jan 2026 03:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769571610; cv=none; b=JlUDXVTvUTaFFJdnwl/osrXtJIQ/MmhA+2O0xTSTFmgQINJpw2qp/L+9g2T6qw4iRRWAXMYF6lp0uLbE09iUuCDS8pywuIw4DucrrJhnZfLJz9iJNFIyh9ifuNgqobGISsC3uXCQp+tuYobOzRHHPDGr1Vm6Bp9hZgaiqTdovqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769571610; c=relaxed/simple;
	bh=//BfpzcwvB30R3A11xxNjLqyeP4Eo+IUUdpj6Ob2O+s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=SVNRB50kGTwAu41PpmSXzVHDjg95xSJy+xnHYL9hQymgdXHfhekUQZOVLbF+g+hKCbl1Q3dFKxPznzZ+0tz6iDQWUmIP7hObQPQ+3ypM3A/DBNK7X/Dm3e7DDctd1TK4Tz92YGjCPo9CJ08gRJuqvQ7oFzFYeTtq6ullPX690Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmGjRf1C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmGjRf1C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB6FC4CEF1;
	Wed, 28 Jan 2026 03:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769571609;
	bh=//BfpzcwvB30R3A11xxNjLqyeP4Eo+IUUdpj6Ob2O+s=;
	h=Subject:From:Date:To:From;
	b=PmGjRf1CCchftRQ144zOB7+vnBrKF3Njoewc8HeJct6OYRQ+5TpandkkTwJOz9k32
	 tVzj42SRIYOOicemPn9qSBmra9d0BWk3LaAAMaiVyA/cXEhIIC1/JnrA5jYzALQJ+t
	 G5ex23g1nvXXnNJhrl/axCZm9KemsuWcbDSqAmylYaEHY8TB12IZwYrGUhCd7Di2zl
	 Z2IR6DKJen00qnrzgnnJjEQHol+dIg0w9aIYpJsDzeTqC526SsNtmutWdDp85LkH2+
	 uAaaqDn9fwo8XXhM5tEJGx/povzcUqA9xJ2N6fu4mzG0sAy8rou/JDX20s7NsYMIdq
	 T31FyYXCEHyGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 514EF3809A15;
	Wed, 28 Jan 2026 03:40:04 +0000 (UTC)
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
 <176957160275.1503257.6088421931825319207.git-patchwork-summary@kernel.org>
Date: Wed, 28 Jan 2026 03:40:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: SPI_AXIADO should depend on ARCH_AXIADO
  Submitter: Geert Uytterhoeven <geert+renesas@glider.be>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1047742
  Lore link: https://lore.kernel.org/r/386273d50fb3c51cccdba4b3101a0705208abd4d.1769540444.git.geert+renesas@glider.be


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


