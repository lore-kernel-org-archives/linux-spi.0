Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F8541F379
	for <linux-spi@vger.kernel.org>; Mon, 14 Sep 2026 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379480; cv=none; b=WnDoS0g/TKf7GU9JI+tSvVB5rQWrTXXy9KmxtSudlI6tjzw86wu04cAGZojLik5hdu9KPhtPH5ZJlfQ3lX2Mzn5gQbeHr9eYxEfuqkg47XFilTtgAqxR7VsM4DvLvjTE9y8KsJRK0aV2He/Agme8MZcHy8eooRiJm5UIJAh280Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379480; c=relaxed/simple;
	bh=8OrSMJDxfVCXlPUCbvwuHBVAJuV8hOLJeTp92mOVEn4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=E+ro+X66ixsEvHf+f5zlH+S3Fzsln7wC4e19jovk37PV7qtlyd9Q2fwLvFJ7d9BcnSZRwvwKo9nXf1M8xd4sQKBIqgOps+OjC0ar+tILx1FxeJbU21sGMLEp+5sUuk+cbTVhMZiL1QgBBZZ/zQGYUFGmBQ9HMl3GIw7r5KQGtmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=POnpvjci; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POnpvjci"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E47AF1F000FF;
	Mon, 14 Sep 2026 09:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789379478;
	bh=AOC/6J4EFp55aoC4VkgIOy9YBzdCr84wUzi6svMspYc=;
	h=Subject:From:Date:To;
	b=POnpvjciIsRsU2RkL9lB2oUJ/dEqbz3X/bCujca00alcAAJok48nLvOJdvUW8hB9D
	 4ZPdzi6gc2c6LVXaDfhcwTndWgTv6fQ9izwLiR5EZm8JlLjLNWU9f+l2BdvRtF1GTr
	 NSwWPWaW0YPgRJ2vik35StC8lfr32NcCbkdaaGcFKDG29u1weS4tF3hqNJQNuV0WEC
	 aW+shQOKyf9CmhwxIADbABsYQ7wQoCi2rqRg2nMMUgtBDrFmsaO9aPFpcdz7HTkEp8
	 Ei/py6IHOM/jVN5WLih6tRbdtLnYg4YKRY+p62Yl8VAnz4gWhInjqNQ/LPIp5gR+RB
	 NQZ9W5vU75EvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 59231380CEDD;
	Mon, 14 Sep 2026 09:50:15 +0000 (UTC)
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
 <178937941381.445884.17113488994377516567.git-patchwork-summary@kernel.org>
Date: Mon, 14 Sep 2026 09:50:13 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: docs: Use the multi-lane mode constants in examples
  Submitter: Karl Mehltretter <kmehltretter@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1161746/
  Lore link: https://lore.kernel.org/r/20260910033219.15996-1-kmehltretter@gmail.com

Patch: spi: spi-qpic-snand: remove unnecessary cast to '__le32 *'
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1160798/
  Lore link: https://lore.kernel.org/r/20260908-qpic-snand-unnecessary-cast-v1-1-26df1cdd4bb6@gmail.com

Patch: spi: spi-qpic-snand: avoid writing QPIC_EBI2_ECC_BUF_CFG register
  Submitter: Gabor Juhos <j4g8y7@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1161386/
  Lore link: https://lore.kernel.org/r/20260909-qpic-snand-avoid-ebi2-reg-write-v1-1-9b1b1466cc75@gmail.com

Patch: spi: Fix the return value in spi_new_ancillary_device() kernel-doc
  Submitter: Karl Mehltretter <kmehltretter@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1163301/
  Lore link: https://lore.kernel.org/r/20260911230211.11755-1-kmehltretter@gmail.com


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


