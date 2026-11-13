Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794609005;
	b=1dCVyaDlSVfdiYKumrRyv7tgq6MXfMESHjZq2yb0pLfjXGhAmamOK/3R9fhhIg+Ta2YZ
	 CqKLkxwyKfenR+zDW2vRoy6q/PyQgt85mgrbVulaKVb5TWXp/GeABG5JxRzAazk+DzMHP
	 jL9bd6zYI459Ap5nwq7YYpJ4H9xz6IvwKoqrXrUien9p0PxoSNg4AJ5E1tw585ruz+IwS
	 mY8OVIpgvwjS2Ph5mO96yMCw43PUuiLKTyACuU9NOsljc33mycm07DLExLi+iO1YspnId
	 esTS7Xy+jUXneZeQHt4tydkHlo+bfR5nH/BANGBrsDFxSUBQOWjJUFRadErVAf3fqeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794609005;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=qmEfHe8br4bDWl2G8wGcMOOFZ0B/U3gDslOPhy/+6ME=;
	b=jsw8YV9MbRCVJ4WGZNf5TVcQZvtpexSwjwUwoUnlwkiUpBRfoG5YAxqapsQN8lsG0O7V
	 iQFzDPW2izXybbOE2RCOHWvKT6h/NQR5zt02lEzNAhAPeraJOUGkSolQdLpY0OlLl6ANx
	 odLNwT0TVN1ybeJMlVN7sJvke0exAkOv6jIWjJsuKzL2pEcYVzWxJtcVgDpkhnkXmSyRi
	 v4eRRj/sb5vVNeiZlbLh3H5jXqlOA3I7R27dvzSfhswibY71lf/egoMm3miWeQ2cFn9wQ
	 q+wGW3r6SITHLx2hKPzNN6+KsMgNMJ+IX1og13AgnnFcskJtiGP5Smr4DLBC7+CU3zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kf9Ilnha;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21FE606A88B
	for <linux-spi@vger.kernel.org>; Fri, 13 Nov 2026 22:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kf9Ilnha
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627AC1F000C4;
	Fri, 13 Nov 2026 22:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794609005;
	bh=qmEfHe8br4bDWl2G8wGcMOOFZ0B/U3gDslOPhy/+6ME=;
	h=Subject:From:Date:To;
	b=Kf9Ilnha/QtNIffI8hZGqR6W5RoK9L+J+TEA5yS5hLq1b1KRfMFQ70WrkFwc2xHEq
	 7DsW3qJV2nr66GGzOefymaxkiIEIzh9uaOR5EjDUlVjcX57vwdL+A99gOETg5by+bQ
	 ZRLqjsQt9HZd+xp4oLSpHmgHjN2KErn8xqurabaT32CKFSSRsLSbHdviTFtgtqoNLB
	 VmGQ1CzeR+poziyGUuXXwbmVUW9BDqDGWlBzUjnXwKOm2jYtTZKBm1h6mGKyjEaVxL
	 PZ+TEOMeSMFSJ/VRiWnahRDykU6OZQ+rQQLqYkJBVwRIHAzOtFaTmBhXCBDJnLKCJP
	 uhZXlJGwwXRAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3CA8F380821F;
	Fri, 13 Nov 2026 22:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179460900399.1874822.11063486426590843579.git-patchwork-summary@kernel.org>
Date: Fri, 13 Nov 2026 22:30:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: axi-spi-engine: Start the program length at zero
  Submitter: Kees Cook <kees@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1210200/
  Lore link: https://lore.kernel.org/r/20261113065508.i.606-kees@kernel.org


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


