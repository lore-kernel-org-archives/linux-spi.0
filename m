Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547CF3D75D7
	for <linux-spi@vger.kernel.org>; Thu, 18 Jun 2026 18:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781809062; cv=none; b=c7GWaV2pa1aakOJPRhPHY2LAMoYzghMfiLAo6d4sFnw9rGZi+F47D89ZRlUHsAYRv+d9cbwbrcZdg0lV84g9iI0FUxm7pKbv9fPtSVrebw5Hs1Vzvn47sin8tWsoEvrTABxId6ZBE7eYt+e7JRjc1HCiM+xw66btkQW5tp1jO9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781809062; c=relaxed/simple;
	bh=k/r34RgWES531nxJmH4etfK2WmQl7Vi8AozDyZWyXt4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=gnQfFwFaIRm2c3dlpXV/ugV/3vaP1/HRjppSLspqQA6SJhnAJfIirL8SuxA5exSw4F0GnXHmw3WCdJvksEGh9L2YpyDCUVCtlVWQdFEQ9DD4DcLa/NhMPixmST5q56p9GBr6zUe006gZcQY6XbWDzG5gIz8Zhq369JSdSQ44Vvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APn9plNG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APn9plNG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3C71F000E9;
	Thu, 18 Jun 2026 18:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781809061;
	bh=qs1KALErFmvP6vrg2EMC9+MMnRLcCa4tQ6FJwwqNIBM=;
	h=Subject:From:Date:To;
	b=APn9plNGtNBtADAnUalZ7jDzQcMgzJaxbjFrPblLVgK3/9HfH6QT1JDwd8FOEY3Pr
	 7lJ70ycIx2aFp27ueKxx1ZBTzVvzMdRiHlIXcws4KwMYWY74jAqVzMtm9ywj6kDU9l
	 00jAqXhFsPfdUhNIhQlrljlvzYIsvkcqHnCuXz5OoDc8qwZRKBj1JAlbddqO3sbRKg
	 9p4PVRCSBkj55b3TlKMDc/8TzFSR0s2Y1lOccOYfq8a8rx3n0OlL+Tu4RK3ZbyIRLf
	 CD9yiNt/dRYG+zsdBXkIkLbFkG5j2efRpz72/x1rwUzRUHcoOErHg/9cJhLxuAtUEd
	 TFOtA6AoPoXeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 962053A5675A;
	Thu, 18 Jun 2026 18:57:35 +0000 (UTC)
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
 <178180905419.3028509.11603823592005008413.git-patchwork-housekeeping@kernel.org>
Date: Thu, 18 Jun 2026 18:57:34 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi: dt-bindings: octeon: Convert to DT schema (2026-06-18T18:01:49)
  Superseding: [v2] spi: dt-bindings: octeon: Convert to DT schema (2026-06-13T19:22:33):
    [v2] spi: dt-bindings: octeon: Convert to DT schema


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

