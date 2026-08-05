Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C925E3E317D
	for <linux-spi@vger.kernel.org>; Wed,  5 Aug 2026 07:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785916743; cv=none; b=DIDNSOpPTGjTX4aXLcnBVYrvcL8OM61TCD7ylIHWm0FzWBwYFKxtdlipvJndohui10D8ljIszYSRYN3vM3IkJg/b4FuDe/6DY3b7T8JHJ6nLKmhzdc06rWFqeo2WUby7VaZ5y0UrDNY9kVOjNnf0JxF9CToi4goDu0yYk3dsYEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785916743; c=relaxed/simple;
	bh=nfKRI9eabeaMSDBZfQD/z7689qYxVFuejDdOZ3yJRdc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=GjqgQ+1hS7prhvDKr6Zh8hGBQGX3EimlnfS7CSdtehYZK7oxpayyEW7o7yrtkx/W1mVExgZw6EFpGd7mii+RMalWWS4oZmJkRRMaC0kajCpoEXIjs3rwsKizfKnKlBTMX5Dd3w/jBknu6vp1suSp7bY2GvQKO2a8242xo+Ff+H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bfea+Y5q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bfea+Y5q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AEA1F000E9;
	Wed,  5 Aug 2026 07:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785916739;
	bh=DnEnTSHJAsAtYyXvEV0V/1//dnyHzURk6acJeMeH1wA=;
	h=Subject:From:Date:To;
	b=Bfea+Y5qT8786yxTfgwwFPMSMIvTwSfdG+UqOXN2Rq/D+TbFpygo0mrJB0dnnBvB6
	 jAbAV+hurG72mnAnIV+2DLbBnBn915sSiQOOCY7ahiTc21sCJlHtDWsP09xoYDLOZx
	 Zl/tbeQfDrwb1In9uDLDU5VI8cwbaMl1OoA+hKMl2omQvJP+6i/gEuC0gyTKNeZVfd
	 7ThRQEcmpPvKhG3u3Rqhv6CvTux+zzWOGK14aMGn+pd0dAImzDPWCj0+m2b4dlo6Om
	 IpYcKxoycds8anBNYHdU9LmA5QJ0hXA+vg7XXAbJ2jvdj9bd6vOWvysbZICeAdzahW
	 zAF+GZItUGVgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D33833927057;
	Wed,  5 Aug 2026 07:58:20 +0000 (UTC)
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
 <178591669940.3981333.1810262001155624680.git-patchwork-housekeeping@kernel.org>
Date: Wed, 05 Aug 2026 07:58:19 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v8] iio: dac: Add support for AD5529R DAC (2026-08-05T07:17:40)
  Superseding: [v7] iio: dac: Add support for AD5529R DAC (2026-07-22T07:54:13):
    [v7,1/7] spi: dt-bindings: Add spi-device-addr peripheral property
    [v7,2/7] dt-bindings: iio: adc: microchip,mcp3564: Add spi-device-addr
    [v7,3/7] iio: adc: mcp3564: Add support for spi-device-addr
    [v7,4/7] dt-bindings: iio: adc: microchip,mcp3911: Add spi-device-addr
    [v7,5/7] iio: adc: mcp3911: Add support for spi-device-addr
    [v7,6/7] dt-bindings: iio: dac: Add AD5529R
    [v7,7/7] iio: dac: Add AD5529R DAC driver support


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

