Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1E17262E
	for <linux-spi@vger.kernel.org>; Mon, 20 Jul 2026 00:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784509099; cv=none; b=a1QWxy2hR0pPUp5R9EWBJRzauO9vvEFx26RCe5sqpLzAtdNw5KcrI25Adm3JWqBmBUcvxSNuDJdZ2umqn6BalsGKS12kitH3akq1qEMlZhwMV50sf1pdYN1UIOkV4ZrnU/b7gB/DeNDcheH0doX1xbQhsAcJFcqDhPhHrlHOBeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784509099; c=relaxed/simple;
	bh=yQB+C3Fm1KiSEHlJtQVmBPRLBT9YxJU8bW1NpVaf8Ek=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ukG5rwwICoP3DEaE4U0EQ8Qa3R0I+cTfdL0zNBxhiliD93Wwezmj+ccUWlvP7tXxlLyFVqXj0iebCkdgk+GUIyW/mNE03UpnVehUhrJQwVzTkQ03jVTA7YCxovTQhwuDq/J06ys8hsNdNPd7RJdcDfAuF0tGCxEL1lHoo37mF4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNXiydst; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNXiydst"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEB021F000E9;
	Mon, 20 Jul 2026 00:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784509097;
	bh=45KqlXSiD0fKP31uQfwgOet8YCnZQiwFqbZ7wQJCskM=;
	h=Subject:From:Date:To;
	b=VNXiydstDxm8kkd6GGWNwwV8VoBtU1JlFssisCcw1Ej7zPH8UWIdO1zm1moDL9Hd8
	 bjBLXimiYYoVrzl70uo3n0LC2LUIiA/HaiNWleprfu0W3737IunRRhsagllW2CYGPA
	 qujccR9A3wALqthn9CN5+KfxbLyroiy+jlG3mlixjk6/GAVb0QUfISjC7c7wXwbRR6
	 lqjtgF1GCRy1dEi+9rZyeRuxoOWzop9ErBll+JwQtSaWoUTBJxkSggPQYWvQs8W/tX
	 v8V5gKHgZ2bdox+dhaX2UzodEzMI2oxrcR3J0m1WFQZgqPsJSPiMc4/qvmVVcxS850
	 46DOU+EnlI7yQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9673438119D2;
	Mon, 20 Jul 2026 00:57:49 +0000 (UTC)
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
 <178450906808.3293379.10878312706609133302.git-patchwork-housekeeping@kernel.org>
Date: Mon, 20 Jul 2026 00:57:48 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: ppc4xx: devm-ify probe and drop manual resource management (2026-07-20T00:30:43)
  Superseding: [v1] spi: ppc4xx: devm-ify probe and drop manual resource management (2026-06-28T23:16:22):
    spi: ppc4xx: devm-ify probe and drop manual resource management


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

