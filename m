Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C114B32E151
	for <linux-spi@vger.kernel.org>; Mon, 10 Aug 2026 15:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786377558; cv=none; b=fw+YeJF45bfF0kA3r/Z2nh2oDSmaXfvFGNDJ77nMmC4h3DI6Q/SCxjOCvNnbl+SSKmax6T9stBR0ZfXbx08C78+YNLk7XmaDYOCBR3RZ4+NHrV+u/VYNJQoAPrxp/r749u8YQv+6cLQHXJuxlaAcosPLNgETdCzXoNoYlZelDPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786377558; c=relaxed/simple;
	bh=wNliAF8z1z9rwkOgdnGbIPD37yvSzPpdhFF6m1LstWQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=QcguN8sqd25OsJt0GER/ixTU1eWZwpjBFJ65c8sism05Y9qu4mU5QUK9SW0RVf0qc/0W3vYCZw2C4tRsMmVD7RY0g6Sibks7UKt1h5v4biaAxd2K/YUi/kE2NA1bvCvwYdkvEK/L+/KgDWg5A/gTUIkAXMS8ic8IL8oszl1VG40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNCItAJE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNCItAJE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63BA81F000E9;
	Mon, 10 Aug 2026 15:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786377557;
	bh=js+AywE4tW6+CUhuP7RSlyH23RkpBgFqwsUH7FOWa3U=;
	h=Subject:From:Date:To;
	b=UNCItAJEyK/wooHBFYrPgqa0DzS3ubWi0RqhMUJZlzRns5MokORIBaxKZd3W890lR
	 oaeEqg/Fd+RoYWYVuxL+MYzaQXetsgl5t4porrrH6zvI3U6cpzX/ti8k3L9usLTvSh
	 EIQwZbMYc86Urw3K8Lf1lDRU4a9jz+PaIFHdAJ6LEg3LtEbACijvyhO7vHcOu1Dki/
	 coX5p3Tb1Z8SQqIRvAeSl7hs4q2RbKLUN0GhlvXxSGVvWz9HlY1bGQaYwVvK2BIruE
	 lKsvrrhP+pL4g7srik/A6dkltxhqmI4ToPiMbgzylIORkIgcrcARpYN2Ys1D2QhFMy
	 ZFljMTTS6w1Bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5924539253EC;
	Mon, 10 Aug 2026 15:58:35 +0000 (UTC)
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
 <178637751391.3848011.11153445315714983355.git-patchwork-housekeeping@kernel.org>
Date: Mon, 10 Aug 2026 15:58:33 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] mtd/spi-mem: Enable DQS support (2026-08-10T15:10:41)
  Superseding: [v2] mtd/spi-mem: Enable DQS support (2026-08-07T14:46:46):
    [v2,1/3] spi: spi-mem: Flag DQS capability
    [v2,2/3] mtd: spi-nand: Set the DQS spi-mem capability if available
    [v2,3/3] mtd: spi-nand: winbond: Enable the DQS pin on W35N**JW series


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

