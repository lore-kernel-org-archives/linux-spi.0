Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8C43AEF35;
	Tue,  3 Feb 2026 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142782; cv=none; b=YTFChhW9GIPiUlTMyVNU4D7t3+tuSkhL62WLDWkEx/eOuWHV/BPbhR9QUSbCtoNQN7fUHlUZaQl+SChVkm7BgrpNNTVcBjKfQ65wDDNkkY16aAc2/zL26o9LRXr9SN7Jq/XcMblNLd87abzpTtuZ7+J1y4LSLEBTKsYUkugx9+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142782; c=relaxed/simple;
	bh=oYhe8dDtvNlpyrT2WI8oHXc9QY8uA1iM2uNTGW8KnM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AMcaFqSlIPiFqZ4DvUXFGNejcDMjWGoZNh9c9E58gkar22vWGD66ARr7o5Wt20vQG054q3e78SdJSLo+Y44ueeALAyFzb2xkOoQPWYTskw+N6lpVPLle/jRfzINYfTzVicBYzFDHB+nB/5KBqVrH/ptLt04yEVu1P69c7U4S56w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T6wPJU9f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T6wPJU9f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8C4EC19421;
	Tue,  3 Feb 2026 18:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770142781;
	bh=oYhe8dDtvNlpyrT2WI8oHXc9QY8uA1iM2uNTGW8KnM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T6wPJU9fcBNS1G8ixyYw7EI2dBsyL6+oDqXyjWP4dYx3yAjicK5jiBb7Hoi/jo5y+
	 JwSBwuRpP0YzyXrndGNqNByXXty0EmIuLsLVd9+RadcELpJ7xr4zG2DCpa4HY5Wsvj
	 9ZoMFJgL/QOemYxSc9BY2iABitIJQV25h8zMgxag9YhsMiL/+CXERs7hhYg0WbsKJs
	 pDkKtGJS0gKRJ7SVM2sp4fGT9N5RyrYHtwZ98o6Hrca86HnHkEQjK+PRe0FLN95fbF
	 dsdZNxvL8m4xzaScnmMn9ca72VmCABTeBIQJDL4ruTCg1UAUHb3fzKw5yto9ELQucM
	 apIaApoW45O1g==
Date: Tue, 3 Feb 2026 18:19:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Michal Simek <michal.simek@amd.com>, linux-spi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] spi: xilinx: use device property accessors.
Message-ID: <235729f3-4a81-4b1d-8ce4-c2a394b542db@sirena.org.uk>
References: <20260203-spi-xilinx-v4-1-42f7c326061b@nexthop.ai>
 <849bf95a-133e-4faa-973c-19342afca327@sirena.org.uk>
 <1DCB4BC6-372C-432C-A6C1-B089711CF8A0@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2e0gAuQCD+J7pxBs"
Content-Disposition: inline
In-Reply-To: <1DCB4BC6-372C-432C-A6C1-B089711CF8A0@nexthop.ai>
X-Cookie: Your supervisor is thinking about you.


--2e0gAuQCD+J7pxBs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2026 at 10:16:46AM -0800, Abdurrahman Hussain wrote:
> > On Feb 3, 2026, at 4:48=E2=80=AFAM, Mark Brown <broonie@kernel.org> wro=
te:
> > On Tue, Feb 03, 2026 at 01:55:12AM +0000, Abdurrahman Hussain via B4 Re=
lay wrote:

> >> ---
> >> Changes in v4:
> >> - Removed patches making the irq optional.
> >> - Link to v3: https://lore.kernel.org/r/20260122-spi-xilinx-v3-1-8cea2=
0e82f0b@nexthop.ai
> >> ---

> > That was the changelog for v3 as well (and you dropped the changelog for
> > v3=E2=80=A6).

> Sorry, I haven=E2=80=99t realized v3 was the same. Do you want me to chan=
ge anything in this patch?

No, it's more just understanding what the change is.

--2e0gAuQCD+J7pxBs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmCPDkACgkQJNaLcl1U
h9Dl3Af6AlIRYHP0eQB/A7CYtmSVJ0OAvt+0gQq0ZAdT3DfA47WKUL/SaSqqkDu5
TG3Kxk68eC0ys9N3tryzti4VyXdSxmUevLe3EDUAAyHMhJl1daIz9WouMdfcoa1d
H54BR60JsUAgS/q8sJ1+l+1oLn3a6I2ePobuNkGGW6W1gB32veTVGgACSpu/xkDj
51kZ8r6TFgPcarzD4JkjOQXholP8IW5DKGXi2ybtuY+DWbb06pISPxQurstSbOMH
NReQPc76d1A46m/l06corm+yPDTgQCRBnlkaivS32APRVgnIZahFv9QIakpoI3a6
Z8WgLTJFZQIEZ2oPQwkva6M2wbfPEw==
=pbOu
-----END PGP SIGNATURE-----

--2e0gAuQCD+J7pxBs--
