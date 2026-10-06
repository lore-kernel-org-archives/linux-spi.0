Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8015A375AC4
	for <linux-spi@vger.kernel.org>; Tue,  6 Oct 2026 11:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791285009; cv=none; b=nTiRUvtFDWRzy3qmwz+WcRVuVKgl1baHjMiCj+cPwNm3UG8QTCClHCRFGS9TKN4TjQw3SRGN0g6GNQEUfcM9E61oG2JuEtnMxm+bz8ZoosrOrGsWDQeVWx7KXQbD229FoeXC0sAmbkUyMmiE8WmNODsoNZfDoFWuGYeEDHM9jdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791285009; c=relaxed/simple;
	bh=Met1+BKztYOojsFAy0ntMh5h3m7mLdXR6dJIqD+qAuk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=TBPcGTMUj34n34P+CF+XV2aB8jXENLMU1P6Z+4Itkm4rui6MByHRWPjQr/G5njjy+RcvKZy4hRW1iSKZt1fkUw3vvx9H3uarfwWIU2/qyhnileozCaf1VwBFDSA+nzvhxonxGevrjYk/QKVgxcZ+62iA3WxhhJnfw0PYmx5fbPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNbbD8QL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNbbD8QL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F4011F000FF;
	Tue,  6 Oct 2026 11:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791285008;
	bh=6sFKPRd6h0Gzj0JrtTZSYY9dnefSVOaXvR1v8X47yv0=;
	h=Subject:From:Date:To;
	b=PNbbD8QLKFS5LO6oXOL6g099f1+Tn9tpmN3bxVjFF/Mx3aIbAmwju6R4OVpYMBgJa
	 gceKh0EyjCV2QoI5PD/ywoF9FfEAiVOcLPibOfquymDIHDIiWAt+C0TrRh6/hslywH
	 RW1TV7NeooXgclU78LqxNGUJ8XGh77DXNiHij4AwAY8cO1kWBMNwnN8diu/2rnKx5V
	 tjd+PcxMm4H3RXnX2owlHfJ7mkPGLDCymzC220jSZnALYW48vXjqqOrTirR/SY7gmp
	 SMJASOCsvIlT/j8VfU4OUyyA+NYMvZjyosewzrD/73QSDzOJ4LKkfxhVMH2HJFW/z+
	 8Jv3qZMM6/Oiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F3D343927208;
	Tue,  6 Oct 2026 11:10:07 +0000 (UTC)
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
 <179128500667.2142077.747532111186957682.git-patchwork-summary@kernel.org>
Date: Tue, 06 Oct 2026 11:10:06 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Hello:

The following patches were marked "accepted", because they were applied to
broonie/spi.git (for-next):

Patch: spi: rtk-nor: Fix incorrect boolean return value
  Submitter: Yu-Chun Lin <eleanor.lin@realtek.com>
  Committer: Mark Brown <broonie@kernel.org>
  Patchwork: https://patchwork.kernel.org/series/1179360/
  Lore link: https://lore.kernel.org/r/20261005030504.2651773-1-eleanor.lin@realtek.com


Total patches: 1

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


