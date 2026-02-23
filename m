Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEFF2F1FE3
	for <linux-spi@vger.kernel.org>; Mon, 23 Feb 2026 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862217; cv=none; b=LbCKEYVRbuDoQ6ysF8gztIXIBoRU52btAetLeQJeNSOXCb51IzdgZXpKTfQKTWjxJ0sPntyJMvirjCcF2r56uHm0s2YVhT4eTceqyGAMMWbgiUpAmgorukpbBpGW5wiW6/XVrDa3cixWyVsmC00cMM9d3XiTMYX+md978t63Rec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862217; c=relaxed/simple;
	bh=o5Tw0xC7Gol+nW+FG4w4sjkAb8cnQLxoTd64Tk/qQ2w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=fiKMMc1O7+Cdaeg2FAlWd36H1o3h7OB2Km4aJAW4bGDpEoFCjirOdkVQFvMn+itBBJwI7LRJTIGOtFZdd6koH/PUFsqkYHv/HQeg+Eyje0dMJIUwIMLYus9OKp6IA3bUYeeZzYnHInBAaYhwg/SReSvU3sJgnpPxSvaty/xMk98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKdwI8y7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKdwI8y7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE8DBC116C6;
	Mon, 23 Feb 2026 15:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771862216;
	bh=o5Tw0xC7Gol+nW+FG4w4sjkAb8cnQLxoTd64Tk/qQ2w=;
	h=Subject:From:Date:To:From;
	b=NKdwI8y7SDbXv0zLL21/3vnaBPGXIQ5fY9VNCJQwqEm+tTWiZPx3ygxGm4O01VIAK
	 0jpI5fP1podl+3oyEQEfLH3OVLjorkFwP6fdv8eLNDcgYO66btCSML7pG+jvfVcjIG
	 rkScec/aBiY2hcaoVMpv5f3lanQ3q+hv4VqVWIOspi/oZq4RElp9+6RKucfVERzsLM
	 WNo0sK6+al7CWoUJzoXk4bhJnO1CpB4ll3JN20t9LZ0HvLHq8RDcckM4ccvu/DEfaH
	 yz5BzeVBl4U0YExTfdkIIBAdHzgfB9kyFMVXe+GAEdh3G3z3q3NfmXSI6ewRMtbZ3A
	 WoEAsLBGiYLHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FF183808200;
	Mon, 23 Feb 2026 15:57:04 +0000 (UTC)
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
 <177186222292.2429093.13546803690824461256.git-patchwork-housekeeping@kernel.org>
Date: Mon, 23 Feb 2026 15:57:02 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: pxa2xx: use min() instead of min_t() (2026-02-23T15:30:54)
  Superseding: [v1] spi: pxa2xx: use min() instead of min_t() (2026-02-23T14:44:37):
    [v1,1/1] spi: pxa2xx: use min() instead of min_t()


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

