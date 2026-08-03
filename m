Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4323CBE79
	for <linux-spi@vger.kernel.org>; Mon,  3 Aug 2026 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785755077; cv=none; b=tiHzTMGMyp29IZi1gLQChyuuUh3kUcX+u1BTGE2VJI4MmdgZ+7LNY/Va2vtCr+mYepk7b/rLmBkWSoHZ+4SWy3u7R/R1gDgjp2mFdglLOXbWWk4iY8PNV3svk5jJ05Oy61FRAgK6nsEjE5LUyaX3cTjI7w5m0jFlZZl3ptyEhnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785755077; c=relaxed/simple;
	bh=nPKuqCjbkGmpV3UJ4IwuQiCNF8F3S0osXcSXwFi0BmA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Xk+6bhVCgZX9pOP+zeN+F2LeQjc0nLPazMXnPAR8rYt8sLoAeYXLCSvxWuSaHbsqQrfvDWrpvXPaW373UB6UrnnCdN5sXDlJcj6AHEC5madzqsrTNgvKlF3LYqClb0x7Lvmg1tAz+6hgza0XoeLCXtICoQx+H1MPmYBpKFWzPM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OF2VvK56; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OF2VvK56"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91B01F00A3E;
	Mon,  3 Aug 2026 11:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785755073;
	bh=d3BoLLLdOx1jJODZAjMk26Upxvu6ib0xIIxPongPmKU=;
	h=Subject:From:Date:To;
	b=OF2VvK562MkTWDbgTao+M5AK90bTslJrJqV/Lk+YMQkdV8jIfKUnnmlTn7U/jA1bz
	 ZjlqjodBDtnq6hhSktm5CUbcnP/As8a2p8sel7Na8P5yoh1OwYzT8ZkKdYA3l/6Ua9
	 xEzplJMLSYuHyw/A+QNW6cOk87nF7XbhfgDyhN/uPHYBG/Gh0U5RQhYZmrFXm//5Jg
	 pqSBU+YqWfK6ujk9iWg4XMh7TrPf8PhFhAm9idDLIxRVPVY2IlYubUzu4z0JmNkbWl
	 DxlgEQZ1xTWIZDt0aiC+To34/d3Lx+mIjf5V5mmVcs5O7tR8dNTgMMbqVejmJM/7LN
	 hM7Cxl5nbXR3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A0E380A952;
	Mon,  3 Aug 2026 11:03:56 +0000 (UTC)
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
 <178575503500.2150518.6550368505307136455.git-patchwork-housekeeping@kernel.org>
Date: Mon, 03 Aug 2026 11:03:55 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v9] spi: add new_device/delete_device sysfs interface (2026-08-03T10:46:12)
  Superseding: [v8] spi: add new_device/delete_device sysfs interface (2026-07-28T19:10:54):
    [v8,1/2] spi: add new_device/delete_device sysfs interface
    [v8,2/2] docs: spi: add documentation for userspace device instantiation


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

