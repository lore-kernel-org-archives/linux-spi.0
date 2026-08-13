Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A512B435EFE
	for <linux-spi@vger.kernel.org>; Thu, 13 Aug 2026 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786621255; cv=none; b=ZE6wzCr4pUDcZKDn2qjcBK6Eu718cSXoRy+EC5SsPVTsKWZjxwAzwlVvVqqj+OvLA3RMEQYkWi8jt9UjqRoYWy6b5G6fhTXyV/+Xh+lv3miEOqxYzllJmicNxmAuYdAkFASd3WKao4T7l2zH+fnTBIzwIp+JjJyx9N0A49yennU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786621255; c=relaxed/simple;
	bh=XIcpFCK3e3qCqTuGoOp5xJg+26yNaXbiNXBRn+fP55E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mKYobiG4h5NzxIWfug4YBc480QQ7rHFPhzvFpePtLT3a0POQiZwXK/o2Fk9zX1pHdSEyx8BNOe0lY9q5RAQzyUEUYX1pUZeZkWGfuvwoEXGVhP67VP8Z9XeDds7/lr0QR1NN7U7mRgazRE5jEmwsDEA2aZvzs6JdjReIjtmhUyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxh+/PIs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxh+/PIs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ADBE1F000E9;
	Thu, 13 Aug 2026 11:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786621254;
	bh=6ub6nCcw2ytNKVCvesiTjhc0QuGUKVvQ0Hr/SVIRSlU=;
	h=Subject:From:Date:To;
	b=jxh+/PIsHzZlFDxDGkrLekDt0lgPQpFmb1YLaQcbQm8fpBzeg2C1ABPOxDDumFskh
	 a4ffCz9GsSeMrofyenQY1LKLkbk9lMLaPkAGYaFFO2BaVZ9KFudTdrRlRj8RswkQIO
	 CfMzqKNiCfzPLCLcz7J8Tulk5jCfueIdTEOj8wb7r48HApHReegWN//jDODgr4a9HG
	 6IdEd8jS/3egaa18xvs4GDRS6MZBUjdreGp6RcA182FUCFdr21+mNyypLTv9fuT+WI
	 veJpROXmGsCylpltDWsQos5djgeeGRjCEhSTawlHE9/43Ik8YspcevDkRlHtDqdyxN
	 d8GrUUcQfNZTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 961D6380CFD7;
	Thu, 13 Aug 2026 11:40:10 +0000 (UTC)
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
 <178662120907.2389593.16419435644964489240.git-patchwork-summary@kernel.org>
Date: Thu, 13 Aug 2026 11:40:09 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [1/2] spi: mtk-nor: Propagate errors from optional IRQ lookup
  Submitter: Bui Duc Phuc <phucduc.bui@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1142117
  Lore link: https://lore.kernel.org/r/20260807102932.45785-1-phucduc.bui@gmail.com
    Patches: [1/2] spi: mtk-nor: Propagate errors from optional IRQ lookup


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


