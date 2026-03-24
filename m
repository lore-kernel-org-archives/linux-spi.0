Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874C91F936
	for <linux-spi@vger.kernel.org>; Tue, 24 Mar 2026 00:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774311016; cv=none; b=p1TI1zIZDu17wpKHFiTPqh+mQyDultXyDwCIlPtrOx2VKEEIwPOdHgdJaJMO600blCT4EDpSLPyVuLlTcrumRNmUmqHcNZ3zu69UYlFj5Rh0k7nBVcKWlnbo9Wol+Y2MXWmW9NaXwltSd+dciLMlkJJ3p3j8unnKaEJvAyrOdR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774311016; c=relaxed/simple;
	bh=w3pOoBiUdaRcWhB8yTI+1e4SMRsEcrtAhldesba20Ek=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=e99jM4PYdEwV1Mv/+L7+hxdU6uio8izWsBYemOGNEiCR6cPMNWKf/5aRwutOH5vz2WGyordoytlorchJ7u28OwqKUheVR5cdHs3p+u1F42/tpA9/tuhFFgQLEzS6ctmfxFlnQi5ajr0HuUJULbSlOpOOqdQcW5+FmNfMXutZBAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nljICdxG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nljICdxG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C69DC4CEF7;
	Tue, 24 Mar 2026 00:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774311016;
	bh=w3pOoBiUdaRcWhB8yTI+1e4SMRsEcrtAhldesba20Ek=;
	h=Subject:From:Date:To:From;
	b=nljICdxGMnapkxXJ1XWyIlWZueM9lce9M0iEoSNjF2nscfqAhZ8BkaoFB3vS/T/yQ
	 w9hyipm9+m6896C8zfaw5FvxonAGUcHlkBwY1VKP2oVkoMTdG1CfiACPkRBpNBsRds
	 eGM+ZlRtLIzSfdYtcNg5vdCFqoWspXl595o6OEpYIdkUgFxSPb2QDlrXeoTkoa6rKc
	 wY9wKb/GR8gVecLNroElr0fBowtdTksifN49KB0DFOILgWfQoFESk5BoLXC0um4w+v
	 sca7pk+JHHsvkpJrz4bp68JdHVqlb6xywj0fcPbi76/XtUE8DcPVZo92Cwr1vSMt+F
	 amShHNpz9lifg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7F8C83808200;
	Tue, 24 Mar 2026 00:10:05 +0000 (UTC)
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
 <177431100393.380025.9063278738361245565.git-patchwork-summary@kernel.org>
Date: Tue, 24 Mar 2026 00:10:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi hisi-kunpeng cleanup and fix
  Submitter: Pei Xiao <xiaopei01@kylinos.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1068972
  Lore link: https://lore.kernel.org/r/cover.1773889292.git.xiaopei01@kylinos.cn
    Patches: [1/2] spi: hisi-kunpeng: prevent infinite while() loop in hisi_spi_flush_fifo
             [2/2] spi: hisi-kunpeng: Add timeout warning in FIFO flush function


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


