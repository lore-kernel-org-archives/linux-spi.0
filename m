Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1719D44CAFE
	for <linux-spi@vger.kernel.org>; Tue, 20 Jan 2026 19:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768936318; cv=none; b=pRQa0IK0OM4erVsHPtUZrlUfDwHAPkMAKwyCNCAqiL7JgEcQC7mVZAheWXTg2WI1HLB3fkN3dVG+X7Ro4/qRFfBwu6KGyZP1YuykKATVRds4UW/83fSsfzXALG1fp1/+4FZF51UeBR5jyzuu4LS/Ii625Zcx+teXd/Phya8ZQdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768936318; c=relaxed/simple;
	bh=XUTTZ+LQ8ip5e05hxZlANkRvBkum9oiZ0Z+yc+zZoDU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cScz6WgC2D/rYVLggdVlidIiLWwTj/QJKZyZ8W2jA4lImfiKNC/8TAZPRzTk3M/f1XR8IezMODOiU4Le0CPgOo9dKGmdAD28C1lScHmUt+/NjzGOtuD+zZfsX3ketpcdVbIfDUJ6Ys9pC1SvIz4L15P4141UptYePFQ5VRZJkrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai; spf=pass smtp.mailfrom=nexthop.ai; dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b=ZA7c3uoi; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexthop.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexthop.ai header.i=@nexthop.ai header.b="ZA7c3uoi"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-81f42a49437so2882939b3a.0
        for <linux-spi@vger.kernel.org>; Tue, 20 Jan 2026 11:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexthop.ai; s=google; t=1768936316; x=1769541116; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ub8N3tY8GwCy8TqVlqK7eFFGB7gNEjREB31fE0IlsTg=;
        b=ZA7c3uoiMSZWwTlRM4WmuRk+7pB6wSBc4pw/xD6IFTRB7g8zjejFCIjFefLhIZdj/C
         I4y3mwuWtf12iCXyINo6re4QpV8bMzVYxeVuzvv2eR8aboxALlIqwq6WaPqo9jQY4SVA
         B+RmkaXB5tOEke/DTdeLQx3XvbsJqm6Gxe1mVGMiczyO0T3kyzpIIMniLRh4TPpoo90C
         6iRTp94Cx9TbtySnIipFDbXQlhS6KM6O1abNa/85DzJlZeqbnaaHWbtb4e5IfwgV90BN
         xnLQSUUq/+91m1iywRYNsN1dH/yOPNioo5fr24tbR3CoEuoUFOp3nSxT1MFhQnFfYIrZ
         InIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768936316; x=1769541116;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ub8N3tY8GwCy8TqVlqK7eFFGB7gNEjREB31fE0IlsTg=;
        b=uY1R21EzMNo3idRUdS4NrB9Pc8ASw1WgbZwB99wFsIRbnPqMM9VzZ/2NsgQhjEsHfw
         Js6tompWl0AV+VjHsqH7ioFi4QC+Agk/G+/AKJntY2hyKo2X0vwbhYNZJzQGsQeeWFN+
         9CAwvjO2ukJBcQbVUHA3rPAJeFqEeBBkUxTy2IyB98UPomBHVXDW1wyam1zgl608S+dn
         WAt7t1mayl5pOYVPUiuS2eetq0WRBmaII6MN8xZaDekT4/60A6YHm0FqHwJfW0zui+pv
         X6Sbk028xc7X9XKSwjwgIVCM9YpvGZYnHgEukAtBpxBV+545yShfJR3Gad/Z1AelB5tn
         Il0A==
X-Forwarded-Encrypted: i=1; AJvYcCVP9TO2WqhKJveSc/e1iohrEwyuaOj82MtBr258ewRSHOWbKOu0vLAd8UezNxmzUwG0TafUpFUD5Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7KjiHn7/0Kja6/e8X8IVPyIUoXGOGV7ceGDL8aokRfai4Aism
	1LVMI0UO2m1utwWClmiUwIs4FbImwRUxlQTRp9xkh1uhiExpuZTYJeVUKOijH2YLBxI=
X-Gm-Gg: AY/fxX7KDJaQXMaHySYgUNdbajkGD7KJ2snVkh9dwVqv5abFw8I6JaaYl46TylyKvY1
	QgInIlouqNMlJKSo+2DHAX3oFE7E0PymeRIiFqAcfrVtMVWksfK5ud/+VbfdN6ibhOi2ILmDyy/
	y6HzxFMhCt7d35Mp3eQdTZ3QcchWJhH6ge5LHorRTARU1AApfjzpNgbkdiPAtCDiQtyRNTNvKt2
	wrin3RxwvS6Tj3iYsMuubQbotqBXFyLUKlqBMseulbiOFCOEWhxNoOVZJ3rLXwveaJE3MOXsUHC
	SVmEVOB5CCrK8+WDv1tnPGscsiton2UdXORWfOTnSSa9css9cI9Wj2r5vBgRGTl6TQbOXLHtRIs
	38tN1s5IhuDntQMjQcEpwwNwfeijdBpbrJYkqF2JDQA2bJCNH9baSENxQuRodet0PeoVgfdlnqZ
	HdhYvOUtwy4Ap2E91MJM44gDfAXYubUS9up3GDozkmiTfB9udeg4kCdGfTk0CnqoOP74V02UI=
X-Received: by 2002:a05:6a21:7305:b0:36c:2cf5:9b06 with SMTP id adf61e73a8af0-38e45eacbfamr2933705637.79.1768936316195;
        Tue, 20 Jan 2026 11:11:56 -0800 (PST)
Received: from smtpclient.apple (c-24-16-26-157.hsd1.wa.comcast.net. [24.16.26.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c5edf354b24sm12357331a12.28.2026.01.20.11.11.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jan 2026 11:11:55 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH v3 3/3] spi: xilinx: use device property accessors.
From: Abdurrahman Hussain <abdurrahman@nexthop.ai>
In-Reply-To: <c3fc04a4-4b09-4c6a-a0f1-e5aa92a22976@sirena.org.uk>
Date: Tue, 20 Jan 2026 11:11:44 -0800
Cc: Michal Simek <michal.simek@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>,
 linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <80A8F67E-7A01-4F9F-9D84-29722678A2CE@nexthop.ai>
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
 <c3fc04a4-4b09-4c6a-a0f1-e5aa92a22976@sirena.org.uk>
To: Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3864.300.41.1.7)



> On Jan 20, 2026, at 10:45=E2=80=AFAM, Mark Brown <broonie@kernel.org> =
wrote:
>=20
> On Mon, Jan 19, 2026 at 04:20:06PM -0800, Abdurrahman Hussain wrote:
>=20
> To repeat once again:
>=20
> | Please fix your mail client to word wrap within paragraphs at =
something
> | substantially less than 80 columns.  Doing this makes your messages =
much
> | easier to read and reply to.
>=20
>>> On Jan 19, 2026, at 3:20=E2=80=AFPM, Mark Brown <broonie@kernel.org> =
wrote:
>=20
>>>> But rather, to re-use the existing drivers as much as possible by =
relying on the
>>>> special DT namespace link "PRP0001":
>=20
>>> What is the goal in avoiding using native ACPI bindings?  PRP0001 is =
a
>>> workaround for cases where you have things that ACPI has never =
dreamed
>>> of and can't abstract well but which have already been handled by =
DT,
>>> it is not something we're aiming.  The hardware you have described
>>> seems like fairly normal server style hardware and like it should =
fit
>>> well with normal ACPI.  Adding ACPI IDs to existing drivers is =
pretty
>>> common and standard, I'd class that as reuse.
>=20
>> I did not intentionally avoid introducing new ACPI _HIDs, but at the =
same time
>> don=E2=80=99t understand the need to, especially when PRP0001 =
workaround works and
>> it works well. We don=E2=80=99t own the spi-xilinx driver and neither =
do we own the i2c-xiic.
>> These are standard Xilinx IP platform drivers that could be made =
usable on ACPI platforms
>> by just switching to device_property APIs. Which is what these series =
is trying to do.
>=20
> It's just not idiomatic ACPI, indeed some other OSs actively reject =
the
> idea of binding to PRP0001 described devices.  In general we don't =
want
> to encourage people needlessly creating unusual hardware descriptions,
> that provides better future proofing so we're less likely to have to
> work around our own past decisions and avoids causing hassle for other
> OS vendors with having to deal with Linux special firmware =
descriptions.
>=20
>>> As far as I can see from the example you posted the devices are all
>>> fairly standard and just need IDs assigning to work naturally with =
ACPI.
>>> There's possibly an argument for using PRP0001 for the flash given =
that
>>> it's not especially idiomatic to have OS visible flash on ACPI =
systems,
>>> usually flash would only be visible to UEFI, but equally the =
description
>>> would trivial and systems wouldn't have to use it.
>=20
>> You mention =E2=80=9Cidiomatic=E2=80=9D a lot. Are you implying the =
SPI NOR-flash devices should
>> not be exposed to user-space? Then why does the spi-nor driver even =
exist?
>=20
> Flashes are widely used on non-ACPI systems where exposing them to the
> OS is a perfectly normal and standard thing to do.  Usually on a =
system
> with ACPI NOR flashes would be purely for the firmware to store itself
> and it's data, storage exposed to the OS would be at least eMMC or
> something.  ACPI has a very strong idea of what the systems it is used
> with should look like.
>=20
>> We have a SPI device that needs to be accessible from users-space in =
order to
>> =E2=80=9Cflash" various FPGAs. How do you suggest we do that?
>=20
> You should probably register the device, it's just a question of if =
it's
> weird enough that it does actually fit with PRP0001 or if it's =
something
> with general enough application in ACPI systems that a HID should be
> allocated.
>=20
>> Also, there are hundreds of drivers in the DT namespace that are =
missing the ACPI IDs today.
>> Do you suggest adding ACPI IDs to every driver just so it=E2=80=99s =
more =E2=80=9Cidiomatic=E2=80=9D to use?
>=20
> To drivers that are used on ACPI systems, yes.  Many devices wouldn't =
be
> used on ACPI systems, or would be expected to be exposed differently
> (for example, hidden behind AML).

This is not for a normal off the shelf server. In our case we are =
building an embedded
switch with an AMD CPU and Xilinx FPGAs that happens to use EDK2 based =
BIOS and ACPI.

We, as a vendor, have full control of the BIOS/ACPI and would like to =
use it describe
hardware and make as much use of the standard Linux drivers as possible. =
We have dozens of
I2C devices like temp sensors, voltage regulators, DCDC converters, =
EEPROMS, SPI-NOR flash
devices behind the Xilinx IP blocks. Most of the devices we use don=E2=80=99=
t have proper ACPI _HIDs.

>=20
>> I am just trying to get this 2-line small change merged so we can =
start using the standard spi-xilinx driver today. I am not trying to =
boil the ocean.
>=20
> I mean, adding a HID wouldn't take substantially more code.

We could, but we don=E2=80=99t own the Xilinx IP blocks. Are we not =
justified in using PRP0001
hack until the driver owner adds the HIDs? Wasn=E2=80=99t PRP0001 =
created as an escape hatch for
these kind of scenarios?


>=20
>>> There is the bit where there's a PCI bus in the way and you don't =
use
>>> ACPI particularly idiomatically...  I can see the dodging out on the =
PCI
>>> bus description, but the way the devices behind the PCI bus are
>>> described seems confusing.
>=20
>> What exactly about this usage is not idiomatic? Our PCI device =
description in ACPI looks like
>> this (GPP5 is the PCIe bridge under which the FPGA is located):
>=20
> The use of PRP0001.

Understood.


