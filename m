Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9964137BE7D
	for <linux-spi@vger.kernel.org>; Mon,  9 Feb 2026 14:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648009; cv=none; b=ZMYTM5NtQWyyBNax5DxnhGiIaDiQRSX/qBck6S3yUBWSAFTh/J88KbwehOvp85HF11DkzmOpgZ3x0RffoL/p+ZhppYwjaLjvva7Kwo3ym7++/WGBz6m9+sX/Qz9/w5R/gHphz15bqGz0sTdLLN0rJu5glnNL+cVOYYsamA//M7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648009; c=relaxed/simple;
	bh=DGELz9PuQT8SFLGFZfyZ5jLCsoIhfjzD7i8DXdIOrPk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ja8G1Nj6PW55X3xn+aunOGdnDa3mt8tPzxi+EqaQeg5QSzHs6cB0jukL3sthz3hEmtMgt3cBhtUp+vsE/WOgSIudiXO8o3fAtP43826Ijpi7v2uLK0FgvfFbVkdVxgjLQmXp3yrFJqEWZwuAiDQscdRd4KCfdfcTAHD8OJ4i8XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtsYKmM2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtsYKmM2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA33C116C6;
	Mon,  9 Feb 2026 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770648009;
	bh=DGELz9PuQT8SFLGFZfyZ5jLCsoIhfjzD7i8DXdIOrPk=;
	h=Subject:From:Date:To:From;
	b=RtsYKmM2+s5VwoMFp5U8NaWAavv14gCnp5S+KWwECnHKhr/DI/qWUF7sACNKI66E+
	 aI82n/OGDf/f7EaVqmeGm9YqhZ8Yl1TCq4iT/GgQYdp9wVR7PWgRWd7Q3RnItaILV+
	 uRP1cM0CECkqq84zPB2VTGAAkTX+OJTiOCo07l9xsIQ1nq1uEteJP/VFgBt/v8h5T7
	 JSjJoF3Jn2l4dby8k1/5zdqCuuzyjcCrYzKjqEA8GG1XEv+7Gp/mFF95r20KMURVb+
	 2yVcdzVHTYjVJDo0Pn6P6QLHxq1W+8lT7fK/yQOc6a19PnKurUo8pQEy1lzBqdaanY
	 16Xlb6RWa2rpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 87581380A97D;
	Mon,  9 Feb 2026 14:40:06 +0000 (UTC)
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
 <177064800498.2684306.1864479443245966316.git-patchwork-summary@kernel.org>
Date: Mon, 09 Feb 2026 14:40:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: tools: Add include folder to .gitignore
  Submitter: Francesco Lavra <flavra@baylibre.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1052213
  Lore link: https://lore.kernel.org/r/20260209095001.556495-1-flavra@baylibre.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


