Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3281E5B9A;
	Wed, 22 Apr 2026 15:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776871008; cv=none; b=tNW3j/lJvaPZ7T3VDeCVK6L9YK/hwPRmc7+qu2xGoeSSPRR7+QBntxt4/ig+/sD8Hmqbqh0ZLOscMAGfF8hpDxbr1LgEP4rckGly0HHRXPPP2f0sXtuG29p7Brh/nKI/IUl4jGo5MS5xb65GWMrQ278WZQkqk6T8KC08zSN9Wb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776871008; c=relaxed/simple;
	bh=YWUFzjrC+YZ66IO1Pw9MWP7gquEpbKTqaDGwadm3x2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mw7uo7dnBGGkBevijWYuwMeJXHjKi5JAhODw95RC24EVcfrwZEZ7BHuI0JJ9MgpmjAWx/Faz0mS80WSfLJDfhQzSdq3bKD8fCE05o82NVGkvNhN2owmp2k7ganaSWspbYYt5qHrWnRe8sjqSM2jaaH5I2qHaU7wZt0TlWbpGshk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5CCLfg9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5CCLfg9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAC7C19425;
	Wed, 22 Apr 2026 15:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776871008;
	bh=YWUFzjrC+YZ66IO1Pw9MWP7gquEpbKTqaDGwadm3x2Y=;
	h=From:To:Cc:Subject:Date:From;
	b=N5CCLfg9eqBi0XE3sGqZ6fcyJ7N54s8J4E9us9foizGdYsvSKqCS4NyfwrEaM299L
	 E2K0qmrC4/UWnVStGXfscxBi6Iuyh8To8jpi1QEjZlDBzRy7C0dFRCGJSG4xUrgkqy
	 gBj2otzlvC0m4ajgXqyshkCu/Rm1/PSrJbM3UtJILusqrLADr/JmIwstZ0XPmEzLXL
	 i8i9b8potcYGQvnOCO1o9c+pziytGmJsA4sby46he0gEJ2Dl0Cy32HZ93dycIn8fVQ
	 QHVOPF/jSkxYkwPiYQg3W4+fgkfRM5pDyZbtlDtqUO69Y47+Ofd/QHn38gNsuTHNyY
	 gDd/DVVxjir6A==
From: Conor Dooley <conor@kernel.org>
To: broonie@kernel.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Cyril Jean <cyril.jean@microchip.com>,
	Valentina.FernandezAlanis@microchip.com,
	linux-riscv@lists.infradead.org,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] microchip core-qspi gpio-cs fixes + cleanup
Date: Wed, 22 Apr 2026 16:15:41 +0100
Message-ID: <20260422-foe-strength-a5d8ad650ef4@spud>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1529; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=MMCTxTqrtSeHxapOKaJd96986V263BVofgVYjUJVYg4=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkvnsmpVnTMXXnTudJBIUVXoigjf1bNfq1s28yaq83uS no+zMYdpSwMYlwMsmKKLIm3+1qk1v9x2eHc8xZmDisTyBAGLk4BmMjZN4wM846eERWIt7uyprY6 968bzyPBDb5fn3ccvLr8R6iqxrXtkxn+e05Z2yFw+9KMvR5zeJbtCqhUDjmWab26QU7wbcnPu15 beQA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Hey Mark,

Got a couple of patches here, the first two deal with an issue that a
customer reported where using a mixed configuration of the built-in chip
select and a gpio lead to data corruption. Turned out, the built-in chip
select always gets activated at the moment even if a gpio-cs is being
used. With that fixed, I noticed that any read with multiple data lines
was not working properly, so patch two changes how the driver deals with
emulating mem-ops. The remaining patches are things I consider fixes but
not meaningful enough to get a Fixes tag. LMK if you want em split out
to be put on for-next rather than for-current.

Cheers,
Conor.

CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Mark Brown <broonie@kernel.org>
CC: Cyril Jean <cyril.jean@microchip.com>
CC: Valentina.FernandezAlanis@microchip.com
CC: linux-riscv@lists.infradead.org
CC: linux-spi@vger.kernel.org
CC: linux-kernel@vger.kernel.org

Conor Dooley (5):
  spi: microchip-core-qspi: control built-in cs manually
  spi: microchip-core-qspi: don't attempt to transmit during emulated
    read-only dual/quad operations
  spi: microchip-core-qspi: report device on which timeout occured
    instead of which controller
  spi: microchip-core-qspi: remove an unused define
  spi: microchip-core-qspi: remove some inline markings

 drivers/spi/spi-microchip-core-qspi.c | 105 ++++++++++++++++++++------
 1 file changed, 83 insertions(+), 22 deletions(-)

-- 
2.53.0

