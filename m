Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C052620DE
	for <linux-spi@vger.kernel.org>; Tue, 17 Feb 2026 19:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771356613; cv=none; b=HOKkS6VCLD2ekqt54SHfF/bRTPWV+ekIRd3tg3jbwDZ4vvwOyxUi9ZDgd2nhcZREqUVNSIQ8Jd6BA6zw6/u6ym6xBACV7umPzmYA+duzZIj+OoLoiMolKvnMuqtcRo/nQCF4tNZFhjRdyWYtrMtmcOlNsa+kXt+Z4rZ2uEUu75o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771356613; c=relaxed/simple;
	bh=wX5ZMUaVX8lpsFNxj6F/NfRYDazqBKhE4XmZKb1qAJE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=SV/T+m0SAT2IQDbrENNTen6aZGGuGPXtZIN14yM7XGj3zKl6ENr2fbe/EtTRQtDsi6WHGnOhU2md0/jlaXWj9KaVzwicZlv1zKMvPEPXbcko2C3Ore9mO7sCjv9XLIDnvsd1y198MTjpeDwtdlV2OPoyKJ8gVaD7FsNc+1lpqh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8MiyeXj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8MiyeXj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD1FC4CEF7;
	Tue, 17 Feb 2026 19:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771356612;
	bh=wX5ZMUaVX8lpsFNxj6F/NfRYDazqBKhE4XmZKb1qAJE=;
	h=Subject:From:Date:To:From;
	b=R8MiyeXjpTz+U0L2h4W3FEI3Kw8Q7u14h8SZcZ6hwvSN43H3q20q50F04oylZPFvL
	 ZnVrVxCMht6L8TFYxyqenTyzBeBt4pQ5Fg8FIjC6jDD3vsBGbtujFH8KDLxMLc8AAt
	 2kZG3E8DlyBmwYuSxQlJ4xiH4ghEAcme4o2rlzhmOrkogPwW7lcqsEwV7p29aOeMJw
	 BTYRrgoz+wUcAFr4hBodwLm0n+Fsx6kAAa4QHZkxdqqgAmWIaNr0sE0OmmjDrLAPIN
	 jFwX2YJI4v8kjeJYfZEJV84DKfkaeSM3GnPFECuVJhDHRvduOjSRNZBjyocnsWfpWa
	 vXUEqNYbk026Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 879683806667;
	Tue, 17 Feb 2026 19:30:05 +0000 (UTC)
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
 <177135660407.614532.8029833755320896711.git-patchwork-summary@kernel.org>
Date: Tue, 17 Feb 2026 19:30:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spidev: fix lock inversion between spi_lock and buf_lock
  Submitter: Fabian Godehardt <fg@emlix.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1053007
  Lore link: https://lore.kernel.org/r/20260211072616.489522-1-fg@emlix.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


