Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F0C23A9BD;
	Fri, 15 May 2026 20:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778877339; cv=none; b=PHgBG+CHpr2CBxFuuzfDB/nI3DlfIAscT+qTXSB/mEgPSf7ZmttwrptDkU6sHyr50XaasiREHRQA7FMiwrtvGjD3DslGvlyI5Bhs/TjWPDxLcEHbZQhDlkqtCNWabBUyXPXZ+0FrOvsL6OiRIipGw+0HL7BYCzoeq/OfcNpxOmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778877339; c=relaxed/simple;
	bh=H2euLxjrfczkBblxLchszB8NvqvYOl3jHXk+BNY5O+0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ts1Vec0EOcVGq+pjXieaqA/T1Q3OUe3Q9QCXBCczsRNlO/9dFwmtULcqJgdY3XomKQr/0dn2q9wF5g30dCvRJsAsCsLo1SOAgr/6CY7mkiRcIl+khLj/j4ZoTpPVhvmNd7TtTETBud8fHpwQGPXv9IvJl+IYKpGZkhFrH7u6Y14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PndDtqoS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PndDtqoS"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 43470C2BCF5;
	Fri, 15 May 2026 20:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778877339;
	bh=H2euLxjrfczkBblxLchszB8NvqvYOl3jHXk+BNY5O+0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=PndDtqoSXfxQjdS1kcLeVBQ1in+2OnsTn7lvgDBA/O3/ZTo2dzixMeqNVMua1/yKq
	 Hoarm7lzEzvl/7MX0W/mQCwmgBaT7qGm3rAh7zxd8RAbyPWj3HlNhdan3dUCGnTgh9
	 tTsr91aAjhTZu+5dJlp9GBHBe5o4XhLLlb4+P+cGJfDkxHB7b5/x2gL6JX7NT8bB22
	 uZ9G3ufegWPIPzups+7NfARuYthEukB4F8pNrPsdh+Ekj11TS+Gkqg/ZAWdUXhcWbg
	 Xda8DRx2mlvXfvF0xyCRWKMvD7HzA+K36e27pZ5xrADinQt9RaSPJn6zNXobIe0F8v
	 vbtbZoygEyKZg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3892FCD343F;
	Fri, 15 May 2026 20:35:39 +0000 (UTC)
From: Aaron Kling via B4 Relay <devnull+webgeek1234.gmail.com@kernel.org>
Date: Fri, 15 May 2026 15:35:29 -0500
Subject: [PATCH 3/3] arm64: tegra: Add iommu and dma properties for
 Tegra194 QSPI
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-tegra194-qspi-iommu-v1-3-57dfb63cd3d6@gmail.com>
References: <20260515-tegra194-qspi-iommu-v1-0-57dfb63cd3d6@gmail.com>
In-Reply-To: <20260515-tegra194-qspi-iommu-v1-0-57dfb63cd3d6@gmail.com>
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, linux-spi@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778877338; l=1187;
 i=webgeek1234@gmail.com; s=20250217; h=from:subject:message-id;
 bh=Np/pDfMhrl4vh3eC9VslgUn4DVBcUQmUCasGPdu9S6s=;
 b=XNElFQVNTMTXCC1rsHQEhqgqighB+BXthtnfT1GQGvp9+UcgAvg2MufyoHJKVYT7dCA8LSXGx
 ImTaWbQKrbrBQPjCga4kRxY7DIcgD6WmFx8mv8dZq6NsB2fS3mxUkZ9
X-Developer-Key: i=webgeek1234@gmail.com; a=ed25519;
 pk=TQwd6q26txw7bkK7B8qtI/kcAohZc7bHHGSD7domdrU=
X-Endpoint-Received: by B4 Relay for webgeek1234@gmail.com/20250217 with
 auth_id=342
X-Original-From: Aaron Kling <webgeek1234@gmail.com>
Reply-To: webgeek1234@gmail.com

From: Aaron Kling <webgeek1234@gmail.com>

Without iommu and dma enabled, flash storage such as the spi-nor on the
p3668 module times out and cannot complete any transfers.

Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
---
 arch/arm64/boot/dts/nvidia/tegra194.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra194.dtsi b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
index 1d659454a6f9fe..0e0a20befe9e68 100644
--- a/arch/arm64/boot/dts/nvidia/tegra194.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra194.dtsi
@@ -923,6 +923,10 @@ spi@3270000 {
 				 <&bpmp TEGRA194_CLK_QSPI0_PM>;
 			clock-names = "qspi", "qspi_out";
 			resets = <&bpmp TEGRA194_RESET_QSPI0>;
+			iommus = <&smmu TEGRA194_SID_GPCDMA_0>;
+			dma-coherent;
+			dmas = <&gpcdma 5>, <&gpcdma 5>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 
@@ -1013,6 +1017,10 @@ spi@3300000 {
 				 <&bpmp TEGRA194_CLK_QSPI1_PM>;
 			clock-names = "qspi", "qspi_out";
 			resets = <&bpmp TEGRA194_RESET_QSPI1>;
+			iommus = <&smmu TEGRA194_SID_GPCDMA_0>;
+			dma-coherent;
+			dmas = <&gpcdma 6>, <&gpcdma 6>;
+			dma-names = "rx", "tx";
 			status = "disabled";
 		};
 

-- 
2.53.0


