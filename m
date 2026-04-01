Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67871407573;
	Wed,  1 Apr 2026 11:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775041225; cv=none; b=AS+S2SQzjgZv7zMG/xpLpsJnP8NMfSys6qQ+1kc+1fmNqyyAcCLfoh5pPEOXQ8uJXcmYT78/SkZsoUrbZ5Rfjx90KbbzMxLjGYYTeAwWJtWjQAHOGQ1I8zzwoEhPOU1RJKrvJiqY0Y2FF4NgscYIWHF6uoLL/azCKK57KvZjy3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775041225; c=relaxed/simple;
	bh=P4gPDzIC37mQ2XU2ES1ReyzNW1zgfb4XNdW83riZvtY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=ZgTKHqFQTOrp4Kt7BfkOrMlNUgwMG/GYCgaoinxovAWDEwjxrsqpMOyW43oc1YlHI6+hZfM1obtKxJVvQKWTViapYLUa7p7B3RyD8w1GOXFvAwjmomePEMla6ppm2+JXU8/0gthzo1XbBOVVGSs6FLldpfahFbNejo7/MboYSNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFSPKFYw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFSPKFYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F7EC4CEF7;
	Wed,  1 Apr 2026 11:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775041225;
	bh=P4gPDzIC37mQ2XU2ES1ReyzNW1zgfb4XNdW83riZvtY=;
	h=Date:Subject:Cc:From:To:References:In-Reply-To:From;
	b=sFSPKFYweFFOdfbH0OagWFKdwhTq+1MKRsDYRdV0xhvI13BSdEYfJPfUUliaIsPZ8
	 59delv7rophLlaAEkA816DG+xemnbsLMn18Z6kK1y4E1ZuyYuvEiMYmsbG4+rvLY3I
	 Qg0dOE9Aeo4I0uV48WTnU4mWriwqWLJfSDHwy6X+fp3uaudWzUyNUbrd3BFgqVMo83
	 tMI5nivsa18n4OrbifXTgH/cIcjG+hjs8npXnLpiNmTcbPCtrDpksT6Q7eFhIbhR0B
	 +2LuH1JNsqXCPyTqkH3RAMie5qpNbRxJA/H/Fk6ORUkatElASRqgw/y/0ofC3NGIDj
	 UyiGqB+8ucCjg==
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=20ef4b1937c524c4b5e1cf3c92e15c2d5ceb7be4f72bca70e5220b66a6c0;
 micalg=pgp-sha384; protocol="application/pgp-signature"
Date: Wed, 01 Apr 2026 13:00:20 +0200
Message-Id: <DHHRLJLX9AVS.CRZTDV7TP1DO@kernel.org>
Subject: Re: [PATCH RFC 6/7] spi: spi-mem: Call spi_set_rx_sampling_point()
 for each op
Cc: "Frieder Schrempf" <frieder@fris.de>, "Mark Brown" <broonie@kernel.org>,
 "Richard Weinberger" <richard@nod.at>, "Vignesh Raghavendra"
 <vigneshr@ti.com>, "Han Xu" <han.xu@nxp.com>, "Eberhard Stoll"
 <eberhard.stoll@kontron.de>, "Tudor Ambarus" <tudor.ambarus@linaro.org>,
 "Pratyush Yadav" <pratyush@kernel.org>, <linux-spi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
 <imx@lists.linux.dev>, "Santhosh Kumar K" <s-k6@ti.com>
From: "Michael Walle" <mwalle@kernel.org>
To: "Miquel Raynal" <miquel.raynal@bootlin.com>, "Frieder Schrempf"
 <frieder.schrempf@kontron.de>
X-Mailer: aerc 0.20.0
References: <20260303-fsl-qspi-rx-sampling-delay-v1-0-9326bbc492d6@kontron.de> <20260303-fsl-qspi-rx-sampling-delay-v1-6-9326bbc492d6@kontron.de> <87wlzlnioh.fsf@bootlin.com> <a1a711c4-d9df-4bba-8831-2ec787f84cc4@kontron.de> <87ecl09wtv.fsf@bootlin.com> <633fee13-a397-410f-a595-db95e04b8110@kontron.de> <87ldf881gr.fsf@bootlin.com> <fed5fba7-0536-4f92-8372-f4b47c89b1c2@kontron.de> <874ilv84j8.fsf@bootlin.com>
In-Reply-To: <874ilv84j8.fsf@bootlin.com>

--20ef4b1937c524c4b5e1cf3c92e15c2d5ceb7be4f72bca70e5220b66a6c0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Wed Apr 1, 2026 at 10:32 AM CEST, Miquel Raynal wrote:
>> Let's say for a worst case scenario a chip has an RX delay of 20ns (the
>> highest I've seen in datasheets so far is 8ns). In that case the maximum
>> clock we could safely use for reading the ID would be 1/(2*20e-9) =3D
>> 25MHz. Do you think it really makes much of a difference if we read the
>> ID (only a handful of bytes) at 25MHz or full speed (e. g. 104 MHz)? I
>> mean this should be fast enough either way, no? But maybe I'm misjudging
>> this.
>
> I am honestly not a big fan of the global penalty, but I am not totally
> opposed either, especially since you just said you only observed 8ns
> delays at most. This is 62.5MHz, which is already above what most
> designs use, so the penalty would be minimal. What about taking this
> approach and see if that fixes most of our use cases?

What are the actual numbers we are talking about here? I mean, at
least for SPI NOR, we only read the ID *once*. And it takes about 56
bits (command + id length of 6). That is about 2us at 25MHz. I'd
guess the setup and the software handling takes far longer than
that.

-michael

--20ef4b1937c524c4b5e1cf3c92e15c2d5ceb7be4f72bca70e5220b66a6c0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKgEABMJADAWIQTIVZIcOo5wfU/AngkSJzzuPgIf+AUCacz6xRIcbXdhbGxlQGtl
cm5lbC5vcmcACgkQEic87j4CH/jivwF7BfdJ2oJO2K3l5ud626MmhRiz2MLQbewR
E5u5gITBAhN2jHdEai/ryzBXc5JvEBklAYCLd3qRamZ8b67NsNkXMP4lXC5UL7VN
gh53mq8O5Msc590EhY5l3GZxv8zwbYJGhFU=
=FqVe
-----END PGP SIGNATURE-----

--20ef4b1937c524c4b5e1cf3c92e15c2d5ceb7be4f72bca70e5220b66a6c0--
