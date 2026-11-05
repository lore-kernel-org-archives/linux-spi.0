Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793876407;
	b=VrZGC3kGwCrnC/v8onu/kHx61RjEtNiTAgprsydQASDuKN+OokFNb1h0eanKQC6RFtnA
	 o8d0VwBHtKp3A0kfSpFCy9hBMNZHi6JSWNsVEeB67ybG9WCrTQ2kRxsCx5WPEwaeLYoh+
	 Zt+0C2vAKk/QULQLuvfQvipaoi8yIcP4O2ZhDLdXX+JK/n9Ny79qcM+IZsUiWgHkJDmKg
	 FmXEUtLYi9qP4Wj/lq/5GyP2jnVOSLkTUFHbpQXAil3Ayq3FFhae3TJB43/tJHsJBpmzL
	 EY4jzsFu2c4RLv+GSIqi43yJ/WUVN1ATzQ9h3M7fzWqRJIdMY5H02A+Mp1U3pDjJmqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:To;
	bh=5gb0WqpDzeP6mgDt7eza2EWQSIYo+azn4KIQJwjFUxU=;
	b=PV1u6Nz4+V1kDC14T/fBUEqTiOHsjBKgLIrz9dIHXYRK33WQ4wcfId1UiHAa+e4+Ak+b
	 3OZ1Dwslj1GT7JtY+iBDZUVGdPvNPFM2YAPrKic5pUgnxQ001IsCI52Bw4SSxdu5QonfT
	 si83JX3TglQ1EClzJconmHe2BI7QWSx7rZUIXpQFZ5UBtuQv+2ZmUaJW5vJOCjJlxAsHx
	 Op5XD3CELz/7H+ukqRWQkT+JRmTYgzy5LVL96vhR7GBtWe7wZubU8Zp/aAORkHrx+YbJk
	 SLy5Ejs/F1HHCgrWsOCnfRfQsvxzjMMR35BNIYWpMSH4MsRYjDOkH66VLSmjVUEg8rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AfPXxtcu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D02F606D839
	for <linux-spi@vger.kernel.org>; Thu,  5 Nov 2026 11:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AfPXxtcu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34F01F00A28;
	Thu,  5 Nov 2026 11:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793876406;
	bh=5gb0WqpDzeP6mgDt7eza2EWQSIYo+azn4KIQJwjFUxU=;
	h=Subject:From:Date:To;
	b=AfPXxtcuyBbrEs8VdJ5hPHfRE2lCNneBra6qegd9ODVnkAaU8+Cvz7GTEaYuVjF5K
	 v0x25qEBWWNSjBeAaftAs2zWfUmrbvIn6bIba2b6Y59Pn3NY7fAyyAZ3R7i6C0RiAw
	 GsYSxNhM4SaI5aDHy7VUXB8xAn2QI4Y+qcyKvSGCPKS8zR0ZCaQn6zLcJfXz6rAlwu
	 NOtwfSXdTiJ0aSSDZCEzVgP174Zu9y1Im4pyPHT82+/pr9AcjgdD5X9RNCOzj6L9x2
	 OSrGNo8+HqQ1nhmkuQsfxDl/POUIV2tZ44V2Uz70/7lV7NpD0SG+0KoF6B+XuWfgtM
	 uQFQniFaJHWAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BCB9E391AFBF;
	Thu,  5 Nov 2026 11:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Patchwork summary for: spi-devel-general
From: patchwork-bot+spi-devel-general@kernel.org
Message-Id: 
 <179387640534.3593676.3715192977808652489.git-patchwork-summary@kernel.org>
Date: Thu, 05 Nov 2026 11:00:05 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Series: Add devicetree bindings for spi-virtio
  Submitter: Francesco Valla <francesco@valla.it>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1194332/
  Lore link: https://lore.kernel.org/r/20261027-spi-virtio-bindings-v2-0-67927b24b9d4@valla.it
    Patches: [v2,1/2] dt-bindings: spi: add spi-virtio

Series: Add devicetree bindings and maintainer for spi-virtio
  Submitter: Francesco Valla <francesco@valla.it>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1196439/
  Lore link: https://lore.kernel.org/r/20261029-spi-virtio-bindings-v3-0-ef30217abefd@valla.it
    Patches: [v3,1/2] dt-bindings: spi: add spi-virtio
             [v3,2/2] MAINTAINERS: replace spi-virtio maintainer


Total patches: 3

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


