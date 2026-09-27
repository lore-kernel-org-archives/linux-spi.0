Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EB2305057
	for <linux-spi@vger.kernel.org>; Sun, 27 Sep 2026 21:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790542908; cv=none; b=TZ4RaHWttkEqR3uCqio75KzCZ96kPgcvEBK+pAFlifXdiwgLNpVXpAP9yswEz4Zhj9bTyM+X7IiiyBXa8Xcp7B7RNzoFuKnWYaXwMQoY1whG3yntNeOPPivwljWU8PMM/0XuJFWGp3/7yHmj/hHsBnPQIqsXhnS4k4etHL1n0P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790542908; c=relaxed/simple;
	bh=GWC97jHZVJFotrmA8pUPJ9PMkNIVvkLUsWuuymRNXgc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=saTb6Rt7aA6OGtsvXhve5XrSOXWLtpTJMhVSFNUUA+5nj6y2cNzE0O4+ncJxJ7xwqrC4FXKP0OIR1sHqFt9zkTknNCi4AL/BuRXN8KTGcy5+2pLK38+Yds8PHITg1YsADcGXFK6y0/D9WzuTGH3ltoWaPR8qI1tJ0JtPaCoNRIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N81sQxhO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N81sQxhO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3FAE1F000FF;
	Sun, 27 Sep 2026 21:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790542906;
	bh=jMpbX29HWibsULiUQ/ubCL/Z4gHWgWWQ6i2zTslGS2o=;
	h=Subject:From:Date:To;
	b=N81sQxhOkkkQlXtfDN0ILyVBv2staF5RIjEElWXtAdD36c4trMq/BID3CIL9aE98X
	 ZQpzQfP+suY+e9dSnx9lowiF80CgX/8oMpJtt4LLWFIZAVZlukqdgMoy7s07DH2sIN
	 YzmhulyZHiBgIsZnhpskj+eXYTIat1AUzFKejZaNFSy1oosLHTnEj/xYc3mYGzWg3a
	 QlnmZHRQ6gJXfKeY6H4wITft4Sd53dZPryg0ZRqBxai4vGg7G689r6QVJnPvWi5PeJ
	 ECffPpN61iMsVtixJ8SlhcOhsLLV9GHDtbXlNVlUjs+8mFRoo/WHJZwTNogjc6qTzG
	 oH+bob+lkqu+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B8A380AA63;
	Sun, 27 Sep 2026 21:00:33 +0000 (UTC)
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
 <179054283211.2876309.439839375462416352.git-patchwork-housekeeping@kernel.org>
Date: Sun, 27 Sep 2026 21:00:32 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v5] spi: qcom-geni: Use GPIO to notify master of SPI target activity (2026-09-26T19:56:32)
  Superseding: [v4] spi: qcom-geni: Use GPIO to notify master of SPI target activity (2026-08-24T14:25:58):
    [v4,1/2] spi: dt-bindings: Document ready-gpios property
    [v4,2/2] spi: qcom-geni: Use GPIO to notify master of SPI target activity

Checked 175 series in 34.33 seconds.
This project currently has 16600 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

