Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046B435893
	for <linux-spi@vger.kernel.org>; Thu, 11 Jun 2026 00:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781139462; cv=none; b=o9/Rwc9OSQEEPoP6QDLEO/iUMrznX1ggGtE4DZI2TK2N9W9NQHaBDIc+7WVqctz+JIrsAYfCrgF6qQC2uWWGlBL3mUjHcVsh+iZtop5tNLePurMZBVzOqNB8VptY0nxU/erYPW9arYYL1Nfe9+z/ptoWCO4Z0vYgYVNkLyKN+Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781139462; c=relaxed/simple;
	bh=9ARrAl0HJHHl3XWx7fysf3HNM0t4oPvm5UKAbtN2N2o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=N0WG+C8WXmHU7ekUTKyaEtLI81KXS1KL1796rWWPAVz/LyUE6BnQ5HCYLPw/e/E1YOMb2f726MuowLboLP6wLzLq67uI0Ni8nm3eHlVmER2PicVpvCn4WL4P/mrKMIshRyTa/E12eyhk84BUxGiDJ3JWCYhFTKhIV0lMHshbfbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJ7bI0+D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJ7bI0+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864641F00893;
	Thu, 11 Jun 2026 00:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781139461;
	bh=vY/5l/KCI9DfiYs6kOiNnPzuhCVT9Jly56H1/S39ngs=;
	h=Subject:From:Date:To;
	b=hJ7bI0+D2kQxviIus2BmXjZlMI7bTQYVUrNi/pSc37UdVjxvtOM/u+rpOL7e6jG6b
	 o2pdSWI/ljgt3z84BlZMkUNK1eLQ3wzs2JQXW1VHGodxPmeTfXdk17R9rO3YwBk+3T
	 bHhkMMUHSDbWZ1tQ5/hT9JPeh3IGktO29FK3375TnDPS4oljW5JJO30zjyRapE6epf
	 2I+ibUoe45VMJNSHcLRmPW2Qdqx9epYZaBp2pHrFzFnV/v0zq2iZxD19Vytm4EZmsz
	 ko7bhdbde4RhQz42/CcCrBBjnBtrhaBUObiRXj/D/BO7sQ4N0bvyI1RBHaI0N1Ostn
	 1EHrh7CUxDIXw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 593753930E00;
	Thu, 11 Jun 2026 00:57:40 +0000 (UTC)
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
 <178113945890.3694600.5665379830261761761.git-patchwork-housekeeping@kernel.org>
Date: Thu, 11 Jun 2026 00:57:38 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] Documentation: spi: add SPDX license identifier (2026-06-11T00:32:41)
  Superseding: [v1] Documentation: spi: add SPDX license identifier (2026-06-11T00:15:02):
    Documentation: spi: add SPDX license identifier


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

