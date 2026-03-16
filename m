Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E86031E822
	for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 18:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684029; cv=none; b=HzTC3/hzsyDFHLsAkNO2LnlV/ARkvc/cc3uobSjr1LReRvsfPWrtguV2iRO31Srqz/cdBtIBCXCfgxo/2YkyM4DnwgC5UCQXv3HrfQwKUJ86phW2zNzIMZgKwhF/M44DufN6i8eFghhUtQQH/lUvAHg6hYqeRwalNx9xSljO3sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684029; c=relaxed/simple;
	bh=Hov+x4qj1xVZLlZwcRh+T5IUERH7vHciRAYrjBF0u3U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=luEAZ+/FrcUd2D1tpPjLvwfyt2GiyAlcKoqr7uCa5pXk62aSIksDixnoLRMlX2sJT3zMtjSi9K+ydM8BJ7xd+Meyduh2hx9qjJGpoRNlTlkKm4l89XkSaEyicLOPUPUboqP4SXOhRBylDxTEsgHjC5FP1u4unGDZLltJHLWqp2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WACYKzne; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WACYKzne"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5F2C2BC9E;
	Mon, 16 Mar 2026 18:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773684029;
	bh=Hov+x4qj1xVZLlZwcRh+T5IUERH7vHciRAYrjBF0u3U=;
	h=Subject:From:Date:To:From;
	b=WACYKznesmiVPJFJu9UnkD/LfwyvIfmjdeBW80Zf7PzYO0MwpaWszkslJimxqsopK
	 anW4WpsIAh/cTEht9I9+BYct1b9ahDdbvFP7JyoOCGoG5VFimhyjQIRxvBbbpW+J6e
	 hSactjuD9rr+uLrHoDEgyif0b1dQO7v1+AMfxIefYcnAtDRdNrq777LfvKLXuEgovp
	 e4O+lSfVH2XVdQReRUEGlfRLJDm2YkExFfUNs1SkkRub7OEg2yaCivqRrjzt7rN9pN
	 w5u7Cf+QHEucpND9fnGjET9jc9xCqcHMJVZ7959xuudxzahMfYZ/umxv1+wMHOUY6l
	 Z1VWQts/2K3Yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 42E9D3808200;
	Mon, 16 Mar 2026 18:00:23 +0000 (UTC)
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
 <177368402185.2784985.18325794505840235320.git-patchwork-summary@kernel.org>
Date: Mon, 16 Mar 2026 18:00:21 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1] spi: geni-qcom: Fix CPHA and CPOL mode change detection
  Submitter: Maramaina Naresh <naresh.maramaina@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1067333
  Lore link: https://lore.kernel.org/r/20260316-spi-geni-cpha-cpol-fix-v1-1-4cb44c176b79@oss.qualcomm.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


