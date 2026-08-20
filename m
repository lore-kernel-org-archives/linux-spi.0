Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BAF3C09F5
	for <linux-spi@vger.kernel.org>; Thu, 20 Aug 2026 07:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787212717; cv=none; b=VQ/7CzgsMTSx9eohM5OZBqblHdEVJjpXpqZaD7ofdim9KmMCgnTMhaaSLXVWem6071U1Wydr4WYOeaWiMwf81nVJuxCAG29ae/F+3u86JSQ65OXoIvkoDIA6iktixEvJpgXaQ++efzOBcQbsOU8/cmi10E00QRcxfSsTFTiKf9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787212717; c=relaxed/simple;
	bh=0BwqxUVP8MybfCIh0HtYOMtLVJhgyS2FdIFooz/UWAk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kwp5sLfLkoIb4V+knlmfwefhtq7tuIxzLlIyrh/AeDWNiXyKqBfknGn2zbysyAbgd3GBVLWEXyOH5gdM7OwPpEgB7iXdgn4BPOE3JhmxXEhi/14712YHtQScWrnnBTKqZwfva6Uxb942js+9V/bqFXsQbBTkPDRChe28EP8HhhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUfG2ZyJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUfG2ZyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9316B1F000E9;
	Thu, 20 Aug 2026 07:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787212716;
	bh=E9LXcahSQkL3f8/jO7e2zW+s3ljQ8Hl7S4xpaD3WC4I=;
	h=Subject:From:Date:To;
	b=lUfG2ZyJu7xfCHNPGGE54Ea3q+zZ2LBqSBBpb4dqcJYMyg3+KpH3Yt1KOz7xApSTO
	 mnXGHUMXaPB7X1PQbXA0RXxjmikKxYkbJLJKLFqB8IXa3jZJo6F565QPawkvYYATQm
	 cc2y+MKriU19GD/7mDcinPVaeQzghLxw/2cH37OknpqJVZKXo65b4xt0uvaCXBDIFX
	 nc7YjhAlWFKnIyEpYs+TqNETbRpHEXe6GMsbwtBBvhQYxm8cWo36NwG5Jad1Cx2Blt
	 28pfIViacG78Ws02+cMFlI3BBH2d6142fjBp5MHseHBI+Xt2KXcRWArYEF7CdYrbbi
	 lpTGd+PaDEbJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569A03811A62;
	Thu, 20 Aug 2026 07:57:48 +0000 (UTC)
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
 <178721266681.3884157.16575975234398057962.git-patchwork-housekeeping@kernel.org>
Date: Thu, 20 Aug 2026 07:57:46 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v9] iio: dac: Add support for AD5529R DAC (2026-08-20T07:08:21)
  Superseding: [v8] iio: dac: Add support for AD5529R DAC (2026-08-05T07:17:40):
    [v8,1/3] spi: dt-bindings: Add spi-device-addr peripheral property
    [v8,2/3] dt-bindings: iio: dac: Add AD5529R
    [v8,3/3] iio: dac: Add AD5529R DAC driver support

Checked 161 series in 2.93 seconds.
This project currently has 16334 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

