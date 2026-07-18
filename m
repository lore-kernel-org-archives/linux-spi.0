Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC2E1E2834
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784390335; cv=none; b=OXQBJHn5ddxoKF7J1XZsgFFtvVdC7w+aJP/OOUm6DMMgmP2s0PpbF4aVDzt1dcinI3IYWUZpkWWHNxsYfOEIpgEO8Pxomc9IjjiyhkhJ/laoZcrQc4tc6lUAI9vC7JlYJIpCVVG9ZIfj0pVVxX1F1ACcx9ky0Vm5mBGCZUg+VP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784390335; c=relaxed/simple;
	bh=GY7/2yazm2T7Fkzpbzk7Iff6sR6ZSjCo1p1oZ51+c7Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=I8zDbBWcyyRmvDIKMYl9xXh+wQYLYaCRKvekID87yNxfTKJM6iBQWN/ZgRo0l5fE+swAYCYqHSkkP4jequEAkUL95Rak2dVWm6OXq0jksrx29jPy/xD4fBhGLlUmkS+BeNfI/4UvlUshjn6eaWgN1uISbpWPPvDD6XutkDBwnEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci+O6Rv/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci+O6Rv/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBA61F000E9;
	Sat, 18 Jul 2026 15:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784390325;
	bh=9e6zjh0ewe1dfJBNQ1JfJtdU+ipDnnM801kdypE4uNw=;
	h=Subject:From:Date:To;
	b=ci+O6Rv/pd+2t613zkLWmxNW4OId7MLv+2xOi3Iq/S59GcIzPOkoLM/3fwEoXk9Ey
	 K06y3dAaM+4eXIi24VyF4RkQoLvy9WBbPkYcN22UlDtC3jH1WB04riNUA76bFd38yd
	 WDbT0e7zSmd3/YXLvLfHGG7IWheL1e3bY7kQCxiYUvqtbYUJJMNYNKvE9Qvyy8zd0N
	 BpaJPYwtYxwrc3IpoeR74YCqgHhVr2X3IY1Crd6QJiyb0jLWYRfF9Oq2XkoeD2i2Qy
	 7/0r+KWpl1YKx2R5XrsU6l85pJTENVvqxH6kBarOErP2MnaQlZv2lmrmQzg8c2/YdK
	 DQA8fcdWBFaQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199D23811977;
	Sat, 18 Jul 2026 15:58:18 +0000 (UTC)
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
 <178439029664.2525926.12455056905192690678.git-patchwork-housekeeping@kernel.org>
Date: Sat, 18 Jul 2026 15:58:16 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v13] spi: pxa2xx: MacBook8,1 quirk, runtime PM, and LPSS S3 resume state fixes (2026-07-18T15:32:48)
  Superseding: [v12] spi: pxa2xx: MacBook8,1 quirk, runtime PM, and LPSS S3 resume state fixes (2026-07-18T14:52:06):
    [v12,1/3] spi: pxa2xx: disable DMA for Apple MacBook8,1
    [v12,2/3] spi: pxa2xx: fix runtime PM and interrupt handling in PIO mode
    [v12,3/3] spi: pxa2xx: restore LPSS private register state on S3 resume


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

