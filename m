Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484B9335540
	for <linux-spi@vger.kernel.org>; Mon,  9 Mar 2026 23:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773099010; cv=none; b=RO1HCBQYJ+N/93g9nXGGwh6bub67rkxlYmtPaYhmKG+hEiqrBZm6kuGLviwwnTGxkN/TgoIJREqmwqSSVqxKEP4sifPuy5Q4rn8uFviLiPK/BhJ2FFVlhJNDLzcvQ5ZJQTwii/OoJRSPXsOEz1eFa7kOnzu4RU8NAagMu3d1wYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773099010; c=relaxed/simple;
	bh=2mcNYkOPAu3U9ZfvaITdR9YY1LXoGTNLBIdMH1VMCho=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=YkvV2f0va5Ibg9RzxIwKLaxCyWOjx54/RGvd6wsLmOPnzj059RbVEMc9slArKjo9waTJpOYyw5WgPlIVETuUcU7sroKSzVa8PrF7Te0e5LvdEDwdC/b0iIBOLEcBtTgQrYdKgDnzSEfxRqc0EHY9xnCDNN8IsAMjUgXCjaU3wco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uSaG+0LU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uSaG+0LU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D47C2BC86;
	Mon,  9 Mar 2026 23:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773099010;
	bh=2mcNYkOPAu3U9ZfvaITdR9YY1LXoGTNLBIdMH1VMCho=;
	h=Subject:From:Date:To:From;
	b=uSaG+0LUj7oDFryPZ7Imsgy5li14B6BWVbIO2E7KcGLygcEs82MbgAfd1tAqU6pJV
	 8dn2ttpqIQEmqJmv84iDLWANu4mt2mA1rYWpYoDmsoqMjMGmqV9piUDx7SHOsCJnND
	 etsWkqFCy0IvFKzLeqZ97yLwypfdqLB5uDDRos0n7IC5KomIujQL+WBAaUv8Bd1+Np
	 jFt1bbI0czVERc0XqNVcI2AY2mHy/LLCCRSy86YYi3o6LeIX/8VArbXj/QzN46ihZS
	 hAb+cBTS/nB1GKkPDXrcpkhhu1NG2nRTKA6k4fSyVUQ75ye3WeklBrJ7p6ptbO/iU9
	 0uuJlwUCDY6TA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7FD8B3808200;
	Mon,  9 Mar 2026 23:30:08 +0000 (UTC)
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
 <177309900705.1977374.8550065961262578446.git-patchwork-summary@kernel.org>
Date: Mon, 09 Mar 2026 23:30:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: nxp: Use reinit_completion() for repeated operations
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1061265
  Lore link: https://lore.kernel.org/r/20260304-spi-nxp-v2-0-cd7d7726a27e@gmail.com
    Patches: [v2,1/3] spi: nxp-xspi: Use reinit_completion() for repeated operations
             [v2,2/3] spi: nxp-fspi: Use reinit_completion() for repeated operations
             [v2,3/3] spi: fsl-qspi: Use reinit_completion() for repeated operations


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


