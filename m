Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41CB42773EC
	for <linux-spi@vger.kernel.org>; Thu, 16 Apr 2026 15:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776354635; cv=none; b=LCJc7p88bzUojxtyTsGzGk16bJKzALZxkV3fr/M9Ahd/3nr+o5WmIRNIjhGiQCh6r+bodINIFWGjM3qs3JaigqMQifDWqGRgHpQNdf2PiGKgYLviskVrWGMUSxvkyZADP6kMl53dy+701g6SM5bd34OFvMuzKbLIjS6OTuVdEQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776354635; c=relaxed/simple;
	bh=tOAagEFJAB2AQuHhUDNpo0/ZAjKYwW8zN3168NzlyZc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=rCQFK49WNr3eEgyX9/AaU7zjyF+lS/9Kc/SeFjdRtGYYGQ/Co4nQyyDxFt8ZcqkYfHC/KDgr6DNfLxU7/WnJFLd+/EU0Ufkjmgsvm3h3zqmulJtAtZnS8x992CWgcT/mZSDJr6lsb+l2/MObo03yTWlMIAYfmyL5/oo/cgDYuQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3QKwcwY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3QKwcwY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23B4C2BCB3;
	Thu, 16 Apr 2026 15:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776354634;
	bh=tOAagEFJAB2AQuHhUDNpo0/ZAjKYwW8zN3168NzlyZc=;
	h=Subject:From:Date:To:From;
	b=u3QKwcwYi36DqB7/zkXaAUC1DUBuoDYVqo1T2T+xm8kguzv01zkFZblRly/sUmOLv
	 4fAHrfWqL1oENjX2y+zcIukdPOm6J5AdqewxqHXmu7f38VoVJBbcHh/TtetBlJgcX8
	 e+acwZSIwOVzGouJ33Rq1R7CLkj5WaIdvssJMElFX3VnW4DYdJMFgtS8TL8Ch6JZZ6
	 hpBt6O9THiPgEvjHSYQXezeKn2mwffUqSQQeTZ9AGcNQlpBI0MlonfdU0OuegG+DUV
	 aHLDlXgubPf9fTwi4qVtGkTAPM1tAQUnRNAjsDRI0UJ54y2BMq6amqEdUrJz3uMYFN
	 Yo7vLPtjZH6+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7F997380AA67;
	Thu, 16 Apr 2026 15:50:04 +0000 (UTC)
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
 <177635460306.3291643.15997572891061346651.git-patchwork-summary@kernel.org>
Date: Thu, 16 Apr 2026 15:50:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v2] spi: mtk-snfi: fix memory leak in probe
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1082035
  Lore link: https://lore.kernel.org/r/20260416-mtk-snfi-v2-1-3f487689dacb@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


