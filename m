Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D67156C6A
	for <linux-spi@vger.kernel.org>; Tue,  3 Feb 2026 02:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770087438; cv=none; b=kCv61Lxw1Mt0LhKzcIs2DpPebCNeBFMW2pzMnqfU7gnfG2Wugf806Nnc4uplGcXAsrhkTOviT6taPCVLbRgkK5EboQOqBtPPnf+C3ebEs9z2Nb3gyJKbLSdsjpmSh63ObDaHGxaz7h4s1KRHwhgkogdfjc3Ad4xy2wmXTcxogEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770087438; c=relaxed/simple;
	bh=rfbkATSKnwAt2+Yeq0Vts0/o1P+so+lQZO0e/PSZrUQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=WqPGfJWwgV+uRB8qBGTHbW+JwDoZ/RILyPZb9lI1DE1YkjR68k5WcZmgTK1RofMjMEAlFguZmy+s6vSacyXMqyc+liLWyhlsolIRw1kICRxV0GmdvqrkMeNs8XLiskISdoiEaz9rI5A6K1PoQh4CEnUfcyKdqjfmBDHokdFMtcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdQ4OpEr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdQ4OpEr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1928C116C6;
	Tue,  3 Feb 2026 02:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770087437;
	bh=rfbkATSKnwAt2+Yeq0Vts0/o1P+so+lQZO0e/PSZrUQ=;
	h=Subject:From:Date:To:From;
	b=KdQ4OpEr3Zw9lADQj+cQUIRvQZu35Nff9XJW+rb+eDrgVzSYXV8ISqYdC+l6tbpT/
	 IaPPdBHr42abeea6Agu02Fkf+HAwddqpoO6cLA/65sDg7xHGYPek0fQ7am/xDJaWyL
	 AJYOGYnz0bESyB6vqK0oWy0OqKgNsadZRuOWPuYvvuJqo/xcPDrxrzYjYZ87m7c5ce
	 56dg5oB/GgxAYl1347mMntxY9xerRdTPXztKMRofzPnESUXpD1kBplA8BgmrKyuu7n
	 2WIXxHIy7UEc/76bDnfx3w3pHJlrm+OyEZN/h+PyFomVG0LlmUq3CVp94nRLULQScJ
	 GCN0crUnL+ZLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 90FC63808200;
	Tue,  3 Feb 2026 02:57:15 +0000 (UTC)
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
 <177008743423.1289463.16872023439470352162.git-patchwork-housekeeping@kernel.org>
Date: Tue, 03 Feb 2026 02:57:14 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: xilinx: use device property accessors. (2026-02-03T01:55:12)
  Superseding: [v3] spi: xilinx: use device property accessors. (2026-01-22T09:00:29):
    [v3] spi: xilinx: use device property accessors.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

