Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE09B23BD06
	for <linux-spi@vger.kernel.org>; Thu, 12 Mar 2026 11:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773314410; cv=none; b=hJJgn2xCF1f3/eagfbMMTqQhLaODrg9uI8CoUtcDKdp+MeM8vPucKZywzIyAnRIkdDPSkgaPWuoRIzRetVrUYPn/yF9RKAVLYW9mVzvNr3B0bMOPFB3mjqUcJiNERk1wD2bCKGMH+Avv6vRWukNrXTWahnjRpl4OTcNk5+ufFzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773314410; c=relaxed/simple;
	bh=ZmhnGEnqYg+fmLknNpvAkwzBvgOzC83d6/xlH+x2/S0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=TsHdn81juePi8rkZ0grd5m0Rdh8SAQaBGjiVXfJs0VdjD/vkE9bgyP2+AzHdUWr8OJamlTUhda8vLPr4uBI/MNE+I6QaDjRme8ayM0vWrALVv9uQ9/ElgI1y26fhSToVZGYbfBnqn1hzoqWu+qiB5s+k4RrzTKXmgfuTBIpTCn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VP84sN7E; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VP84sN7E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83877C4CEF7;
	Thu, 12 Mar 2026 11:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773314410;
	bh=ZmhnGEnqYg+fmLknNpvAkwzBvgOzC83d6/xlH+x2/S0=;
	h=Subject:From:Date:To:From;
	b=VP84sN7EioDeqEQVT/YMs31gV9BbCui8nveKAhAfRdFfxDGp7xsuKyigwnTGpB5cf
	 qZi+1g/TRaGBvG4DJ5H4p/CIlq9ROsSbRqUhEWH9DmRoNNEI7tjDYHKsa0wNgUHaU0
	 erMBKXfdUFpoKX0jbn91OF5Orz/Mjd+UbE8j8coFaWKUjYvDTvft12IY97+DZPVRmb
	 +vF5wTnftXax+rJZch2GJrKDS1pBJSs4/2Dpl5/4xtQ2bmV9HQdl8z6jGN1QfE7nNp
	 rtWUaLWqBlGBBySFba2bY3gxhXjssjvak9tEsyqzZlq1YjScGSi+0O++3u+k0uHhKP
	 n4DiawK27AqiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 42AA23808200;
	Thu, 12 Mar 2026 11:20:07 +0000 (UTC)
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
 <177331440578.4053740.8775912817708201751.git-patchwork-summary@kernel.org>
Date: Thu, 12 Mar 2026 11:20:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: atcspi200: Handle invalid buswidth and fix compiler warning
  Submitter: CL Wang <cl634@andestech.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1060385
  Lore link: https://lore.kernel.org/r/20260303024737.1791196-1-cl634@andestech.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


