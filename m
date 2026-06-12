Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105F53176E0;
	Fri, 12 Jun 2026 13:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271084; cv=none; b=bv7i+t6/kz+5p6XgnaY6AEG2p/5eJ70YqEKRQ0IBUpPAvhhIB94H5dWs3duwWE1UBsCT+pKDmtt7ikf2f8y6ciIcUoQCnwZ5WKA4p8pEdmgd0vRKfDousuWI5gT7LjnGexmvkFiWZMHJXTH1J58vPGPIGCXS07HlLmFsIYn8swU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271084; c=relaxed/simple;
	bh=ElUFZ0J71drnXO9dcQjG44rWipWYDV2qGeK3PRPBSoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Am6Z6esnWQzKhzfPx1GRjsGhBiNxfMchdg06Gu5GZN68VVQh9H1Vi2+vmyVP6sr+gXZDrNwNcLBwa/GXzbC33lYj9JFFLdhfW7JBAFAOkPVZOe6VoM1JaRtqo7ozsv0SoImn8yhLpXoa9n6Q8TD3X0y17tANNRM98eGDtJT0OcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ps1qWvVk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ps1qWvVk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170A61F000E9;
	Fri, 12 Jun 2026 13:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781271083;
	bh=ElUFZ0J71drnXO9dcQjG44rWipWYDV2qGeK3PRPBSoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ps1qWvVkfWAaxDsjgYj835uoC3J3/BC4WtTYsIcdq4yM2xFXammiqgxnX7lTilyaO
	 83tNB1J5mUKFkE3SgyJTfNSflNzN7nTxszy10ft5xpajHe+kqMyuvczZmMh4v/Auxm
	 PXagO+8O6zQzHQTsyEwn06TTpdbEy64DYzPiS3EiaDuqf6XeOHoOPIvY3HnlcDznrR
	 2yJHeKyCWzgNmBhRpInqCd6BFLEPnDWlgVGAw09u0NMS6lH3cAt/1OttqjaJGJawQR
	 br02oHO9QGhuuXFGEc0VTLgytVC67/amgz09ljk2ziRMX6EWR7/RBcoKzyy/646AGH
	 wnJVp7156q+wg==
Received: by finisterre.sirena.org.uk (Postfix, from userid 1000)
	id A34BF1AC58C5; Fri, 12 Jun 2026 14:31:08 +0100 (BST)
Date: Fri, 12 Jun 2026 14:31:08 +0100
From: Mark Brown <broonie@kernel.org>
To: Changhuang Liang <changhuang.liang@starfivetech.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v1 1/2] dt-bindings: spi: snps,dw-apb-ssi: Add support
 for snps,dwc-ssi-2.00a
Message-ID: <aiwKHANdWVWhaSFA@sirena.co.uk>
References: <20260612125856.8530-1-changhuang.liang@starfivetech.com>
 <20260612125856.8530-2-changhuang.liang@starfivetech.com>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WLwyDBtIUcqAnQnF"
Content-Disposition: inline
In-Reply-To: <20260612125856.8530-2-changhuang.liang@starfivetech.com>
X-Cookie: Nice guys get sick.


--WLwyDBtIUcqAnQnF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 12, 2026 at 05:58:55AM -0700, Changhuang Liang wrote:

> Add a new compatible string "snps,dwc-ssi-2.00a" for the Synopsys
> DesignWare SSI controller version 2.00a.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--WLwyDBtIUcqAnQnF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmosChkACgkQJNaLcl1U
h9DxRgf+I0pbawxU8DD0tiE7vjN+XCjBCDKUpiJ9A03WpZPbcX3GWEryJEPF968U
1A12GVNnE5/ojtxsoeIhkoS4rODVvqsbCSVctiRkvsH+/eYmkCEmDSDXYusUoRvt
75JL9TEJBVuXVOgIhG+rsipRw5o1ywWQimMyNTUX//OHPcHbFd+I30MEMHt0hY8U
ys44058btPGVIuYuHa7Huzxg3vrGgxC4t5qN/JF4it5gvCqHMTf3czu57h1rgiJD
zP87KeXznkQZoxipF1V8GcNRDzSFW6un4R/epGYJ6F0pGr07nfOb9MdA4m1uaADx
rVhpHPWfW57zNj5jWB8Q2RX9FI7Wsg==
=lTWK
-----END PGP SIGNATURE-----

--WLwyDBtIUcqAnQnF--
