Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFCC47140F
	for <linux-spi@vger.kernel.org>; Thu, 13 Aug 2026 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786621954; cv=none; b=sgqt4MtuNAVP3Bmb3eBa6VsvfcwaQ9KQdA5gTHWC0kok+7MCE3wEspfeahNFBHbkPy388pH79VobDVVFzHuLBSN5WmTzXrvbM2QycxbBKvMkM5tvU1w/OOTfBEg1tZyjiKcX7ANkRatgk0U+hTVa20przcFdmP49zD70BIAW7/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786621954; c=relaxed/simple;
	bh=DcgmuXfSkZn43b+MVFu8+K2HKWXCoe4MTOZqBrkwi+U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=H1oADoD67YW9Fpvaq8vWzV1qNLlwyklVtrFyfKIuzTvNk47riunHtqzkeMlG2hydKE5qdFUEytJJJg+whQmByrIzhFtaWENM4QhxMWPQjsxmnJH7hekSjv3lqw1eoZwcYNp3HNDrzQRk/noeme/wCv8dz5XKgS0iMRDiZtSfV3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtdMvArc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtdMvArc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FDFA1F000E9;
	Thu, 13 Aug 2026 11:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786621951;
	bh=ocH9ibLFBIDkG+c4/aPwpzWb0C6OWCFcUStgWnWU5co=;
	h=Subject:From:Date:To;
	b=AtdMvArczNdVw1n2j1Q/aN6kQ3xFeWRg6SCa4deXYFYKdXAa5xc3KS9vGIqQwjZv6
	 pnbrLq0XcIlh4nAeaRRuLQzTqNIqnzbwHiHA4BzJCgcZOSU21rwPmq8hDsMQEC0+tb
	 seoqX7MrhA0Ugzx1xZcVpcLan9KZ41XPKDyZDvyaXDEH24aZzjU0BGD8kAEsUHabiA
	 4u6P+vIB43gdw8ROilAcbRAG3ioMMfMuUghJwWb96fT2X/RepmRsEFNCRj5PN4zDcC
	 P38NpICL1dTllRYpoFg60kLsqfrTVqWCHyosDUNKY/Wxy1LoHDlpc61SAIFNzueH7s
	 fUWFB6oN9XacA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C3C2380CFD7;
	Thu, 13 Aug 2026 11:51:47 +0000 (UTC)
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
 <178662190569.2393133.13960915190509202632.git-patchwork-summary@kernel.org>
Date: Thu, 13 Aug 2026 11:51:45 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [1/2] spi: mtk-nor: Propagate errors from optional IRQ lookup
  Submitter: Bui Duc Phuc <phucduc.bui@gmail.com>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1142117
  Lore link: https://lore.kernel.org/r/20260807102932.45785-1-phucduc.bui@gmail.com
    Patches: [1/2] spi: mtk-nor: Propagate errors from optional IRQ lookup
             [2/2] spi: mtk-nor: Propagate errors from IRQ request


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


