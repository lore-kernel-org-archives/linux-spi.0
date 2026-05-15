Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720603DF019;
	Fri, 15 May 2026 20:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778877339; cv=none; b=JqvnYjk+j9f0fa/B46Z4WLxe6EPbOeifOJiwRNkOo9zRIQzfhsd6GrnvgiQ6VaL6MzvtifSLZI3me0eazCvzqAxeMXr8571lOBijYbcqwaSAxmf9OHZm9c5qRw2Vuyj64/nz6q09pyoctTrfmRoV1RvT7oz4i8I1+kuvUE+WjuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778877339; c=relaxed/simple;
	bh=Tp/WyJ9SuV++kB1/ECxssyYjII+IBNRjHnQoniBaOW0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sGcZkUkVxEhMILXSQVIisS6rQUZiOBML8M1wIoQBjGvyymytyVL1Dv3eu3cPqhX7UlZMp86FkWC24McYjwaZC0l1BPYtHAvJDnMFy9CuRoZAVENiboyK0o7Ez7MgZhWlHTcIptaQpKjuFh9aL5litgs0UqjmW3tqHTeAGP+2xLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eq7PEVMd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eq7PEVMd"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0E725C2BCB0;
	Fri, 15 May 2026 20:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778877339;
	bh=Tp/WyJ9SuV++kB1/ECxssyYjII+IBNRjHnQoniBaOW0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Eq7PEVMdpKPUU/EcGGzxgzigrC+o+6aclWT753icfczM4w23DNvTTvxSFM6gkvM37
	 AOxuA8/QPd6I/08RTf0NWr5qiqlRkwFuE8htVPYUB9di51+We3QFWL9RIRpLbNVlkW
	 0T85cuQwzbDMRVp6j16naeCyH+hjchtdyPBavNG8UrJ98GJYxlCSR7o2pDRkhgvbxN
	 5vN8e6+M4LFO6CTJSnoWHhrZzYviA9YsuJIczLIzJQ/2m2r3Dm6AlcSZWbC96j3ZWr
	 le2InsCuX5U5QxY4jLo4KT5edw6qMDA8MmoqDlOrONlMdZOAHk+Euh7xrJhQdN/IQ2
	 Ac60cyJcCHUoA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED936CD4851;
	Fri, 15 May 2026 20:35:38 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Subject: [PATCH 0/3] arm64: tegra: Add iommu and dma properties for
 Tegra194 QSPI
Date: Fri, 15 May 2026 15:35:26 -0500
Message-Id: <20260515-tegra194-qspi-iommu-v1-0-57dfb63cd3d6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avErBvIGIW6SrSIHG0WaWlFEN09a
 fkW/z+QOQln6KsHEl+SJYYCVVcwL1PwjGKLoW1a02il8WCfJtUR7nkTlLiuJzIxGSKrnXVQyi2
 xk/u/DuP7fgRpoz1lAAAA
X-Change-ID: 20260515-tegra194-qspi-iommu-e4e4644d5fdf
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778877338; l=904;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=Tp/WyJ9SuV++kB1/ECxssyYjII+IBNRjHnQoniBaOW0=;
 b=4QKrUmyw8OB12fTPNgswQKz/NOJUvCF8pFGN5F24/IJctgZRkBmS26CSDh2hbTcCXH4FSQE+e
 H0SxcZaxGoKBabxGuHSZX9loqaxCcviBAMgO2uqVJGR6vKfIsYBUM84
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

The reason for this is to properly support the spi nor chip on the
Jetson Xavier NX module. Prior to this, it would time out on all
transfers and sometimes even trigger a cbb fault, locking up the entire
unit. With this, reading and writing to the flash memory works as
expected.

---
Aaron Kling (3):
      spi: dt-bindings: tegra: Support IOMMU property for Tegra194 QSPI
      spi: dt-bindings: tegra: Support dma-coherent property for QSPI
      arm64: tegra: Add iommu and dma properties for Tegra194 QSPI

 Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml | 6 +++++-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi                        | 8 ++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)
---
base-commit: e98d21c170b01ddef366f023bbfcf6b31509fa83
change-id: 20260515-tegra194-qspi-iommu-e4e4644d5fdf

Best regards,
-- 
Aaron Kling <webgeek1234@gmail.com>


