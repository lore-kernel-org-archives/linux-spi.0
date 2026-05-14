Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A5C38D401
	for <linux-spi@vger.kernel.org>; Thu, 14 May 2026 08:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778749087; cv=none; b=olP2boI2uMVPl3oKMPPoyx2Ak8r9KNl76i73pl2PZ+TwqRr7LgmQs0RPXiR+tqaCqANe+vK9rXGse75CpjRuH3vPmj+cYgdlT/zcguqczi4ikOPFJt7cJvhhqqO/iLmfLIuXpuCkFuNLXzvkbnp4aRalI+euFajDK29NM/7nlSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778749087; c=relaxed/simple;
	bh=KSDOjEFIM4TQw7olYIzr9B5WNJvdknFCID9930SwQsY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=Xi/XTtP9HqL0g15Fi48+TfLqRYJjYy9691ZtAksQTUQEH3+3MrT9z+NHq4BB/urlun7Ime4Qk+79ua45qki9e0ehIUo8jNfJ5FICbtgusiQ85JyfdHT4a6xK4iaKnRAot2sheLpfxR/kDZr11IDlPDRCn1xueQFzcOV2S7jaQQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Szz8qAGv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Szz8qAGv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E66C2BCB7;
	Thu, 14 May 2026 08:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778749086;
	bh=KSDOjEFIM4TQw7olYIzr9B5WNJvdknFCID9930SwQsY=;
	h=Subject:From:Date:To:From;
	b=Szz8qAGvLRnyXfjJmPubKVdkw0eBWON9zeGN3QjpMTaPi0KAjfUd7BvkDrjHKUUG3
	 36vFCZBwtyDBunl3hrIVg8Jt9YVF+bEG3h5k124k5oosVUJ3wN9f4oCBzBxCuXVcTe
	 GlQWAeRa/YgkVu6gzPDC1EgPv6Xz4jcAj4M9nklxA5JWikb/PKTk8+q0eBpB2zeI5o
	 GKzXJkN9Erwz2I4tV+gJ7oWs8JKWqRftiktuF62kRQPwpqH/u8CQxbstm15jZwLqkM
	 oluKTrt4AK/k9OFeuotopuw/xa4HQRplWK01qN2+53bF7BWEtVeBfcJH8eQ4iN2Zl6
	 RS234CP+OZh2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F2A3930910;
	Thu, 14 May 2026 08:57:12 +0000 (UTC)
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
 <177874903134.4027920.13213163134834450076.git-patchwork-housekeeping@kernel.org>
Date: Thu, 14 May 2026 08:57:11 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v1] spi: Add spi_for_each_controller() helper (2026-05-14T08:45:44)
  Superseding: [v1] spi: Add spi_for_each_controller() helper (2026-05-14T06:13:08):
    spi: Add spi_for_each_controller() helper


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

