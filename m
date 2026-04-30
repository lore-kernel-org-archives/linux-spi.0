Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3773BB5A
	for <linux-spi@vger.kernel.org>; Thu, 30 Apr 2026 04:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777522849; cv=none; b=UNk5plY+gBaQfRvkeTk920/acpgR7CXdeGe4ODK9oWpPBAAUrmXuflMg3cvOjBLytmFoJPtBUSvHu97pozDQkf+R45tsXBmKHeql3Hii02Pghu2+awetS16yYI7Xr/GZvSmTcAxIPnvBN+36nsP5mzbjpa/J9Bsw6l+8HZ/nyn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777522849; c=relaxed/simple;
	bh=iY1G37ebjQcvBQ/iJ+Ie2IzpJJSyE6ddNv6xdQrBCZc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=YBPtw1jXlHvs+lZGy9cUH8264O9FbrG4qAu+aW8V2Sz9O6JJ4ga+qTUaFHU4wDTuYGnukPByS26JQSauG8TqAa5QQ/XOkX3daVlt7lyyJT0VoSDVhyfIBcHOHBnENF9LLKz9WMk/BBrLAqWy7UQ54imbb0Z/myp9/Dafc3LDgu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZF9S6dSK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZF9S6dSK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B02C2BCB8;
	Thu, 30 Apr 2026 04:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777522849;
	bh=iY1G37ebjQcvBQ/iJ+Ie2IzpJJSyE6ddNv6xdQrBCZc=;
	h=Subject:From:Date:To:From;
	b=ZF9S6dSKYjcjLYiRkpRgp+EBqRrNaAeMFpH4JG410CildyiM67nZgvm9qVdRsl2O6
	 nXNnsd8X4BJ8JVraWLpBAVQoULEd4HhgPetx+X7/wbqUox4nPHvott06F/ftPCj3qH
	 +35HeL/1M+ej9YXUHFrbijGnvvsyOooGFtr5H4/SYlDNunzTP7vPlgu8vHgyd8JoxV
	 F5wnISIrQT3Z5NIQnzeQOPp9fEV1EyfV6dEkhoDJlIanx8uZOMuSkjtG7pGTQroPXv
	 2tJ6hd0akeBhXc/vQJ0Pd6ugG3AyVv1kMAqoeSgd4p6jallswqAQj//5sKPyfdrAkB
	 QJEa/Uch1HRFg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7F7A23809A07;
	Thu, 30 Apr 2026 04:20:05 +0000 (UTC)
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
 <177752280404.2347954.8810470802342497675.git-patchwork-summary@kernel.org>
Date: Thu, 30 Apr 2026 04:20:04 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: clean up controller registration return value
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1087352
  Lore link: https://lore.kernel.org/r/20260429092301.166375-1-johan@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


