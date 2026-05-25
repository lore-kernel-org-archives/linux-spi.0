Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B595838758B
	for <linux-spi@vger.kernel.org>; Mon, 25 May 2026 14:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779718399; cv=none; b=RCQGlGz0gU8nu6KID5mrX7N7knunwJB9gPBgequOR6N4LMo3C2fBy89x02cV3bjZ8T34dDQRj5L66zOMm4pSYUIqOQgd+kvbLkQGXhTUYpqZIE2NAPrcQeqUx7Ohz/dP1XE8o6eVLg+kKrMUyl2LHJ9Wj06buE7dYTGPqPEub5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779718399; c=relaxed/simple;
	bh=R9eIpjgXYxTFejAtk0g8QpVOFe1+/JUvYYhun0/VI7g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=E4UsM2ByaV0yjYZhbc920t5z7Jbi5r1pah8yTJXcOZ+BqQoZcibw/FvPws00wVidopKjKIjjTK/NIir1QkCYHBeFYzHcgH/1cD3Ee64y0x6Gc4WVESLkPlyIbMm/qQNtgoGOY5xMDK0QfmgvC0xxC6lSP7cSW/08SMMVwOz2bWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSfiNpdw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSfiNpdw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E64E1F000E9;
	Mon, 25 May 2026 14:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779718398;
	bh=5y2lJRL1rXlimHIda1mL9Z5e0En0PkPsDwde7u/SW9g=;
	h=Subject:From:Date:To;
	b=iSfiNpdwqne+AzjnolQQOfytlsqP/FRhp08uFfvlI7heXyBLAzxLzEbc5qdpvPlWV
	 RH8lUnFewBCVL+I9CylfDb4Vh1fLjULBzzR479JoUVqF1jsykkT/wn6s9S2A9iJTuy
	 Eo4oaUWeo3PuKZ1tHwww2rdtJSgRZTa7OZXyCh0hd43Wmqe4Dw1S+X9n1c69SSq2//
	 LdcbmKhLIVulxCj586s7N9CA6MqaUCXwLIn8eeeQmQQ41VQc8aisWJbPaxnQlmctIB
	 NbDzTk4T+lE2/Dfe9sAZgj2FW4JtArFTqW/O49Ttltmm03uK/zz3fGNGXcyNzGg7Tp
	 MMtfpz1/LYKWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 596DD380AA61;
	Mon, 25 May 2026 14:13:26 +0000 (UTC)
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
 <177971840477.2591498.11015124533654145940.git-patchwork-summary@kernel.org>
Date: Mon, 25 May 2026 14:13:24 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: omap2-mcspi: Use of_device_get_match_data()
  Submitter: Rosen Penev <rosenp@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1096927
  Lore link: https://lore.kernel.org/r/20260519004352.627148-1-rosenp@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


