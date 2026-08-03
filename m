Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47C3727707
	for <linux-spi@vger.kernel.org>; Mon,  3 Aug 2026 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785761958; cv=none; b=jTPhMGrLZoBFfHXnBf4SoHYoOglq9/X75Vrhesc2nJLNxXQcUSNZiqplErplFB2deiH9CLiqUrTP98mG4CMvtz57hpZWJ4Ygr226JW7EJzfyR6hpuscXLhogN8/ne6cQnpQYnDcMSYof8DdP10Rag0TDiD0IwL53NAmX5WbckXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785761958; c=relaxed/simple;
	bh=/BurpZZVvL6zrur8nxP/sYCxl0GuZkrxhJIQWC+9O1c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=I4RyHzPQkCpfjP+XkdFhwlvoIZND91nEdsM1JRfoEesrcBNbb8nlN5bkoMisU/oIEKWWvNjI++JBxURzdVRVc3AzXSMXZLr9XlsMnWwQmNuBjat4eB5v2FMAcxUfNZXewjGukvxxrCA7/c/E/7/1LFdhPsLGtKS+7lbuZ6PDI1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QwnTCpRL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QwnTCpRL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2AD41F000E9;
	Mon,  3 Aug 2026 12:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785761956;
	bh=v78jXC3Xaj/SXj73NkeoNgmhJ+mGb9JL/J53FG0uJdk=;
	h=Subject:From:Date:To;
	b=QwnTCpRLe9K++E+ElYx9sx+xzjf0uiG+Y5MM0lmG9B3Edb5Vc8hae8Ryj9gdWJjtf
	 5oZqiEBikR9YJt5ocOqpAgPy44xYHB35An6Ah+JdQlu6G72XCKw18zKdtmxxp3QMqz
	 X20FP9K7O6sveNeHu44NZVwAdX8Qh9iaDM5oQRntfKDImH3ku5czBLbMyeHyolae4B
	 rGekVonhCvqtffpNMjn+lwRRm0blMopUqhIIFboq12lMpcWUnfMCGWW9th/WJw7Mjr
	 Hz2VvxpJcQaAximjxWMAR/Z/i1GSXWiQC7mgcMp2cm9fplnzpm1eGINlW0RHOX5SK9
	 YzNQQNmjTW2CA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5696D380A958;
	Mon,  3 Aug 2026 12:58:39 +0000 (UTC)
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
 <178576191793.2193670.8274733896596028242.git-patchwork-housekeeping@kernel.org>
Date: Mon, 03 Aug 2026 12:58:37 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Add support for StarFive JHB100 SFC (2026-08-03T12:40:33)
  Superseding: [v1] Add support for StarFive JHB100 SFC (2026-07-09T05:51:59):
    [v1,01/11] spi: dw: Introduce spi_frf and STD_SPI
    [v1,02/11] spi: dw: update NDF while using enhanced spi mode
    [v1,03/11] spi: dw: update SPI_CTRLR0 register
    [v1,04/11] spi: dw: add check for support of enhanced spi
    [v1,05/11] spi: dw: Introduce enhanced single/dual/quad/octal spi
    [v1,06/11] spi: dw: send cmd and addr to start the spi transfer
    [v1,07/11] spi: dw: use irq handler for enhanced spi
    [v1,08/11] spi: dw: adjust size of mem_op
    [v1,09/11] spi: dw: detect enhanced spi mode
    [v1,10/11] spi: dt-bindings: snps,dw-apb-ssi: Add starfive,jhb100-sfc
    [v1,11/11] spi: dw: Add support for StarFive JHB100 SoC SFC


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

