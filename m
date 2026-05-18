Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FBD38643B
	for <linux-spi@vger.kernel.org>; Mon, 18 May 2026 04:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779080218; cv=none; b=Hfb7ODR2FDuLB06iSLkbSwzuUK0WYW/ITSmjenD4Wqwj1cK0LucJmB4nMRUq0JkzqyrGjjiPXBFh6B/1WvP/ES85kRXLF7ds8Oe7gUyIPXzXfJNbHx/2VCA/YU+TBYpXprluooPwXg6wPvTy9dyz5jWffYwkc5R+GBC96JRtBII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779080218; c=relaxed/simple;
	bh=do0HsbjvkCEygW3MfoM8m/Dg5iBZuehcbhDXX62jCBI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=N0QWSE8P49uBPy1B7FnNvAlUR6lcdwd51Q4bpwRV56Ry+KtdzQyDHF6izp05ZQFUSqtb/j91ePL2v5dkLUpMvmFVbyTQXXZQ6oYVqsZIUY8KrIlSsnmrFUNbj/nk2nQG9DPsXkFjaCeSgmM2nbImCVBHZIF45H8wGeBSb9QPQ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zxt0ZnpP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zxt0ZnpP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830C6C2BCB7;
	Mon, 18 May 2026 04:56:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779080217;
	bh=do0HsbjvkCEygW3MfoM8m/Dg5iBZuehcbhDXX62jCBI=;
	h=Subject:From:Date:To:From;
	b=Zxt0ZnpP8p7U6fj0VwqSkxk/OyKrrC965XmO8Yq4n43ho/BKCxTX+D9uoYDMo8oOl
	 QpUo9BOQFaJp/mTdfUwGWVSik6kPqWGrHi/NvT7SwYQ1rsCWDvBO6t2p5duPsK7hvq
	 BOH4/HXAk1tFX5dtdy/QI+wQkmYAvh5BTHFMpxcBqlNqXYMf/Hz4TnpknGKJz+h3rN
	 1Vuj1UjALyREUDunLL4gPJEYvgguN1QA9NGe+rkO8Arr1OdRVlZt0XOuweV6eY+yr8
	 Ct2nUxNIvrDdGBykrpwF2sEC24jv/rAkMeOJvAICvpZ4G/QiS/855RR5NLnhtlU3wU
	 TBQT9qE4pLs/A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AB83930BA1;
	Mon, 18 May 2026 04:57:10 +0000 (UTC)
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
 <177908022912.1204934.16273383815491537618.git-patchwork-housekeeping@kernel.org>
Date: Mon, 18 May 2026 04:57:09 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] gpio: dwapb: Add ACPI ID LECA0001 for LECARC SoCs (2026-05-18T02:49:35)
  Superseding: [v2] gpio: dwapb: Add ACPI ID LECA0001 for LECARC SoCs (2026-05-15T11:03:19):
    [v2,1/3] gpio: dwapb: Add ACPI ID LECA0001 for LECARC SoCs
    [v2,2/3] spi: dw-mmio: Add ACPI ID LECA0002 for LECARC SoCs
    [v2,3/3] i2c: designware: Add ACPI ID LECA0003 for LECARC SoCs


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

