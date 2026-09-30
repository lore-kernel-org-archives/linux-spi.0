Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E4E344D9D
	for <linux-spi@vger.kernel.org>; Wed, 30 Sep 2026 18:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790794789; cv=none; b=fl6ll9WhCXahSlIGvOTsoSgTdgLt0G6tnp28UvUh7r8+k6cwMmsIio5nkVlxnPejrJdfVQHFRHkqIe3yiostVy1QQfasRNYKYBFXoZ0Y1dzRMFBoCdosTPHyhnCJk70BhVC4xDn+trE0qoUFhT3oJU9EejlD9Zu3woHwytefzJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790794789; c=relaxed/simple;
	bh=fzzVj/mh/Yef5/Y9PPcDKxbWMuxueHH3U8B43NsWlHw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=RphrL9yT48cUYopniWs1cX/fNBtj9HXRkyl5BnkOZYdV3N3zk81GStzGI6VOcYAfXgerkN4VM33mhwdb0FR2OyyIPzdkBj0xm3Bl3lN5mu5t8qv9aafzvjPM84OUp+zkm99+Ynh5cKEanIxNWDg1D7Vk5K4bhmhuRmc3HZvpYIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSKHhAH4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSKHhAH4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CFA1F00898;
	Wed, 30 Sep 2026 18:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790794788;
	bh=VcHyJ2UEYaUCzVmJXAt8N6eeX7rv2VdvxB4XoZp0N+Q=;
	h=Subject:From:Date:To;
	b=nSKHhAH4I4ADKxGheondBaykFHez45+6yTrfywq/jeUu7logZIgmMFZGtfTaiTvk2
	 tnFiceUU1poRD0VltIylcBh1S/ZQXncOCjBj17FBq5eGAeIovkIEvcDml9mRaNgEba
	 XnP68QGbRj+u6THmJsi1+edOO6FcIRjemnah63uTUARDweNTZXT6te6a5te9aqyYEl
	 vUnb9bwZp+YJjELf1NOKdj0wParLTX6hcGO6zsUZjt80qsalv1i8KVndKKXMRqU9TJ
	 RlBuss3gMnH8Kf0ozpgjAdgQfOAMhmwbAyqr68I8TouyBOqd2rUWsvGLpkh9VzI/u5
	 RgqHaG5Wh3uag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 779213A5676C;
	Wed, 30 Sep 2026 18:59:48 +0000 (UTC)
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
 <179079478699.2085443.16417008173830112836.git-patchwork-housekeeping@kernel.org>
Date: Wed, 30 Sep 2026 18:59:46 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: sophgo: Fix SPI NOR errors and clock limits (2026-09-30T18:22:51)
  Superseding: [v1] spi: sophgo: Fix SPI NOR errors and clock limits (2026-09-17T14:29:19):
    [1/4] spi: sg2044-nor: Return transfer errors
    [2/4] spi: sg2044-nor: Honor SPI clock limits
    [3/4] riscv: dts: sophgo: Enable SPI NOR on SRD3-10
    [4/4] riscv: dts: sophgo: Limit SG2042 SPI NOR to 12.5 MHz

Checked 185 series in 5.20 seconds.
This project currently has 16672 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

