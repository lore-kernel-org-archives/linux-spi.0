Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D3737702C
	for <linux-spi@vger.kernel.org>; Tue, 22 Sep 2026 08:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790064687; cv=none; b=hJGVhYlSqpha95GXBLcJ4EAdVwkiXJxFEcD+OQJNroPeCzjTEyJXsPEuvSPD2A2+srMYCyGjk2wysAhKkAAugTl2f5zMebipERbnw6w5nV50SU9gD4HJa2sBYDH24YD6xT03Ybx3Qdm35yyQN2yrvD775z/mBAmKehzMPmbpuok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790064687; c=relaxed/simple;
	bh=Ty76AJS5owJnYexy5quGeGbEKJvCaV7dCSHAbPxkol8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=RKkDAfUPpm+g0Eqy3YJdsTtwg3hsSN0IKR+8lizNDxeUdGo3OnVSWJmFyAa0Jl6SLYa/VYgwJKdanZoxA/XDjRk2Nqvwu6qzBwwussF+C4YqB+WG8KY6rlGbMNzrcaSyXz/oY0l1yCUjXmzFOTQeUK+8j8eHUV8w078rARf+wtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1WcYZwa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1WcYZwa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19BD61F00898;
	Tue, 22 Sep 2026 08:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790064676;
	bh=icScWwagvsdwMHEAIhoxI8XesexBZ+UFiu8ziLxCV/o=;
	h=Subject:From:Date:To;
	b=C1WcYZwabjY/1Gpa3PNrjY+ehXILd8zsQTAGgVOF+9bZmrN2c211mmjvmS7Vk6z6Y
	 HRvwiOZRWD9XZ/Vf8RDArRsDGlb5AAOmazV+p9qE+XgSbZRpj44StV6UB3/SuHtPae
	 AAiPYcz2IwOIJdTzG/ifWvFQv6wZSHY9atvwcZwUlKFF/yUjxOo/6pBo9npCd32tuw
	 9Adh8PDZ1I2aR5Zrr7/fLxjkX3F425ZaGEmj8+5Ph9ZV3HWyF4lJsuY/SUjvKsKr1y
	 b89rWYypbUDVCLDrU90w21mMf4u7AVhbOu2L3YGoIv1YDlfz9+MHjzRfceNUz1/ro9
	 LpA6+bY7nbaIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5928739D5FF4;
	Tue, 22 Sep 2026 08:10:08 +0000 (UTC)
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
 <179006460690.3464476.40007503522083950.git-patchwork-summary@kernel.org>
Date: Tue, 22 Sep 2026 08:10:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: Better specification for rx-sample-delay-ns and core parsing
  Submitter: Frieder Schrempf <frieder@fris.de>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1170258/
  Lore link: https://lore.kernel.org/r/20260921-spi-sample-delay-cleanup-v2-0-b460d572fd32@kontron.de
    Patches: [v2,1/3] spi: dt-bindings: Clarify what rx-sample-delay-ns describes
             [v2,2/3] spi: Parse the rx-sample-delay-ns peripheral property in the core
             [v2,3/3] spi: dw: Use the rx-sample-delay-ns value parsed by the core


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


