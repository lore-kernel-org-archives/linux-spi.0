Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4442C3245
	for <linux-spi@vger.kernel.org>; Wed, 11 Mar 2026 19:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773255613; cv=none; b=m/UCBb+NYupL7yNUBuC4YXCCbGBv3SCTJOdQO850+qKsTAauzti/aOoEznDQdTE/A/c3AfcYIIMciLG8XG7XB1xnwnUlKWHcV4BzIO7mu5WMTod5x6v08b/cjo+W8W5iMkmO/GJ66OhNtA2NVbg+4ZQKvkXHmgV3GzVohCzAenA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773255613; c=relaxed/simple;
	bh=3jlSbZwG79qUcA6FHdSnhybiXF0iHF+69nCSAtiuiwE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ggvKA6gS8IhR4c+/lyGNq4HX7ou8SyovdXJBNwmfQ4nMFF4H1t6Fj2RnChw4Wt5XwWwrlhXSVRWfKltaaLUhRQQmMAfJyoZZtISrQo7xDr0a8bQms6d8e5HX8hg0/MbJrZfgvsxHxSomoSJCThv6fZEpiTCO7jdMImHWfgNNZtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qg4AHuu9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qg4AHuu9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851EAC4CEF7;
	Wed, 11 Mar 2026 19:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773255613;
	bh=3jlSbZwG79qUcA6FHdSnhybiXF0iHF+69nCSAtiuiwE=;
	h=Subject:From:Date:To:From;
	b=qg4AHuu9ZuxQA+7JPUKPbfSNGHCydByvfIzogWtJAjet0iPX//Q59j/QMQoGwWthD
	 h7FRBlOys7b8WWCdhA1m+fcMb8OOH2agYm5iCF3Zn+aIdVjdk0hF+HNSPrSlpssvoV
	 b4SdqEfhXYJZvGz7SgF/adS5UFPqHv17faZXLJBE30j/dCGTC8Q+0I1g/EGSUKgiyq
	 3uWUQiByktdMW0yTp79ppoirBs5f4u4Uyq1no0fKgmKwqPO3afkhxADvB90c1PlTZG
	 Is5AAFu6lnz/Ge4VQIT9kgNbO/uFs7B94cKpghVKNcJwAsNmZzvS+8QQetqYNklon+
	 RBp+DqlA+YBCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA2C23808200;
	Wed, 11 Mar 2026 19:00:10 +0000 (UTC)
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
 <177325560935.3793965.9843521114799616048.git-patchwork-summary@kernel.org>
Date: Wed, 11 Mar 2026 19:00:09 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: arm64: allwinner: sun55i-t527: avaota-a1: Add SPI NAND
  Submitter: Chen-Yu Tsai <wens@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1060109
  Lore link: https://lore.kernel.org/r/20260302153559.3199783-1-wens@kernel.org
    Patches: [v2,1/3] spi: dt-bindings: sun6i: Allow Dual SPI and Quad SPI for newer SoCs

Series: two cleanups in atcspi200
  Submitter: Pei Xiao <xiaopei01@kylinos.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1064727
  Lore link: https://lore.kernel.org/r/cover.1773193726.git.xiaopei01@kylinos.cn
    Patches: [v2,1/2] spi: atcspi200: Use helper function devm_clk_get_enabled()


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


