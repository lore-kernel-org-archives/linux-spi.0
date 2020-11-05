Return-Path: <SRS0=1/NZ=EL=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B44C4741F
	for <linux-spi@archiver.kernel.org>; Thu,  5 Nov 2020 17:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C0FC2083B
	for <linux-spi@archiver.kernel.org>; Thu,  5 Nov 2020 17:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604596334;
	bh=prd6A+NX6LVE+G7iCgaOeI4PsZ1pzhd+/v/KcHyOs7M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QPJlZ3+wmFRilB9d6tqyPeH+UuRveasWCLe7KjEsbhj8H13E2Ncs0Y0y1/MmAscT2
	 7ZsqMzCHnCznuRPzRNTPmg05TmoeApSi0/6GAXPjz71Rz07zP716tH3YbfxuDIm5yI
	 1wbsckKlxSec1q/REnHRjgjwx/pLUINcgBNsXvQA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgKERMO (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 5 Nov 2020 12:12:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:56374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgKERMO (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 5 Nov 2020 12:12:14 -0500
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3649206F9;
        Thu,  5 Nov 2020 17:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604596333;
        bh=prd6A+NX6LVE+G7iCgaOeI4PsZ1pzhd+/v/KcHyOs7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2hKjTD3Q7T/nvSvxH8BCCTnpJ+eUegzVk9CdfNBsVLCBLv0mJTC4wLmYztnSDiWDm
         6UHjqbxKsjrm93HgW5CCDac1Fxpaha2MasoC84giqxzcSt1VUFwF/dNq9wpCwKDHdd
         lI7dEKtRblBBHZDqxD/ZpIc+aSNcDyQDtsA5HEtM=
Date:   Thu, 5 Nov 2020 17:12:01 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Cheng-Jui.Wang@mediatek.com, kernel-team@android.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        clang-built-linux@googlegroups.com,
        Daniel Mentz <danielmentz@google.com>,
        linux-spi@vger.kernel.org
Subject: Re: [PATCH v1 2/2] spi: Populate fwnode in of_register_spi_device()
Message-ID: <20201105171201.GF4856@sirena.org.uk>
References: <20201104205431.3795207-1-saravanak@google.com>
 <20201104205431.3795207-2-saravanak@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dWYAkE0V1FpFQHQ3"
Content-Disposition: inline
In-Reply-To: <20201104205431.3795207-2-saravanak@google.com>
X-Cookie: It's the thought, if any, that counts!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--dWYAkE0V1FpFQHQ3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2020 at 12:54:31PM -0800, Saravana Kannan wrote:
> From: Daniel Mentz <danielmentz@google.com>
>=20
> This allows the fw_devlink feature to work for spi devices
> too.  This avoids unnecessary probe deferrals related to spi devices and
> improves suspend/resume ordering for spi devices when fw_devlink=3Don.

>  	of_node_get(nc);
>  	spi->dev.of_node =3D nc;
> +	spi->dev.fwnode =3D of_fwnode_handle(nc);

Why is this a manual step in an individual subsystem rather than
something done in the driver core - when would we not want to have the
fwnode correspond to the of_node, and wouldn't that just be a case of
checking to see if there is a fwnode already set and only initializing
if not anyway?

--dWYAkE0V1FpFQHQ3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl+kMmAACgkQJNaLcl1U
h9BOhgf+MWUPQ9E7PEgdJdwUqM+ffCc99Cl/O061oCqIkejrGFzDQBe1C51Mwua5
YqXAvXKEIkITeDVDKeaHM5Jf3bO6Xe1MxaASDZ40nbv+U2qLqG3MleCqwzOYBug0
7dB69Y4Wm7vB8VGN3CzCkkW3wa6AUKTXrPzSM1/lmZ1KPk+x7OtGvjsbtGBMTqEw
kQopqW/5ol63N7M4G9h37IfNzJgPkrpwdDJnWG5OzzWynyj+qPwQ/xku20aGBRp8
ARW3QLNqQERVhfP45O3/Wgppk0SUUFYx+RFUFyaZHbvn7tFrSFtpaPNKySGdVRQ7
Gxj9X9vuN+18Olyswofjx9rqRTiDRw==
=eA6X
-----END PGP SIGNATURE-----

--dWYAkE0V1FpFQHQ3--
