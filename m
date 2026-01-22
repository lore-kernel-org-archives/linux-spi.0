Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055AC3783A6
	for <linux-spi@vger.kernel.org>; Thu, 22 Jan 2026 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097402; cv=none; b=kd8SMdL4kTxir7UxlAQ17XCD19z/O78xthCQMSMAcWoNLX0E1QmWURxO+UNkE45VPu0OEQ41bk9J3ZF0ZkhI4S6iJwi8kYKcz9es9a7zul2P3zPxaLeZoDk/RmX220xpFE7TFsegt+SLg357pkVbnOKw9JTZlxO14CFJbKL7CWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097402; c=relaxed/simple;
	bh=P9yRC0LrwHtjx5eYVxqypS+UnvX74Z2WTORdpHTsHXE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=sTJvnnGqcrg1qY1LY20Xqh8sULFGLmdNnqKnbZL63pl+FkDAPhuFSmlrYjXTKHhrzlSOGg1siv/Nltnzcnu6NN2k+Kmiacjy3/ygbVr50zWT2JAVMaMzVwx4s9Vg+CDBaM+bSXRhMS5ZVp07ssQ1gymxrSKHr6PWR9saISzkugg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMvMJU7S; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMvMJU7S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30533C116C6;
	Thu, 22 Jan 2026 15:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769097400;
	bh=P9yRC0LrwHtjx5eYVxqypS+UnvX74Z2WTORdpHTsHXE=;
	h=Subject:From:Date:To:From;
	b=CMvMJU7SEBDaUWqB5dXiImVgNL7I/feH6c2rv1PTejQnexE/+3FPa12CMSmMm7oLP
	 OPWFZJW9HgqqyqlhP7OgbY1Z2cHZKIzEXfXuBAczA8EoJu5PZjl2woSW9gWbh2Dc15
	 TLbd+l3Q/rwz4t4tLBsiq5DhlsyP2wK2He1sWiKAdoT54uNw3UiyYfS95IioYDbb5t
	 WvCECzEd1BCIc/nDqIYmNQMvKvrF26N+PsyRgrb5rv6sxSleb0j5+kOTgdjCR6aUFr
	 VuK5kCi2VWSbmZUY2J+zSEsPxTOedoG4EE67RmiLX/l9RNgJpj5AaXtC++eab/Oidc
	 uxEpT4vTpxvoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8DE53808200;
	Thu, 22 Jan 2026 15:56:37 +0000 (UTC)
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
 <176909739645.1778197.10107605211675344489.git-patchwork-housekeeping@kernel.org>
Date: Thu, 22 Jan 2026 15:56:36 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v4] spi: cadence-qspi: Add Renesas RZ/N1 support (2026-01-22T15:13:25)
  Superseding: [v3] spi: cadence-qspi: Add Renesas RZ/N1 support (2026-01-21T17:04:56):
    [v3,01/17] spi: dt-bindings: cdns,qspi-nor: Remove duplicated constraints
    [v3,02/17] spi: dt-bindings: cdns,qspi-nor: Drop label in example
    [v3,03/17] spi: dt-bindings: cdns,qspi-nor: Add examples for testing the specific cases
    [v3,04/17] spi: dt-bindings: cdns,qspi-nor: Add Renesas RZ/N1D400 to the list
    [v3,05/17] spi: cadence-qspi: Align definitions
    [v3,06/17] spi: cadence-qspi: Fix style and improve readability
    [v3,07/17] spi: cadence-qspi: Fix ORing style and alignments
    [v3,08/17] spi: cadence-qspi: Remove an useless operation
    [v3,09/17] spi: cadence-qspi: Make sure we filter out unsupported ops
    [v3,10/17] spi: cadence-qspi: Fix probe error path and remove
    [v3,11/17] spi: cadence-qspi: Try hard to disable the clocks
    [v3,12/17] spi: cadence-qspi: Kill cqspi_jh7110_clk_init
    [v3,13/17] spi: cadence-qspi: Add a flag for controllers without indirect access support
    [v3,14/17] spi: cadence-qspi: Make sure write protection is disabled
    [v3,15/17] spi: cadence-qspi: Use a default value for cdns,fifo-width
    [v3,16/17] spi: cadence-qspi: Add support for the Renesas RZ/N1 controller
    [v3,17/17] ARM: dts: r9a06g032: Describe the QSPI controller


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

