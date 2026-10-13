Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E5E35C6B9
	for <linux-spi@vger.kernel.org>; Tue, 13 Oct 2026 03:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791863894; cv=none; b=JARadEEJEy+OjgXormlXZRireL66MD/5CtoS9eQQBnMjJoYb4VdoxotaGzgliMEmuq/hnGxpP4SVKn4RaNNFGHxQLoJNz41dS4IA8QTgMaoDnN6XBwyQZJHaq7VopAWtyaRujpuDsJdlMhA/HEEmNh+KwYDiWolb+KD/vm7tTzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791863894; c=relaxed/simple;
	bh=onpme8nOJqLjEvIjvpOEYYlew6HsvYgtKBdQqkNfylQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=O5Z83q3mVY7DKabZfyFtPlpqLMAiWvDjKgbaSqAcM2rEH5rT6sqjAfrvE2xFnjQB7H500yJs9OPKD/kJuIIHlRQeDrc4Dmv2BP2G3KNkzkm1nImBbzTo7H7appATmW9A6WozvGoAVGLMff2DATlhTuJon2CkBRKc6rvYR0wkzTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QnW24SPv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnW24SPv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811981F000FF;
	Tue, 13 Oct 2026 03:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791863892;
	bh=kRfFqb5ouvdcF1kDa8xz8O7msE+cWJVb0A06OwFo98g=;
	h=Subject:From:Date:To;
	b=QnW24SPvfweWv4zyEjre/s7q2/F4FX3ylKerLssogg5gQBYNPu4+G4T9QG8Ct/pUb
	 bgnh4MvJ9eoMovrygJbJWxzhV818RaQzB1QbcnHW0dJ7frp1ndgOvJmO0LPaY6M8Bk
	 grDYz1B+Bt5Yly7tIcOZSlAeYwZczoNb0g+4LetqG+1P18hvV8BWXzlzN9AmFlnTX0
	 dITZI0BqicLLwYJlWeitP9Id/HWzo8Zz6pLAUfQfyOWKgQqP1AMN0ARzqeK6UCB/V9
	 hB7LoRdJlClJojN58prbS35tYV9tqc9Hf3AIGXZpr6DuWtJQvayK+hFD8/hpo3Bub7
	 NpCaTIyGRKRKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 776E139253F9;
	Tue, 13 Oct 2026 03:58:12 +0000 (UTC)
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
 <179186389103.33741.14327823368248453555.git-patchwork-housekeeping@kernel.org>
Date: Tue, 13 Oct 2026 03:58:11 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: ljca: validate the response length before copying the data (2026-10-13T03:17:17)
  Superseding: [v1] spi: ljca: validate the response length before copying the data (2026-09-29T08:01:26):
    spi: ljca: validate the response length before copying the data

Latest series: [v2] HID: spi-hid: isolate DMA transfers from protocol buffers (2026-10-13T03:28:34)
  Superseding: [v1] HID: spi-hid: isolate DMA transfers from protocol buffers (2026-10-10T16:57:43):
    [RFC,1/6] HID: spi-hid: isolate DMA transfers from protocol buffers
    [RFC,3/6] HID: spi-hid: assemble bounded fragmented input reports
    [RFC,2/6] HID: spi-hid: add spi-mem quad-SPI transfers
    [RFC,4/6] dt-bindings: input: describe the Romulus13 QSPI touchpad
    [RFC,6/6] HID: spi-hid: expose readiness for reset diagnostics
    [RFC,5/6] HID: spi-hid: support the Romulus13 QSPI touchpad

Checked 201 series in 3.60 seconds.
This project currently has 16746 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

