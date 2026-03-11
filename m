Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E453148DD
	for <linux-spi@vger.kernel.org>; Wed, 11 Mar 2026 05:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773208648; cv=none; b=fqYrF7kgkA8OnlQ4wmwBhy9YaWGzt1uxgDSc9su9HIK08q40XGd6PnE+jQIKXLM76/h9+nBJ5mXhFi1ZH0gjbTMwPvnwpXVQyUSfaEDump6NLnL+0mfCWDenpRvoX5uTnjpbPlB7+4FKS5IUqMQ8Xthloo4KD88FrABFYR3Po94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773208648; c=relaxed/simple;
	bh=JA50RuGZMm6UzZQj3SG0iDF0Dd8l9tucKmVsIeqXJko=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=kwR4W7Cydid2w/aKDlAsWb8Ou2SsUVPRC7YHjAXRIfv6ZtHir4PcXs5Vps8552P9lLShG8HC+tqn7r2BGMrgfDv+H5jNREAaEvywFr1OFPhMWoqLtRaID1ickvq/jKlMzLJulyrogptDrXuaMnOkw52Vz/OFKj7K1svuX81EJTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myAP8aRc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myAP8aRc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72209C4CEF7;
	Wed, 11 Mar 2026 05:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773208647;
	bh=JA50RuGZMm6UzZQj3SG0iDF0Dd8l9tucKmVsIeqXJko=;
	h=Subject:From:Date:To:From;
	b=myAP8aRcM/mXOv1QmvO45jIPfzRvQsHIzoo6YINp2kgko09B+Yosb30RvyH2pNquc
	 8GbnWea4B3JUwLAwwGkUlcabYdFfhDgaabRt60NcwtGPpYx4qL8qDUsiK4fuXDjeBa
	 RZ6GBD0245Fefn3W+iaS/YfoCSq8+JkXiCcxs3Jme0WR3Fxk+91ZTKXz/yaGuLwRK7
	 JYyLTbySvEechSmkWRqFDSRJOgV8cIhRMy0Vxwu6dFck2l7GBpTq4aJ5WxMNQ4Ct1p
	 RTFUKaX7q6gK4HW0nDYotlIkj6UaR/0KTLpQ5pl1FEL+CnyZA6eaU6QJ0IILOEIhR7
	 SCFpa8YhHQ6wA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0302D3808200;
	Wed, 11 Mar 2026 05:57:25 +0000 (UTC)
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
 <177320864363.3068005.15814531177074576937.git-patchwork-housekeeping@kernel.org>
Date: Wed, 11 Mar 2026 05:57:23 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: dt-bindings: mediatek,spi-mtk-nor: Add clock bindings for mt8189 (2026-03-11T05:33:33)
  Superseding: [v1] spi: dt-bindings: mediatek,spi-mtk-nor: Add clock bindings for mt8189 (2026-03-11T03:43:40):
    spi: dt-bindings: mediatek,spi-mtk-nor: Add clock bindings for mt8189


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

