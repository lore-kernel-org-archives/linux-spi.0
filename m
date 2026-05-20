Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE5A4F5E0
	for <linux-spi@vger.kernel.org>; Wed, 20 May 2026 18:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300594; cv=none; b=jVi8aPczmtA82v6/I7ZV7BNp7G9gR7vXFETmi+2JchC8ZAckLc93/ye9+T4Js/T95Bfw0gku63SwfNKT1dBJolGvOBExP/BmnFylFCbjcUFHgckvIdKpg5Lv7yqRKochqgsUvWd0f1x57tjEVYrxABBJoSKy+jtTA3NOw6A22sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300594; c=relaxed/simple;
	bh=MvtB+/gikVURHToGQzzAeMoyRhGfcx8QHWhJG4fBjmU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=uWMEkBmn4iMrII9X+ttmeSlFgrFir40lLUYb5NZ4O5VfKUj/b5a1Sk4x545C5DAhJZeZv2IRiFzNHZUIhxNWPQ00cKf7VCe0sIkU1xpjbXS41CLNqxjJMUMBbhPgUxTjSbnTK0XiLjjPgvB34VMzw+WAGhZ8zqs5Lq8Ct6XKvYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGuMsWeU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGuMsWeU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464CF1F00893;
	Wed, 20 May 2026 18:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779300593;
	bh=7th+QtwyEhiIm+odL+OgFc1sPUjWArrgj8nZ57t2I6M=;
	h=Subject:From:Date:To;
	b=RGuMsWeURZdpnc+Z1KicLh7cEUxrstwrlusdz57opT36DxO+NM9gy+HODj49Po+uK
	 IpVL/jZcGA6sNcJYFJjc+LcOV5eU1p8WSyhz7eDte3NsR4ieWc4O2zefZPd5bDy2/F
	 74hu+1V8KEFfB5CY0r4Smqd1kaeSjGeZi7iUNTwQNMXhToM67NyNkQ2sIM89FspU8T
	 j5/Xn36jtNUe1aRgtjceKLqLhXSK+fBWruDO+FVrOKiy4u/kU2DG64OWajJXXUn2X8
	 ghsYb4pz3b7KbnghBvGdjQzX+TwXelaA/oj6voOtlHOMyJ3/SuQlGLXG9q98GAFdxt
	 7X0V7srwXHxWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D39D53930B88;
	Wed, 20 May 2026 18:10:04 +0000 (UTC)
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
 <177930060347.3697528.15663962626015731675.git-patchwork-summary@kernel.org>
Date: Wed, 20 May 2026 18:10:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: cadence-xspi: Add COMPILE_TEST support
  Submitter: Rosen Penev <rosenp@gmail.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1096938
  Lore link: https://lore.kernel.org/r/20260519005614.628437-1-rosenp@gmail.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


