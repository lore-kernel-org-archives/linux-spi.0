Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6F241CB39
	for <linux-spi@vger.kernel.org>; Fri, 10 Jul 2026 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783683657; cv=none; b=ZxL2BSf7XJy4MIKge9TmLclIhnGfHCVgtNiMKJRakbmvg+k47ptEoCAE8cbPU/GsSNr58TAOJUlbtt2xeMV/CCDjxmJoj8m4Wivmz9GRCd9nVLvFUkHiDwobAsuDH9VRuMiLlC289DAPjVFaMvRLVpecQLKkzUKvzJJvxG3N37M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783683657; c=relaxed/simple;
	bh=P5K+vK1F1PCkopq7I6s6QqW5fCCyjKz/0zB0hExq1ps=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Xg2MB+s/WjOyjYl1B1+SiyiYeG/Z80rcpxJDdasRZbU8M9SwGhmVbKwr9QaJizcOTZlTan8msJzgk26ME7qMrzXnGO+B0/HlAfVoCrkRRm4LA0XcSswxOrU6voo3V8qgAtsrNiT5V8wndkOPuGCFsojultunTnRXrLjiu5iJshM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJayCfLC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJayCfLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EA71F00A3A;
	Fri, 10 Jul 2026 11:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783683628;
	bh=wmSqdQLGRxypdHcxhVlkfzKo/b+ewzo9Eo2mBPXzw8g=;
	h=Subject:From:Date:To;
	b=WJayCfLCm0KusXgEpfmVDk+lZlp90LD8gnox2EkZEY57gYM2fJx+BMXk94wYfThzP
	 cNDQpK9PrAAVB/EKzwK/wDRlesfYF8Koms0Oo+ko0E0a5A4L72fojhigDRdFXNzcOo
	 1te/EgnNDAHhY/DOWV6EK+onL8c9AgNSZZIgn+t2jz58I1btn7jY/zvWdMQ5vpjjXL
	 IZ1fU4UWJu8ItQMVqUTBCVOWZ6FjNs1W95Kyu1BkoECrRyUSLe4uHi/lKPng0DQtG/
	 Hr87rRIi69S3PU9f0UYx7BBxnCFvZN81YGiat8Paj/5LLUFcZays278+lgHScOmV2z
	 T8EPVWnqfFqaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 58BDE3924F8A;
	Fri, 10 Jul 2026 11:40:07 +0000 (UTC)
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
 <178368360594.197766.15375170028860341565.git-patchwork-summary@kernel.org>
Date: Fri, 10 Jul 2026 11:40:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: fix sticky -EINVAL after PM runtime resume failure
  Submitter: Praveen Talari <praveen.talari@oss.qualcomm.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1120243
  Lore link: https://lore.kernel.org/r/20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-0-6ddc317011c0@oss.qualcomm.com
    Patches: [1/4] PM: runtime: Clear runtime_error on supplier after failed get_sync
             [3/4] spi: qcom-geni: Fix missing error check on pm_runtime_get_sync()

Series: Fix sticky -EINVAL after resume callback failure
  Submitter: Praveen Talari <praveen.talari@oss.qualcomm.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1121232
  Lore link: https://lore.kernel.org/r/20260703-fix_sticky_-einval_after_pm_runtime_api_failure-v2-0-578b78a0cf46@oss.qualcomm.com
    Patches: [v2,1/2] PM: runtime: Only set runtime_error on suspend callback failures
             [v2,2/2] spi: qcom-geni: Fix missing error check on pm_runtime_get_sync()

Series: PM: runtime: Fix sticky -EINVAL after resume callback failure
  Submitter: Praveen Talari <praveen.talari@oss.qualcomm.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1125308
  Lore link: https://lore.kernel.org/r/20260710-fix_sticky_-einval_after_pm_runtime_api_failure-v4-0-be81d6c15043@oss.qualcomm.com
    Patches: [v4,1/2] PM: runtime: Only set runtime_error on suspend callback failures
             [v4,2/2] spi: qcom-geni: Fix missing error check on pm_runtime_get_sync()


Total patches: 6

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


