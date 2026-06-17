Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058F748164F
	for <linux-spi@vger.kernel.org>; Wed, 17 Jun 2026 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709611; cv=none; b=DuVCzCu/rF+PDa7kmCsAafRTG65rUbNqWwaLqz+rgcRdGXduWdaFCwS5i2F8KNJdz3EUs2PsuRRZHPKi1n514r5MJEpq5Wb6NBX7qxET1IScVLsdiwQXqB9AejPItObx3pBS5sHLmoYp7OtSbM79kH1nZbFqRE2k08YT0+nKnxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709611; c=relaxed/simple;
	bh=+JibUYnDWTY+bIYxaWcsTdzVa5kVR5X9b5hIzkVSaBs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=hufucCl41QPxHh1Ua+3LgHWAIDfrHNX+oLUozRz0ASBjhxKWbGn0Ikhsjsf0/przDPivh5PaxO40BR2eSkHDTx6YNHmH4pKE5Gw63TA9lgjVxFRy813iLKWY6C2UaRvUBKxQE0OgqIFMXoueOJJay5enRcypC6MxPMjIjTlAEVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHOhpruG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHOhpruG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16E21F000E9;
	Wed, 17 Jun 2026 15:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781709609;
	bh=SZ7+nrwr+q/SXoROEu1lrJjTns5G3Y2DusoSsxFNsXs=;
	h=Subject:From:Date:To;
	b=cHOhpruGboFS9PIbK+9PqCuh6hsdkMDFwby+rFDFM3nwHzo1o6n5BlsdPf+lqS62b
	 o1Hyi2AGjFL8+EB1u5PipiSKRS9R1nKOal403R+rDiAjyYKrBO/vYPkhvldeW7BJT0
	 b04ZVOp5l6BujiXIKUjzdeDFMb2bJr88JBdi3Q5gmJA7JT5Fbf8nQVgNLhSKArm235
	 KY4xkhq8+SFPLmlVlCs/ToAnFiISZDWZlpagZMUb9tTeiaM+0rU9CfDzVAfvS+44W9
	 iedUmdicDI6NEy1ez3Fm9GbOink4jZRiAS9QM5f288/Z6PdhsDHMp/DKrFYyXmWelB
	 DtQ8DJgXJEhPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D35083930E4E;
	Wed, 17 Jun 2026 15:20:04 +0000 (UTC)
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
 <178170960371.1661381.8167544559254696058.git-patchwork-summary@kernel.org>
Date: Wed, 17 Jun 2026 15:20:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: [v1,1/1] spi: acpi: Free resource list at appropriate time
  Submitter: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1112801
  Lore link: https://lore.kernel.org/r/20260617092406.2649384-1-andriy.shevchenko@linux.intel.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


