Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FBF22127B
	for <linux-spi@vger.kernel.org>; Tue, 29 Jul 2025 16:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753808389; cv=none; b=X+7zePNqKdvHShGE46MHMGXyRj1lof5OtuCJarFnFC/3PmWlMlmbSEDhrEmB5bor+pxWbWxHgpWdbilznW8JhIOY2Yv5jKwx0t1yl2KNqbF0QwN48JZLmDzbI+R5MTD4JfCLJdtm5Gq46CkQnZmv5Pi1dzXrYVGR219RFHnpdoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753808389; c=relaxed/simple;
	bh=t5ezCRd3O0v5gGGyGxCjxL/s8dgtAwOGfxjoJgVCweE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=jjkT9/Ctyttd9rNcvXvVKMVlg0Lt+2zVWqgzlSm8UMy07xxv/bfbP97mddkWOlDfEfospeKDWDpT1610CkAxpRfeqxrXY6psM8tfRN8rT5sP/vlDgO1tA8MdZR+yim33oYvlPwskVYe3xUN0f2X+PzZCZ8kZ1g51MKrtpWV+73Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZGIX1aR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZGIX1aR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AA7C4CEEF;
	Tue, 29 Jul 2025 16:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753808389;
	bh=t5ezCRd3O0v5gGGyGxCjxL/s8dgtAwOGfxjoJgVCweE=;
	h=Subject:From:Date:To:From;
	b=lZGIX1aRSWHx3dnE1lgV4MVzcD91F4qCK0WxtlNnQ+rJcULPc8M9L8Nin4YL+/HPP
	 36bwjceynlO7EqDkKF85/yfJ5k/5ITHedNM2aOH6X7UG9D/TLMy0tJtVMdPnjE3iuf
	 RdIqbpyPD41FZCZx/o9fg8fU+Q+49eNDgeaVy96Nb38+uWXaeSkh7jPmLpyo0Odgnr
	 SkkmZhPaKgMP+va4LhmjkvupmK7n1mSR9Ek3Br8aSN1cFRecb+T25cUC03QZ5XOP3i
	 QgbJ3c8z2D2cwqrsZP7pRiBibmHWMuwcp25ZIuHiFDFe+LqC00jIfDySqTtWlYJ+cE
	 iCnD/YOLjhBpw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFAA383BF5F;
	Tue, 29 Jul 2025 17:00:06 +0000 (UTC)
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
 <175380840512.1548851.8291973334311435558.git-patchwork-summary@kernel.org>
Date: Tue, 29 Jul 2025 17:00:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v3] MAINTAINERS: Add entries for the RZ/V2H(P) RSPI
  Submitter: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=986766
  Lore link: https://lore.kernel.org/r/20250729145110.37258-1-fabrizio.castro.jz@renesas.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


