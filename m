Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7413672B3
	for <linux-spi@vger.kernel.org>; Tue, 12 May 2026 06:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778569085; cv=none; b=CzDXoP0B107gEliTEDqEPWnM5grNSVr61t47Yp5NRmHKNqAOVrXih2Rn4BLIffldrfHKxZc8gtxYlB7phwJW4EeAnhUW2EJAOPfRChfop7H0Ki1TkmfQC/REeESugbC1g/Ne8cB00bMhg7B/Lbzy8nIP7mh4aoNXqGpNQomhjgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778569085; c=relaxed/simple;
	bh=WCdQjPLosSH38PYfx2J3wZH3IMzhw/6ds2psm1wpoN4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:To; b=IKFXvXUPblSK3Kh9bZALLVIc+pidrHa7dSyBX5RDfs/KUrOkQtmZpRT3wt5HYPj7J6qi1RLOqQ9Hz/lSRlpY4OHA6fSydLjThVahPdGqXNNvEmiwaDZNd1IwjsqzLmMGHLkBimmYLbrQ9yL0uXgjvqAjvvS5/ZrglnuX+sFLp3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lp0LDfPH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lp0LDfPH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2EEDC2BCB0;
	Tue, 12 May 2026 06:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778569084;
	bh=WCdQjPLosSH38PYfx2J3wZH3IMzhw/6ds2psm1wpoN4=;
	h=Subject:From:Date:To:From;
	b=lp0LDfPHm/Wh2gP/eI4qmqJBmrLbxFO12QkWgj0ZPU14ouLpY11KswE1BEocc1ftT
	 l3I+9Z5nMaf1H8pK5YQ3o5VSGrodcoaNEA3uFpGzvaig6zA5dgo7s3W8WzCjsck9ws
	 hekoocge4cnMOLLS+dKr/4FkWmmtaxBt7wiPZH3vVXBquO+rmbnRsK4vu4eDZF/iR7
	 3a2VXu1uaSSIlsv26HTWtOzN0bAnM+FOCaiY0x66GILdMkohLYprTzil9MzY8R3VNs
	 NiFKFvNuncJhkjeetr/xYW9bOWQQFE74XEQZtxtA69U8pX+6wpkO4ta+5dLOvHfHom
	 P7cSry8vbZFKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CF523930930;
	Tue, 12 May 2026 06:57:11 +0000 (UTC)
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
 <177856903021.2698584.7938096514386123828.git-patchwork-housekeeping@kernel.org>
Date: Tue, 12 May 2026 06:57:10 +0000
To: linux-spi@vger.kernel.org, broonie@kernel.org

Latest series: [v2] Add trace events for Qualcomm GENI SPI drivers (2026-05-12T06:12:51)
  Superseding: [v1] Add trace events for Qualcomm GENI SPI drivers (2026-05-06T17:29:41):
    [v1,1/2] spi: qcom-geni: trace: Add trace events for Qualcomm GENI SPI
    [v1,2/2] spi: qcom-geni: Add trace events for Qualcomm GENI SPI driver


-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html

