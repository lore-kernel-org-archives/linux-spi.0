Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE573BD225
	for <linux-spi@vger.kernel.org>; Thu, 13 Aug 2026 12:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786624743; cv=none; b=bEZDggyKm53pXIegZTbejp27nbw7ung8BU1gS+aI3tCVtePoOpEuLoV6Zeht4Kf+7ld2NJl94GeiFQQEos9/3/lI9Lc6W2Pr6Up55uiOX82rrhPOq4s0wgBen6v1OYjpmylyJFYiB6FdJbCMKROe3sjBbd1GI+acdiUd7V1oE/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786624743; c=relaxed/simple;
	bh=j+lFCbKOYd9H1yFvddTNPExSEdnzXU1BxHinp+KMOOk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=ouWNrkQSAD/K3/BQHKWcH4BFt3ssJbj5n8REqXRSXb/aFAvFJg1Hi+UkGfRtN6f5hm1N1t08E4dzny7ySia6xAWQ1olEXCt2b/dTnZVWuYMQnFBKkCNtXSaPFHsI6oPXh8w9FoD8ycnP7gYJ4H9ZSEjF1hbEm8nBGgmTdkbbPgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ko4Rd8h2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ko4Rd8h2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 040171F000E9;
	Thu, 13 Aug 2026 12:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786624742;
	bh=bmgg5mwrF1do6XDE+o850dnQ1PtoHit4GYd3DPXQ7bg=;
	h=Subject:From:Date:To;
	b=ko4Rd8h2xdvTJOCqb0dQEJ3hWear/3cG63f8pSxIcWh8qOI71jDVguf7ypT3uNs4T
	 AqHcS0p8te+5lIHKWSCzL5ibdmsa4NdozAfCZ/05ah70AhfW4hqt/k+DjagY1/zatZ
	 v1W7X6Ej/pGnEvKMM4wqpEJNaptC82UDipoQC/tXHv5IQgOIgGTtRSh22nUbnYyIAG
	 ustaP63nE5giCHi60AUlAn6HMGuwKT9el7G17q4vAn3IO+7iZQyu0crxdl8gaQ5F1D
	 iAVxL567nwxshQvQLiQjYT8kniNIsEOPFXS+HoBKAJAckNPjwF8uftgbfDtckUGB2Q
	 R1YQdCrhi78Tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 010DF380CFE6;
	Thu, 13 Aug 2026 12:38:17 +0000 (UTC)
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
 <178662469659.2410029.15414615133860540146.git-patchwork-summary@kernel.org>
Date: Thu, 13 Aug 2026 12:38:16 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: img-spfi: don't disable runtime PM on DMA deferred probe
  Submitter: Felix Gu <ustc.gu@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1142366
  Lore link: https://lore.kernel.org/r/20260808-spfi-v1-1-6bc4345be430@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


