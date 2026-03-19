Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF303C6A57
	for <linux-spi@vger.kernel.org>; Thu, 19 Mar 2026 11:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773920413; cv=none; b=ejFj/hCVCE8htYYHI8swY3wekg9NzkRCHQSOVm879CEpiFyQoQOvfRwwJvyutoaaQrY+xrnWfcUSyR5RNGo/wm0jV62vDy5vaSfX9IThvzo226Emp9BApKahu0OsiPo9V2YW31avIUpm4/rop9q2qnH9NxqrzCAAHlBk9UPYPKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773920413; c=relaxed/simple;
	bh=2XnXaXCtlH6LA4HEl++XJDwleODIiBpPJvM+U8AYUBI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mNVlef1EgadfFr4zJO1DWaSahxAxhjWyseOjxV0jZWjlT4I56vmH5eAdMbB9sMBFX37SD2fp2+ZT+jIM4WVnMk6K9VwOoHTP6OOxaCLjmH2SLkAtFrSenu5g6om/fZRmOWS2SjqGluf3sc6go7Jny4+lJAjew1WW7XiJH0i2nxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAgFDXJe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAgFDXJe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86366C19424;
	Thu, 19 Mar 2026 11:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773920412;
	bh=2XnXaXCtlH6LA4HEl++XJDwleODIiBpPJvM+U8AYUBI=;
	h=Subject:From:Date:To:From;
	b=qAgFDXJeeyS+nGVcuorRY4hyO4du9uot6Hvxm6Cjz074W/RhgHz/KfYH74yUUvI8u
	 i2acdk/8e9yNvwcEZp9ZnmkYCEY3/3HyoVkTBFNwT2ROQlWGRy521Ne684VDzOW74Z
	 nEM48OwABZ7ZP1brDs5dTQZRvxodT64Om5PTzDaX37SDQlc4yCQJ+PhUMUwvvC3dEi
	 PpcSQ88klP09vAEx4wis1WaiHBy6gcBH03ooQoSbh5+z0ZuEwb27KA6SSk5ySdq46J
	 evatSbrkjug6rXCp89WnJJW1QdFXIAQr5+J5Ttmd0pMJ0HpquZNEf6j9nCT1dwxbEa
	 H4OxSf/tCMPRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BC61E3808203;
	Thu, 19 Mar 2026 11:40:04 +0000 (UTC)
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
 <177392040323.1161235.5881429952123006492.git-patchwork-summary@kernel.org>
Date: Thu, 19 Mar 2026 11:40:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add RSPIs support for RZ/G3E SoC
  Submitter: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1054931
  Lore link: https://lore.kernel.org/r/cover.1771344527.git.tommaso.merciai.xr@bp.renesas.com
    Patches: [1/5] clk: renesas: r9a09g047: Add entries for the RSPIs
             [2/5] spi: dt-bindings: renesas,rzv2h-rspi: Document dmas property
             [3/5] spi: dt-bindings: renesas,rzv2h-rspi: Document RZ/G3E SoC support


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


