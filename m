Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22B529994B
	for <linux-spi@vger.kernel.org>; Mon,  4 May 2026 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777881507; cv=none; b=m1cjVkYLB9lmhS0FakpMixUX3bACwqs/KjVjqiYJl9ra5/6Rz1wNiLbr2PA6v68G+7jHwLgXXjKd9wexry2jV+QLFZxkuiO/lGuSfcIwGKydnys08GwLwOIoQwH2RjzXCpByqn/b/9GO8JbIoCNtCMXDmVrlFQnhu434wVyD9Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777881507; c=relaxed/simple;
	bh=FwukZiixd5sIwPqdRyblqclDZ7wR6zVXpahnT+SB6iw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=mdvC2DbhTfxBlipKHRS0zmi8rPXg2MDKSWj/wSokCuQEhnZSuzP35i2qPooFh8WJbYWUwBiaAJ5hP33X80jRH41ibv6W1CL57WCELRogScN4BlzxeZ1OJRaF4knN0im+1TmKchEmnVIyUvh9H1hJZMsB/zM9X+CbRjU5uUsM/0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DO/Ax/jx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DO/Ax/jx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D81C2BCB9;
	Mon,  4 May 2026 07:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777881507;
	bh=FwukZiixd5sIwPqdRyblqclDZ7wR6zVXpahnT+SB6iw=;
	h=Subject:From:Date:To:From;
	b=DO/Ax/jxRkdbamEpm14H88Ti717jK5u5liG61gdptcsm0/KAZcYOeA86HJ7BbzB0X
	 7AwEpUFV/y25Tcnd6jKF9fWlJlPKV9QTcwQt/riwLPWesem5YDBanBFM2WuQmpeUxe
	 bF4QROpssTIG/d/FIs78DbuYkgw2ufqhKmxyZF3/2CYH2CaKtlnTqJGaz9SsWG5jJ3
	 AS4N5CY0E0TO76BzBgSNzyg4KAJPMJHIOKWtaMEXF3MdPIoJy97j0b59isTdCKvpOr
	 hYs+4vCmV/b7Ee3tUbo5fSPu4ZLvS1mG7f7c1tfnHtc14bsfqz6rn5PHejSFdmBvVB
	 qgCNfEfIj0ZuA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA442392FFE2;
	Mon,  4 May 2026 07:57:39 +0000 (UTC)
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
 <177788145845.596416.7138984236605834345.git-patchwork-housekeeping@kernel.org>
Date: Mon, 04 May 2026 07:57:38 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: add sysfs interface for userspace device instantiation (2026-05-04T07:40:35)
  Superseding: [v2] spi: add sysfs interface for userspace device instantiation (2026-04-25T17:34:25):
    [v2,1/2] spi: add new_device/delete_device sysfs interface
    [v2,2/2] docs: spi: add documentation for userspace device instantiation


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

