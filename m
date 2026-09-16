Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1BA4BA1DA
	for <linux-spi@vger.kernel.org>; Wed, 16 Sep 2026 10:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554090; cv=none; b=Ywp6tTAnQeoyM0kfY9TlpOt2RqQVm10LgbvLJMR5+vXSUXqOBqOMNGM9uE7LUjJMsK8oaProYuQ1uIArWJ6QsBvv6BYHKynCUfT2ZCQnMWa8CnfFeU1rS0tzFf73hEVaAiBcCsCG2HVfbXLPMPPdhCZ7qFTHccUsmjYifbZCFPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554090; c=relaxed/simple;
	bh=+TDJa5qy+rye2CZuH3+5Uj+LEYmaLPS4d3ugYj8J8J0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=RfW0ad6wi1qqwRzxijXbN+leSiT8mBwDHIf3owreyfIFjpgDKjR3eP91i0sa/mVplzmIurA5sN5A8PCphwTo9cmCnOUPpr8ypmm5wbu/Ebpe6QtSCTEepOOQKqMagZnAgqUe4TPL72vHTxVkSoRpUReEGt9CZQI59RBY1+RM/Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0mc1LC0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0mc1LC0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5031F0089E;
	Wed, 16 Sep 2026 10:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789554071;
	bh=mqHq7EKI4c7kivHq9yjFM+ftsFQigNrgJa1HE3SHy9M=;
	h=Subject:From:Date:To;
	b=C0mc1LC0d87mJmATU8AZVYGsowpdE2JZIYNmvL6iCtLwDmoizFYn6kAgmGAS/2WH9
	 +9cMvlwBVl7OAZLO2fjRrWQawqWfTTdNr9Co32LxHiULqzya+XKMj6Jy8qQz7CsS8a
	 Gt6yxAb4+IHjNm0eCIW547I9XbtNuTIgHJQ6H+zR4CxyeElz/uaaMjmsweIAkUuRJ4
	 q24BE4UbWMshiCA67czgQu4SCX7XJkSwVxcx1rF0CTXnFcRWb0fwP+coIwDFfYOGw3
	 bPjxeimOlZFShsgYy+OMdaixXcVTJxBZYBmLXTKj9F2aVj49uNpekv0Rz2rHnxM8Wp
	 DjaiuWVNfNX+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 58F4539D5FE8;
	Wed, 16 Sep 2026 10:20:06 +0000 (UTC)
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
 <178955400497.2542028.9934046195129524982.git-patchwork-summary@kernel.org>
Date: Wed, 16 Sep 2026 10:20:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: virtio: Use the per-transfer bits per word
  Submitter: Hao-Qun Huang <alvinhuang0603@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1163597/
  Lore link: https://lore.kernel.org/r/20260913032049.11209.alvinhuang0603@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


