Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00341F5EA
	for <linux-spi@vger.kernel.org>; Tue,  7 Apr 2026 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583026; cv=none; b=MHEjiTZ94WbfjadXtEvF1zvLIBTTnISTnuLfQ/MbFHekOX5PHzo/OfyxjPsDT+aifMH04nbUl9TdUEzpVmta+GcyPksZEgMQQ7A0La/Df03frfZJU2ZsP38IFLxcJVRCZvpakusvL7uI+c+e/S/225niiIoU+ofZhw7vWR8gj3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583026; c=relaxed/simple;
	bh=NtnL+EVJnQTZaK0zk+1IspbpR4aJuVtvRZFEZCr9z9Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=jxUX+RI/ZRvuINgmGeMAKtOWQWT/K0KTUokl/yFhIEdorwZQiU8ngr5AV+ThFA7bO6dMXzs1R366WIFW+5Jvw3UzG/D4W5paW96ofcuMMSxubxB8TwWJQ1a4YvlkiCA8FOqTKJkT6RaJW877mIIvDXteWMSEqRzjW4Rumv3xjXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ol/Wgy37; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ol/Wgy37"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8221AC116C6;
	Tue,  7 Apr 2026 17:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775583026;
	bh=NtnL+EVJnQTZaK0zk+1IspbpR4aJuVtvRZFEZCr9z9Q=;
	h=Subject:From:Date:To:From;
	b=ol/Wgy37NLjK2uPtwuJYSwZ7hVKFJLlsx2kIGADwog2CWdcAkQTAbAcEg5pH3JWZb
	 2ijj3R2CMo7HGychiUq0L/Vm/NPGQctKACbqu2nD3VOwX435ZjVxY2AMoaleaQEGd+
	 AXhybcdT/ZRYCuEJybHRJkQf/zMaxPKjjoREPhJH0+d+0MQ2tHv45v5EgR/53GUMsv
	 t9NoyksVx5CTKPUl7WKQUlVAkp+pGZmSW55xbo2p1jFZodO2XP853sIsPGYJ/hPGaa
	 +M5WOuZcG+vyryOg5KISCxfarfEWx2kBnQANfIdgFT9ASuOgkEOusPp4LB4K/Mryhn
	 dcsR6Pm2qPt0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4341E3809A31;
	Tue,  7 Apr 2026 17:30:05 +0000 (UTC)
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
 <177558300373.4084611.3789890169350264899.git-patchwork-summary@kernel.org>
Date: Tue, 07 Apr 2026 17:30:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: MAINTAINERS: Update AMD SPI driver maintainers
  Submitter: Raju Rangoju <Raju.Rangoju@amd.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1077604
  Lore link: https://lore.kernel.org/r/20260406091042.4065767-1-Raju.Rangoju@amd.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


