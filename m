Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C911F195
	for <linux-spi@vger.kernel.org>; Fri, 23 Aug 2024 23:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724454029; cv=none; b=kVH0RN1Jmx188w2/CR20ZAu0sH7O3brjBSG+q7kJyC8fUroGiomCqQtomHbm2ZFzOxdjJ0Y9rYN55ikPuFWOkNPQBSDrcqIVY5iMmgF5RlBvMU65rRN5wDDXH0aAjdJPTscCEC8l8e3ikQj3zRmhLBXC4PvfUetBH/HLKw5sIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724454029; c=relaxed/simple;
	bh=FLPEupXzr67Z74OGYV4qn3V/Hcp30IJ4O5PENQBms+o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kBmQW7nGYGxxy97Yz0sopHl7S0kNuolbb4irjgAJQCa1EelYqcTZYJmgNzaeCLvTQKlyrAGMnrEMPO9nSAxHylrVWW/rtuqJXUeP9AmMm/thKSnprTcudUX3Y3I1oNqRpCxTP7PRchsyV5SF/oMoN9SEjG1URh//uezqHfh1KoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCfqznQX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCfqznQX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D549C32786;
	Fri, 23 Aug 2024 23:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724454029;
	bh=FLPEupXzr67Z74OGYV4qn3V/Hcp30IJ4O5PENQBms+o=;
	h=Subject:From:Date:To:From;
	b=nCfqznQXd7TGmN4viv1PunlcKqryK7QsXaHsZVOLHAsX411m0JP3Dt/D+Qcj/fAgv
	 iSzHYqOMoEkeNH14PXPw5tC7q43Ra9FDT67MLj3ePIJSYKFh9qbIRYmaRYoHqmCKOY
	 rSlMcuxOfHpxwmv6CrpHV0fpSzH5w/WExDF/FrDjIILhkHV0Y18GmroDscAwtveDnL
	 SZsoLXcUziFJVlwDoDFGE+0ADqqOj4lNPMv044WsH3KX9PidfW3JHJlnkdfGyz5his
	 KQUNwmO6tI0IWTsN2CyGWF1sNWO9zYroMXjNMnVVH3IC7zU2giTFRZwJxIvPATBZ8f
	 RSkdB9b2G/pLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 766023804C87;
	Fri, 23 Aug 2024 23:00:30 +0000 (UTC)
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
 <172445402911.3106405.13178525598893998313.git-patchwork-summary@kernel.org>
Date: Fri, 23 Aug 2024 23:00:29 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [-next] spi: wpcm-fiu: Use devm_platform_ioremap_resource_byname()
  Submitter: Jinjie Ruan <ruanjinjie@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=881337
  Lore link: https://lore.kernel.org/r/20240820123518.1788294-1-ruanjinjie@huawei.com

Patch: [-next] spi: bcmbca-hsspi: Simpify resource lookup
  Submitter: Jinjie Ruan <ruanjinjie@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=881345
  Lore link: https://lore.kernel.org/r/20240820124011.1788479-1-ruanjinjie@huawei.com

Patch: [-next] spi: atmel-quadspi: Simpify resource lookup
  Submitter: Jinjie Ruan <ruanjinjie@huawei.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=881344
  Lore link: https://lore.kernel.org/r/20240820123818.1788432-1-ruanjinjie@huawei.com


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


