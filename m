Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FD335BDAD;
	Fri, 13 Mar 2026 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773421627; cv=none; b=EjU+kooTGWhkO7qCfVSSMwkiOCS5gd+SQAPC8wMYDpH+0bp+5FsKHGXP+epdJv8gh5e1qge78tsUg6gTPjtBZwZMYc1ABQ8mS3AKHmnUGbQCUFBYbB+GrXkN7J2llouJa9kN9+jINy+6PaouTHdX/dComCdzsZr53oJaOViCQjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773421627; c=relaxed/simple;
	bh=HIVBii7z63Fjbssugr9oQ+YbgTK4FS2fYGy1CRNso6M=;
	h=Message-ID:From:To:Cc:Subject:Date; b=Rh4u8rcpMLzKQsVnUvqCvr514TdhKu8xYVBlO0uq8/ZOi02DjgQE9TAcNzoc3XEyefAm2z3JO4/H2qJDQ8SzfVJtC/9ZNORNzv8VcAwDLy8MKFutge3ZoBsP4r33daWjFcyzJHwJPOFgs2bRSZVvGrK7l4LM3zGWwBMUVRh7WLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hwduo+J1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hwduo+J1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFD30C19421;
	Fri, 13 Mar 2026 17:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773421627;
	bh=HIVBii7z63Fjbssugr9oQ+YbgTK4FS2fYGy1CRNso6M=;
	h=From:To:Cc:Subject:Date:From;
	b=hwduo+J13TIS6m/1xMGeUj/kmI3DqzlxiPJNjzdDoh4o6WwfcLm97TpcKzdIZw3jo
	 HolN9aRjDv4gH4bm2qRN3iisE3TIjOhxbgiI0NviAh/9+S1zMKiDqzQtKz0u9ubhIz
	 TRb0nv14yb+DjQjTh8eDNr3I0UGnoltHU5HwifClwfHE/dHnafiTTms/DAYhyOriKk
	 l2T4srS8W37yn/Pq9ThTpb916sdGhUk5vzLQf81F1IZnSqH+5oNplMkHqLd6z1TpSh
	 nY9zX21M05/o1mkRcseqORX6baUwqqviTYszGU3Ub5fMQSz9p2hyddyHzIW5Gbo6X+
	 TtVJd3eEiMQ7A==
Message-ID: <6c3c2037d9b46f47a5e3416071f0ffea@kernel.org>
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] SPI fixes for v7.0-rc3
Date: Fri, 13 Mar 2026 17:06:52 +0000
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>

The following changes since commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681:

  Linux 7.0-rc3 (2026-03-08 16:56:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-fix-v7.0-rc3

for you to fetch changes up to f879365c5bb210ed0d0b0aae1a0202d0c0b4b9d0:

  spi: atcspi200: Handle invalid buswidth and fix compiler warning (2026-03-11 19:08:43 +0000)

----------------------------------------------------------------
spi: Fixes for v7.0

A couple of device ID and quirk updates, plus a bunch of small fixes
most of which (other than the Cadence one) are unremarkable error
handling fixes.

----------------------------------------------------------------
Alan Borzeszkowski (1):
      spi: intel-pci: Add support for Nova Lake mobile SPI flash

CL Wang (1):
      spi: atcspi200: Handle invalid buswidth and fix compiler warning

Chen-Yu Tsai (1):
      spi: dt-bindings: sun6i: Allow Dual SPI and Quad SPI for newer SoCs

Felix Gu (3):
      spi: amlogic: spifc-a4: Fix DMA mapping error handling
      spi: atcspi200: Fix double-free in atcspi_configure_dma()
      spi: rockchip-sfc: Fix double-free in remove() callback

Mark Brown (1):
      spi: cadence-qspi: Fix requesting of APB and AHB clocks on JH7110

 .../bindings/spi/allwinner,sun6i-a31-spi.yaml      | 29 ++++++++++++++---
 drivers/spi/spi-amlogic-spifc-a4.c                 |  5 ++-
 drivers/spi/spi-atcspi200.c                        | 38 +++++++++-------------
 drivers/spi/spi-cadence-quadspi.c                  |  6 ++++
 drivers/spi/spi-intel-pci.c                        |  1 +
 drivers/spi/spi-rockchip-sfc.c                     |  2 +-
 6 files changed, 50 insertions(+), 31 deletions(-)
