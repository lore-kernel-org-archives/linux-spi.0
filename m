Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B340D381EA3
	for <linux-spi@vger.kernel.org>; Wed, 29 Jul 2026 23:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785366650; cv=none; b=dZ/31X7ihS9MoOJ/25fmppd7JxI3WAi0NTorGo8OgQxI6Gikzjyj8db1gFD6SHxGqgAWQ8JjYSN6yEoDh+K0/ykIJt42s27gvDFwdRsoiKCl9L0SQdNVmLUnQ581GorptqETqMbWO6dYl6eVjljMWTSl77ns7R0wVHJOMojO+c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785366650; c=relaxed/simple;
	bh=pw9pWlaMxFH2N8Kn5wsUfPHNX+UVrQcBzqIafiI3CLs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=W+upwzayiVbdR6SFbXZ11pUdnHBnwgNb2xYOhM0ojhE9Db/kEA2LHeute7Uvs9k2WDjhq3bfxW8BOxbQz4LvOft3KgmOq4nmZhHnS+MM73XEYfwwSMatnZIHUdSFs8lwTmQRc17DPVvLVq2fh7QwQhK0h5Dh6jeyT/pzeqEbCJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivlsqneM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivlsqneM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC451F000E9;
	Wed, 29 Jul 2026 23:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785366648;
	bh=VmdE+TMBJ/goZgjXIMLWe0pTsdR5C9CYcVLBsSNeH0w=;
	h=Subject:From:Date:To;
	b=ivlsqneMjNeJJpMRO8MzQiOcSfUWRWtISp53+ZIpIboAmJIOi/4eZURTbMWdmZYOw
	 ZL/uijVaXoSec4NwIhpobWPWBVQKrki2fABmlRdnLidp4urY+DCUaUosrA6sEurY/K
	 WKMd4RkTYt/78kqE7cWb0Ob+n10UliDzMgusY9eUwAsOz9VQn48S/kQjXJn66rp6iu
	 3Z/WyvGryPTDKU5yresnnZHbQ1cObLjOjC4CK8eajgmygxWybuhix2I77BuSy65e6K
	 4eTjCrih30N8wsDZ9ETcBtu2fXd/SmQssERaIazyfuCwFVTg3XLzuqE1gPK7lYZ07N
	 eXu9VzDBdqh9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0F61392624F;
	Wed, 29 Jul 2026 23:10:13 +0000 (UTC)
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
 <178536661233.3275976.4613949988736660618.git-patchwork-summary@kernel.org>
Date: Wed, 29 Jul 2026 23:10:12 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: davinci: switch to managed controller allocation
  Submitter: Fan Wu <fanwu01@zju.edu.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1130194
  Lore link: https://lore.kernel.org/r/20260719010014.3163356-2-fanwu01@zju.edu.cn

Series: Add trace event support for GENI SE registers dump
  Submitter: Praveen Talari <praveen.talari@oss.qualcomm.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1136747
  Lore link: https://lore.kernel.org/r/20260729-add-tracepoints-for-se-reg-dump-v4-0-08bbd63b0ed2@oss.qualcomm.com
    Patches: [v4,1/2] soc: qcom: geni-se: trace: Add trace event support for GENI SE registers dump
             [v4,2/2] spi: qcom-geni: add GENI SE registers trace event on error paths


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


