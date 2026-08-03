Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C523A1682
	for <linux-spi@vger.kernel.org>; Mon,  3 Aug 2026 19:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785786645; cv=none; b=OubF0nyaVG1bfSMAvrtLoXpfUjYFG2DsehY4etgIGquC4gVd2cnJOLxjszp2IykjhbO8jbgk71+naMR9K3QdGXPSOijXwEGbvL9j0q5t414iO1+RJYpsDbYbalGu9ZjZ2VJNESY6RQ7wYFOKFEhTAWp/AhZutkg5Gs9xBopMJ+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785786645; c=relaxed/simple;
	bh=KZ0Iqk7bmLUi4GpDoRYCJAWlf0ijuMyRgwW79kktT0Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=su0o8/oq0E4hi8CmJXyLCeTX8lvWEDdsFc6Ne/UckYi+gVSOFb53aJL87ZfMzTZKpow3f4Lr7EVqnU9jVQBfApmtuB2IUNL44TtbcS4N5LQ/GplM8ia4NcYTKXdLL4XspLE3OdnHkw3ERPyGf+98LeKRmYy9th0M/ostIp0KDMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y73nxuI/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y73nxuI/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651D61F00A3A;
	Mon,  3 Aug 2026 19:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785786644;
	bh=vWJ4GKq3JJ4ng7lhvmFhPK7W1mWYmwxbFszVCJCunHw=;
	h=Subject:From:Date:To;
	b=Y73nxuI/pxvWmNxXuyRX+fdR0La0JL2thWDkL4LLC++fWD39loBybDyvyaA598KNh
	 GLSuNtKhBZnA1Pnn2Y7a6S0Wn+dc0LLDAIOGTM8Rn2B9od/rwBvGhT3KGsUnlR4OR7
	 gVh214y3iSPEaCDvRxxJhNAFobYFaF6oEV38nsLSG15qENEKAuWOoInU9f5SxtmGU6
	 Qv80rsef2sI8b+k8TwfLaKg8UIofB5Q2mTPrzH+GcIsYeYqwwFiyVM0eNtIpqmcmR4
	 zlVtFB3HjDTYrHKWars1BP2Vsye3x/8X4MX4/29iP4PE3cjsL4biUv9hMjv6MHZET0
	 pHrU95kXFwa5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 961A4392444B;
	Mon,  3 Aug 2026 19:50:06 +0000 (UTC)
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
 <178578660529.2807325.10364895309629551388.git-patchwork-summary@kernel.org>
Date: Mon, 03 Aug 2026 19:50:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: dt-bindings: spi: nuvoton,ma35d1-qspi: Disallow GPIO chip selects
  Submitter: Chi-Wen Weng <cwweng.linux@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1139081
  Lore link: https://lore.kernel.org/r/20260803024048.1641756-1-cwweng.linux@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


