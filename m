Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3823CAA57;
	Thu, 23 Jul 2026 06:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784789035; cv=none; b=nVYvwGmp18s5zeHn0qO3PlAJqifS1jHAK6CnxFAIhbXC1FAzWloYvLCRNOrdkOgahg722tkcuNm5ZnTsIat/VQRse99nXUZQiDMYjmvBE6R9CnZYbLHy+DuTEbeC7QQ+UoI839my6ul8IhuPjD0yvUqElFB6JEFKTGkXaf24n7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784789035; c=relaxed/simple;
	bh=DGj8+OBGUddq6591+eaVQwRebOdg449UgOkQcJ5AB2g=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=W7idwOEOMFGPkQMm5MNL6AJP1RNclaNKPT3HGCvhKKhBqn6EZU04L+HNSn6gNcluY1hcqKCo8l8+BcBHfHjqJcUgYEX5J4O3/j5QV/pp0Nd2b+4rsqfRr3s7RyGAfshqb41WKmvr6dZnMhe2DuqKMd2gEskG8FoRNPVDT56XFT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tO0YKUS/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tO0YKUS/"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2A769C2BCB8;
	Thu, 23 Jul 2026 06:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784789035;
	bh=DGj8+OBGUddq6591+eaVQwRebOdg449UgOkQcJ5AB2g=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=tO0YKUS/Qn27hX/QDiufn324Y1ijvd9Dvr1W/Dv8+Vlmq3kNH2+tOfZa35c3l6AT5
	 7jXTBVCL5eJXJUytW27tG81R8FINhBTLwXaNWdbeaxWrrcNH/ijbk4cnjlKRAyCoLs
	 D0seyB1Y2Qz8KY3sm/sJy54yrScVQ1YkJHlNaaO5pz9/5LTPGeSCzxhSf5vPOQ/qMM
	 5dt1bRN0L4GeoPfJck4f4tCrcpDVy5RRpGkcJ9Ns8gq0fNARhNdu6EULMjTHOXKcKB
	 BTnxm57Jcqdb8I1tBGf2kBLAoZrcrDNw8N0DxEqihF2Uv7uKN+D9ZCVn9D9ytD2BA1
	 +9yMjS6iQYtjA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004ADC44524;
	Thu, 23 Jul 2026 06:43:54 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v2 0/4] spi: add support for Amlogic A9
Date: Thu, 23 Jul 2026 06:43:41 +0000
Message-Id: <20260723-a9-spisg-v2-0-9fc39106b7e2@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB24YWoC/0XMQQrCMBCF4auUWRtJojXElfeQLmKcpAO2KRkJS
 sndjQVx+T8e3wqMmZDh3K2QsRBTmlvoXQd+dHNEQffWoKU+SaN64azghTiKoKxHeZQH10to9yV
 joNdGXYfWI/Ez5fcmF/Vdf4j5I0UJKTQiOmNuqGy4uOmRIvm9TxMMtdYPMCEY6qIAAAA=
X-Change-ID: 20260715-a9-spisg-f19ce0403a50
To: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784789030; l=1229;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=DGj8+OBGUddq6591+eaVQwRebOdg449UgOkQcJ5AB2g=;
 b=sb8FB2uWLZMo8CYLxZi5hPTuZCrISN1HZmzteGPAmYDm8drwF8LzXqRtDclIL7L1HQhOUqU0y
 iUJt2D/nfiLB8NTYUzpQ2/y+SVU9xkm6SpoQZf8TKhpg/eqCdRlI8KQ
X-Developer-Key: i=xianwei.zhao@amlogic.com; a=ed25519;
 pk=dWwxtWCxC6FHRurOmxEtr34SuBYU+WJowV/ZmRJ7H+k=
X-Endpoint-Received: by B4 Relay for xianwei.zhao@amlogic.com/20251216 with
 auth_id=578
X-Original-From: Xianwei Zhao <xianwei.zhao@amlogic.com>
Reply-To: xianwei.zhao@amlogic.com

Add bindings for A9 with some features, and driver for A9 base on A4.

Fix the incorrect keep_ss of the last descriptor.

Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
---
Changes in v2:
- Move the added properties defined to top-level and then reestrict them  in bindings.
- Fix some pre-exiting bug reported by Sashiko AI review that as a separate submission.
- Limit the value that will be writed to CFG_CS_HOLD.
- Link to v1: https://lore.kernel.org/r/20260717-a9-spisg-v1-0-2eeea77be19f@amlogic.com

---
Sunny Luo (1):
      spi: amlogic: spisg: Fix the incorrect keep_ss of the last descriptor

Xianwei Zhao (3):
      spi: dt-bindings: amlogic: spisg: Document A9-specific properties
      spi: amlogic: spisg: Fix transfer size limit and timeout handling
      spi: amlogic: spisg: Add support for A9 controller features

 .../devicetree/bindings/spi/amlogic,a4-spisg.yaml  | 38 ++++++++-
 drivers/spi/spi-amlogic-spisg.c                    | 90 +++++++++++++++++++---
 2 files changed, 113 insertions(+), 15 deletions(-)
---
base-commit: d0b5dd16226814e5c73ba8daf88d3d91c990a38f
change-id: 20260715-a9-spisg-f19ce0403a50

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>


