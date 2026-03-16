Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A4330ACE3
	for <linux-spi@vger.kernel.org>; Mon, 16 Mar 2026 02:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773627010; cv=none; b=J5Ri/mpSEpNvjdWttW1fryCZxl9gNIC3H+k3I2kRFYfHQC87VU2sjhwlWNv0s0n7tjzaIPNAk5dqoZz9nskSgNVVrX2Ud6QcA6zFmxdto9riSwNkw95Dc17HIu8e5biGwr4ghoLXvoUSwjrVeMPhYXYjTvGLCGqqyJVqhp9PA+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773627010; c=relaxed/simple;
	bh=AEbjAzeKR18FNSrrk3mKf1BcIF/JJ18nxqp1knl5XsI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=s5EyRMTz2OuiBD8obCiLoyBX1YZMORuXYS7cHqGrsdmKZaUwe4R/lsRlGFppZJ9nYaXidz11m9U5Wa66iWS4hse4Q0oD2Z/SWFCCfHYATgGjnaABzlfdYvHtFDWa2WN50OizimoyXRnf08KhTVBLM2LIDrjwuzh7KGrMYcenhDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsAenQ91; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsAenQ91"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5B4AC4CEF7;
	Mon, 16 Mar 2026 02:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773627009;
	bh=AEbjAzeKR18FNSrrk3mKf1BcIF/JJ18nxqp1knl5XsI=;
	h=Subject:From:Date:To:From;
	b=NsAenQ91CfNXmiZaVC6RcK+jYo+xczi3izKO2MkVOSA/oCgcyxU2HMcsXVBCObYqK
	 meIVOPpJwXmsASMYUexLyJSV5fik/uEy/wOgR4JEaXlKoA6PixkboMlKaEIbMpYUFW
	 q/VPgRba1pquk1adEw0Cc9hx4YrzmEgNbw6datuyNV5PC1rUxiDGXkPOEzO2wyqv5u
	 TtQGIjUPEv1fzikr/3EF08VjloDnd5S464kuiN0iYGQCzmb6Ya0yOmyvJ5xNPcXO5Y
	 TTS7lWSS44IHZ+QMhtg8dNfQXrf4KUXp7xqyHS0t7yb2d1qVtAmHjZcZ1qcmRXdb6G
	 DOlhYfz17lFzA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 42C633808200;
	Mon, 16 Mar 2026 02:10:04 +0000 (UTC)
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
 <177362700290.2462110.16657360244361081644.git-patchwork-summary@kernel.org>
Date: Mon, 16 Mar 2026 02:10:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: amlogic-spisg: Use IS_ERR() instead of IS_ERR_OR_NULL()
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1063181
  Lore link: https://lore.kernel.org/r/20260308-spisg-1-v1-1-4e209faf228d@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


