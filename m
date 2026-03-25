Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F7623EA94
	for <linux-spi@vger.kernel.org>; Wed, 25 Mar 2026 13:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774446016; cv=none; b=Vf3KwVgvJP6mOay9AXNu/wNrTFU6FGe+fqg/JZaEA9sgPHVAsPDRo29JJ/R3kmJt/9FqbnRUXaneTXdlXWKZy/egxD4vmgTqRZ5EebRMe8E9hqNVSMcBmJLnzsaw7YfLeARNQgXsYo5so6f3oSnZo3QZRu/hiwVN5ewF44Wkqtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774446016; c=relaxed/simple;
	bh=qSleT+AxEbAKe5DWZttG/Yxag3d2bMqxzP5S0MDXbzM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mxlY6oilSdfbmxrtWZ6dRG1AerhsdWCASLhfk5R3b925q9R6uTXs1iUP6lWBPF1LLOXuPUHH/8OBp0Ur2/8FupcuLsxWtNuJsAps/QlRcOieyx3H9f4p/73BMehUWjXVolJcSMF9R5cBRpz3l8uIYIaWoww4WX0/moaqWcJVJ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NiWk/rTs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NiWk/rTs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D392FC4CEF7;
	Wed, 25 Mar 2026 13:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774446015;
	bh=qSleT+AxEbAKe5DWZttG/Yxag3d2bMqxzP5S0MDXbzM=;
	h=Subject:From:Date:To:From;
	b=NiWk/rTsEyQMN20eNvSeiSAFE6HBG5SCav3Y3zHcmVVEFYFcMiS5t8zCyJuQCN0E1
	 Etq/hlRngweBeJooAPv8USNXKQO6nL6ZR1foMHizoYwSbLIJtTm1CiC0HRe8DaADp4
	 9Hf8wK95bPPaXngnEq0TuZgLWfrRx8ZzAxvBgUD4bmSl+8P/Tk7uQRXd07TcKd55Eo
	 ZM8WVZILXM8xVnPsfLvXs3V+qRW6sjlDtnX29HXnXtAoK99nN7iSzEa+Do3ftXvg1l
	 Qzb6dj6oIvJNRf6BWkZisJ7j0mqBo5mweE/sqbDrmmWgLfXrlrFrVElomSa4S98SFg
	 OK37wqCF5/GSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 429A13808205;
	Wed, 25 Mar 2026 13:40:04 +0000 (UTC)
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
 <177444600284.1626099.12578138473826387040.git-patchwork-summary@kernel.org>
Date: Wed, 25 Mar 2026 13:40:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: pxa2xx: update outdated reference to pump_transfers()
  Submitter: Kexin Sun <kexinsun@smail.nju.edu.cn>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1070294
  Lore link: https://lore.kernel.org/r/20260321105945.8224-1-kexinsun@smail.nju.edu.cn


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


