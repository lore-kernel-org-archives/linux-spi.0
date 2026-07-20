Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8683B0AE8
	for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784553059; cv=none; b=IEz57dRzYyaOJYs73lWEVcFb2PHEw1C8NDH00KX1iEwWPdFQec/VlAQ7wpBDagySO7qx52iJabR2PB2VbDhMQ+W2Ox3rhAre/rPIxFN5Epd/Qgri6WqCcHcFvsAvem8/noz1v2YHktlY8asw5czBRfsJI1BBCg73WVhL3yXmzRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784553059; c=relaxed/simple;
	bh=AVX+nG27ivJsOI3CBwd2BO6MNrUWHQkETHZbto7+2cE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=pSu0YnejE2tpaAtPtjjvwSXKKNCR6RfYEg8JzhKCJ/geZqel6UZiUw3QyHboGb6eshhoy8ETrsZaD+5CaFHeqfTV9mWk5iONqD9q6Tf3vhGnJUl9DoxVgTZ7+zyeuvu4ohYQRW0uN+kISWNrB5z3lp9xPNIxYgeWTDq9vzs3HbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYIXrSVz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYIXrSVz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8151F000E9;
	Mon, 20 Jul 2026 13:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784553058;
	bh=wvny9CpmheCgWxoW65r3QtedlyUPqouq9Ei3dtqvt+I=;
	h=Subject:From:Date:To;
	b=JYIXrSVzdjFByM/vQyTRFrPBMQWmR6/Szh8MHxM1TpmX7Y3UlWmmxXU5S/WOoNeNb
	 079yP8fVtnLl9K6dfsczMVFVG6FEn+gWFJjzYTRqZwvmSxIMnxg3PSSCMWOXJHkhri
	 Me1gZcNK4f3bEcp0ijSLntty5MnsjbqcAatFF83XKPhTMO2saBl2JxqDVIImntFxiU
	 UWDfRo09x4lGw7SBUWDUfDAXGn9IwRFdVMf6vkKudSMg1rTkbczMW9lxQem1nCVg1b
	 p4oiBQog/j99qjjhLC2WXfmbeX2zPxwRenu1u4H45SVs4kVg28Ol1m9dXfb5ly4VV6
	 szpCUlHJo5DBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C49F392444A;
	Mon, 20 Jul 2026 13:10:30 +0000 (UTC)
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
 <178455302875.3533719.4051489068251109055.git-patchwork-summary@kernel.org>
Date: Mon, 20 Jul 2026 13:10:28 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: axiado: cond_no_effect and kernel-doc fixes
  Submitter: Babanpreet Singh <bbnpreetsingh@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1126312
  Lore link: https://lore.kernel.org/r/20260713060807.7-1-bbnpreetsingh@gmail.com
    Patches: [1/2] spi: axiado: merge identical if/else branches in ax_transfer_one()
             [2/2] spi: axiado: fix kernel-doc comments

Series: spi: atmel-quadspi: add support for LAN969x
  Submitter: Robert Marko <robert.marko@sartura.hr>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1124618
  Lore link: https://lore.kernel.org/r/20260709112006.390742-1-robert.marko@sartura.hr
    Patches: [v2,1/5] dt-bindings: spi: Document LAN969x QSPI
             [v2,2/5] spi: atmel-quadspi: add controller init callback
             [v2,3/5] spi: atmel-quadspi: use init callback for gclk variants
             [v2,4/5] spi: atmel-quadspi: add LAN969x QSPI support


Total patches: 6

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


