Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECED74C0401
	for <linux-spi@vger.kernel.org>; Fri, 15 May 2026 16:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778863791; cv=none; b=cAJF9D4zrVCUKwqW7G42DM5L6eumx3CO+3yTgIBLDHsD09MWkv5p5yUzPJF17anGecn34oHnMDMkHJ1N1K4dwwM9I4RcFq26b/QUDw/PE/OnoqEWZ/pldZ+fm66v2nGSTMkd8zD+E55qwcuOnljDxwFablFq6pRpCMeC5vn2cbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778863791; c=relaxed/simple;
	bh=gdqjBA+A6rFxACREz1WyC3LWCuqgc5Qu3HeA2tEoAGU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fA/aQ05U5uRnMGT2lcGm6OOipWUWgFlCjf4AYS2QF+vilfXDQL9x401pFD+Qu+YEg8gsKs2n0M83db0KJtdX2P2MTYjUSv8eFewtnvnerVgUAE05tNTgqyIHQCGYP2/WQiitfUW8qF0zlLxi3c+Z823B+Ije9pRpnLhAoVh842U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVH4uWqU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVH4uWqU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC1A6C2BCB3;
	Fri, 15 May 2026 16:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778863790;
	bh=gdqjBA+A6rFxACREz1WyC3LWCuqgc5Qu3HeA2tEoAGU=;
	h=Subject:From:Date:To:From;
	b=cVH4uWqUr6haHpUogc9ntapofjPKf9Tq8yCGrnntkHh4Uikp2jJSQ6v3aFgXf3HOG
	 aADQbmyz2nuP554FmFbr97DVIRdPWwubDa/uAHvDpgrnkAuOUr+mc9OLTYmfFtuvvv
	 b0offtH2zYPkZVdL3SCcOfhftAtqytsZfQFlxE/bcVo1Qq03TwPqRh6vbMOVcu2D3e
	 5jZS7QQdLEJt9hL3KABcvvCXCsj4ag3GHLlF9BCXqSr2Yfu2Sb+C5qufYLdr3GSYcc
	 d1v1N6xw+jeRck6e6Q4tl5YN+y+xWT+BIC/eohfPFPBZTUq4L44UbxQilmbtnHPOAU
	 /f86Q1oJaxgGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1BF3239309AC;
	Fri, 15 May 2026 16:50:05 +0000 (UTC)
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
 <177886380354.76649.176622563300484958.git-patchwork-summary@kernel.org>
Date: Fri, 15 May 2026 16:50:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: hisi-kunpeng: Use dev_err_probe() for host registration failure
  Submitter: Qiang Ma <maqianga@uniontech.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1095309
  Lore link: https://lore.kernel.org/r/20260515102620.1926930-1-maqianga@uniontech.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


