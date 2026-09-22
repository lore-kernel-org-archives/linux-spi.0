Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABEB41A4E2;
	Tue, 22 Sep 2026 08:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790065634; cv=none; b=La8GdC82iyKOYXMXgqgvVH/PUA5dJtBO7+Q3pAEr4yfdq1ioscYNCU6PlznWC/m/QHl9TF2PSb8SL9NpHPXR2fhMxGmDtJBkoJNsoEJ3sRgECeVn/9k6jpyguUVpuL3nGB8M0zWLX7yeGjJ0V9KBq3PgP3IPk76+auwTHr7jZH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790065634; c=relaxed/simple;
	bh=HiGqAbkp3HQkEufXm2YJSlPZQmpbwLS/2lsUFiRdsag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjIFeCL2Cy2DwLORCTRF1F8Qdq4B0jWCDZL4XqF3JDt75DyWvE6LP/CHiWG0LI8jSfR+Z5TZW/Ia6rAvUJu5LVNm3v7//uYs42SJ8Br/d5SYvqwdt7qVDjbfmCr+FmqE0/ebH7mUXXLMRGWRjzLGJp62hi3KS1cFsMaINwCjH0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5B3A1F00893;
	Tue, 22 Sep 2026 08:27:10 +0000 (UTC)
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
Subject: [PATCH 2/2] spi: sh-msiof: Add support for R-Car Gen5
Date: Tue, 22 Sep 2026 10:27:01 +0200
Message-ID: <a254e27481716a07a49b10db31523fcaa3114afb.1790065451.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790065451.git.geert+renesas@glider.be>
References: <cover.1790065451.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Clock-Synchronized Serial Interfaces with FIFO (MSIOF) on R-Car Gen5
have FIFOs with 256 entries, just like on R-Car Gen4.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-sh-msiof.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 4c425ec627767a46..90a671e9de70ebbb 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1016,6 +1016,7 @@ static const struct of_device_id sh_msiof_match[] __maybe_unused = {
 	{ .compatible = "renesas,msiof-r8a779a0",  .data = &rcar_gen3_data },
 	{ .compatible = "renesas,msiof-r8a779f0",  .data = &rcar_gen3_data },
 	{ .compatible = "renesas,rcar-gen4-msiof", .data = &rcar_gen4_data },
+	{ .compatible = "renesas,rcar-gen5-msiof", .data = &rcar_gen4_data },
 	{ .compatible = "renesas,sh-msiof",        .data = &sh_data }, /* Deprecated */
 	{ /* sentinel */ }
 };
-- 
2.43.0

