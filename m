Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFB92D5A19
	for <linux-spi@vger.kernel.org>; Thu,  2 Apr 2026 14:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775140221; cv=none; b=j7N9XCVgeF0nohkg4XHgn9MMnqbxwvMi4ym+WNGYq9PmUXp1cWu6HN0UOwc44oHe72vyx/N2qwQLFQNbnBqIYvXZUTvWfWUNWWT7rgX7asvkCoJr0GC7QsGy1JNMg3OLfsB+qxRD+R0+EXb/iNVEtEEsWh53dT8bIUJRjWOG0mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775140221; c=relaxed/simple;
	bh=JUlU3rH9EInfSydrSNwz05G6YQV6kcmUofRub6j58Bw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=t/qqul7Dwu0iDIutyFAJ2JpJTGQSA32OQ2Tevtu9ULKduGd/8touVdwZQwp8toRk1o85id9Gddm9FEkoD7TagqC/i6j/qGcAeOBtp2X+X9RtOJxN/z8xkJwb+F7kh64DS/0kufbh2omprYDjjYH/4UVpUf4HWniEYtFy8ts+BOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzoveRXn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzoveRXn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CC1C116C6;
	Thu,  2 Apr 2026 14:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775140221;
	bh=JUlU3rH9EInfSydrSNwz05G6YQV6kcmUofRub6j58Bw=;
	h=Subject:From:Date:To:From;
	b=RzoveRXnakdjR1xgKqNINKJ25aHU+KQoYnYD6HYT5DhHqh3qo1Ihk5EkBpHb/AIdq
	 VvTPlisvHbl6I5w6q3VimQsrU/jHt8JSakcY8wOqseTk37NgrpEd+fmAjJ44N/DIlz
	 JxuqvjT36wWb8smMzkdM2N4nWtaNnz0J/Bd1EeTiUONP/ViBgBzq/eXX/Fu/f+gPjN
	 JY1oHaHwkw3SoDOi0FdbO5Y72QSMcdLqY+td2Z7N9pmVE4TOKUwrDagfEcCri019JW
	 zXe3sF6x8czY1tUmgzbqqOKqEFfsmphjkktq6qfTsXNqvKhhbu2VxMjuOzneZ/WKR2
	 rYc47bYJvfFxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 42C6B3809A05;
	Thu,  2 Apr 2026 14:30:05 +0000 (UTC)
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
 <177514020380.469770.17682994240924690866.git-patchwork-summary@kernel.org>
Date: Thu, 02 Apr 2026 14:30:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: ch341: fix memory leaks and use-after-free
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1073495
  Lore link: https://lore.kernel.org/r/20260327104305.1309915-1-johan@kernel.org
    Patches: [1/2] spi: ch341: fix memory leaks on probe failures
             [2/2] spi: ch341: fix devres lifetime


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


