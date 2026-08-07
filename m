Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EDD314A73
	for <linux-spi@vger.kernel.org>; Fri,  7 Aug 2026 16:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786121935; cv=none; b=PFkjY6z3t7bBeHdPtu29vo2R06tjqwH6OGRVKaB3pqondI4l41Kg6JaBXxHayBrolIupmDypbZWZVy9zhBLOSK8IQY5uT3k/u1r9qJaFcCJPT0LnZ/W3sj5x5wNQ+cEgPBGivK/WAXV5PrsletXFbOPAn9gt7SWpOnL9zb3QgfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786121935; c=relaxed/simple;
	bh=Z9ETvtCh3dtU6ktY65f+rrPHUhBgORsBKWocXd7vX/I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=VKgZa6x1t9qKvIqvGKqBC5ZPNGnANldPB/0RHSoKGa1iYrpuoGZBlM0ifaiMQQ+nY5d6heCI5bSSeG+9K15xnWfqVbHIp0IUX6xVpe5bXWMp6rvf4ym73ewF00zS2vxkq3CFFtghHXbO5qW/tsYBnjIWRoDWE2voHA8SUbycw4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnDWcqha; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnDWcqha"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7408A1F000E9;
	Fri,  7 Aug 2026 16:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786121934;
	bh=YKIaJsmaJvyleuItjvjJ4AZM30AEYib1KtkbVr0wFsM=;
	h=Subject:From:Date:To;
	b=cnDWcqha8PXe0AO1nOQ+AX+uOTACzyN/FMozGwIOlO7YoSwnBauBtyfpx5U5VwKlF
	 04fUsxKk66bMo1md6EJbqcrrjyaBLGNXJYwsEy9qP+O4XKqkvVCYq77JPZmH30vPh+
	 V8BaKQfntk+vXcRnSjarMevhNG61hlUgN4SyMx9f7g1is5Oi+fC93JSSEkl67VeR2B
	 IKYS13wZ9fWYyQkofbFOGq7ksO8eh8ak6K5/uc8AzVkc5DJbT7E3CqBAvcgQfkX1Zb
	 HMosJEkyFHXUTKylTKiLENnrnvNjE4kvOUVHWRdm/TLDBT4KP7Hg1wILXNJwqQUi6L
	 EjGP7zYE9w9gA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56998380CEE3;
	Fri,  7 Aug 2026 16:58:14 +0000 (UTC)
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
 <178612189284.1896333.15107234121788750093.git-patchwork-housekeeping@kernel.org>
Date: Fri, 07 Aug 2026 16:58:12 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Add quad mode support for QPIC SNAND (2026-08-07T16:03:54)
  Superseding: [v1] Add quad mode support for QPIC SNAND (2026-07-16T05:27:44):
    [1/3] spi: spi-qpic-snand: move command mapping helper
    [2/3] spi: spi-qpic-snand: add quad mode support
    [3/3] spi: spi-qpic-snand: Handle Macronix quad read opcode 0x6b


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

