Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794485645;
	b=l9MDF9Uq3RlVqLdrKVIZjaW3qN2xZIIVDEt6JllpuIN4uzHbkTkElbxosgZhxa6l4NTR
	 Tzh1mW+prjuC1I7loVItFPK4Nhv0GFK/y7EN1vGW5G9i+oZVU9fvNjufq44VEmfIvQn+z
	 apEqci4YJs/fcu7HJw81BRxuZ5ZqcaUXF5DIjqtcoS6+rKm6dKM1MG753ghSgcD1E2yyn
	 ZvtJxyAkQZ7l20drTTBlWzqv1L17SZvsp/ORDhgaUgvHjvn/aXR1QErW4yeCm6r/OjDMD
	 8YXRlnJi0K43I8bABEtepQoYUzMZryrnpANA0wJUfmC8FzxBQacyV7MSnQ1F09/gF2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794485645;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Subject:From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:
	 X-Last-TLS-Session-Version;
	bh=XnZv+Fvy9sZiITTaYH0t03PvvK3AeTuBITl0A3YU2qs=;
	b=FaeRlpT41VGCPnBIPOKrbGo4yEr/hu1c7yMHhwdQf8Qhv/KiFYWxbYQuFTBcMd37Mu74
	 nH9Qik3O6NNk5GT0dZePTJnZ8leMdN5dEDlBCWD9e1UIBjwvJQleaW2ya9lPaDskntTNS
	 5bAI5O56rhX5FtDrxGXtApKK3aBQa9EKTTurgHmQv/5Ur6nyOJEGcyflp//dxSmMxWJhe
	 oyaA5cdw9zk8vZHRXAZ5XqQj052rCMRPbX0webkB2RaKWcf4VGO5Il83Tg7yZHWZ1ipzj
	 3NinfLfzkreysta5UZDPEiRY4/T4ignkiwSriQyTjyqm2W+YGmYgR63ArRFEHkCfhKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=DeyJN3T2;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D796606A323
	for <linux-spi@vger.kernel.org>; Thu, 12 Nov 2026 12:14:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D796606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=DeyJN3T2
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 701571A162A;
	Thu, 12 Nov 2026 12:14:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3A6A95FF85;
	Thu, 12 Nov 2026 12:14:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C32D711BC09A8;
	Thu, 12 Nov 2026 13:13:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794485640; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=XnZv+Fvy9sZiITTaYH0t03PvvK3AeTuBITl0A3YU2qs=;
	b=DeyJN3T2zm4Qrq+XxdaBnaJFAaHiJ5I0SyHiGLGx87BboKMkXv94dr5S0aQTKSJHtxGCo7
	O9K+YrlhERumzbn9NrlCptuCkqenyxQFcsotbAeYWho3Ok5cbdRaTzuoaokJf2OA11lWOX
	KTfGbsG1vixNQEMrc/J1LOY2A/8G2TqqumxRaQodh6/yaHiPaLoR2pNJzb99KisccYcfP1
	eHK6kpXaE6a9ddHJVdqM1sq0sSOn5BaOVayDJU4VrMpz5JFTlOoo8W7nbRIjylKGTEUzU1
	BRAcypszK9fR0ytqroR5DDEUwBUF4DF7oG3slBF0MA/CjrBhiwqMT9CVzMJ4GA==
Message-ID: <57c4547d2a763b4de6913d14118d90c67ccbbc0a.camel@bootlin.com>
Subject: Re: [PATCH v2 6/6] spi: cadence-xspi: Add workaround for old
 Marvell firmwares
From: Paul Cercueil <paul.cercueil@bootlin.com>
To: kernel test robot <lkp@intel.com>, Mark Brown <broonie@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni
	 <thomas.petazzoni@bootlin.com>, Bharat Bhushan <bbhushan2@marvell.com>, 
 Sunil Kovvuri Goutham
	 <sgoutham@marvell.com>, Tanmay Jagdale <tanmay@marvell.com>, Jisheng Zhang
	 <jszhang@kernel.org>
Date: Thu, 12 Nov 2026 13:13:53 +0100
In-Reply-To: <202611121914.Tdw8zp6W-lkp@intel.com>
References: <20261111103541.100848-7-paul.cercueil@bootlin.com>
	 <202611121914.Tdw8zp6W-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

I had missed the big fat "#ifdef CONFIG_ACPI" in linux/acpi.h.

Looks like some structs aren't defined if !CONFIG_ACPI. Not great design IM=
HO.

I guess I'll send a v3 with ifdef guards around the ACPI code...

Cheers,
-Paul

Le jeudi 12 novembre 2026 =C3=A0 20:02 +0800, kernel test robot a =C3=A9cri=
t=C2=A0:
> Hi Paul,
>=20
> kernel test robot noticed the following build errors:
>=20
> [auto build test ERROR on broonie-spi/for-next]
> [also build test ERROR on linus/master v7.4-rc2 next-20261110]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>=20
> url:=C2=A0=C2=A0=C2=A0
> https://github.com/intel-lab-lkp/linux/commits/Paul-Cercueil/spi-cadence-=
xspi-Properly-handle-errors-in-transfer_one_message/20261111-113536
> base:=C2=A0=C2=A0 https://git.kernel.org/pub/scm/linux/kernel/git/broonie=
/spi.git=C2=A0for-
> next
> patch link:=C2=A0=C2=A0=C2=A0
> https://lore.kernel.org/r/20261111103541.100848-7-paul.cercueil%40bootlin=
.com
> patch subject: [PATCH v2 6/6] spi: cadence-xspi: Add workaround for old
> Marvell firmwares
> config: sparc64-allmodconfig
> (https://download.01.org/0day-ci/archive/20261112/202611121914.Tdw8zp6W-l=
kp@in
> tel.com/config)
> compiler: clang version 20.1.8
> (https://github.com/llvm/llvm-project=C2=A087f0227cb60147a26a1eeb4fb06e3b=
505e9c7261
> )
> reproduce (this is a W=3D1 build):
> (https://download.01.org/0day-ci/archive/20261112/202611121914.Tdw8zp6W-l=
kp@in
> tel.com/reproduce)
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion
> of
> the same patch/commit), kindly add following tags
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes:
> > https://lore.kernel.org/oe-kbuild-all/202611121914.Tdw8zp6W-lkp@intel.c=
om/
>=20
> All errors (new ones prefixed by >>):
>=20
> > > drivers/spi/spi-cadence-xspi.c:1234:58: error: array has incomplete
> > > element type 'const struct acpi_platform_list'
> =C2=A0=C2=A0=C2=A0 1234 | static const struct acpi_platform_list mrvl_pla=
tform_list[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ^
> =C2=A0=C2=A0 drivers/spi/spi-cadence-xspi.c:1234:21: note: forward declar=
ation of
> 'struct acpi_platform_list'
> =C2=A0=C2=A0=C2=A0 1234 | static const struct acpi_platform_list mrvl_pla=
tform_list[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 ^
> > > drivers/spi/spi-cadence-xspi.c:1239:11: error: use of undeclared
> > > identifier 'all_versions'
> =C2=A0=C2=A0=C2=A0 1239 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .pred =3D all_versions,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> > > drivers/spi/spi-cadence-xspi.c:1249:10: error: call to undeclared fun=
ction
> > > 'acpi_match_platform_list'; ISO C99 and later do not support implicit
> > > function declarations [-Wimplicit-function-declaration]
> =C2=A0=C2=A0=C2=A0 1249 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return acpi_match_platform=
_list(mrvl_platform_list)
> >=3D 0;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> =C2=A0=C2=A0 3 errors generated.
>=20
>=20
> vim +1234 drivers/spi/spi-cadence-xspi.c
>=20
> =C2=A0 1233=09
> > 1234	static const struct acpi_platform_list mrvl_platform_list[] =3D {
> =C2=A0 1235		{
> =C2=A0 1236			.oem_id =3D "MRVL=C2=A0 ",
> =C2=A0 1237			.oem_table_id =3D "CN10K",
> =C2=A0 1238			.table =3D ACPI_SIG_DSDT,
> > 1239			.pred =3D all_versions,
> =C2=A0 1240		},
> =C2=A0 1241		{ }
> =C2=A0 1242	};
> =C2=A0 1243=09
> =C2=A0 1244	static inline bool cdns_is_marvell(struct device *dev)
> =C2=A0 1245	{
> =C2=A0 1246		const char *compatible;
> =C2=A0 1247=09
> =C2=A0 1248		if (has_acpi_companion(dev))
> > 1249			return acpi_match_platform_list(mrvl_platform_list)
> > >=3D 0;
> =C2=A0 1250=09
> =C2=A0 1251		if (of_machine_read_compatible(&compatible, 0) < 0)
> =C2=A0 1252			return false; /* shouldn't actually happen */
> =C2=A0 1253=09
> =C2=A0 1254		return strstarts(compatible, "marvell,");
> =C2=A0 1255	}
> =C2=A0 1256=09
>=20
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
