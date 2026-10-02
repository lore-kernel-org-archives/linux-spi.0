Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BFE4EFFB1
	for <linux-spi@vger.kernel.org>; Fri,  2 Oct 2026 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790956757; cv=none; b=R1QCrvDzMqOnYuYMbhYHVJkimMfXgr45flZQlntnKptpk2RWG58JFDZJl22gU1IMl2ILPSD2cpS7TExGynIwbLI6oMpmXF/QfG6GtBv02R13PjdnZsqgSNNdUW2vVWZzFS0MprEydtohygADMXsTDZFQf0gGlqo24Dfw2Q08yDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790956757; c=relaxed/simple;
	bh=TMLilEcWtFoNLwC1sDbpmUI3AiDqvAJWuYdqoWj5UBI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=QgDaHnuniRFsSa6tCI5QWYlGbY5a6dRSWKrm73FgW5II5GU64tbFa3FgzJ8eOCG5dTeNt+mJ8AMmdRWVc4Txk0ytESS5mM1Oa6lxwfX87oSf/BJdQysypiGipx8z26QjjVMxpBdBqelbMs6TISJVSmCZBpfwGGKXHW4JddTnl6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JKRIT1xw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKRIT1xw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 199AF1F000FF;
	Fri,  2 Oct 2026 15:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790956755;
	bh=iPFrivCoIUuwyXNG+55nCMLUJ8PoMiOhPlveZXR9IE8=;
	h=Subject:From:Date:To;
	b=JKRIT1xwJWbd1OZAvbUlAeGQWJbvA1luKsn5yPAwGE8x8o/yAQ6d36cbO60logQQL
	 Ub03iRoQaSPyoSMiqSSpFqxSehFZdEbJUgRzEUnRPBDaAuW9YLzw+jdoaDqn+msPtB
	 XGd3yQ0yXg6w2i9ivaZPrfBAW/EG1r8d2HZCos+XyiD3GkhJeoOpec9W/GLXYZquom
	 8xxETrOzghXcAAiOW5W9fN1IlkZI0P12rBV+yhQroqOkykP/v+sE+aZ+OrUEueW/Dy
	 K1DOlNed1ZS6eTBB6lHr7LqmrZPtuB62+75zqSnLt5SqwPh8Qe21KDsCIjcbJrkuw3
	 P5VoNQn6psKBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F3E123811A64;
	Fri,  2 Oct 2026 15:59:14 +0000 (UTC)
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
 <179095675343.3480154.16959513798146668280.git-patchwork-housekeeping@kernel.org>
Date: Fri, 02 Oct 2026 15:59:13 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] spi: bitbang: Drop duplicated word in file header comment (2026-10-02T15:55:27)
  Superseding: [v1] spi: bitbang: Drop duplicated word in file header comment (2026-10-02T15:49:19):
    spi: bitbang: Drop duplicated word in file header comment

Checked 191 series in 3.99 seconds.
This project currently has 16682 active patches.


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

