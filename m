Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB4533A9C9
	for <linux-spi@vger.kernel.org>; Thu,  5 Mar 2026 07:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772697435; cv=none; b=p0tgInt0j0Mst7oT+aLgpt8YO5360//M/ZlX04y5fVgaPw2uF+rRqGcIC7vAQtpYmYUmo3rT9uP6GWMWuynE8wChyJBeUvRiH+qtIiCwfMGGkwzDF/1VAEj5zhzSIz5wtvRnH0ZJx6SRUkV9D2KZg96W0u/M3eAsakcPOfRv004=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772697435; c=relaxed/simple;
	bh=s5/Td8TRnFYhF13gBWzCoUfkpRZxZEB+JvQVoPxoPQ8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=WQ4xkezQUNxG+8BprVPfPOAcGNUEpnSkXrPOjQQzxWUVJ4fOIJP3k5rx3JxLBy6I6sviu5W/vvHEr84LYBUS7XlUpYTDdEE/2M/83IU3qrgdxphtoIOpsyw7nhFj3aNLfWWFV/qBWvF20Bumfpg+kIJ5/ntnVIOswZ82vO0MQTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IwsDWzqY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IwsDWzqY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 532F8C116C6;
	Thu,  5 Mar 2026 07:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772697435;
	bh=s5/Td8TRnFYhF13gBWzCoUfkpRZxZEB+JvQVoPxoPQ8=;
	h=Subject:From:Date:To:From;
	b=IwsDWzqYUA0jLaq+JCb9Iazm4xBOCfhJrHlJPbu03OBYRCcHvQR9PoIvad/nkVetj
	 M06TWlm0FVwejN3lJI3luphIJHPcuP/j/USMnU9x28YbuNwS/xi6g8xQ7KviJwN2ud
	 PiyZzz8K1xgTj1vgIz8FVSTrWZ8KaIV2jpSEmhKD/a2vhK4gvRHx3tp8aVVwkg/u7o
	 Eh48krNeNSlX5mtSEehNH1Wv/OwTCSYXibN4BDFDQxTQWxBHRpeiJqgtItOrnyUt8K
	 tXARel1RjkY+uAN02rhgnDE7keNteYO3hSnJEBG29IKff9ndQt5Z09wpsZdnL6BY1M
	 hW9IhqSN4bSzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0423808200;
	Thu,  5 Mar 2026 07:57:16 +0000 (UTC)
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
 <177269743535.2564834.4831807409805728401.git-patchwork-housekeeping@kernel.org>
Date: Thu, 05 Mar 2026 07:57:15 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: dt-bindings: mediatek,spi-mtk-nor: Add clock bindings for mt8189 (2026-03-05T07:15:42)
  Superseding: [v1] spi: dt-bindings: mediatek,spi-mtk-nor: Add clock bindings for mt8189 (2026-03-05T02:27:36):
    spi: dt-bindings: mediatek,spi-mtk-nor: Add clock bindings for mt8189


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

