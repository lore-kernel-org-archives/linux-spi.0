Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6263546AF35;
	Tue, 28 Apr 2026 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777392762; cv=none; b=n9lILJ44ULuC+3x3H1VIUsWR6F0uwW9DTtmuKc7BIVC6qBzGzBYM4aRRzMxlFDcRnhFMD0DpL8WfcpCA+mEfg7KH1yqT+CMgsOfkkPyNQEFLJ11O3pIs4YJi8W99lT34bZNQUuwkqki3CKO4Znl1GOcJn2zWq4WEd/d++A8XoMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777392762; c=relaxed/simple;
	bh=dhffF3ZrJYq66Fq83zPDuRzj54IhmH5nUsYS1m4ih+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kr/IU8eprXsdjLV3hrYbyqHqFIO+byD6vH3ETpR1+kDs/zK/THatWFNUr4gY8J1Z9h0XphnstvWbb7uWlnGjP8HTG9feijJVHv5TTP+cCo7Ttv8Ou09q0z/QxyAPQqoJvc+35nHDEtNqgbT1PAuRGUxCKBkJhTmGYJWGZbSxtKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=osTcUcN2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="osTcUcN2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B8EC2BCAF;
	Tue, 28 Apr 2026 16:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777392762;
	bh=dhffF3ZrJYq66Fq83zPDuRzj54IhmH5nUsYS1m4ih+o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=osTcUcN2LylikR7wp+pHUM0f5BPypaqsCxDAv4lNwPeg6bvKUnv8V3vjCNQSPAxer
	 t2X7bg9YKhl+dF9Z5lgmYdc3iZEy8qeNItQa2kwaDguXMX0vSBCsxLfuDU0qSRTSWv
	 Vn+1qvWWMHzdP7Ty2EROcCHTH2OV5Oh9QcW5h14Dx3iCekOWCLq/iOyG3ZzOJPYuvx
	 VtDMrKGhkCJw4ZqKRITnHarI1y9Uz/HV5uzwzZrzpruCZe/sMtux5ViTN9t8iDiT08
	 ljCmQcVsSLVNiTXkM/8DgqKpA+9uY2wDnoqALkpmmDGwwK/jugci+OCg70wGnPFInW
	 nE6AAh6nxoMfQ==
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
Subject: [PATCH v2 3/3] spi: microchip-core-qspi: remove some inline markings
Date: Tue, 28 Apr 2026 17:12:07 +0100
Message-ID: <20260428-acting-yearning-24bfa6d66c7e@spud>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428-plexiglas-smith-6ae4e9ba8abd@spud>
References: <20260428-plexiglas-smith-6ae4e9ba8abd@spud>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1848; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=/xpbTb3+/lPBLIXkcANfDJ1Gn4CZegvxDmd2/FsdDZk=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJkf7iTWWf5Zw69usvn0twVldVf4/848NO+Z6Q+9mqYbd 56ukxH/1VHKwiDGxSArpsiSeLuvRWr9H5cdzj1vYeawMoEMYeDiFICJzJBjZNh5gS1BmvHYgVVJ +Yk3ltxgFexL0blwu2bxe41iR4YrEhsYGd5feq1stOfEtpPFN0NXahVpmm79HCj5ok9M1brER4G 5hgkA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Remove inline markings from a number of functions that are called as
part of mem ops callbacks. None of them are either particularly trivial
or sensitive to overhead of a function call. Just let the compiler
decide what to do with them.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/spi/spi-microchip-core-qspi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-microchip-core-qspi.c b/drivers/spi/spi-microchip-core-qspi.c
index dd3644ee80c6f..d15cf5664da5e 100644
--- a/drivers/spi/spi-microchip-core-qspi.c
+++ b/drivers/spi/spi-microchip-core-qspi.c
@@ -200,7 +200,7 @@ static int mchp_coreqspi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static inline void mchp_coreqspi_read_op(struct mchp_coreqspi *qspi)
+static void mchp_coreqspi_read_op(struct mchp_coreqspi *qspi)
 {
 	u32 control, data;
 
@@ -236,7 +236,7 @@ static inline void mchp_coreqspi_read_op(struct mchp_coreqspi *qspi)
 	}
 }
 
-static inline void mchp_coreqspi_write_op(struct mchp_coreqspi *qspi)
+static void mchp_coreqspi_write_op(struct mchp_coreqspi *qspi)
 {
 	u32 control, data;
 
@@ -264,7 +264,7 @@ static inline void mchp_coreqspi_write_op(struct mchp_coreqspi *qspi)
 	}
 }
 
-static inline void mchp_coreqspi_write_read_op(struct mchp_coreqspi *qspi)
+static void mchp_coreqspi_write_read_op(struct mchp_coreqspi *qspi)
 {
 	u32 control, data;
 
@@ -422,7 +422,7 @@ static int mchp_coreqspi_setup_clock(struct mchp_coreqspi *qspi, struct spi_devi
 	return 0;
 }
 
-static inline void mchp_coreqspi_config_op(struct mchp_coreqspi *qspi, const struct spi_mem_op *op)
+static void mchp_coreqspi_config_op(struct mchp_coreqspi *qspi, const struct spi_mem_op *op)
 {
 	u32 idle_cycles = 0;
 	int total_bytes, cmd_bytes, frames, ctrl;
-- 
2.53.0

