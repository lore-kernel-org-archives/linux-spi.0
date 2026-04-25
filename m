Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB09345734
	for <linux-spi@vger.kernel.org>; Sat, 25 Apr 2026 17:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777139921; cv=none; b=IIOOgIiu3XwNFY4O5c+dp/UhRpRDguQgGoJd5uemQCpX3MDA0Qun1l+iwRDlJMOmNqpJDtAqKqsacy0caXzLodqdjCUflJpv3mpcTZf1MRe5x/JTqSFlQKNFnptfX04Ve42Tx8M38PykvHHDnbapG9m4XsSgQCCruPRmluFexoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777139921; c=relaxed/simple;
	bh=SmzmQmOrOhxb14F0k4Qd+Be1KoobypUHqrwvoNk8Ass=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=haq7HyGKRTtakpWbo4ieCr4kspMmeR0SKEhsUCft3/uAElr1QRuoV0G8l14/lcd0tqctJ/xN9rJSNx22ZoYoA4QZTrRaE0pUnBabVDwkBNSnge9MiAGkbl20pdokHIvM9dGqoYDpF/vU2Es0bjrCJB45Fqnat2ER6QDa0nI766U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=feadL0Tw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="feadL0Tw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D16DC2BCB0;
	Sat, 25 Apr 2026 17:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777139921;
	bh=SmzmQmOrOhxb14F0k4Qd+Be1KoobypUHqrwvoNk8Ass=;
	h=Subject:From:Date:To:From;
	b=feadL0Tw8DW4QWv2y6IdEGgO2i/hmKPD3hOBfkfNEBsxmHxfRPqcNN36M7ce3OfcM
	 cI72tZwqR8i0VFEdSIELiCX93nRy5GjYWrF9ETOzoHdfQjII5s6/HsS4qfsHWQESj8
	 5iUjUksftkwaSIesHSmQDPuVBttWMyJ+9MnJcSl27eYr0In7dxyeFdknqLNiQclIj1
	 UlHLsiefJcuSVjA71ZXQOg/e1DS1S+FR2rYfEYhygRA/kesCXj1tDfX9PfvmQS09TZ
	 1xC5RSxSIqXfe7OJaMCwdmPKqeQbYGOcek1RUa5Nqs+xroiS5dXQ/LrsVYW9mGQB0M
	 2tZ0iu5zfyDEA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD6D38119CB;
	Sat, 25 Apr 2026 17:58:02 +0000 (UTC)
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
 <177713988086.2027581.1155384034918580327.git-patchwork-housekeeping@kernel.org>
Date: Sat, 25 Apr 2026 17:58:00 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: add sysfs interface for userspace device instantiation (2026-04-25T17:34:25)
  Superseding: [v1] spi: add sysfs interface for userspace device instantiation (2026-04-20T03:14:15):
    [1/2] spi: add new_device/delete_device sysfs interface
    [2/2] docs: spi: add documentation for userspace device instantiation


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

