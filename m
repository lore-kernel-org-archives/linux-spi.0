Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0AB26AF4
	for <linux-spi@vger.kernel.org>; Thu,  7 May 2026 01:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778117454; cv=none; b=s0RVZAAbrx07JmRJ9XMVoNp/CF7k+ySXpcIT2P2GRLx8r2Ik8jEdeIH52jqA6jz3q+xXdXXLsi7CnIsR/Ttsj/GCG/j2PPKqnnRfxzfH9dRrBh5hu8eFjN5WtZeb7uPbKGOEwbU/NP3SpZnEpr6DOlxkIxwOIp2qEPUrNJkIUTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778117454; c=relaxed/simple;
	bh=lyECjFF+kshdaO5XbPBttNHGi8JattUfjFnvZn36/uQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=U1IL76WdEdq6nJSpoV7PhNyN/3M5eGcWCUU85m7qofV6OLhtRsPhFQoF2HGSk5hudotqET2hHX21Tb/i6/VyFDkl6z7N6CwIaXi4cRNP4k4tdBBuIuRaS2yg2UbFZ+bxcQpSBO4TqcbeSUzg2LEfP6KxQvEFr1ZVvuO5YAzHsY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eT3ezoOb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eT3ezoOb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC0AC2BCB0;
	Thu,  7 May 2026 01:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778117454;
	bh=lyECjFF+kshdaO5XbPBttNHGi8JattUfjFnvZn36/uQ=;
	h=Subject:From:Date:To:From;
	b=eT3ezoObyBcxPuikO2ujlVlJPYehhBV74jMU+Z5kZ2+ACKs5rZDKwzvUvz6ZP39ER
	 5nYLdtJ1zs4LnFRGPYygHvX+cCuzta+J5H4mnaP5bZnnnFkgw180YKsAnUPlUb0KJI
	 kghx+xghMAQpK5DiVWww8KzTD+g3kP7+tZTz0O0E+AazBnahE3aPezRkou7HUMty4c
	 s/EkGS8b5NmWBfTX+zPtBF4kwyG9VBq621TGNELJYepxxiZtZrwsidiV//EDmMGXXi
	 gqKEUQb5bFKqcj6OkF+IskHV7FV03HLkNSdxODvyoc7Ec6kMAb3NmzrXZS5LzKlQzX
	 vYdmeHcW0yzNA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BCC27393089F;
	Thu,  7 May 2026 01:30:04 +0000 (UTC)
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
 <177811740343.3291094.14519647501947748380.git-patchwork-summary@kernel.org>
Date: Thu, 07 May 2026 01:30:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: ch341: correct company name in MODULE_DESCRIPTION
  Submitter: Jiawei Liu <ljw@wch.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1090273
  Lore link: https://lore.kernel.org/r/20260506062412.371034-1-ljw@wch.cn


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


