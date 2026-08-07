Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5C1472F89
	for <linux-spi@vger.kernel.org>; Fri,  7 Aug 2026 11:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786103957; cv=none; b=FhJwG7XJah1ktbOckBVYY9Fd6lfNtlVmjOuzd/2QpEWnomjNUm59AfZF3cQHsCqMvfmhC7BE4ZScHtYwicoYDIuoNmmykN0X/9mY6Rm0rVgnOtkG/Fyn4WdszInUULCQC9y2uD25NzFx8PDGcrCyU67kgIzMAhb24phA0kKrlZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786103957; c=relaxed/simple;
	bh=nvgpC02ByaDBWewhVHHLSeNvwhIOkPs3XtTzY39EmP0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=twjg6X6ft6WZ0IFEa4lqErS524UtMktKP3IeeHb/ojrVaFNFb0r7dyqvoez9e22eOcoMeu8xZshbs5Cjsmv90b8ZcYwVcBoaOOk1abCFLklW8fDHoBpm6DA1bJr9VSn6VBX7sQzcbRSaV4CNkQYq39jwflC7QWDfB46NX+NWywo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XVqVMlvo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XVqVMlvo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F251F000E9;
	Fri,  7 Aug 2026 11:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786103942;
	bh=ruaLpn00E3v+Oqx7kXM4juYtofCy687kMRM/F2iMKZg=;
	h=Subject:From:Date:To;
	b=XVqVMlvoh3fQdwLsEg/35J0yko4u+ELcX6wTWfSqrIfdfLVz1HY46brc7vm7cMR/r
	 5zflHeOitANgAofL8gxUum/X2TD+xyjczsjfq7Bh/uU/ipRc97nabVxmLl+9WQuO6J
	 dB7uEftmBsAzeoNSR46lCpMQXVYoVRLTKGLKcmpL4xXR8I8etSP2psr7A+lHLw2Q26
	 irmk/6lH/WmRFjDMHWXDaw5gFL8AAkPbYYNUb+8yE32LP2+F8CypzmSCM3NQsTSeiK
	 tGQLR+ROy3NO1wjesPTksS8hBqtkpoBJHk+mSPw91payujEcz+5r/nQLa5VQCBHUiC
	 3hnAIrD4EXAyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1BFA5380AA6A;
	Fri,  7 Aug 2026 11:58:22 +0000 (UTC)
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
 <178610390053.1761897.16104262668827872750.git-patchwork-housekeeping@kernel.org>
Date: Fri, 07 Aug 2026 11:58:20 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: cadence-quadspi: fix probe error path and remove (2026-08-07T11:49:20)
  Superseding: [v1] spi: cadence-quadspi: fix probe error path and remove (2026-07-31T10:53:45):
    [1/2] spi: cadence-quadspi: fix runtime pm cleanup on probe failure/unbind
    [2/2] spi: cadence-quadspi: release DMA channel on probe failure


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

