Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281174FE2F6
	for <linux-spi@vger.kernel.org>; Wed, 30 Sep 2026 14:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780381; cv=none; b=pKUtEGNaUMeFRmWP1pAeijY85djgor9YHFR0H6wJ+7mx9xrZH21mc81Vn5fYrehXe6RdPL6y3u+A860xyuwTELFg59Ol6gUPAL0/Wc8SEO/x+RWCtejQHdMVRhIDn395Cb2ZHXp55RllZ9AFeHiVIEqnzYyfoRkhL0d1TxkgPEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780381; c=relaxed/simple;
	bh=qHwNUSdjVVgIy00NK/zaKYjePD0BH7CS9lvzqm8vqcY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=MsnZ8tRMSXNEMSx7D6RC+y2M20Hw+oaaDFrizfDMQzFrWdhRvOjPaCy9sXeLbuHnN743oZr31/SLVjLlcmCc7oGdpekqRrogWyybthj6dudqVKPLLvb3DvGmZvXmGi2bkyH2f1wIx5O3KfH5LNZS1QAHBgDF2nXvy/M+k0pzmgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JT7Xw26d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JT7Xw26d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 491091F00898;
	Wed, 30 Sep 2026 14:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790780369;
	bh=HKe3Sr163hd33LsdafYU036cgtqQcdBk6vmkYEnXtIg=;
	h=Subject:From:Date:To;
	b=JT7Xw26dqEo8o9DZWwzJPgtaq17EXTD1EiNCzl7DM82Lv2ou3l394t0sHPhKK1Bgu
	 g998NAH0cVuHpaDJz6rFvmwHURZKstpcMpwkXCJjkd2mYk+i7/8QD0l0ElSVRAXZuE
	 t4B/Cn1vUxO0VoNSL9AHw8zdwOwfqnLREKWAlCUktNIJUCrG7vReXnslu2GDlLuaxN
	 1X0ddrrBrcDyZPaDFGTiQtmJBAspjtIMY9dPcXSllEhMsUE/lqhz5VylGRJQqe1N7M
	 rCTkKHGQkbDh0fYxU+Fivs5sz34M9Up+U1Z9LE9tc8d/FgIP7g6KppSqQj/EruGrR5
	 +wGW4QymZjolQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3E33A55FA7;
	Wed, 30 Sep 2026 14:59:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork housekeeping for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179078036785.1959938.9267675966896974338.git-patchwork-housekeeping@kernel.org>
Date: Wed, 30 Sep 2026 14:59:27 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: use dmaengine public API instead of raw ops (2026-09-30T14:02:54)
  Superseding: [v1] spi: use dmaengine public API instead of raw ops (2026-09-29T15:54:42):
    [1/2] spi: use dmaengine public API instead of raw ops
    [2/2] spi: use dmaengine_get_dma_device() instead of chan->device->dev

Checked 184 series in 4.56 seconds.
This project currently has 16662 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

