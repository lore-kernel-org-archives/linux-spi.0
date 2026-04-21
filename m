Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0605F2BDC0B
	for <linux-spi@vger.kernel.org>; Tue, 21 Apr 2026 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792642; cv=none; b=B329O0pP5hL6P7LCj0uYqtQ6vzuCjWTaGUleldNN+g5gXtZNAQL/Np/FMhzkwU0Sz/xrmJ6iDLBVdxNS+9+2LlgGpi7ez/wNqipI5iRkFhwQdjsjhD5N+EePIY4QLgKerjd0ko+0JvZ5mMbYw06JL7D4/gD71mJt/MSUTOJc0/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792642; c=relaxed/simple;
	bh=/1B/6fiah2/qANLp7V4/9sG3Gkzr/VF/Oa/xkd9Eqaw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=unvUqLDlELYU0JrryPUflpkczdlR2lHcQSxEV+itc09jX1KgxrREbHzFrAF0TLT5B8rqsPNFh2uyW521FxrFvJzC/wp9UWdvm2pnHHtu3d+F+wI8+kLw7i2XhirQ3fzc246SKaDLAiNDBXTT7CMFM/99v3jDSaecRVV8xPcJ4I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPs4X9/8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPs4X9/8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD9AC2BCB0;
	Tue, 21 Apr 2026 17:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776792641;
	bh=/1B/6fiah2/qANLp7V4/9sG3Gkzr/VF/Oa/xkd9Eqaw=;
	h=Subject:From:Date:To:From;
	b=rPs4X9/8K03LCu5YChA58zL9mjRAPGFgi2bYJU7LBZlJ0u20M6S5kHjyz91BtV8XZ
	 JkuLOiIOpNN920GbaAwIeNNTRFb9Jz5dKuEMZ/ONx+pOjEDZPIDpyqo73/G2bttrwk
	 TwcOGiwMUSRx9MRKb/Z905V98T5iPHucs0ARs14Ag3cVwZatcJDuwjKELFP/mXW+Tv
	 o6PNTPqzCwnNClsIW1UWRk4VPg0CB2felS1OZhnntvWiFF2Mk7FMLnTxcFGj7j3NeG
	 OZ1Km28GesV0o274CT5Gq6KTFnRkc5MRdIP0J01LaG1HxNX6D/Jzi4wVXvkp23qAp4
	 w8Jrh2ejkPCWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3D49D39301B9;
	Tue, 21 Apr 2026 17:30:06 +0000 (UTC)
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
 <177679260487.2923960.14050491465373377554.git-patchwork-summary@kernel.org>
Date: Tue, 21 Apr 2026 17:30:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: Fix the error description in the `ptp_sts_word_post` comment
  Submitter: Dewei Meng <mengdewei@cqsoftware.com.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1083594
  Lore link: https://lore.kernel.org/r/20260421025808.6572-1-mengdewei@cqsoftware.com.cn


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


