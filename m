Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F1D4BA1C1;
	Mon,  5 Oct 2026 15:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214950; cv=none; b=XMvk3qbqECMq3E0VHCJ3OPL3jk6paZdz1pVTraayb89NEmNuHWNOI3+aLnxF6rcZ5IbgB+ly7nKXMsP2SUhN4zvWlC+RTty5m+JNEGmWd/K+A4pFNDQCF4b+iWoEY+lyiTR3bXOY/9JaD6XPexmXb+rLg1YSCvBkQjw1i64Xmrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214950; c=relaxed/simple;
	bh=fj4OMuH0jQ1sZSqKm2Ek6vC7DvUQIrXRLg10NYu7wH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DhWqbwJL4VnBS4umjwKnXpZb+15ZiF2LLUvdjxO5Y5COvNRLS6fTnWOIC881puRobTDPMQNfx30wzCIzKyBJLEaXIcCV+/3j8WIRHzGwoWIMM5PAl1H5PMgVmRqQF6QQ8tZSD1hZNo1MaMUeczzGYk7F3K+lYmIuIu0bCrZOUjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KhxX5TlG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KhxX5TlG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D26C1F000FF;
	Mon,  5 Oct 2026 15:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791214949;
	bh=4LoR9vP2iNc+7lsbl3WuvZLwu4ihDSdaejDj2zJPu/I=;
	h=From:To:Cc:Subject:Date;
	b=KhxX5TlGxr62rTZ97hqidI4+S8PTq1/pH30x+i7UmDdQMc3wZ0ij4inxOFRiHyLsx
	 0DLCoIBWN/5JoaulW2G/7dFS4XFVWA8cBVuyIOIILWiZtZk2R9ZY9zaNb1rZarlgze
	 WGl4kjR8GNds2kvWKoFgoSsmmxnN8KLTZ2FkBbWOCSo8CrAZ/Tew0HrU7Ow4f9SI+d
	 Ae58Gx8zj0VM1AYJUsiQC3C+TtQ8x2ltu98rLsyptj8S0goaTeGXU0CB5fRemH3qBW
	 tvUGUVGwu5J8VnMJJQ0wYai4WPxAG+ZokM7FqoPva5GZRmI6XnxiSr2iIfmWOZKqZG
	 qBEMY2668nFEg==
From: Jisheng Zhang <jszhang@kernel.org>
To: Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] spi: dt-bindings: snps,dw-apb-ssi: Add Synaptics sl2610 spi
Date: Mon,  5 Oct 2026 23:22:30 +0800
Message-ID: <20261005152230.25294-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the compatible for the Synaptics SL2610 SoC SPI controllers, which
are compatible with the Synopsys DesignWare APB SSI.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
This is one of the "arm64: add Synaptics SL261X SoCs and RDK boards"
series, I want to send it as a separate patch.

since v1:
 - use sl2610 instead of sl261x
 - send as a separate patch

 Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
index 1e70c6804d5d..20c123601b51 100644
--- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
+++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.yaml
@@ -62,6 +62,7 @@ properties:
               - mscc,ocelot-spi
               - mscc,jaguar2-spi
               - sophgo,sg2042-spi
+              - syna,sl2610-spi
               - thead,th1520-spi
           - const: snps,dw-apb-ssi
       - description: Vendor controllers compatible with v1.01a
-- 
2.53.0

