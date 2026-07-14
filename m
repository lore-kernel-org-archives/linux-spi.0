Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BC535AC3E
	for <linux-spi@vger.kernel.org>; Tue, 14 Jul 2026 10:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026746; cv=none; b=nYX4HuEZKkdrY+psbSivdskZkqgLPC6JQZfF5gyHPi1dt9fYFl1Clb37OUGUd4eYGV+l1ozDNksyOPEjzpbC3jhMSu9dmiTdOrPFK8qQafoYaBaGJ5sOex1dvdZ6htc19fPQkEbVOJ/OIwvDnTKWSD4OUSs4Tu8UGcqbS4oW1D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026746; c=relaxed/simple;
	bh=8Xpz0lTYwH0IbIXeqf16B0b5eXBMlim1NUA3hbNBeo4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=UP6QhKG+5QRx/UAd330qgf8+uUFREVo59UpehMzTUU0rM67VHv78ZL1taLpXtEoNrEszKLaeyQvny4wWaQffwTqH1n3BX7D+SgLcCbeiAeGCeWXH9FcuISVmnVsPQ0H1dWoFNMopwhJ8P50HNtmVZjgdx8q09rnks3vycQ2PB1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzLqPZp+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzLqPZp+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E1101F000E9;
	Tue, 14 Jul 2026 10:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784026745;
	bh=9AW/Zn2DyB50XqPYepdA4suMGIr7wFWzslGZ7kIfmic=;
	h=Subject:From:Date:To;
	b=WzLqPZp+aR2//HKVJ+JNY9S6SrjFf2vi1FimciSH9/B895E/1Ihts77CWuIPjYRTC
	 PAHhumF03enDbf94iBxk6413g/hQnKa1V8PkMPI/5msy3ly3s3hfsCxlwiCYGUaJUA
	 ANtXXAymQlF72nmRqiGl1QuNeXWl7gnQnGhx0eNWfxrS+8B493I7ndPmplI03Yl7Ew
	 GAb/cMgtn35UGpQzXlzW7iJFD+UL6RKyANLpGV6y5quJ0ckWKfFsDyHdYEf2XwiRi6
	 wuqZ7SBF+I+/TOOjVfSa+yxqYniO5exf03vkUeeK+1EExYH6hx6M84WqxnNNck03uh
	 gih9nEK90bxeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4845739250DF;
	Tue, 14 Jul 2026 10:58:41 +0000 (UTC)
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
 <178402671985.3093630.2473489448973711736.git-patchwork-housekeeping@kernel.org>
Date: Tue, 14 Jul 2026 10:58:39 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] spi: add new_device/delete_device sysfs interface (2026-07-14T10:09:43)
  Superseding: [v5] spi: add new_device/delete_device sysfs interface (2026-05-17T20:16:00):
    [v5,1/2] spi: add new_device/delete_device sysfs interface
    [v5,2/2] docs: spi: add documentation for userspace device instantiation


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

