Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F69346E6D
	for <linux-spi@vger.kernel.org>; Wed, 22 Jul 2026 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739536; cv=none; b=dQj9UBne9Hju/kHlTW+O9QIKLu3rBoUDQFLXm8ozhjWwbVjHIQsh/TFQSew+2eraJNvcMK1dJqs27dIgqPkPx8FXQdlq4bGSMhp70mggVkExoL7a1ncscGFiA4ulZ26I8QA0wPYkW1kuP/O0k5kUriWX4/A2pA9Owh2iTL0cg5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739536; c=relaxed/simple;
	bh=ElCEFiUYzJJZeYqyvNKNYMQEpARjdgZe1GMGnhLETOw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=pB08WqHxbvOa+nDLzeR2KC6kTayJYVdK69pIsyn1ika0dlyO1Hpz3IkzORa4eUHP3nuJ0x1duI3F7bTtCAn0B9wJc3ljL2u+qpjPLRe603FNQkkCuOl2cS+J0+3Q5QhlyjPPNyUqHdaK3KtCYWhq4zYQgk61ich/aSPZEG7+GBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5mu/VGF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5mu/VGF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FF71F000E9;
	Wed, 22 Jul 2026 16:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784739535;
	bh=UGDB3smN63iYAyVkjgLcbP/c8uFXHaL7g0HP5f9CA/0=;
	h=Subject:From:Date:To;
	b=H5mu/VGF9Hg+2+N9fnSaFK7Pcsd7guz3yNE2r3L2WDp+9BlwFX3jeaLHF2yDc+Yov
	 zBPn525HWsLetNZwgHWexZZRJjTDE6C1aEK8DHeYBkWBMxpIaW+VQlNQsb6YILY/t5
	 OYxB7VEyqm6sR957naKpWUuZpKYnsPs53yKxhEmnSlyyTL+jkFW4Y3NTc+kZIB6NuK
	 de7UCCPhQuRuc7Y2+RPOYaj4bMTiFzCJcN0BXG28vq4U+LiL2K7Lb6o2P9r9EsMDJ8
	 aR9j8SDmWBOV/W+HvnWKjltIqzxkd+CLm46QhO3IByr1/cFmA9a/pNZ26jVrPrIa95
	 2U0rzyVMRcGXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93ABC380AAFE;
	Wed, 22 Jul 2026 16:58:25 +0000 (UTC)
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
 <178473950419.1941701.1707471585123299156.git-patchwork-housekeeping@kernel.org>
Date: Wed, 22 Jul 2026 16:58:24 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: spacemit: prepare both DMA descriptors before submitting (2026-07-22T16:24:44)
  Superseding: [v1] spi: spacemit: prepare both DMA descriptors before submitting (2026-07-22T03:41:03):
    spi: spacemit: prepare both DMA descriptors before submitting


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

