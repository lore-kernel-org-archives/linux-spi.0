Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43B4347FD1;
	Thu, 30 Apr 2026 10:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777543836; cv=none; b=I91Sr2tOPUzfNU4bhbITo6okHtho1RHJE1VOELb6y2tYBci3GhOkmPXYvqDHUuo0oqNw4x7Xqsk/cqMfiQlUD/3IYt/VUAHTb2JGq8NnpiSCww3yVi/+AQ0qHm8Bk306QHHD3p3aPE/R64bAwvmrgk3a4esXeokttP2U0BOsfD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777543836; c=relaxed/simple;
	bh=EqvFN38G79HDAnXBhVWjYz3r2hRoIRTEoiMkhnAtoN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=koXx0Tj0ArTN5RoOF7npPd2l5iXts5GYJvoQQCUxkHl/UeCJnv1Re3Vb5RbKl8cqlMLXcW8UYIgPgvlHATJhxYMRR3Cb1nU2Ea6S0Z4h95j23aK/+njg7wh1KdcbWbJywjFvUsQrF+c0l10yGIhd2CGnrE7W5EF0Z6Ank1dvUjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tHvxstCP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tHvxstCP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9BCC2BCB3;
	Thu, 30 Apr 2026 10:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777543836;
	bh=EqvFN38G79HDAnXBhVWjYz3r2hRoIRTEoiMkhnAtoN0=;
	h=From:To:Cc:Subject:Date:From;
	b=tHvxstCPI/ZD9WUtvG7SafdI1LnJJjAm0B0tCOGOJpg8z+N5OGTSJPPiWxuNT8g8Z
	 e84RsLAZcA0YxDKDNTwmko7XZfRTY7iE2+EH39zBE9ETup8+jAJQxoB74EfI1MnCKC
	 3le0jLllF9innE7JrKx5buCYkA0BWAMb3ybQb2RCiTUCZZIs6dQC3Dog9wrCY+xP+e
	 CW0jA9/wrlfw5JNmzU64yqvnhLJKMh0qNHatnwvH0/126ovE6WKVmVdtwwPXcfGex6
	 eDdK+m+FJMrvzrJuwc4pZ/yi7bGPSkHq3ZdCMAbmaOFxe8RKcBBgRjCdLrYovH2Pq4
	 F8C4hwCDCtEZw==
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
Subject: [PATCH v3 0/3] microchip core-qspi gpio-cs fixes + cleanup
Date: Thu, 30 Apr 2026 11:10:17 +0100
Message-ID: <20260430-levers-defiling-00406e391c5a@spud>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=977; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=iJzKH5JoBUPIXWclDGc7MiyoS0OlrYwr9MtEDV1CR7s=; b=owGbwMvMwCVWscWwfUFT0iXG02pJDJmftTp+FPXW7OY5ayU2Ufqn4upI04XtH0Vspmn7OAkHB nxVUv3QUcrCIMbFICumyJJ4u69Fav0flx3OPW9h5rAygQxh4OIUgInM2MnIsF0gPio952py5QZh 6+dl7u/iVp1p2LxV26U6Q1ltR5tDEsNfYc+rjx/ab/aWEon5XnU3d98x+5bjLHlW7K99X6Q967N hBwA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

Hey Mark,

v3 with the review comment about the core handing CS_HIGH dealt with.
I noticed that in the same function there was a "raw" BIT(1), which I
replaced with a macro that the patch was already adding for use in the
setup function...

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

Conor Dooley (3):
  spi: microchip-core-qspi: control built-in cs manually
  spi: microchip-core-qspi: don't attempt to transmit during emulated
    read-only dual/quad operations
  spi: microchip-core-qspi: remove some inline markings

 drivers/spi/spi-microchip-core-qspi.c | 99 +++++++++++++++++++++------
 1 file changed, 79 insertions(+), 20 deletions(-)

-- 
2.53.0

