Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8BD396585
	for <linux-spi@vger.kernel.org>; Fri, 22 May 2026 07:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779436661; cv=none; b=LoC2fFkUH0UYLJL0XrphBjSBt9oJDorg6+tViLfOpkR5RlHJqzeZ2LwxARn/4Re3W1mNuVjz/NjwJR/RCpRZPPiJdtpYD7ZAucG5zXSdDO8FUEk4TdUuhptFDReDQEu3oXhPT3+ZoQkwghSLq6lwiRCyh2Ve/hsZELkX4KCCLT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779436661; c=relaxed/simple;
	bh=RHSDUOnDi226l9wAMm9KyajlHRHSJCmfBq7CeFwQoec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=GOZUUu+M1MdQdrOyzjsfocXoFdb4lOsS8QJOJR4jt2leLnGMCf3bzsvhJZTJy3vXmabVoPMSlN3b5eGAxZANsWC97JMJ8iRWiOiICT2vJV1xKUf8aFU0LxgiqWlrkBOG+JVew0QxuejaPC+6VlRKNaeeyHgtM8YkW3sYf1Qi/l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXO+f8zV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXO+f8zV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34C9B1F000E9;
	Fri, 22 May 2026 07:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779436659;
	bh=wZVezGDIoHeDJDaySu2t2/9xNFyzIrjj2WBSIl8xCGA=;
	h=Subject:From:Date:To;
	b=KXO+f8zVS647OyUHSJ1mabpeysn9ENf/SHjq5wq4AhPup756a6+uryq9EXhtZa+Ov
	 LaHurGIvdaFOAEuTf+8FLdZW1JyrxJuNh3EgQLLD66AUsCuVCi8sNY20YaAMRqI1Us
	 LvLXdXosYqN9aM3Flfo68cgpjR0iKyRVtBugvZMicMPQP2tvvZOOhorBd1N9UetJLQ
	 koNgAmNpUZQh0JaQ5WjRmQJychH8S3DuNjPC/WpeCE07GC4usaEq1dErfwdyarsxrd
	 hzwXo1hISxobsO0V3pU8jIDAbl/LgBWOIPZnOcmF5e+yjComse3sTRA/5emPPf4RO/
	 nNOzoJRMvarUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0AB83930E52;
	Fri, 22 May 2026 07:57:49 +0000 (UTC)
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
 <177943666832.676578.4274205051533412935.git-patchwork-housekeeping@kernel.org>
Date: Fri, 22 May 2026 07:57:48 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: aspeed: Fix __iomem annotation and VLA parameter (2026-05-22T07:16:19)
  Superseding: [v1] spi: aspeed: Fix __iomem annotation and VLA parameter (2026-05-18T09:57:06):
    [1/2] spi: aspeed: Fix missing __iomem annotation in output transfer path


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

