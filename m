Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF18E559315
	for <linux-spi@vger.kernel.org>; Thu, 10 Sep 2026 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789063120; cv=none; b=FBMjOYsa85iOBpWF5i9YFN3aj743sT2hPkaGQxOZQHIpi4/rukmOewcYWyPGG4yfeNCdqXNc1eCB/6eUN0ALTVI/HowNhXAD3a60lz44dUARNNkjqjqf492qPsljRBQX+93USxYHqnKMaep9h6CMyGRKXGPuQWc/1dMXr+2l65U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789063120; c=relaxed/simple;
	bh=noWXHcbe7rMdr3co9+Hub6//MBtu6zRc+p9awLkTIIU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Fhodu6mNjMueD9lFeE626NK3T/HoR2L59D4t9QheSPptm5yEIcew8otOEu3TkVBLMejlXet0y7YcEPlC/iLCasCuscrpD3j++EJoqM5QTzXZizHm7Fyb74Bs+3iT2AqLPlYr7I0erkWotF0G/Dbk53iMXNzFtsjAhp0y+0e8yUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jB7MZMJl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jB7MZMJl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73F51F000FF;
	Thu, 10 Sep 2026 17:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789063119;
	bh=xRyFM0P0dB1fBnqvyrM4pmV/nysmQVslpQDygVesWns=;
	h=Subject:From:Date:To;
	b=jB7MZMJlKEHI6yharO/00rgsMwQQt879GXdOAixZXq26b78iwfnmEQv2n3tjPcglO
	 //LyA7qUPVC50qZbLlZKegNtQOw6Z2ZpRoVgNaYgVNK/qsPGIJ7x0fTeVsADhVW6L8
	 LT6GXeMpC4eQlfRWwYASrnLo3R4Hnp+5+Nz6zHY3h03QiYX1Rm5lNNP++D9aMbZlB3
	 +AIDDvjhCy/AODKp+/LgE7RAaE9+ietzmKJUskZC8AscZYPaVrs86TfSOQFz9+8YMo
	 K8F76M1+5ixbtJpk6UOqcP0A0AdgYHQHVak1KN2pVMOm+VGVbAgCJT7KjhlSfhyj1x
	 RGYmUepAu6ZOg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 58115380DBDC;
	Thu, 10 Sep 2026 17:57:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <178906305716.2010188.1923882845496022913.git-patchwork-housekeeping@kernel.org>
Date: Thu, 10 Sep 2026 17:57:37 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spi-zynqmp-gqspi: stop the controller on shutdown (2026-09-10T17:48:32)
  Superseding: [v1] spi: spi-zynqmp-gqspi: stop the controller on shutdown (2026-09-10T11:33:25):
    spi: spi-zynqmp-gqspi: stop the controller on shutdown

Checked 159 series in 2.18 seconds.
This project currently has 16454 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

