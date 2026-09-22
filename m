Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F7F41A563;
	Tue, 22 Sep 2026 08:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065629; cv=none; b=VY+TRtNwPGSf7WHK2fj3dDBNvlv1H0ozE2HQhSanQZMs5u5Jv8QhvnPiRmNRgPDA+5MKhAa2iLoQdLmkj+6QcRSmbdGPNlAd9v7FtaNAz9Zm1rlYUXlooGh9SdP8jeqbgQPoukTmjhV44YdFi+s5kxVUQJEmQ0p/NmHigRQp8ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065629; c=relaxed/simple;
	bh=JmxFGJTPI3N+E6AeptXOynw0nauw2u8521t/9HC+EBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iSLqwoRL8q+Qgb0R6k3vgkIK6c6NAgB0wARrEW290369vkRxfeLMvxgWZa3AwUXvT7WUokaJDH9UXJy4r37o63OVAIe0Hh3+chJX1HrTMfBSAjjfV1VeBn/zxFWTTXbNt3qWFZBCgTNCGD2cnMjSz+4CRbycA09EhNC7F2Mg4cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD34B1F00893;
	Tue, 22 Sep 2026 08:27:05 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 0/2] spi: sh-msiof: Add support for R-Car X5H
Date: Tue, 22 Sep 2026 10:26:59 +0200
Message-ID: <cover.1790065451.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

This patch series adds support for the Clock-Synchronized Serial
Interfaces with FIFO (MSIOF) in the Renesas R-Car X5H (R8A78000) SoC,
which is the first member of the R-Car Gen5 family.

It has been tested on the Ironhide development board.
Thanks for your comments!

Geert Uytterhoeven (1):
  spi: sh-msiof: Add support for R-Car Gen5

Thanh Quan (1):
  dt-bindings: spi: renesas,sh-msiof: Add support for R-Car X5H

 .../devicetree/bindings/spi/renesas,sh-msiof.yaml        | 9 +++++++--
 drivers/spi/spi-sh-msiof.c                               | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.43.0

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
