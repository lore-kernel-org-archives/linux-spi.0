Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78D8280CE5
	for <linux-spi@vger.kernel.org>; Wed, 22 Apr 2026 20:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776890446; cv=none; b=p2uE3TpGH3OQZdYNeOeM1fWT3IThZEbGQ6OHcfI1R85BtRe1IwOBNx6FsER2PCS52wOo9bv+MBrzfnqut0ZGAEsvhbVEc9JbuXQRBUxeWJ5z7xbdgkaJsFRq9XmVjFgGvqA7MZeMfTyVFTkrF3uu2Q+aPYgcfwq411A2E+39ajE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776890446; c=relaxed/simple;
	bh=/VDWB2vBv+tUeRu8sv92z5D6Q2B5KWY0Zw5f88i6Fu0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=UQORCWS3a91z5YAoAtP/t1PSMVSnkfQYbcmC8EaURyhguHtw7rBhkJP4VIKlGdGZvM3MQTaVJaTTaYN93kWU/OnbwDqVHSbKEBZLtwr4uL6Hcks5CVh1kDDPeki06N/QHTzYjUtkIdH2t7rQlm0fHQFX3k5r5b0zzJ0VKFb6Sk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y5H9i5nR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y5H9i5nR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BD7C19425;
	Wed, 22 Apr 2026 20:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776890445;
	bh=/VDWB2vBv+tUeRu8sv92z5D6Q2B5KWY0Zw5f88i6Fu0=;
	h=Subject:From:Date:To:From;
	b=Y5H9i5nRX3FLDTediOX8wKhstswMBrt45FExnpwEmZJcLfmoNL1MB3KwOh3HugCzP
	 XyA9XbZTKTq517/Tvz7QF8ICKSg3U6c/zKn0dH6ZVjswUhRn0LeGLa0vbcuarvwka1
	 oN/6G6hB8naIVU2BRzzZmRlei9GeBnbqAMVkfevDpMvCJevFrq6il8tRbKj8ezIyVY
	 CaNdIyTWadXoF37E9IkE/BQ2MSVQPvrcQ378iFL6R94M6bYjZJ3jjX3weQvMaRFfPy
	 VPBHn43oDXsB+r5eVCGqBXoCpMxoPamn/VE491aiW4G+a/CjTQ9tsZI4tpu/r1xG32
	 2+QZjpmTjK14g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 423F33809A84;
	Wed, 22 Apr 2026 20:40:09 +0000 (UTC)
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
 <177689040778.4029096.5612996310942331324.git-patchwork-summary@kernel.org>
Date: Wed, 22 Apr 2026 20:40:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: spi: orion: runtime PM fixes
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1083851
  Lore link: https://lore.kernel.org/r/20260421130211.1537628-1-johan@kernel.org
    Patches: [1/3] spi: orion: fix runtime pm leak on unbind
             [2/3] spi: orion: fix clock imbalance on registration failure
             [3/3] spi: orion: clean up probe return value

Series: spi: fix resource leaks on device setup failure
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1079835
  Lore link: https://lore.kernel.org/r/20260410154907.129248-1-johan@kernel.org
    Patches: [1/2] spi: fix resource leaks on device setup failure
             [2/2] spi: fix controller cleanup() documentation

Patch: spi: imx: fix runtime pm leak on probe deferral
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1083846
  Lore link: https://lore.kernel.org/r/20260421125632.1537235-1-johan@kernel.org

Patch: spi: mpc52xx: fix use-after-free on registration failure
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1083847
  Lore link: https://lore.kernel.org/r/20260421125800.1537361-1-johan@kernel.org

Series: spi: axiado: spi: axiado: fix runtime pm imbalance on probe failure
  Submitter: Johan Hovold <johan@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1083900
  Lore link: https://lore.kernel.org/r/20260421143925.1551781-1-johan@kernel.org
    Patches: [1/3] spi: axiado: fix runtime pm imbalance on probe failure
             [2/3] spi: axiado: rename probe error labels
             [3/3] spi: axiado: clean up probe return value


Total patches: 10

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


