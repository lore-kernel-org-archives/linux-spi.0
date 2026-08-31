Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C674A3D36
	for <linux-spi@vger.kernel.org>; Mon, 31 Aug 2026 18:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200462; cv=none; b=A9vCvu1YYZNjVNsbVKFQGxBb58np3AAG7FqaEuAR8ou4OKMkiIxOgA8aFSVjCqWpHI7T828NN8zujOnbCKiljLX2U2yjhhVBL3/ywZZr1ELQE1K13ccwY8ILDbSIyZ/HBPSInfjF2B5AOqzvxvh2GBUfq4dAozaiJD21kuFO4V4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200462; c=relaxed/simple;
	bh=Xube5wscT9Yl+Lz6MXJtBCYuVcdrtvxohhhbAIUQS2g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fv9yezTq7vA2wYo9wSCpnrwQCpXOu+h593GRKyhpSgwp6equxTlEo8hEztquHYarpJh9M0Sgvv4DU0exla1BDbVDALb3DlMP1Va6x7wKlHSiozUcAWpT8s7HIZpcB8lMyGpQYI7ys8NnZhBpZTyOtjss+jkSlU+FvRYwH8Q12VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7k3+39j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7k3+39j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F911F00A3F;
	Mon, 31 Aug 2026 18:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788200460;
	bh=8O2sVMGwSjOzZiiPxpvwjG2gPn5hIPlaEF3T6IKN+Jc=;
	h=Subject:From:Date:To;
	b=b7k3+39j95YEaN40+m3zylEPE8jat0cPyWupq4QmhaiUYyJkoNBTbKV/Nnb8KI0Sy
	 FdZ6emihVWAT3f7nFySD6PFp5qzd7l0Q7xYb9yMqvb14ioSX3K11oPNFU3neJxg8dV
	 +qz81OwVmgL8QPviDVuDWLEL5/Gx//5oLOK7spmGsEK5U2kl+bG1EVcZXIOw6D2/UB
	 2bNQiqOrszeib6n3Zng2ljQTkD2I6m/eAq9d4e8tUg0nwcevCVaU8isBWQjPyU9ftw
	 QSRniJRD5J2A9DXgIecXV9BMOVCEsWcbZo0ignWpnbm9CSdmVISJMoa/1Getrb536a
	 7veGfPyi2lsjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1C145392445E;
	Mon, 31 Aug 2026 18:20:05 +0000 (UTC)
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
 <178820040360.700932.449565572648517560.git-patchwork-summary@kernel.org>
Date: Mon, 31 Aug 2026 18:20:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: virtio: drop duplicate completion init
  Submitter: Francesco Valla <francesco@valla.it>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1153890
  Lore link: https://lore.kernel.org/r/20260830-virtio-spi-fix-v1-1-62f486f4acdc@valla.it


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


