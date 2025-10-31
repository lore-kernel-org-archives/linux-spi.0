Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104B12868B0
	for <linux-spi@vger.kernel.org>; Fri, 31 Oct 2025 07:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761897444; cv=none; b=n9oPuKTlYRlOie/vxzbNdOKd526ZtYktMd5XTkS6JCrnoDviZIsAiguZwdrYj024K3cCiH4MeC2JWutqOub4X8rIHqXe+bgYJjBxRRT2WmFwXfbKl6AUe0+HWctgr5eJwBiPcm3OEtitU/G5Ikv9RVShe9MVN/eL3DAA83b248M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761897444; c=relaxed/simple;
	bh=9ujpE9r4/7/MblHOi56Jo+QszGZ+ARAS/+TbZpfwLyc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=hAvcMFiP6E2flIplP0XcE7Ay/Aukp8xYqGj4MgoEaqO1FqRm05DtfD8g/KDddxF4+SBP5hJQgx168RWsN6flUVb0hYN6W+MIYlaqC6Tj53gbWhv6D5qz2GGHLN06MoEd8/eNMNKyaK0aB4VH0uHmtvsI3vzI4t4VgyYliyW8neI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HH/NcGYP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HH/NcGYP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927E4C4CEE7;
	Fri, 31 Oct 2025 07:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761897443;
	bh=9ujpE9r4/7/MblHOi56Jo+QszGZ+ARAS/+TbZpfwLyc=;
	h=Subject:From:Date:To:From;
	b=HH/NcGYPqiCVtdCqAnS/FfeaTW7LsnDT+zgki84Rw7trIHbmRlgDWjvmrRXF+YavE
	 4t3jhv84ofATCvsMMjWYuYM+13oKUJQa9lrQ/Q49MI+3mfthmBcz3mKCxcbbNNjUpC
	 4D0/S4WifJB8fzt4gk1qVXzDOxkFvSosC0GSNFzAu1Vn9zjX6B4UJPD/vy/PaM6vIX
	 LGuyXG2dwqRQFH0PTKNkFRDGD2XxDsW0rKxe0sQhOuR3NDXPxpv3DoDNjmnTh2qZBM
	 2/kszaV4ru00v7NWvDG1trExA5btiRFM2uOrYRFSYscynWmIj7EamOqVp0Xxg4b26E
	 igyxVFFjpPntw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EE3FB3A78ACB;
	Fri, 31 Oct 2025 07:57:00 +0000 (UTC)
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
 <176189741955.4178051.17947654753143836534.git-patchwork-housekeeping@kernel.org>
Date: Fri, 31 Oct 2025 07:56:59 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v3] spi-cadence: support transmission with bits_per_word of 16 and 32 (2025-10-31T07:30:00)
  Superseding: [v2] spi-cadence: support transmission with bits_per_word of 16 and 32 (2025-10-27T08:42:37):
    [v2,1/3] arm64: dts: cix: add a compatible string for the cix sky1 SoC
    [v2,2/3] dt-bindings: spi: spi-cadence: update DT binding docs to support cix sky1 SoC
    [v2,3/3] spi: spi-cadence: supports transmission with bits_per_word of 16 and 32


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

