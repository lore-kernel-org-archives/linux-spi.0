Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE233B42E3
	for <linux-spi@vger.kernel.org>; Wed, 29 Jul 2026 15:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340735; cv=none; b=JOU4FcCEvamNpzl3q/9UiFk4SuNfwOBvTfIq/sgopc38kgc/ZKwLXv1O/kyahHJk2Ih0cdtPJOHx8U5oNyRO1IXmSuXGhDYuZ/G25DvIA5vVt/UrfosjcHWYqVHXxaO70/gYnTwOvhaAyeqrtBsmZVCPbgGoUTO5w2a7ffFklGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340735; c=relaxed/simple;
	bh=FBnZi7EUo/fMcU+q5i4oYBk/HrKsuC9ajvxHMibE7xE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=klaHABOSrK9Rjnm3mZOu3SemR9H7T1vTMSMM7yOvmo2Ganzmx+K8koATs1u5iDlug53R/ZnxIZFWpDynRVcK6Lt/vxUJpzYzFyDOlTlFjdRurH4Czho3v+zj+Libq/H6jMNQbDVl09IJoscJ+xaVZWA+BHMR5+vOUQuyj9Y0A60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ql2c7iAf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ql2c7iAf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68EC91F000E9;
	Wed, 29 Jul 2026 15:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785340733;
	bh=QCl4j3YJeOGKT23RuNZQE/j95fRpdiuU4FxPv8zIVIQ=;
	h=Subject:From:Date:To;
	b=Ql2c7iAfgeknh4hjQ5yOjSnl6eB/RrETHcUvDi8RRilQcaNW9KBbssD1stVapIt2R
	 Vg9+AcH6BrCSyuBU/gdPlODf4/zbomrx1LpwkhovTMTSD2spFRMiuMynvw+7UxCobj
	 Q+3rhcLf5uhdvglqLDRaY24zSlmQ3EgA86LV4Ccnkv31pzWbYAR74SJ0bRS4JyY/yp
	 7E8YxoTyu5JUmbZBBHBTD2H4kkwHKhSVt0+3mqX9qT1yGVBTwVZ/bsvD0F81j6wNTQ
	 d3xpgKVyMauVI0arpG7w81HiBGgBlfU1M6++hQ7LJChzP12alUEMKwyLfnQ6Z01LTv
	 MTz0vHMlSCnXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B3439253CF;
	Wed, 29 Jul 2026 15:58:18 +0000 (UTC)
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
 <178534069725.3142056.3893398165019086439.git-patchwork-housekeeping@kernel.org>
Date: Wed, 29 Jul 2026 15:58:17 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] Add trace event support for GENI SE registers dump (2026-07-29T15:13:24)
  Superseding: [v3] Add trace event support for GENI SE registers dump (2026-07-15T05:20:46):
    [v3,1/2] soc: qcom: geni-se: trace: Add trace event support for GENI SE registers dump
    [v3,2/2] spi: qcom-geni: add GENI SE registers trace event on error paths


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

