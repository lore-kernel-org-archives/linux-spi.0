Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE7939656F
	for <linux-spi@vger.kernel.org>; Tue,  3 Mar 2026 19:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772565603; cv=none; b=k4hk/IotlE7+OslZlSLxv+UOhvD2tpNCSoQMKNdVZbpfTmt9ITM/63RzoWME7z0IATzOGvqkl6MpN3QzTLclPs41cS0Y0QyRYLEAic33FYAgLM9pIg8do3KaO4J3LhFEAVDSHy6hiHQCuEw/wdLvY3TrJNVBNp1t6U8V/SyIIZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772565603; c=relaxed/simple;
	bh=ODTZOE+zC8/lwUW0ih+Pg2wQyd2rXuZI8hghIDhE+gA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=oVOE8KXLPhzbFsygTg1+g4CmS/xwd8hJpg6SE5rMTe21AxIiItq6pKxAHx/j/3z6sdEtBRnvGFA3cmbG1AFRXDrpI4nXM9FNM8xBV+m6Kio9aDDiBEVi0rzlBataxW8frt3UaUrlTM0J0fkqe0gzUpMezbdTLRz0SkyiK8SBczo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFnKhM2b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFnKhM2b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DDE2C116C6;
	Tue,  3 Mar 2026 19:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772565603;
	bh=ODTZOE+zC8/lwUW0ih+Pg2wQyd2rXuZI8hghIDhE+gA=;
	h=Subject:From:Date:To:From;
	b=eFnKhM2bZBUozVbvoQL5SinqpKXrV7cti05yeIY/yRtLd4sk8vnKCj/Y3w955iVjW
	 pL7KizORMKvwSV72eXwYKzbu8/iArMC6b4aT9+uejwFiM94IQBBLvZOrXP96zh4k2X
	 8PabvPupefAk3nYx8HJwm9Si0+4TbfHJ8PYEsfnj3jckpCkUnJZ8rYk5NW6nZarijf
	 i4E1n6l3Mn6k7sT9exaMPvXqZDjyBYVDP1rGA9jt+71q8PkXKMmJPVQVnsFA85sQsJ
	 3AhFk+c12850tKpalUHvhzTXchnKj2blUA+nZgLPbVXYqvrfhbAbbo2Mr9WB4f5wnO
	 ph4oHizkHz3tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7FCCF3808200;
	Tue,  3 Mar 2026 19:20:05 +0000 (UTC)
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
 <177256560399.1437229.1266527703970989249.git-patchwork-summary@kernel.org>
Date: Tue, 03 Mar 2026 19:20:03 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: [1/2] spi: dt-bindings: mpfs-spi: permit resets
  Submitter: Conor Dooley <conor@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1060739
  Lore link: https://lore.kernel.org/r/20260303-deceiver-rack-82f2b89eac40@spud
    Patches: [1/2] spi: dt-bindings: mpfs-spi: permit resets
             [2/2] spi: dt-bindings: mpfs-spi: remove clock-names


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


