Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE325464F
	for <linux-spi@vger.kernel.org>; Fri,  6 Feb 2026 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770337207; cv=none; b=lweGA04jfouO5TV7cJYLHn9z0vS8igiH6h+XQNlHZSBi4fzhBsD3yM7nUYMw8/JSix+7/as8Qnr6+qnSgkGmx60EOVG/XUF/aVCHETVy7tK7whFxHgfAP+mRFqATzjZGopI5JYnPnxozj8Nr8XtQlzh7k2qiFCOcdxPLMiv/fa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770337207; c=relaxed/simple;
	bh=+TCAMV+gB35b6xEauVOEi3BWGrY77Uv+O7EKdFVUbbI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=uEQseVDVRzSkcvdD33UHuiPNj52U6ifmvw4jbiwiDQJthkz0TmXgq4TiI6YHZ0QLuR+JdiY0rEJwykjHYYy8C3GhkAqSSceE8N/wx1WQkrbaZVEd/5YpAnDTeOjT1IcqI9Dyex0EhxcWd4jdnq+cTPxa1VES8BKNnwoRKGwwXe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8Ut4h+i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8Ut4h+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2F5AC4CEF7;
	Fri,  6 Feb 2026 00:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770337206;
	bh=+TCAMV+gB35b6xEauVOEi3BWGrY77Uv+O7EKdFVUbbI=;
	h=Subject:From:Date:To:From;
	b=L8Ut4h+if5EDPdxDZ2VSrpp1hRXjfl1CjcoqmV/zivjxe0i+DxUTclpRLzqVuQXmj
	 mg3IJRqrBCzNv0oAjAUpPCFDsV1qPA7TOz3ciUy6eRJOz5/AMfBEVKpRqBFkrVyZVi
	 I6ulSJxo7DBYt4Z2wf1gYdrdh7Lju/8axe29OXRFNYJhxI8WuOet7uAi86h9C4Sxrr
	 tQHMITxxi0c/XhPQd5OMnmuIZhdFlC1TtOp+hlPQiODJuaO1vg9IzJ9gdFISmsb+YG
	 28kNoUD2lrReiyyeGk08TwtNLAVh++crRcZl7FWtbpO0b2k81yq+/Zze4nHufEHNHI
	 sdQ2+U93oQVdg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 879393808200;
	Fri,  6 Feb 2026 00:20:05 +0000 (UTC)
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
 <177033720425.619223.10941284175377997186.git-patchwork-summary@kernel.org>
Date: Fri, 06 Feb 2026 00:20:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: cadence-qspi: Add Renesas RZ/N1 support
  Submitter: Miquel Raynal <miquel.raynal@bootlin.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1051278
  Lore link: https://lore.kernel.org/r/20260205-schneider-6-19-rc1-qspi-v5-0-843632b3c674@bootlin.com
    Patches: [v5,1/4] spi: dt-bindings: cdns,qspi-nor: Add Renesas RZ/N1D400 to the list
             [v5,2/4] spi: cadence-qspi: Kill cqspi_jh7110_clk_init
             [v5,3/4] spi: cadence-qspi: Add support for the Renesas RZ/N1 controller

Patch: spi: tegra114: Preserve SPI mode bits in def_command1_reg
  Submitter: Vishwaroop A <va@nvidia.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1050782
  Lore link: https://lore.kernel.org/r/20260204141212.1540382-1-va@nvidia.com


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


