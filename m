Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA0EC2FA0D3
	for <linux-spi@vger.kernel.org>; Wed, 28 Jan 2026 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614809; cv=none; b=RF6sUU949AOUMQixxX90rvUozbnZLfapPO5zw7N4uB7vKpnzF0CfDVVpTnkW8qBUfRtV5dbg/Ek424Ac6ujm3xiSXdJJXQVf+FQ9Tmpy2FEZ2JNQLHsEH5b3GuIrwmALrlkaDvFKZqM4V9DPNPBjRba9lod6h9knK2egOElqI8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614809; c=relaxed/simple;
	bh=FeYBnBWHTLGv/H5Ohv9ghZ8FwfzzVlqZjdT6iHvEh7U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=urhFR+q6zAUsATAsIySGfMZAd8QPyHR06I0HaXJ/mhKs8CJFQrOiJiQkLXvJaPVSbXP9ErlGRb4g8AeeuxlRLpTGVoM/LSTuQmgYRqu7ikvdPRHZcHjBAM0Yrvfu2weXxRo/4kitXjUgeAaP33Pfi14aHGSUFrKsNA/2UyXO8q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=me3n2xd7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="me3n2xd7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686BBC4CEF1;
	Wed, 28 Jan 2026 15:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769614809;
	bh=FeYBnBWHTLGv/H5Ohv9ghZ8FwfzzVlqZjdT6iHvEh7U=;
	h=Subject:From:Date:To:From;
	b=me3n2xd7xogmYEnbbmTEa1WiIamJh7dysv7KWyRnx7k62g2UKrhqWGPHT89AWpFpv
	 7y6h6mSLFJ52a6IHJt4pQgIPmhnXks/Bz+ZwqGcTQZMeXgau37OkzCbph5WvVLyD2J
	 uypWciSI0L926VyjaY34ft8GPXjiIduXTuSjh1QG3ILBZZAwKgOat6rbzaEqCPwLFK
	 7jG7iRDIBdlx0+KxAqxvIRPSnsHUB8pXSJ88YM31XhhoC9GMLXu9dyiB7vgjVE5fdH
	 cycwtvgt/GoCC9J4XIexVH0MFnT56/2C2lh/p2MelBHlgTeSRRW0B2ILNZ14CwWR45
	 rdyTXhWpzigOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1459139D2F41;
	Wed, 28 Jan 2026 15:40:04 +0000 (UTC)
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
 <176961480264.1728318.16926553559149886141.git-patchwork-summary@kernel.org>
Date: Wed, 28 Jan 2026 15:40:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1,1/1] spi: dw: Remove duplicate error message
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1047971
  Lore link: https://lore.kernel.org/r/20260128095748.4156926-1-andriy.shevchenko@linux.intel.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


