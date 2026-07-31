Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618E631B823;
	Fri, 31 Jul 2026 09:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785488910; cv=none; b=IMqEr2z/vlP1YkSf37dZvdk01XuCQ/v9yAoPJX6LvxHCzA7LertraAwMYtYmGX3V+5bk7WaxDEor5TutPMa2wyTxiBzECCHXhnh2w9MTy5+DzCG6CYaaw5V498X0LaBks6EsNK3WD85VrgoQkNRhmaoCuM8YLc0wry1E2FlUgmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785488910; c=relaxed/simple;
	bh=bvV/rM0nI+620wZ/+v/nwmaJtEmXb5qVlKP3MmQr9lY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Dw6FWrW1p35UYr8wR1Tp9NpkjO3pZiQjpCL5YX4PUbHnhKEXt+qk7j7DHR/rDoP+Ulvu32wOMpZqyOwsjheVUOsAI9KmNoAYYPbdr8QeJch9JuEctxDq4NfU49IrqBm5FbMmao4xUud/dZx22z0zq/waTeUmuEjWQ9twXiFmu4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJc0ovEu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJc0ovEu"
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB6AAC2BCB9;
	Fri, 31 Jul 2026 09:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785488910;
	bh=bvV/rM0nI+620wZ/+v/nwmaJtEmXb5qVlKP3MmQr9lY=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=VJc0ovEu96/XGt43BVnIUuZZ9Qee2/eqG3NAova1Or4Two9pujpckvPV8bdXgRjLZ
	 wbHDtsCpvkeDJKshfAeUGzrTnuwhm5czFve1E+2e8n1bAyQXz4cp6HXuqU3tKOsZt+
	 u43CP4PQ82My1HPMUNem3bWI2JI1CrLgjOg2YZUFGaE/vycOWdbH373z/93OW8kOsr
	 br3IeBDKv7m2DSZpf9Pro2EuCrcJVd9pcW28zHaBfJA9jmbd58D806RTkXGRYPgjLV
	 CjYrdx7Afg4v9V1XFbBe3+ORXS0Dixv3PCBIufCRTo67/JFsrHGcdvrZtR9IXv+wW0
	 I9sfwRkeLwB9w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5EC7C54F54;
	Fri, 31 Jul 2026 09:08:29 +0000 (UTC)
From: Xianwei Zhao via B4 Relay <devnull+xianwei.zhao.amlogic.com@kernel.org>
Subject: [PATCH v3 0/4] spi: add support for Amlogic A9
Date: Fri, 31 Jul 2026 09:08:24 +0000
Message-Id: <20260731-a9-spisg-v3-0-a15da3f70029@amlogic.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAhmbGoC/1WMwQrCMBAFf6XkbGST2IZ48j/EQxo37YJtSiJBK
 f1304JYj/N4MzNLGAkTO1czi5gpURgLqEPFXG/HDjndCzMJsgEtam4NTxOljnthHMIJlK2Blfs
 U0dNrS11vhXtKzxDfWzmLdf1G9C+SBQcuEdFq3aIw/mKHR+jIHV0Y2JrJcqdKtVNlUY13yghoW
 o3yX12W5QOVxzoh3QAAAA==
X-Change-ID: 20260715-a9-spisg-f19ce0403a50
To: Sunny Luo <sunny.luo@amlogic.com>, Mark Brown <broonie@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-amlogic@lists.infradead.org, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xianwei Zhao <xianwei.zhao@amlogic.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785488907; l=1506;
 i=xianwei.zhao@amlogic.com; s=20251216; h=from:subject:message-id;
 bh=bvV/rM0nI+620wZ/+v/nwmaJtEmXb5qVlKP3MmQr9lY=;
 b=SdQy3BS98tF3sFP+q+xnLU/GSSdFyQs9HgENdgmZKFHmierrxjzMQG3KiuhF7b9VSJjSn5r+V
 BrYZZ8CRcO/A/v5412XiLu9mRtVN7bIZIPTwft0onk1U7zrLxL6zaod
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
Changes in v3:
- Re-wrap binding commit msg and drop "amlogic,word-gap" property.
- Handle the hardware word gap through the existing word_delay mechanism in the transfer path instead.
- Link to v2: https://lore.kernel.org/r/20260723-a9-spisg-v2-0-9fc39106b7e2@amlogic.com

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

 .../devicetree/bindings/spi/amlogic,a4-spisg.yaml  | 30 ++++++-
 drivers/spi/spi-amlogic-spisg.c                    | 99 +++++++++++++++++++---
 2 files changed, 111 insertions(+), 18 deletions(-)
---
base-commit: d0b5dd16226814e5c73ba8daf88d3d91c990a38f
change-id: 20260715-a9-spisg-f19ce0403a50

Best regards,
-- 
Xianwei Zhao <xianwei.zhao@amlogic.com>


