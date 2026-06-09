Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C64370D4C
	for <linux-spi@vger.kernel.org>; Tue,  9 Jun 2026 08:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780995493; cv=none; b=eDcttLJjNfD1oZhP4abK2pfUp2WocGZHJE51F8gMqMiCjsGvmyDKzL1SgRDgfdGPCp/B9WbVFJ9pHIsjYrqYpCcObrpWOmm1ClrdvSWmRqhCinYrjyve9LEl0Vuqr6gPHhsK0JcKFmENojt7TznCr8vBYPmk9hR70sO54v70KlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780995493; c=relaxed/simple;
	bh=UrU+HQYCycM4ia8etfY6hOsu1RKB1c+Y0BBruVxZYQ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=oYxGc1zf0xrmCABLsu5i5tih+adj5yzutwpUsv1RETxi7BON2iVQXqYPdyUzVYGDksPJj6clHgynbUXgvfw+U6aLW1b6loN4xpmLWXlJII9/hD3s314IeCHkvK0DqJRe48LRQqhFKg8pswMwLR6z0xGxyPex3mUXgIbQjODx8rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bph0yu/K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bph0yu/K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786A91F00893;
	Tue,  9 Jun 2026 08:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780995492;
	bh=IeMo5WwlweNLnjw+XoNxK6JZ6LHZU0oFE3libC4iDJM=;
	h=Subject:From:Date:To;
	b=Bph0yu/KrptU8RR5ajYHweqgANFgP8GbjffVpI0EjMKlBlM72wx1Xp35Pku7W+GD/
	 Pb3dhOV2SqlI5wylowsgQ93/6tqQShz3L3Srb+lHr9WKOdeXkl84RQ3VwHF/RfI1g6
	 T2iSUZPXf9s7n3i+jn/R2tFwsJ7w52WSZ6E3veErTFgSYbkkQ2DutdK6p9YdnwU7qZ
	 HFIEEBNlffN2WwVSGFx9lKFohC7sV9lmPMRIS0/k+SYQ9jamFy/fWpQjk1T8DX5B9E
	 5zn0hQYvQ/Glr1NbIUWhlWugYWE+YaUJ1DDMjkKv+wvG22pFUMmFYvh8D7UUrBy5qT
	 4COjaCespILJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 35B3A39301B9;
	Tue,  9 Jun 2026 08:58:12 +0000 (UTC)
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
 <178099549078.1893704.2673626986342867752.git-patchwork-housekeeping@kernel.org>
Date: Tue, 09 Jun 2026 08:58:10 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: qcom-geni: Fix cs_change handling on the last transfer (2026-06-09T08:43:09)
  Superseding: [v1] spi: qcom-geni: Fix cs_change handling on the last transfer (2026-05-28T19:03:08):
    [v1] spi: qcom-geni: Fix cs_change handling on the last transfer


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

