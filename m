Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A80C34D4FB;
	Tue, 20 Jan 2026 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768943104; cv=none; b=aNJ+/45NySq+X2iPjlfHq4FGh4PV9o0DBONZ6jBgX3CCWXv9GV1E+f3UUlUiqh9rHen5ypX2A8to5hDYKegV4ZcRhlz0MZ2N8HhzXnrIvTuzjjYm9N/dHjNCBH2DIbZx4ElE2TSKT8PEHGOLO35G4IdPN21tTy2nzsCzJC2Asls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768943104; c=relaxed/simple;
	bh=y6JkTdrfZ0IdqU5DBnuy7dDWlv3s+hrrid20IbLAFIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtS13qN9bmD2mWuSLHW/XJVoP7o3znWVFsYUzXMMdVaK4+RfEkGSVk6iK1yw6wcucg1LdM3FsQJRP6umUI6Ee19FOWwhfvsYUaL1gZYVrWbEASKwtF8XoJBkA4VgY+VIYct5otztpLjbRU8UxljlEkLRhLC8nyUpyhGAllPVCRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axYfTCER; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axYfTCER"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE21C16AAE;
	Tue, 20 Jan 2026 21:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768943103;
	bh=y6JkTdrfZ0IdqU5DBnuy7dDWlv3s+hrrid20IbLAFIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=axYfTCERvt9h65ERKYbSIt98DAmiMInhCHMPaQOdF3Fao3B1JyD+Q39dcUZxhhsbF
	 bzhz13Nv2EEO9MZym2dD4UTXUrLC704WHvfDr0JR0KvWBOMiVo0Myzbt2Q+mLDVsXZ
	 vLNCBg7Q9vLv1ctbRO2QA2IulWdApdGFolNUsJP/b9B0dffoMAAVBMn5LDSX4SISky
	 NvMrc9M68x7bfOs3/14PrLuSKW7BK5kJAWBllhDtS9FTTXd76AFP+9QY/O8A0Q2MDP
	 VvTzmoGdKZnWgCCTost15YIpRIdamN7yJkwl5UQRihpMIpA5WDd3Eu/ByHgCFj1mlz
	 QtTJVlFWR5jDg==
Date: Tue, 20 Jan 2026 21:04:58 +0000
From: Mark Brown <broonie@kernel.org>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>
Cc: Michal Simek <michal.simek@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] spi: xilinx: use device property accessors.
Message-ID: <817bcc43-7f10-4329-8924-6c375eb73ff2@sirena.org.uk>
References: <b9ad8ab8-7985-4c89-a82b-c7f31d32c167@sirena.org.uk>
 <a6d57890-89c1-445e-836c-d8239d20c621@amd.com>
 <b03307f7-93f6-4680-9241-cf28b5456fd0@sirena.org.uk>
 <a3fcef3a-d1e9-4b46-b114-3a82575e052e@amd.com>
 <980ad372-a2c7-417c-91f9-4958d3d1aaca@sirena.org.uk>
 <4831B269-DFC1-40E0-96B7-67981AC72562@nexthop.ai>
 <6e06696e-09a4-46e0-98fa-252690b888e0@sirena.org.uk>
 <BF71A04E-7FFB-42D1-8C8D-6FD13415EED5@nexthop.ai>
 <c3fc04a4-4b09-4c6a-a0f1-e5aa92a22976@sirena.org.uk>
 <80A8F67E-7A01-4F9F-9D84-29722678A2CE@nexthop.ai>
Precedence: bulk
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dzBsCT7hqYc2f/af"
Content-Disposition: inline
In-Reply-To: <80A8F67E-7A01-4F9F-9D84-29722678A2CE@nexthop.ai>
X-Cookie: Slippery when wet.


--dzBsCT7hqYc2f/af
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 11:11:44AM -0800, Abdurrahman Hussain wrote:
> > On Jan 20, 2026, at 10:45=E2=80=AFAM, Mark Brown <broonie@kernel.org> w=
rote:
> > On Mon, Jan 19, 2026 at 04:20:06PM -0800, Abdurrahman Hussain wrote:

Let me once more renew my plea:

> > To repeat once again:

> > | Please fix your mail client to word wrap within paragraphs at somethi=
ng
> > | substantially less than 80 columns.  Doing this makes your messages m=
uch
> > | easier to read and reply to.

> > To drivers that are used on ACPI systems, yes.  Many devices wouldn't be
> > used on ACPI systems, or would be expected to be exposed differently
> > (for example, hidden behind AML).

> This is not for a normal off the shelf server. In our case we are buildin=
g an embedded
> switch with an AMD CPU and Xilinx FPGAs that happens to use EDK2 based BI=
OS and ACPI.

Sure, AFAICT it's mostly a PCI card with a bunch of stuff on it from a
software point of view.

> >> I am just trying to get this 2-line small change merged so we can star=
t using the standard spi-xilinx driver today. I am not trying to boil the o=
cean.

> > I mean, adding a HID wouldn't take substantially more code.

> We could, but we don=E2=80=99t own the Xilinx IP blocks. Are we not justi=
fied in using PRP0001
> hack until the driver owner adds the HIDs? Wasn=E2=80=99t PRP0001 created=
 as an escape hatch for
> these kind of scenarios?

No, it's more there for the cases where embedded ACPI systems need to
import non-trivial DT bindings so they can avoid having to respecify
things that ACPI really doesn't cope with or for local hacks.  See
Andy's reply earlier in the thread:

   https://lore.kernel.org/r/aW9JihlsjnJ-uBul@black.igk.intel.com

AFAICT for ACPI the HID assigment is a bit of a free for all in practice
- board vendors generally seem perfectly happy to just pick something if
the silicon vendor didn't do something.  Just look at all the parts with
INTxxxx IDs!  That said Michal is on the thread so hopefully that's not
an issue and we can get something from Xilinx fairly easily.

--dzBsCT7hqYc2f/af
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmlv7fkACgkQJNaLcl1U
h9AP+wf/fY3dptR4nlcZm7vi3ylm1tT08D0HjjuiLaAYNM7iwdqhtiqP6mphbZwe
2DaY2C7MZQDoP9L8ZLPhmMzBe97Av5zNeog2oQrsqVzHVUjRwVQ+mZQrF4DsFHW/
dESpAcscaKyYcNDZZFLOIQaDXKfXyFQ1/QHLZJ75Sj/btFTqdoEtI3dnvUWJheyb
rnNKtZIl9BAqyFl7kP1gEDDU5Mxw1rsev+hzqisb+Le0NAwQIJk83m0X8yTiW69Z
RGH65oxkW+SegH8762gKdFdzZE4zAQToJf9VONxQZeRTXJ1O9ZcrSmWS9FbFQHoB
b3gndELp/rI7Xxy3DNBEZHWP1FhgIw==
=w2PD
-----END PGP SIGNATURE-----

--dzBsCT7hqYc2f/af--
