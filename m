Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75DB1B5A0
	for <linux-spi@vger.kernel.org>; Wed,  6 Mar 2024 22:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709763631; cv=none; b=t3oNhzD2JSKVE+qe3Fw6OKNusC/O6JFRhZ4zTnA5jLR4bunkN7cBSOVAHdppwh9LP2BVz3yCuwR7knOeVqbk7nP7+OxpWeumdZhTRUpF0+gYJOx/HEDhVnNAw1y5fVFNI3h2zSjaO9XYEAFKBRtEutU4fZelltQySPdBW3mZEIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709763631; c=relaxed/simple;
	bh=Ij/HyoO2gqh6na0v2fv5UX04bz7iBMG31bKFzI17xFs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ifYFB7ZOfwONDGse3auyzC9Ab6TtwRSIjFEAnkUDQhfYZzAgD8dM7Gt4W5zUNbgYSKVt3SPmPrps27Nd5AdqD4VcrcocrBD5/di0LrqbY6dL1lNU6iQnugWtRogAKtuBvskQ6ZnjkH9acL8B+Yrmakkgto0QbTuwb0yOGx+JlU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lG88HcQW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lG88HcQW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3BDC8C433C7;
	Wed,  6 Mar 2024 22:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709763631;
	bh=Ij/HyoO2gqh6na0v2fv5UX04bz7iBMG31bKFzI17xFs=;
	h=Subject:From:Date:To:From;
	b=lG88HcQWR7Lu3uVjTV7HSV3f/lD9Z3Eypy8GjG4EqShV5UGuxaicGQj1F5GO3As06
	 cM+MqpjAuJwVkUyNzK4QXH2TV1y0o6IBdeQSzdfWwMd/6nOb4rR3Hc9JwmHSrqrjFX
	 F7/AxAXKI3qDVRXQOo+sA7cKRjebDVGaID8aXVUXM3ki7sw71tENegufybs1Pl+Ttp
	 xqyu/RemR2/Lz1QTyqvmyofIeNG85cbqmJoYwMPhWai/50ahOf0e0XEyV2Eu6GzUA0
	 bYxFRpIc2G2Wt6LUnzKSOSIRYtBQ1bRG99Lc4Ukn5u8I1IENVkdFAa/pomVu6KeppQ
	 0Lgr8DvOK0yMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C423D9A4B6;
	Wed,  6 Mar 2024 22:20:31 +0000 (UTC)
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
 <170976363105.30198.15731633334456302085.git-patchwork-summary@kernel.org>
Date: Wed, 06 Mar 2024 22:20:31 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: cs42l43: Don't limit native CS to the first chip select
  Submitter: Charles Keepax <ckeepax@opensource.cirrus.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=833048
  Lore link: https://lore.kernel.org/r/20240306161004.2205113-1-ckeepax@opensource.cirrus.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


