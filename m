Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52394F4036
	for <linux-spi@vger.kernel.org>; Wed, 30 Sep 2026 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790787006; cv=none; b=Wvr2H8OKtWBY6OC9CiZYk8Ia43rRMT58UA1bsCPZcStDb2XQ3vYF8On7Q9+qScLtNR7MBJhkVPwkzt4UC15nr/IhOzrcwGC0b+ZiFommBF9NH+Jgw9Jdca15VltrIsSFC5/zdbgmWfnLeKmRnHenTM42PqYV+PHhIn9wT74QPNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790787006; c=relaxed/simple;
	bh=AVGYMQBKcTzHDxX7lTqqCKV/z4uhStPTp/DqxB12uRk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=bzM0rfcT7foIkuJ/M8QSR1KtPs1QJaadkST2DRReKQ9T4W4Xi+qV/ea9rWrYGZNhQ3tEfe8pNb8f9GQmCaSTAj8dXmP51FKVpPjzWlqmIX3g7VJ4tT/EeYsgzFgpgoZpV5304xYV5CsyDT0QcT/3zKMjZ7HM9Zkxg3LvEiwE7q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhcLtsNA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhcLtsNA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA6C1F000FF;
	Wed, 30 Sep 2026 16:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790787005;
	bh=xz/DyqxuV/1LXmZw7IoXwVIDnCRyuWF0SCSSOUKwXoI=;
	h=Subject:From:Date:To;
	b=RhcLtsNAm3hoLtXLziPh5lcda5SfohsDFXYhVCwNk375xzEmaeMcHCiehd5E4KGHl
	 xNgKBVuTqIlZby28DTmlw+VB1WYZE3zC97sCcwNKwo14qsM5UEV0lYdzxs+z92Z7gr
	 5f+a0jHtTRXGNvG0V4ArxsPIPxg+HflYdJOnPz1BpOmW+LtAd71dsRVzyuntSwVaW5
	 VP3AsdE+ZnRDQfs6ch49raMD0rUrCZHPbG5jSDWwH/8e5+GC2St8z4m64cFNmPWxio
	 NUGlTAOy8d1/3HORA21JzH07tyBaROvLSaB28fGHiQ4yaytUxzuLSWsyMlgD5TZTZP
	 7YR6yG2VKM+9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 79D8E3A566EF;
	Wed, 30 Sep 2026 16:50:05 +0000 (UTC)
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
 <179078700397.2015676.6035058794698435257.git-patchwork-summary@kernel.org>
Date: Wed, 30 Sep 2026 16:50:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [1/1] spi: ingenic: remove dmaengine_desc_free()
  Submitter: Frank Li <Frank.Li@oss.nxp.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1176346/
  Lore link: https://lore.kernel.org/r/20260929190621.3516424-1-Frank.Li@oss.nxp.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


