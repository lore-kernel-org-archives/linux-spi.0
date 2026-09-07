Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA94951D530;
	Mon,  7 Sep 2026 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788803686; cv=none; b=G/zXDajLwWuLrUB17cIPvdXGtXBRXoVv+4wVxmZ76rqPxH1zhCJOLbMz4VGRIPjY4BvxJm3xb1PCkAY8brZt2/Majpd3suslbHRdunuUVa5PCjag8xryivJu9SSnIBPQZkXZeC4+JW3yeTkTGdBJ2+kPuesSbLi6Et+Q8cOWrZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788803686; c=relaxed/simple;
	bh=XyfbZA/ixpBmVjCPJ8nTfD+CjCeqlsu/hxKTUnWjh1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPLN2FhrDTnaQsbDZL9INTbCIXZU2knt/bKnIRDvO4PTxuWcrfH+P220+cw9oaCdpOMQVv5kV8eRGlUwYbxMhVEpkZi4J2O6H9yxeEmAk0FBgLJ4frK2Exu7G8J7hZ0bt+UMxqcLTds5umkeVgwFSHLXw4rdF4LOrOv/k/aLh2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nyzjDXf1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nyzjDXf1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7681F00A3A;
	Mon,  7 Sep 2026 17:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788803685;
	bh=XyfbZA/ixpBmVjCPJ8nTfD+CjCeqlsu/hxKTUnWjh1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nyzjDXf1cIJSFEAtxTeSGXW4kGWoZRgawPAMk57DTnopUjTzTFBinHkRWSRa6HMvV
	 peo0k8Wct51By4/qlpVbl4sPMbzeIMG28c1NvhZebzbC/2njmk5P1IKo8wZoT4VDSC
	 x4LbcJMOdWvwsfnvhcDp65u62JixZ+ll+SCiRxOHxWIQGIRVWiOUUe/bjea8DQ7R+b
	 xjrUkLulWuRx8Gj2vWE7l0qCBunGLlau2Ay9f2gQ93P+C06aOf3YfyCWkao7oTNm9/
	 l9bud6j4+nvEWbp5INGppVn2ioOko9vN/dPYBmKwK81rC3pNCn9ngcxM6uhHDkgAWr
	 KPQcpXR/makYg==
Date: Mon, 7 Sep 2026 18:54:38 +0100
From: Conor Dooley <conor@kernel.org>
To: wangjia@ultrarisc.com
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Anup Patel <anup@brainfault.org>, Mark Brown <broonie@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
	Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
	dmaengine@vger.kernel.org
Subject: Re: [PATCH v2 06/10] dt-bindings: i2c: dw: Add compatible for
 UltraRISC DP1000 SoC
Message-ID: <20260907-purity-regulator-754568d732d8@spud>
References: <20260907-ultrarisc-dts-v2-0-5eb4c97477c5@ultrarisc.com>
 <20260907-ultrarisc-dts-v2-6-5eb4c97477c5@ultrarisc.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d3s8oTptYL8UWlPp"
Content-Disposition: inline
In-Reply-To: <20260907-ultrarisc-dts-v2-6-5eb4c97477c5@ultrarisc.com>

--d3s8oTptYL8UWlPp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

--d3s8oTptYL8UWlPp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCap76XgAKCRB4tDGHoIJi
0tY0AQDAVilktDjyvug1a1XYy4Zo/VEoy9WNtWTxNVqZ7L4AnQD9Hg4Id7AX48uW
PvbTKH7j0iZeCl6p7nglpmQhyaj6pAI=
=/vVk
-----END PGP SIGNATURE-----

--d3s8oTptYL8UWlPp--
