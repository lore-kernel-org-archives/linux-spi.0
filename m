Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3548435AC2A
	for <linux-spi@vger.kernel.org>; Mon,  2 Mar 2026 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457171; cv=none; b=ZEwdR9BwpKniGkYJJmysfJORKfTZCdRxB0xKgHnVMfMbU2O2rCHhu1KHVRHmfAhxI7VtYfl9SscT5qQiLZ+24LIHXAfAbHnpjlPvj2qcuP5PEUyJVWfvtmyx9jobwgKazb5phX9q7lN9V6074uG2dZs+J6VQmevQY14w8ANSD0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457171; c=relaxed/simple;
	bh=Jf94DwNA5PSg4Ay2h+sZy/qznt9xaI67MxdB97Aylvw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=JDDSpguK17Q779t3JPZ40tJEoXxMaya+2VfCkpJ9zSNdUbFpn+iZKtwfKju0Vfkv4jZuIPHD557KK6FZ3cwdNu+Bnfh4TrerlaYBCTx2LVKD4/5LwfkgqPRsQ+p3Q3IhJQFIyKOibGDoV2kLdo/PNkeZlD5kvJRvJjFweGynlLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/ORtqeF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/ORtqeF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8FF8C19423;
	Mon,  2 Mar 2026 13:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772457170;
	bh=Jf94DwNA5PSg4Ay2h+sZy/qznt9xaI67MxdB97Aylvw=;
	h=Subject:From:Date:To:From;
	b=C/ORtqeFojO4AoNysONuMAiOkWE19jX4pk72yQ3pj+EXoqQJQsDsXIaVSC/gys4iD
	 1W+AGbUFwXojmzf6T+nwhOaGwcIfrQWtCp2jhQC0wQQQdKa7lbON2Y5NOI3ndzxQxv
	 hz0eRtSIPFeuHFNf/Oqi5AhYpm3NEqiBBaqorLsAvJXSi4JhkCvUli4rHE94zx+nq2
	 xW8WId9V/k8VYzBe6dYRAYzq8ZfaA5z6nJAsT+JrJP4N7SUYTbIuRMIIiMVxR0h/SY
	 sddS9a29oAvigb4BS6FDgVB6+heQwoipLuGJVp130PajyidfFBr6Du+Dv2C2AD7HCd
	 bhSA+uodsR7dw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 059E03930881;
	Mon,  2 Mar 2026 13:12:54 +0000 (UTC)
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
 <177245717254.4084307.8565709130748251916.git-patchwork-summary@kernel.org>
Date: Mon, 02 Mar 2026 13:12:52 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: spi-mem: clean up kernel-doc in spi-mem.h
  Submitter: Randy Dunlap <rdunlap@infradead.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1059561
  Lore link: https://lore.kernel.org/r/20260301014743.3133167-1-rdunlap@infradead.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


