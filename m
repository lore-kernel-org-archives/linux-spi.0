Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D784730F957
	for <linux-spi@vger.kernel.org>; Tue, 19 May 2026 15:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206234; cv=none; b=kMwmBmjxsMSRBCWfk6/+k55W4tP3KBdyBvkFp3h4s1Pal4a+ghzplDi8gyaiwenU6c9c43ixfhoMdKc3Cz3fjYYPvjKx6fayAVrkFRU37QBtEqGK0Lo6ky/ZTG88LsOKjSp5oDtPp7cQGtiUOfxmmTQiJ9p5haI1ej/p0JqGsgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206234; c=relaxed/simple;
	bh=jiYygXzWV/+fvypSkUU9zf6FHeiQseEXFcN6geL+c34=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=QlNaMoMNgIQCzk2Q+OO/CeMK05D9EwzJR9nDhXKEYJBFjdXqd+qLeaJqS+Y/rIuh+r29Zhs4LW4Pt1fvHYVCCzQp/JIdYsdrOJoLA1yZdbffr8GVhUHvhLcAelI3nqTJ/FK1A6gJsnJ5rG0O7PJ3l2JV+JUqIpKdenCqE6EqfnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rZLVhfPQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rZLVhfPQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DAEC2BCB8;
	Tue, 19 May 2026 15:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779206234;
	bh=jiYygXzWV/+fvypSkUU9zf6FHeiQseEXFcN6geL+c34=;
	h=Subject:From:Date:To:From;
	b=rZLVhfPQtuD4DYmbJP+wvSHkrl83YmMvEVdir3Zxl6zxopbM6KiGDDevJrRaICCK3
	 9YX74QLLjvo646Jd12Jzh0X0OLFDLRoN3Wf6y1oYbPZnzOvZVqsJmYSER3DFNYjJAF
	 AaOB6AryxLmUWEZlUIpo11A4fpilhIlT5uyj9PBBS6xfMKRzbwN2S//YGvo/Mk8kZi
	 w7QXBCnTF534dCVP6TCMSpQUN1vMynKzm+G3ZouLJpY+ZxHYY7j+AeQUMOAKcXaceD
	 GprdhQkbRI29vHtODdj5J8XDzo063qYtRxDqZgotCeqYtnzCGkazQJPH8bHlS1jcLV
	 kdm/pA4OsLgnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 954CD3930E2A;
	Tue, 19 May 2026 15:57:25 +0000 (UTC)
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
 <177920624425.2782100.1180369836826848699.git-patchwork-housekeeping@kernel.org>
Date: Tue, 19 May 2026 15:57:24 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: tegra210-quad: Improve interrupt handling for loaded systems (2026-05-19T15:51:06)
  Superseding: [v1] spi: tegra210-quad: Improve interrupt handling for loaded systems (2026-05-18T16:07:36):
    [1/3] spi: tegra210-quad: Convert to hard IRQ with high-priority workqueue
    [2/3] spi: tegra210-quad: Cache TRANS_STATUS in ISR for timeout handler
    [3/3] spi: tegra210-quad: Process small PIO transfers in hard IRQ context


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

