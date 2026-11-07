Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794037266;
	b=rVQolWdPBGa2+VpGm5l4GH6fesB+VgePvnw+07wLIrg5XT0BWmnol7VMESXPAAvUeVAw
	 qQD0Fc3cEawFvUJN0G64tpqPsr/kpOxqJrxqHLDirviFMI7/3XkpaPBmC4bBlw3oisN0H
	 5bXQtTSbachf5bIfg8CbSrW31ZwYLZlgDy/HQCDvNjn4xKvLdcUtul5d2U62Eo6GJebDF
	 mcLofcysrACHuNcdqdOkY8ZyK1AIZzqtcapJ9ZinqAJwOLt7Xc675nf8AumEOT026IXbQ
	 NfqHraAPCL9qBAGycna2fj5UDR7XmQ33XZ09hE6AWHbfMOPQWR6B121lHrrdkUu+j9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794037266;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UAE5S70ytxpyf1CKxXux/vhEAxzlmoH4+aGELf9a1gY=;
	b=pJWUKjAgFuNqQ2Tvo+VsRTCxzksA4fQmLxgi7BTVGxbOg1Wt19hmm3v2NvJfz2JhT/Rq
	 lmkknF3tsCec/TMn/hrS9UQ9L0oMdb7kGBF/PAilkJI5NwrzszOy56dAZOZ3NGYtnjGtv
	 VVd4MAsqCr16qF+Xq4zJd6joN8EtnmOhlu/FZYKMSpCYBVvm1E1MSzMvpMNSFafhx1fEn
	 pAtWfwtkSKxMRBc++wgU5vZQ2jBdl9n5Nzr4f2pIu03QG6QNr9X/gzsdlw1mVRdFCZ/eF
	 VZjTXWqGgfu2y8T1OgvrhoLtbEj0LQ/yhXgMKXhg3NGi7oq0fTKXnke9Vw7OOYbVO/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RWqmvMJ8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D83606A32D;
	Sat,  7 Nov 2026 07:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RWqmvMJ8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9381F008A1;
	Sat,  7 Nov 2026 07:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794037266;
	bh=UAE5S70ytxpyf1CKxXux/vhEAxzlmoH4+aGELf9a1gY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RWqmvMJ8pxdzOz1Pzsipvm7Ohff+L9HRowwRDTHszKi89nyBe5zL4YU8NmubgbnhA
	 v80XqOfE3d/1FfJQzqAleSmI4Pb9Qa9YGDi9xzTspKGZ0gmh2Vd7/WQdQNxH1MIHs7
	 oJWEZ1k4Sv5nu1r2wQs0egzLz7dGESAEh5/hRUR2WabZ6yUKJ5aBKhnUwUOed5OgpX
	 zaUWW34Bt1LBfbLfkWctyWuzfKVvMtbWOjgD5uA5WIzB99bPNZtBFIkR8O+2xXYlHY
	 GtEf293hplDch5ytmPYkCzgtbOuNf4PXgyfJLnxi1ugfDuBfqNf56GH7WsHAq2Z7nb
	 6a/bEFhXtDW1g==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Fei Xie <fei.xie@horizon.auto>
Subject: [PATCH 3/3] spi: cadence-xspi: Use writel_relaxed() for cmd regs
Date: Sat,  7 Nov 2026 15:20:44 +0800
Message-ID: <20261107072044.17574-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107072044.17574-1-jszhang@kernel.org>
References: <20261107072044.17574-1-jszhang@kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use writel_relaxed() for all command register writes except the last
one in cdns_xspi_trigger_command(). The ordering guarantees provided
by the final writel() ensure that all preceding writes are completed
before the command is triggered.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/spi/spi-cadence-xspi.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index d9996ec42edd..72852849ba27 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -494,11 +494,11 @@ static int cdns_xspi_wait_for_controller_idle(struct cdns_xspi_dev *cdns_xspi)
 static void cdns_xspi_trigger_command(struct cdns_xspi_dev *cdns_xspi,
 				      u32 cmd_regs[6])
 {
-	writel(cmd_regs[5], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_5);
-	writel(cmd_regs[4], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_4);
-	writel(cmd_regs[3], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_3);
-	writel(cmd_regs[2], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_2);
-	writel(cmd_regs[1], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_1);
+	writel_relaxed(cmd_regs[5], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_5);
+	writel_relaxed(cmd_regs[4], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_4);
+	writel_relaxed(cmd_regs[3], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_3);
+	writel_relaxed(cmd_regs[2], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_2);
+	writel_relaxed(cmd_regs[1], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_1);
 	writel(cmd_regs[0], cdns_xspi->iobase + CDNS_XSPI_CMD_REG_0);
 }
 
-- 
2.55.0

