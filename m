Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A7D3FE356
	for <linux-spi@vger.kernel.org>; Thu, 12 Mar 2026 17:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773337218; cv=none; b=q2mKfFZET9HKdV53oo8xM3VS1FuN9EiuSsmIQt2S/z2VMCIzZ7zVi7vHtLdZXINRXa439h7t9z5DnWhGcKnxW3hZdzfRF2MHprTa8Y2B/A4qEm3VYmptajCwyhd1az82tKtplBjDf1VdwDyWT59eWt6m4gL27u0HXqtlUnPHUsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773337218; c=relaxed/simple;
	bh=te9rdEQ+o5kQGx7eMpvygfiBYdiPV6FhiZNSQHpVEbY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=DJL0UqKyLOdVTcU/2xqQkCKnccFyhu5SZi79CZGHPDdFXzug5XcjnNJnWlk2xzcq9PwrWHHUFQzDmb0HL7jB09lURHHGv2C0Ld/NaVVh9teUj3UuszDYXny2F30EYjlnzGycQ+sxrfl+guEYZN07Z9sDuIpFROj9ynrtSNz31cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lzA0xQlv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lzA0xQlv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3846AC4CEF7;
	Thu, 12 Mar 2026 17:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773337218;
	bh=te9rdEQ+o5kQGx7eMpvygfiBYdiPV6FhiZNSQHpVEbY=;
	h=Subject:From:Date:To:From;
	b=lzA0xQlvLHQ5m/EO9x3SbGjuOc8bkfo1e/koW/9h2H5ukzphxhufcLL+z3qWPh+aD
	 zn7XyWpvK0PGLab55t+M/9SS5eA91lcdjiLhkDydmlDqWF5l+Madod7Jqe5R2EKnhN
	 6BFTYN1VvqxD+tSCJtxeGvYzCK4j/gN+hKdJYlKBucU2nq1BviWDdoZyCZeWuJ+3/U
	 eq1cGVzolh8gY4sjRxd/OATjdJPX7hqyXcESJ0z0UWN/Njr7C3Z8bIvUuzMBweHmqR
	 FF+e/FhRQvyGck2Nf8kpk5yp1DiGTuB+60vAAsqxozZTV+Wn3X0tjtQ/Zbo6SgpEqm
	 hi1Uejyln3bag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BCD223808200;
	Thu, 12 Mar 2026 17:40:14 +0000 (UTC)
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
 <177333721345.16162.9740032162037790029.git-patchwork-summary@kernel.org>
Date: Thu, 12 Mar 2026 17:40:13 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v3] spi: atcspi200: fix mutex initialization order
  Submitter: Pei Xiao <xiaopei01@kylinos.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1065361
  Lore link: https://lore.kernel.org/r/15a71241affc25108a97d40d9d3dd1bc3d2d69ed.1773282905.git.xiaopei01@kylinos.cn


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


