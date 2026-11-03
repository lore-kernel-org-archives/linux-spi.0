Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793706606;
	b=XqI9HSgCuZkFccibbhuIjt9Z27p9Thv2MgVQz8IL2y4Cn7x8YDXC3Z2VLN3SviZl+7G5
	 CYsTULi1VuxLkMe/NDHL8jPGEqRtcv/OMtPBjMCd+XOclVGmdOrnTNsvGpiMJTMBpY4hE
	 mbcj7judUOp6eY4FYQY0BwPHG2d9kkSKoh7SYaL5BoPVKMaIt/2q2bBgIKL+7+hV4LXLr
	 9e5HHFc6FGAKMcG6b2mWmAjeZw1LTNIEUQ+M/zNKVNcI4097rTu9A81o1sBImiw5Vpoub
	 FVGfLqIGrW2teOhALg5Mq3CCp/Gq9r4nXrIvfzJQQPnFKC4JOFNn3cM1aP2m5IGET7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793706606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=moZ+ztRSsmKwEicCscSpemaCNWpPPtZATd0erH9Y+rU=;
	b=jBBkMpK9UsdwPZt1zWKr9PgtgLqKcEiFMa8UxtuzhurC7rM4IWl78/J2qIz80vGf7lNt
	 sQyJbEFnOwQgqDZc6lqxPxAiOnmnBS8Qw5dyZGNMH3+gl8xW5KpFPUIltQURHQGndMKZs
	 xRcwqYi45DtypIX7iCIHIkvNuM9P24vUjVGlCfzIjIBTZIPDpDgy+i4K+ZWyEL7lDY0DU
	 m2qIGOfYTJbrIitMMTDLhEXlGFTE2aIs21+X+QUymfLBVT4BH/ic95yYajGXs8P82irxz
	 /6zg1ZSfmPDfMsf1nUdeyF0JnYWVDOT2PfmWlD76qfZ7lyilUQ0gHHfz4DnsRCIWZQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D91zp5rl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CE6606D80E
	for <linux-spi@vger.kernel.org>; Tue,  3 Nov 2026 11:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D91zp5rl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BDB51F00A1E;
	Tue,  3 Nov 2026 11:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793706606;
	bh=moZ+ztRSsmKwEicCscSpemaCNWpPPtZATd0erH9Y+rU=;
	h=Subject:From:Date:To;
	b=D91zp5rlPszl1bUxUZSA9IKUb0bvpVnePEd114JCIRE0eLTuaC+GjF6x49Wd53NIy
	 2sz6rTIuUpkqI9IxIvVdkuOcjh0/z/yXEDONNfANdgkzr21w06VcE7sbQII7KBD3la
	 6wukCVea1HCrF6HFkNziBWPBkhJ0wmtBzu6X7F8pUeLTzEvsEqLWaibyF2FPtj1f/m
	 aBdEbRncsreE6Kg/mHN7S7hhpyzA9GyAnKoNSdaZG1aUYHCzGHV5WAG53K2kFa4lOm
	 bXbuCEIw7bY00s8Jjz1v3WBiHXQef9aQmF5CZP1JLaeKcgdKG1DgpD5pVbxceqCt+N
	 UpMZhd0/1r84g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 05EB13805CDD;
	Tue,  3 Nov 2026 11:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179370660459.1076381.14031369451845145163.git-patchwork-summary@kernel.org>
Date: Tue, 03 Nov 2026 11:50:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: handle runtime resume failures
  Submitter: Jiale Yao <yaojiale02@163.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1188695/
  Lore link: https://lore.kernel.org/r/20261019084443.1824122-1-yaojiale02@163.com
    Patches: [1/2] spi: stm32-ospi: handle runtime resume failure in remove
             [2/2] spi: ti-qspi: handle setup clock runtime resume failure


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


