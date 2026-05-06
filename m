Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEE02459DC
	for <linux-spi@vger.kernel.org>; Wed,  6 May 2026 17:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778090327; cv=none; b=C1i7vhKNe/7TS5JU8wiqqClD1AJIG3aiGqYiUnlYybLQCDT1Ch36llKTNGl0jtYe16x10mHEdWpXl5yw6FNVBcrtvxy2ODE8jQJXIcFvek3Tqbgys3TQi4915r9SJHK6FDkDnC6IlZBes8eXl0y69x1r2SjSsY5WeCNu98GsyRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778090327; c=relaxed/simple;
	bh=nD7ptOv5a2Ih3lAjU6qaUUzTEF5RBs+dkO9rKuYjuiU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=WDGbIHGwQ6IzxHhIpcknwjsr75gnwdFd829txW0ppphWskoiSjhVoW8NdAu1aqChweS8c2MC3qrTQiz1Ii+71VLwr4JH/e9l9KgZwci0z+qmoF/LcyIPrK7Mxw29JylIBInO6ucATw0O3nlJMkK2ZXK4wqQty5cf0M9DV+VrGQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pRYBgDvf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pRYBgDvf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5052FC2BCB8;
	Wed,  6 May 2026 17:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778090325;
	bh=nD7ptOv5a2Ih3lAjU6qaUUzTEF5RBs+dkO9rKuYjuiU=;
	h=Subject:From:Date:To:From;
	b=pRYBgDvfH9VsToy0NsUjW+OvRV+m8EAWc25JX6Ske7ctL2G7DE1crR2XjXslPD0zW
	 kU6bvmtp0DDGri4Zf7ttoZ7p+/flBirQA3o/J3YwqfbNJtKC4vAfgQG+trNKBii5II
	 vcm9xNPwLJBXJncOFoKguA1pvCrU+miDx1/wJ5V8zNvfLAjuaSy3n97UtLyihuIPuZ
	 jYHnvgQEK0UAyR+6oEqrNbaojkXUcXEO6GhysT+fCCK6fwhjBmPz0ucw2lTsn1/FSk
	 /nzTlE+d+fZrPfqXYWDHhVjR1+xHgPzGydPzn9MkCeFzKyiv3EOLs3a4YVXgd+iM9P
	 3yR9K0Gdbk5mw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD06393089F;
	Wed,  6 May 2026 17:57:56 +0000 (UTC)
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
 <177809027506.3107611.13777244258933503434.git-patchwork-housekeeping@kernel.org>
Date: Wed, 06 May 2026 17:57:55 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: s3c64xx: fix all kernel-doc warnings (2026-05-06T17:51:44)
  Superseding: [v2] spi: s3c64xx: fix all kernel-doc warnings (2026-04-16T22:40:56):
    [v2] spi: s3c64xx: fix all kernel-doc warnings


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

