Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD7F2E11AA
	for <linux-spi@vger.kernel.org>; Tue,  3 Feb 2026 21:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770154491; cv=none; b=PEgh+P4jUYfnLwVw5g3TRzEEJlBUBRIx2hJ3KsF9xU+dyiCxgcPZwKYWhfLL1iZNXUA4JInMjvAr33QH3cb63rSU3y4AywdeMWpPv97jgsk1HUWxBX2TPvp4lboHRY//P5xLUJYsDDdOchyrcXyoSXDPGhw/up2Vd+4DUq7K2N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770154491; c=relaxed/simple;
	bh=9O+nlgHvNVaEF3oH8nfbc7j6kbZw/IjEFzpj6eWn3VI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=QWZBNDihEGdzTM3VkdEl4IJYT04bc56EnICp2YXCeg99yKSPDAy255LoWtjE8xqdHFdanNi0jyD40K1bWsqqxjtvwqPkC3Dkbmc1mKC1TaBESYjWQWaPObcwKaTEflzoOvFx6h15LuLk1hQpeshhqeKt69WjRG2dDWPwtES6mkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwxvtfs/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwxvtfs/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8574AC116D0;
	Tue,  3 Feb 2026 21:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770154491;
	bh=9O+nlgHvNVaEF3oH8nfbc7j6kbZw/IjEFzpj6eWn3VI=;
	h=Subject:From:Date:To:From;
	b=dwxvtfs/5a8h6EFX9HZ0/oUj5AO2Bq9DF2zsE+zRu8JZp2q2Xp1tlkZJtl+HWRrHf
	 /hufRFYJSOQ+htzENcsBSOGskU7dTDfBTIBPx3AksG5Vk4vzBIjAViVkoCA0iwxrVn
	 7xc09BCDOafovERjjmRL9UROvWOXEI3T3b6Wf+yg6UYtXs6Q6NSVZ529tfs+ELjXjR
	 PklkC0ZDoNYpVhSJbhzH1aoadLHDs2YBgKdkUY8hr8S6ba57MqLVyBKp+J9bPxDK/h
	 xwtg/nnICIsUnkfOBXs57jyNI5SnRhj8u5CPbNqZYtcv05CYMzXZu6M64FJ/QjIlcp
	 da7biW6Enls6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 16E013808200;
	Tue,  3 Feb 2026 21:34:49 +0000 (UTC)
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
 <177015448774.2033762.1968063150264774133.git-patchwork-summary@kernel.org>
Date: Tue, 03 Feb 2026 21:34:47 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: dt-bindings: spi: Add binding for Faraday FTSSP010
  Submitter: Linus Walleij <linusw@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1050211
  Lore link: https://lore.kernel.org/r/20260203-gemini-ssp-bindings-v1-1-6d85c9c72371@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


