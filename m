Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E3E390981
	for <linux-spi@vger.kernel.org>; Thu, 11 Jun 2026 06:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161075; cv=none; b=E8LSj3WGTwcHScgWg0sSeNfZLZHxKPOmC8pJkrU/ZiWseTBj0aTHSTwKCVEnWDiLFblVYEUMFI/HOVOjf7tlOem7Te+KjeCUsBA6Efk77f+mYlcFXQowV7ayvZNqhJpbjYMZhMabbnJfpwhR6K0iTntAIdQHZAzhCs1nvOsbd2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161075; c=relaxed/simple;
	bh=3qWiKfGCx9HQgh6pKA5R9/ZY2M6UFcm5BfndztKgtoE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kg5U+7ulQ6yX3w/j93cFpHooFye0197dBR85hGrEVlMcV34aqE81Dm2wRy6UQoCdvsfju/NIEzoScE0JAuNTa6Y6+m2tCGIPamMZh2yKzD2SkSjftkGGg8o/kLDBSPV6iMqsqjZ3Xc42n8U/bimidJpNs6+/5niPn/eCZqUSq3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyAYcDxq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyAYcDxq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95F2C1F00893;
	Thu, 11 Jun 2026 06:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781161072;
	bh=a3hUMJUX2/JND2qMkWw3kjWFuBf9V/D0etpn/rqWhzc=;
	h=Subject:From:Date:To;
	b=KyAYcDxqWa44k0iSCOsCQAOwh88N9oa6w07tEsogdXMDVrWhB5Orz9IAaX5EXRvNy
	 A0Ud4wRWDFBCK9vGesYaOwVFmUiiUS8ckJ1ZUkAbIahjCw0ZG3dEXubQB1+343A3rE
	 X76p0Csiy0C7YjKkWbxuGpVQ618AFmRPnxKhcFoT11IkpoqPkYnXk+9TOwVSsW6vlI
	 xBla2ku9JxWNmXAml2HADkEbmNkJGxThR12dulTqm5a9FO+QZxwdawZ/jv+Png+Nid
	 kl7GSJiFA76PSwJQOtVCiCNBu2V5hEMwbwNBZC9/mOGqWQ2MD4BnsbnRUq/2GbYw/R
	 H+hO190XqN1zg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AE73930E11;
	Thu, 11 Jun 2026 06:57:51 +0000 (UTC)
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
 <178116106992.3792234.15727616399247034039.git-patchwork-housekeeping@kernel.org>
Date: Thu, 11 Jun 2026 06:57:49 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: cadence-quadspi: fix unclocked access on unbind (2026-06-11T06:37:19)
  Superseding: [v1] spi: cadence-quadspi: fix unclocked access on unbind (2026-06-10T02:08:09):
    [6.12.y] spi: cadence-quadspi: fix unclocked access on unbind


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

