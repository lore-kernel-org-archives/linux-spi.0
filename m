Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5BB3C9424
	for <linux-spi@vger.kernel.org>; Mon, 23 Mar 2026 18:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774289458; cv=none; b=iKoYygDa0J01xJjp+lMyA6FGcy7Zsfk+wVqGpFRExrFPgldBdFvNRInmE2OPbW3dZUtoIEBuLGKrqw9/+FIfkvPdsiLfx8lLj4WnKaL4x574+7PqRyufjxdyML5LUhExquZFdZWG59uUPnDPymq2477J9aiqvjyNNy/hXu8jWSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774289458; c=relaxed/simple;
	bh=UDtu6Vk0DeREcX4NPiTpdTS5ctmrHVcBJyH5+1JAoWc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=M5ksx75W4UdVHVh3Jj5Zj/OLy95rnABY74NaRMu4d2oJofWKcDZcdZofzWRcI8qFy+zb9MoVdqqT+R8UmwnvooP4Tu+SFdV7ZC8ni7jpABRxD9CLPV13NYQYOwgRaYCHE6VJCwK1dFVeXd+F6q9gKPELjSRiW2HVyk2WxUC6oQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBuWwn+J; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBuWwn+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E10C2BC9E;
	Mon, 23 Mar 2026 18:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774289457;
	bh=UDtu6Vk0DeREcX4NPiTpdTS5ctmrHVcBJyH5+1JAoWc=;
	h=Subject:From:Date:To:From;
	b=lBuWwn+J2rC1li29Zpfy9RVU6O2XGb2/ajQDc9SOa2mseGCp0hwyBkCrQqcxRmLzD
	 0gu3lr6g8wqPvAjKD2Xg0qMinH3ayJwSmJPyatI/njoQ2eDNVkF66TsM4a4vMh1i+J
	 r8SXHGLYHpBNnH67ks6uQF6NDzd0owxjwT6GoAsHg4Okz0X3G9My6M8I1kZDPpJPbb
	 kfy1yNgRgI+D+LCHUuQ6SHCAHDO52ZKWfMxQe2agpBzI0ZResmGkzJ3t914btPwPqU
	 toOTNlWjdcOx0z1wu76CVizfl61jpU3HLGrUi7X+qTPKhBnAJNamsPyDYDolSWIpwi
	 Qx2GAQ2qZ0oTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 2D08C3808200;
	Mon, 23 Mar 2026 18:10:47 +0000 (UTC)
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
 <177428944583.251598.6095518650779955197.git-patchwork-summary@kernel.org>
Date: Mon, 23 Mar 2026 18:10:45 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1,1/1] spi: Replace open coded variant of spi_bpw_to_bytes()
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1070962
  Lore link: https://lore.kernel.org/r/20260323140445.3496736-1-andriy.shevchenko@linux.intel.com

Series: spi: sn-f-ospi: two small fixes
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1068749
  Lore link: https://lore.kernel.org/r/20260319-sn-f-v1-0-33a6738d2da8@gmail.com
    Patches: [1/2] spi: sn-f-ospi: Fix resource leak in f_ospi_probe()
             [2/2] spi: sn-f-ospi: Use devm_mutex_init() to simplify code

Patch: [GIT,PULL] SPI fixes for v7.0-rc4
  Submitter: Mark Brown <broonie@kernel.org>
  Committer: Linus Torvalds <torvalds@linux-foundation.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1069965
  Lore link: https://lore.kernel.org/r/a4e342d6b3bc37b9a25872843d25f5db@kernel.org


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


