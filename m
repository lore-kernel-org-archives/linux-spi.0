Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1CF2566D3
	for <linux-spi@vger.kernel.org>; Tue, 27 Jan 2026 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769553655; cv=none; b=OLQGTjC0QGIrNWdGimjKE5y6PlAVZx4AvuVeTEv+B2UCWK6WkeZIwgrETK/psDrfHZwygSYkRapLAE4of8anaZ6Ll35sLzsQgiN6w0esOkDHOYvYXO4zQ6HX98GJ7YEted8kSIRZ+V2HwbheNdmD8aDsPX3zSEMRzRfTvN+Fx/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769553655; c=relaxed/simple;
	bh=2WPQdixEQ+wAjln9ej6AbkiJ5wEj00SU+YbNEH2pQ0w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=pS7oXkjGbEsnuCYRM5EGuJHBXEkB8CV/2ZKEd/gK57tzhPXWLvxh22pWmTrICTg/mdQw9ih72XdSa5+IyqxnMYuFj62eEn/h0qn5Krggo+2I4D7pJ41XlqlWn9jaRfwiwQG2lAaAI+LXyvBN5wcYox34eWx/s1b3iPCUf0odwaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrmpCmo/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrmpCmo/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 661F4C116C6;
	Tue, 27 Jan 2026 22:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769553655;
	bh=2WPQdixEQ+wAjln9ej6AbkiJ5wEj00SU+YbNEH2pQ0w=;
	h=Subject:From:Date:To:From;
	b=OrmpCmo/zF18xQxI3R7tFywAUSeohwU/VhjkEoU8+C9txAMXgZWpEVB96heV/qhy5
	 Q5UB/cMcqOJFGRzdbe7KxWFPhPeA50IkNIHA4d3Q/6RgHf+csPFJ/hWB7YCungXrM9
	 mDvigx5Z/mkBTgpAszEa7xs1YZDgp8I+WBg4gsepzp7CwzSiWvDcoXri1Fbvs10c6S
	 QlNKJd8uQXZDLZ80lk/irHBXVYSO2logrMAjdzBz8bW/R5s5Zm6xkd+FBhRQWSgU27
	 SXvwwD4Hyi1nFE/LfLpfhOSLtYEouIxMDLN+fp/81LehoBAi6dgg6+0ymuoPIGBDlw
	 znMfjywuWTN6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4EDAF380AA67;
	Tue, 27 Jan 2026 22:40:50 +0000 (UTC)
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
 <176955364877.1428043.14650806000399110571.git-patchwork-summary@kernel.org>
Date: Tue, 27 Jan 2026 22:40:48 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: dw-mmio: support suspend/resume
  Submitter: Jisheng Zhang <jszhang@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1045772
  Lore link: https://lore.kernel.org/r/20260122155046.12848-1-jszhang@kernel.org

Patch: spi: cadence-xspi: support suspend/resume
  Submitter: Jisheng Zhang <jszhang@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1045773
  Lore link: https://lore.kernel.org/r/20260122155119.12865-1-jszhang@kernel.org


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


