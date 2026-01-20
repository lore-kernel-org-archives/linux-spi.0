Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1104C42882A;
	Tue, 20 Jan 2026 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768934760; cv=none; b=ev16xDzw2cFj6YlZ43V4yvh0W0vrtIUP7GRf9rhRnLIhKzy77reVyTD89dbD33EV+rZv8trT2vFtJ84y88F8nWjjS/ORfzY5bbB95X6oa1a+bn61BpsbUdiArygvIzur4c5VyhFgVaP69fSP3YGmyN7TjQOih42MagvLZ04JAyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768934760; c=relaxed/simple;
	bh=QxtCkYnJbx/KGEnrRmlYKad20cgBUl4NjFIxcVB32gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pz7O0Qce2PjEuQcRT6h8lQ6WEw/vvpL+DPNZiawTJd4lrBcsZZujoI4tFWUq/a1IqRpfobunYJ5E9tV1+gARi31ScV+8kYqMRLbwl7+jyqkfzmF7v6y4S8bUb2sTEIRHnbu+81SgrgEb8HC/qJEvPR25HsMfzRVmaljOhIjRoQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzzP0qd2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzzP0qd2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4709DC16AAE;
	Tue, 20 Jan 2026 18:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768934759;
	bh=QxtCkYnJbx/KGEnrRmlYKad20cgBUl4NjFIxcVB32gI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jzzP0qd2WF87kE+VUFREmoAKdd+xuI01bkTDMfbeIWqrOwLPoKhm4JWepQDPhSu8G
	 j6Qc+kM6yMqte9tGGKr0DSBN+U6GHnfiklG5lPpMubsiyP9VddPCjGwGyeH6ZV3vel
	 vSlY+o5viMId/nKUpzMRUGdZ6+E8MSDQTrSkYnQ6S52f2IVmfrovt9jetOw/InHmb2
	 ISYAfVipricA+sdcGC65lAFVmxBmUo+bFZdDstsI6Ye27GXvZblfY0R6nvKdxrNWOp
	 Sp0amlGv6zHrGw9uPKJcAge94Di3cpsY3c5ZCRRJd/FA1DWygR9QlpEuZh3kEjdT7R
	 71R4j0qcumHtA==
Date: Tue, 20 Jan 2026 18:45:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Michal Simek <michal.simek@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] spi: xilinx: use device property accessors.
Message-ID: <c3fc04a4-4b09-4c6a-a0f1-e5aa92a22976@sirena.org.uk>
References: <b1b79de0-a078-486d-b3e9-96899354407c@sirena.org.uk>
 <3D1B59A7-6E57-4C8C-AA95-EA7AA115264F@nexthop.ai>
 <b9ad8ab8-7985-4c89-a82b-c7f31d32c167@sirena.org.uk>
 <a6d57890-89c1-445e-836c-d8239d20c621@amd.com>
 <b03307f7-93f6-4680-9241-cf28b5456fd0@sirena.org.uk>
 <a3fcef3a-d1e9-4b46-b114-3a82575e052e@amd.com>
 <980ad372-a2c7-417c-91f9-4958d3d1aaca@sirena.org.uk>
 <4831B269-DFC1-40E0-96B7-67981AC72562@nexthop.ai>
 <6e06696e-09a4-46e0-98fa-252690b888e0@sirena.org.uk>
 <BF71A04E-7FFB-42D1-8C8D-6FD13415EED5@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="actvbmG5SZ1QUxC+"
Content-Disposition: inline
In-Reply-To: <BF71A04E-7FFB-42D1-8C8D-6FD13415EED5@nexthop.ai>
X-Cookie: Slippery when wet.


--actvbmG5SZ1QUxC+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 04:20:06PM -0800, Abdurrahman Hussain wrote:

To repeat once again:

| Please fix your mail client to word wrap within paragraphs at something
| substantially less than 80 columns.  Doing this makes your messages much
| easier to read and reply to.

> > On Jan 19, 2026, at 3:20=E2=80=AFPM, Mark Brown <broonie@kernel.org> wr=
ote:

> >> But rather, to re-use the existing drivers as much as possible by rely=
ing on the
> >> special DT namespace link "PRP0001":

> > What is the goal in avoiding using native ACPI bindings?  PRP0001 is a
> > workaround for cases where you have things that ACPI has never dreamed
> > of and can't abstract well but which have already been handled by DT,
> > it is not something we're aiming.  The hardware you have described
> > seems like fairly normal server style hardware and like it should fit
> > well with normal ACPI.  Adding ACPI IDs to existing drivers is pretty
> > common and standard, I'd class that as reuse.

> I did not intentionally avoid introducing new ACPI _HIDs, but at the same=
 time
> don=E2=80=99t understand the need to, especially when PRP0001 workaround =
works and
> it works well. We don=E2=80=99t own the spi-xilinx driver and neither do =
we own the i2c-xiic.
> These are standard Xilinx IP platform drivers that could be made usable o=
n ACPI platforms
> by just switching to device_property APIs. Which is what these series is =
trying to do.

It's just not idiomatic ACPI, indeed some other OSs actively reject the
idea of binding to PRP0001 described devices.  In general we don't want
to encourage people needlessly creating unusual hardware descriptions,
that provides better future proofing so we're less likely to have to
work around our own past decisions and avoids causing hassle for other
OS vendors with having to deal with Linux special firmware descriptions.

> > As far as I can see from the example you posted the devices are all
> > fairly standard and just need IDs assigning to work naturally with ACPI.
> > There's possibly an argument for using PRP0001 for the flash given that
> > it's not especially idiomatic to have OS visible flash on ACPI systems,
> > usually flash would only be visible to UEFI, but equally the description
> > would trivial and systems wouldn't have to use it.

> You mention =E2=80=9Cidiomatic=E2=80=9D a lot. Are you implying the SPI N=
OR-flash devices should
> not be exposed to user-space? Then why does the spi-nor driver even exist?

Flashes are widely used on non-ACPI systems where exposing them to the
OS is a perfectly normal and standard thing to do.  Usually on a system
with ACPI NOR flashes would be purely for the firmware to store itself
and it's data, storage exposed to the OS would be at least eMMC or
something.  ACPI has a very strong idea of what the systems it is used
with should look like.

> We have a SPI device that needs to be accessible from users-space in orde=
r to
> =E2=80=9Cflash" various FPGAs. How do you suggest we do that?

You should probably register the device, it's just a question of if it's
weird enough that it does actually fit with PRP0001 or if it's something
with general enough application in ACPI systems that a HID should be
allocated.

> Also, there are hundreds of drivers in the DT namespace that are missing =
the ACPI IDs today.
> Do you suggest adding ACPI IDs to every driver just so it=E2=80=99s more =
=E2=80=9Cidiomatic=E2=80=9D to use?

To drivers that are used on ACPI systems, yes.  Many devices wouldn't be
used on ACPI systems, or would be expected to be exposed differently
(for example, hidden behind AML).

> I am just trying to get this 2-line small change merged so we can start u=
sing the standard spi-xilinx driver today. I am not trying to boil the ocea=
n.

I mean, adding a HID wouldn't take substantially more code.

> > There is the bit where there's a PCI bus in the way and you don't use
> > ACPI particularly idiomatically...  I can see the dodging out on the PCI
> > bus description, but the way the devices behind the PCI bus are
> > described seems confusing.

> What exactly about this usage is not idiomatic? Our PCI device descriptio=
n in ACPI looks like
> this (GPP5 is the PCIe bridge under which the FPGA is located):

The use of PRP0001.

--actvbmG5SZ1QUxC+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlvzWEACgkQJNaLcl1U
h9A1Lwf9EIKncY79XfwBNkHduXMoAfGtv9+VAuS/tFK/H3fYR+tXso2/dso8PDbu
lTq6ct+yulP+9nD2wtNxZ2LcsxSy2WcqVcJ3pLAVJk6AdjqNuG+dXAHcxhkfiDG5
kS6Ayw43aMOgJ5UTO3fmb/fU8PMe0R/v1Dpp+jXuoEJ2jKU7jO9injv+ZSUXug1Q
pnNjuP2fH/F+3uEq3NRu5cYyQhvLyndQmucNjyLZtk8qTFfkNQjhcLZgPWoghB8L
h2q5jx/XSORykcTEc7F3ySC0rqp15mAUWO6SFgIkU0vDoJ83+3L9Wh6EqqR1OlIy
jt/3GM+RoRXCUaZy66FYFLD+tnZp+g==
=whTj
-----END PGP SIGNATURE-----

--actvbmG5SZ1QUxC+--
