Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14852D780C
	for <linux-spi@vger.kernel.org>; Mon,  6 Jul 2026 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783366226; cv=none; b=VWywhmYVPNIXts+YibC3FHdt/QvqKoUgWOglSfN0pYpLqbjGLR/RpqXDU4MtEqHjBBpeZQ4oux1UoP401CvG2+kt+0+Mp76FXe6TWI5Ozt9m/wVwcHUG/bFTS9DyxtsAZW7nI3i3c2RjmKDfQSFcB70/Dng7hgPGrQqCW9U3BJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783366226; c=relaxed/simple;
	bh=UWgEpuJzxbauU9isOQb+xlW2735vpR9aasf9M7oGG08=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kR4DtkkcnFXuNI6/UiZUCr6sq+bn0WDod6OUsVa3JQ8wDp6/DlAkQbvsatt3u/ZhCm+re7qL5m5hJYTh2iKvtPYCnJqaiTgxhbuDRcDuk7CGcD2wsLrsrEex0RTl3HMk9raasJwo4YFnwB7PMDT0Vr1texpdOLHV0we8SsX8IbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jaww2Zqn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jaww2Zqn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4816B1F00A3F;
	Mon,  6 Jul 2026 19:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783366225;
	bh=rYV8LACKEGYHrAH2NtFOThnrJ1jVd6lMuqHV9u1ijy0=;
	h=Subject:From:Date:To;
	b=Jaww2ZqnQIOK9f56x2K3TwWDeTDOo4jh2XlpphArsErllJmdEM6BHU/pjoKKv6Wjw
	 wr2vyYYfj3vykD3XMayRjua4MAYvXYhREKXfV86BqJSZ753g+GaGZ4QReA1Mj/dlMt
	 gqQCLR8cldAD5DORDu0KcX0r3Uh3JOmL3f47ono/XljKEUl6FQqnLuQ8g2kArQ8aeo
	 cblJe7SxMst3+myKkd2bPrPjE09/gp6AQVs2LSHnytt5kNyDPBIDnG7Bna/S3leK+q
	 cLRwi5vrQogVuEDYTZ+zB0TQd0O2lwajjfiewt9cGVe/b+QcN1OwWTKWNZcDaSuoWW
	 mHpEcySB+1uPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D33953925F51;
	Mon,  6 Jul 2026 19:30:06 +0000 (UTC)
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
 <178336620525.1174442.16543427740300435701.git-patchwork-summary@kernel.org>
Date: Mon, 06 Jul 2026 19:30:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Enable SPI on SA8255p Qualcomm platforms
  Submitter: Praveen Talari <praveen.talari@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1113322
  Lore link: https://lore.kernel.org/r/20260618-enable-spi-on-sa8255p-v4-0-f5b5067e7e1e@oss.qualcomm.com
    Patches: [v4,1/4] spi: dt-bindings: describe SA8255p
             [v4,2/4] spi: qcom-geni: Use geni_se_resources_init() for resource initialization
             [v4,3/4] spi: qcom-geni: Use resources helper APIs in runtime PM functions
             [v4,4/4] spi: qcom-geni: Enable SPI on SA8255p Qualcomm platforms


Total patches: 4

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


