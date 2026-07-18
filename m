Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F2F233955
	for <linux-spi@vger.kernel.org>; Sat, 18 Jul 2026 01:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784339915; cv=none; b=RItguqTvgw1IB6SrS7z/Pg/JVlIr3AtJCNHb+YSe/7QjVO9URDeIU+DkR86hvuY+Lcx9IP7VTydQteollCxWWd1IjvqY/Wfjim4p/KgsR/QvxzWGWCykwdCIte0iNA0ex4orXy7x+/T6oF38iUI2CHu+GKfJkbZUhvMYcAoop/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784339915; c=relaxed/simple;
	bh=oI2F/hkeONWsQa+tsuuNSHi2ZtxGRveMsx4k1YxOgtI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=eb9+w6D/WbbHsJvv2vXyy39OoASQeSu5PK7RYOVazUoPI3JT12StLwgZlwjowLsrsuIpf4X2CohZze43fYMLXhPWJYGQlioE4PrVPSTa/rcoqDMExY8KDODkZCXzqaMthhdxado6u0KOdiUU/s3f2XsalGAywCjsTdsjZ6u+GoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoDhzpwM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoDhzpwM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971011F000E9;
	Sat, 18 Jul 2026 01:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784339914;
	bh=q3ODlVrbX0mf73maWl3VZ/frMBpnOF5dQbWoezO9DU0=;
	h=Subject:From:Date:To;
	b=RoDhzpwMFzLAfwl+RxQlKwDL/1szXdF62SU+HxryIC7SvRf0P53f365MXURNNrKB9
	 WrFA1dClV1lZMD0DW3vNmjWQpHbUlqEFb6jqWkQj+cjJYDs81ewCGPjyw4nguKGFRN
	 7bmDt+Q/tNApzpreh81TAgAWDejNqX4BEhw6mDzzajBB7UPKmon6j0Wc2hJFL6ao//
	 Ly9J+xj8j+MTIiKgHE8Tjrz5oaeZdyGsnoWBEOHYYbDeabPsTJgGdZsnLW1DS/ZcA3
	 U5LwhB/JU7RgB7jeSEUry2IRJT4BPpusNyx8SKw29E3WKnXx2W5JQOeF/Ph3Ml4b8D
	 paX8HDuJ6pJKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D37603810936;
	Sat, 18 Jul 2026 01:58:07 +0000 (UTC)
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
 <178433988650.2369964.6945626382419505909.git-patchwork-housekeeping@kernel.org>
Date: Sat, 18 Jul 2026 01:58:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v6] spi: pxa2xx: MacBook8,1 quirk and LPSS S3 resume state fixes (2026-07-18T01:24:29)
  Superseding: [v5] spi: pxa2xx: MacBook8,1 quirk and LPSS S3 resume state fixes (2026-07-18T00:38:19):
    [v5,1/2] spi: pxa2xx: disable DMA and fix runtime PM for Apple MacBook8,1
    [v5,2/2] spi: pxa2xx: restore LPSS private register state on S3 resume


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

