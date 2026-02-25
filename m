Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2CD2FD69F
	for <linux-spi@vger.kernel.org>; Wed, 25 Feb 2026 11:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772020797; cv=none; b=sK8vF1V56CfYaE4yObIbpkgO6mtRENAKxfNgIFSsX8MsdOVvmYr2jXWT9c+3d005N1AHgMX8QMMgYpT3VXTyG7yVHMzrPowAaACZJW9n9Qv2Gqtp9LQ4Tf1ElHiKb4Kwjmz13ZIn4SfaXL78Hhaqptj5MxyirfHYmVouHw8rDQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772020797; c=relaxed/simple;
	bh=gL5afgy+Hr0uDcGyParSb1cz11e8LybB6MISktcWS9g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=IXPyhlsP0w8cwXwyETQQccn4Wbh1ZPHKGfCTZaHkGG9yLlqk67x3j4OQr/ZH3K6kpqXNLw7x54E30ud2BzuVybQKl4NcuAnOTloxGBUDCH6anbNnWh5N7oRugZhCsKk7xy4joLw3+0RwMrPVW3oj3m9LlQDBGuOksOgYiK2GwAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLJMDID6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLJMDID6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD60C116D0;
	Wed, 25 Feb 2026 11:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772020797;
	bh=gL5afgy+Hr0uDcGyParSb1cz11e8LybB6MISktcWS9g=;
	h=Subject:From:Date:To:From;
	b=nLJMDID6++nD5xabWPhkppJ5D9GxZSx9BQQkoAG9q7BJ9A6fMflz9grXflBcXtR9H
	 5FrSWyhVFCcWANLp16L8Dcx7N5SWMtQ6DSedzVL9lIAJttqZWG24bE4qNP20DhZu+3
	 1EXuaUbvFyBjNnTsTEaaIsG+P1YGCLOSlOg3J34yDWegfSSz48oYSVb45dm1IGMu+Y
	 lck05uWmM9RDcrES9V9zkOF54hEu+hid0kXUJfnzaGQiJGgSmLuwsGS0rnKXpaBQiK
	 g2sd+UqJ5MwvsoNoYl72WRUkgVX91KfibIhjY+M0SihsmC6C1lSK+h+SeIL73FZozt
	 X2ajhNo4ADOgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BC9AA3809A2A;
	Wed, 25 Feb 2026 12:00:03 +0000 (UTC)
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
 <177202080222.286318.1305969401292423060.git-patchwork-summary@kernel.org>
Date: Wed, 25 Feb 2026 12:00:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1,1/1] spi: dt-bindings: snps,dw-abp-ssi: Remove unused bindings
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1057203
  Lore link: https://lore.kernel.org/r/20260224115218.3499222-1-andriy.shevchenko@linux.intel.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


