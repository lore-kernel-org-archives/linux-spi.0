Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC08384258
	for <linux-spi@vger.kernel.org>; Wed, 29 Apr 2026 04:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777436452; cv=none; b=Oh64tuZj2n0wOHO7KwSR5796MKcej56dC7s31pLYo95zS0MvKhLvbrT2xQMMUEi1tTsXvQMbl28GAfjSf005bnAqxSe3KDJwdlAhmS8maDj7bBwBI/a3wO1MR31Gashht7WfuuAMadezyZ8x2lozWi7viMEAQ8GrmnzdrDAndmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777436452; c=relaxed/simple;
	bh=/HlNfeYowdkMZgNTHoGPDRMqlqkZazS4i6HTi57C0yc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=SURGmgR99L3DlWqpzSYPBMyHl+WIJO6VnwYCUwxM3OMQAGRXPRuxG2QWNy8xaznshkbcOApI3INvXTPKEUD69EYs2Utb2+9kBytLGF7S14tw8a8XuS35HYkGb5x2a/17mfEXWuPBRiZq6dChXwSP7b2k3RlDXDRvuTQK4C5vDYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBLh9Aeg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBLh9Aeg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17EEC19425;
	Wed, 29 Apr 2026 04:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777436451;
	bh=/HlNfeYowdkMZgNTHoGPDRMqlqkZazS4i6HTi57C0yc=;
	h=Subject:From:Date:To:From;
	b=BBLh9AegXro3aHko1Qp503aD41FR5SKlfGNXS6JP38mNu9JFmbsY0T/Swaf2DpR5a
	 zBjGcHDuyjvnFTC3/GfIBwynhWGbuZvrurBOdNbQlaIfogfp5cXWUecnto5/TwK5rs
	 PpJDJNP61fuUDIPG/dV+h8oTXUa3L4PR48WoFk5aFWYZNns6IHcps1cyJITKOeLSEh
	 SjGsDvBwcX0GfkE3ef0xgWSJ+2YiN+HubKAs2nQyD1ghgLB35xZDjS6pVc+94qZzR/
	 jH6n8LfWJNrQZ0g6XCNzHPwLqBEeqKKX6wGgrUyZVHxOxL21NArfq88DPs0RQwLGAX
	 OiA0lcGXaKNyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0557639302D5;
	Wed, 29 Apr 2026 04:20:09 +0000 (UTC)
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
 <177743640761.1339914.15515922878329267922.git-patchwork-summary@kernel.org>
Date: Wed, 29 Apr 2026 04:20:07 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: microchip core-qspi cleanup
  Submitter: Conor Dooley <conor@kernel.org>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/project/spi-devel-general/list/?series=1087043
  Lore link: https://lore.kernel.org/r/20260428-surfboard-unhearing-96776be0495d@spud
    Patches: [v2,1/2] spi: microchip-core-qspi: report device on which timeout occured instead of which controller
             [v2,2/2] spi: microchip-core-qspi: remove an unused define


Total patches: 2

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


