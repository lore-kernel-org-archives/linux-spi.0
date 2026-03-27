Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A17632D0FC;
	Fri, 27 Mar 2026 10:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774608197; cv=none; b=bG2T+rgK8rWVupn0X7FXFNE/HyMRKJMW/qIdSE5glnPYnYIlD2UGR8olvq/B+Gi4Bu2wTGv8oOHiLemCiv3xoKgfNROd1Tf0pAXVcz0F9sKEuuU7oXhej0lVc66PtQXCYwuLGzN0Ib8hSXI+v+GCDM0IiUfD/IJoOt5EkQZBXHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774608197; c=relaxed/simple;
	bh=GEDyC9awVrEOfdhQD4T6iGTG/z9Cfgp8YVwVPJkoNbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Td6VUvq39GCb8Q1d4YNRaEg6lncLHn83z4+DNOtSzQsyRs4OGtjsPbYmxbOiKqkB5MIA2XQCp8g4K2wehWT3MXqouaEbbwDlxdnQYjIiB1oEWbA7Ohq26bja61AvHROpoD4DMRhoAIF5Jjd+gYvYC/IgW6c5ymiGVpPMNS8wZJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQNFv8Yx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQNFv8Yx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07382C2BC86;
	Fri, 27 Mar 2026 10:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774608197;
	bh=GEDyC9awVrEOfdhQD4T6iGTG/z9Cfgp8YVwVPJkoNbo=;
	h=From:To:Cc:Subject:Date:From;
	b=lQNFv8YxaTqfh68KFmAfaViplgg2bdTu7odnKkK/PDtI5eXLulvs0676JUrwmB4V8
	 54CBW1cjVMbj1Qm1l3zRPytltWQUtQU+785dUhwh30buFoW1dabduXBiSewmtdfFzC
	 PFmDEvmYkDtGWpj7fKhj/ywPFZDgae2UaQDY5F0LxMXEDuWRxsl39LcoJjYY+fLB1p
	 98mNCUT0t34YvmKK6o6lHWwZNmRLJLRLQ4AWUAlGN5uUmdwCfEBEZuhBYEqtFzb4kJ
	 s+tnR5Fu1AnW8UaatV0OBeoO5qXe7bN+qw4Zim2VxZZeWsb6cLuMfrr8+I8RXYrmEU
	 IsLi9xerQ89tA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1w64eo-00000005Um4-3Wgz;
	Fri, 27 Mar 2026 11:43:14 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Johannes Thumshirn <jth@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] spi: ch341: fix memory leaks and use-after-free
Date: Fri, 27 Mar 2026 11:43:03 +0100
Message-ID: <20260327104305.1309915-1-johan@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix probe error handling and devres lifetime to avoid memory leaks and
use-after-free.

Johan


Johan Hovold (2):
  spi: ch341: fix memory leaks on probe failures
  spi: ch341: fix devres lifetime

 drivers/spi/spi-ch341.c | 43 +++++++++++++++++++++++++++--------------
 1 file changed, 28 insertions(+), 15 deletions(-)

-- 
2.52.0

