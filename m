Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70A336F40E;
	Fri,  6 Mar 2026 18:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772822291; cv=none; b=D2NHQO/SN/3l2ejEubLmGSoD7xWF8o69vRDH/2kDcIp/EXxVD9MmDlMYSZ4Aj5rnsm9rldcCucP250eDuUiPozY6LY63IyAUdEb7rhN4XIlxYWzRylPoj3X3iW2IvMp2hlTEFxesXJFtVb2ZruBp8ld7tFx0mgzJxG/0rq+O4GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772822291; c=relaxed/simple;
	bh=Dd9KiDK7xd1RD5ppy7dwccbeYtCsapqxB7L5od15ifE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=oUDMDvtKXVvKPyAKhXmZ1JkqWx00etIeVTYuzOEXyFqphiiNMa4/6OcjZnc8gmee7LQVJh8Kbocyij6FFbdg8OejgZw3x06fTW5dHgsO9kjDFbAtzU5/4I2VP55olEXs1E+z+wQofIAjyxDaMVMLGvzXgVmCDP//eqjNh5HX+58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lvn+luBP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lvn+luBP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9396C2BC9E;
	Fri,  6 Mar 2026 18:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772822291;
	bh=Dd9KiDK7xd1RD5ppy7dwccbeYtCsapqxB7L5od15ifE=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Lvn+luBP3jIAATu+tn40sEHS7xhjQmBtnYGfo3nv9AutXAXPoZpuxCymrVuFSqunh
	 UDX9g6re4G1Fs19zYfzFSGjcwDW5Nb8ot9lGJzbe673BUr/mVqQOVBl0XIHWRSOfHt
	 TInQksDO+UxdRwHECnEczM4bLF1L6MYeDvq9D9XwI+L21uZA0MDEv6ErCMsn+vLfxH
	 pvjjP+36+MYovkwiBqTvvUUILVX1ycx+DqtfCNYfMAW8avf6CSj8c3mWsdCcitgF+V
	 uzuRrKKP7UlLng69Bi83QxW7NPhpCLzwcmFOv0SMJtoHhrBOP82ATZjWWxjPs3ojxi
	 LG5ftDpcsKCUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF733808200;
	Fri,  6 Mar 2026 18:38:12 +0000 (UTC)
Subject: Re: [GIT PULL] SPI fixes for v7.0-rc2
From: pr-tracker-bot@kernel.org
In-Reply-To: <61575061427a7f607de3b67bb125d2b5@kernel.org>
References: <61575061427a7f607de3b67bb125d2b5@kernel.org>
X-PR-Tracked-List-Id: <linux-spi.vger.kernel.org>
X-PR-Tracked-Message-Id: <61575061427a7f607de3b67bb125d2b5@kernel.org>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.0-rc2
X-PR-Tracked-Commit-Id: 3b46d61890632c8f8b117147b6923bff4b42ccb7
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 651690480a965ca196ce42d4562543f3e61cb226
Message-Id: <177282229074.7628.3103470559458212060.pr-tracker-bot@kernel.org>
Date: Fri, 06 Mar 2026 18:38:10 +0000
To: Mark Brown <broonie@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 06 Mar 2026 16:56:48 +0000:

> https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.0-rc2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/651690480a965ca196ce42d4562543f3e61cb226

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
