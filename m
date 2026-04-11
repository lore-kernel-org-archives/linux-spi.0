Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806F718AE3
	for <linux-spi@vger.kernel.org>; Sat, 11 Apr 2026 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775935229; cv=none; b=GREgqjxxqFPI6k4YvmITe8B4uI7kz9w6BFj2Lt8lQ9Akum3sAoqMGU/ii35gOxKq0Y0/8gyUd6WMyOusPhcMd6XUXnOFXnrGOn8MOYMOeY0ZvhlM6NAgI64PpRag37reZibX3bzIE7Kk3z8N38kxbAqyuMAgKdqMPPTZa6xAjCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775935229; c=relaxed/simple;
	bh=ZRn1mf3byWDkIEV1xJ9uirPD1sF1HPyyJJcDyl8hkvA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=AhZoUL7ve92BlwCCY3fFjHkqkr2Z5kQJ03lgpJwAy455sSOjYaocYaARgWDX+5f9iF+61HxeM0gVex+lM6WK/gom/DbXyR53VtX1w3ubloVfHRfuteLJ8N08xrmbB1gMtOAdwFlTlrn/to1NTAKLbnF+r6jjrMENefc1qKJtQFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1HdbQ0S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1HdbQ0S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 330CFC2BCAF;
	Sat, 11 Apr 2026 19:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775935229;
	bh=ZRn1mf3byWDkIEV1xJ9uirPD1sF1HPyyJJcDyl8hkvA=;
	h=Subject:From:Date:To:From;
	b=k1HdbQ0S3gqCise23Hxg0xQShqZDvXNQASzecr0PE8+rc6BeXq3rldlffJ2JutQHV
	 N4O0foFxaAcrhZ0xt+7wtHGAZHI3h3+O/uizbiELae7AfeD8HLYT4FJJLWcIF0pBj7
	 Fbb3SPTQSbx+n4459kSqmCSPSWCHe7p/5p0yBHB4fpaCSBm7MZRthkzll6RJlo43B/
	 Avq8nnlUl6w68K1Td+lGEhS9VbEKypQf1nFy5NR0vFaBw18+QB0pFkvaeP3Qumqtre
	 p9ncClQzwpf34t7H1xu8bBeWwiirCPcoBRCB9MZXpZWNtx0JpsDJ1TnHEv1YOwBrZc
	 1RsGtrPKQwMOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BC5A13809A8B;
	Sat, 11 Apr 2026 19:20:03 +0000 (UTC)
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
 <177593520234.3056106.14423474163817655620.git-patchwork-summary@kernel.org>
Date: Sat, 11 Apr 2026 19:20:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: sn-f-ospi: fix incorrect return code for invalid num-cs
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1080103
  Lore link: https://lore.kernel.org/r/20260411-ispi-v1-1-af384e81c4c8@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


