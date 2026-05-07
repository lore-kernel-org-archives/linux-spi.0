Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD5A54654
	for <linux-spi@vger.kernel.org>; Thu,  7 May 2026 01:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778118654; cv=none; b=qOdxjZstJlv04u1zMzEQDI1S/9xz/VH2/iftMUQeTa7XllnG17g7lDcoMkrHCe7It3ORdJI4CNMOfN/9QMSp0vyn80HBObvbKqqKRUI/QolxT3vhcLRq0e2nqPYRV8d87vVWoTz87zxC4epWWZH5GXooLBaIJSyHGJzH7OqeEn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778118654; c=relaxed/simple;
	bh=nr0/kFbuYcs1mmFHPK/DHaBtqDVQjmn1CoGvo4KlDSE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=TcHZjR/Kb/6ZLctSMx8vUtHocBJBgg1KycbRDPbr05bxRBL7nk/4RAB3Xr3HHmgFX5Il0GvQ2KKuY5MlXHlBHUngJB+ifyjMKCXSitncvfWP/V/mrOv0jClfqIdSM5kRWSuEP9T15d28PF4i2Ab7EKQn7WvCTGR6sKxzeazGJaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSivVwUe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSivVwUe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F65EC2BCF5;
	Thu,  7 May 2026 01:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778118654;
	bh=nr0/kFbuYcs1mmFHPK/DHaBtqDVQjmn1CoGvo4KlDSE=;
	h=Subject:From:Date:To:From;
	b=kSivVwUePtaBCB3/f5cSM5ZjF2yu7wKEQQ5g1lds6vJOzesttVc8DbS3DDkwj/Cph
	 JJBoU5hoxfW4/f42RnIVNyuAZ1WDdSFYPBiJXgL6TlX65Ta0MMHsFd0j1TudqwGsVT
	 bOoKv7tgdVF9ZKNHkrRnkXv3wZxwhFwdVzm/emMfWiFatSeIRXet9rUX47jDTRs0lO
	 AGdn36m3ghu07zaaF2q8tnX4UnUB+MnzkH3HOBKVxidlB+mj41omVTdxk2ZmodFxq4
	 9n5uzPfPlj93N1jr1MgdztLy3XSPbOlxRtRdHOmD/fnleNR5irpGY+s5CdL0dgfltc
	 EVZ80Q1YJFwBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 05608393089F;
	Thu,  7 May 2026 01:50:05 +0000 (UTC)
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
 <177811860350.3297406.14891687441484997422.git-patchwork-summary@kernel.org>
Date: Thu, 07 May 2026 01:50:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v3] spi: s3c64xx: fix all kernel-doc warnings
  Submitter: Randy Dunlap <rdunlap@infradead.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1090624
  Lore link: https://lore.kernel.org/r/20260506175144.449364-1-rdunlap@infradead.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


