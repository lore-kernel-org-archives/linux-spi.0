Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938EA3B584A
	for <linux-spi@vger.kernel.org>; Thu,  7 May 2026 09:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778144455; cv=none; b=QaFoKExD5F5y2m2G2KJhTEno6avzpyr11+ab9L5YCWP8PxXc/Z2C1EDFJKzrx/DHdJ7OJLTw75LnjenFokVimv4iO13bv2y8gu+ixdzk+PsbR+i7H/d2k2AYjhvxuV8Fe2+26yAJ3MUp6O7+LmjdD8AP/JnegnO6TuTsRLXD3Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778144455; c=relaxed/simple;
	bh=mN+NSuDJz8WTPeDHBMciQnWPvOWAjrrvQPlb5mz1j9o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ET/8NTqqoXbS63oBc9GPxrJ28pRa5F//YxvNk9TYFsphHfNrcXecT/qDixbFfw2WZOgyIpfOYXy6hRK24+8BWZsH/XYowNn7OBLFDsxcp8opOqW8/IJt/Ag4jkevoS0MARtTBjx8MMqAsWgo4yEP1XeaOIBxcJ96RknP68Vl+pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mF3TjCiS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mF3TjCiS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACEB7C2BCB8;
	Thu,  7 May 2026 09:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778144454;
	bh=mN+NSuDJz8WTPeDHBMciQnWPvOWAjrrvQPlb5mz1j9o=;
	h=Subject:From:Date:To:From;
	b=mF3TjCiSaFvLlooHK8LaNO4ZFuKkVFMtYH/Ll7vx17TU7NSQeu7XypzC0F28zO1Sw
	 1l/YuezADFDky3wU9a4AMwQlg5aqDfZ4e2uxKqyoP5ACBOL0kcLoPRB5jPvBR3DqSW
	 muvnufftVoO3qWmlYP0IIjoqW2fe8R5JrpghA/4ZqJluxSrkeb6BndCdksFHYgAJ/7
	 Q0aPyKOmr01OdFk0wrL6b+fSmpdSdMb23+9IZDipv41+xWqJY+vzoRU6etzJGR4/wC
	 /1RSq5GyK5T8Qei54l0/cSSE1PoX43o63Ipw98rSHouC3DJfgGPo6VO8Y3uJOXcitg
	 vLcpuj8GWAA4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FFA939308CC;
	Thu,  7 May 2026 09:00:05 +0000 (UTC)
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
 <177814440379.3420432.1092617515292892216.git-patchwork-summary@kernel.org>
Date: Thu, 07 May 2026 09:00:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: amlogic-spisg: drop misleading NULL check on exdesc
  Submitter: Stepan Ionichev <sozdayvek@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1090637
  Lore link: https://lore.kernel.org/r/20260506183513.482-1-sozdayvek@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


