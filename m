Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BE4C433EF
	for <linux-spi@archiver.kernel.org>; Mon, 14 Feb 2022 16:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiBNQS7 (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 14 Feb 2022 11:18:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiBNQS5 (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 14 Feb 2022 11:18:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D15C42EE7;
        Mon, 14 Feb 2022 08:18:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDA85614B9;
        Mon, 14 Feb 2022 16:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4100C340EE;
        Mon, 14 Feb 2022 16:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644855529;
        bh=30+VMmwq/+Ww84ESrOXe06POA0Lt6UwrPtl9Lt+70b4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KOdYiF6NBh0X3dd/jzIhVKqdjaCmSJlkRYSvp07dsQjKWRt87+hxE5Qkxzgiox82b
         Q0lG9XKZMUafPhEzNdkWJ9pgtbWL/Ae6TS6H2p9dxHs056p1kYoDx3tcOc8LOxq+QN
         6Lcj/tKD80W5TqvPm2mHxabC4PROpQUJQZZxrRjdy1nLxqZ8rt8jiGUtWRjxFZiAdQ
         oAlCm5pe0ZzQqlvfZQsvUsI/ThgHSr4gPsN0Y/2C8ge+S1lxr94UEacWYVwU0wARZw
         G1XfdixxC/bixfsPJcml60Rx6vBQwu0P1eZGiPKWbnFsl3J9WBV+FmnXya0Yh+Q9gs
         znGjTT7Owwbrg==
Date:   Mon, 14 Feb 2022 16:18:43 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        skomatineni@nvidia.com, ldewangan@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de
Subject: Re: [PATCH 2/6] spi: Tegra234 QUAD SPI compatible
Message-ID: <YgqA45CXxLTx7TY4@sirena.org.uk>
References: <1643970576-31503-1-git-send-email-kyarlagadda@nvidia.com>
 <1643970576-31503-3-git-send-email-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="At+QsLQe3QIxJ5HT"
Content-Disposition: inline
In-Reply-To: <1643970576-31503-3-git-send-email-kyarlagadda@nvidia.com>
X-Cookie: Your lucky color has faded.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--At+QsLQe3QIxJ5HT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 04, 2022 at 03:59:32PM +0530, Krishna Yarlagadda wrote:
> Add compatible string for Tegra234 for Tegra QUAD SPI
>=20
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>

This breaks an x86_64 allmodconfig build:

/mnt/kernel/drivers/spi/spi-tegra210-quad.c: In function 'tegra_qspi_probe':
/mnt/kernel/drivers/spi/spi-tegra210-quad.c:1322:2: error: ignoring return =
value of 'device_reset' declared with attribute 'warn_unused_result' [-Werr=
or=3Dunused-result]
 1322 |  device_reset(tqspi->dev);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~
/mnt/kernel/drivers/spi/spi-tegra210-quad.c: In function 'tegra_qspi_handle=
_error':
/mnt/kernel/drivers/spi/spi-tegra210-quad.c:957:2: error: ignoring return v=
alue of 'device_reset' declared with attribute 'warn_unused_result' [-Werro=
r=3Dunused-result]
  957 |  device_reset(tqspi->dev);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~


--At+QsLQe3QIxJ5HT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIKgOMACgkQJNaLcl1U
h9Bjuwf/VbgBj6Nl0baUijAzK/jUkC0Q/kbtBGV9SdEmIYhv1GZQySMAxbh69PMl
MXwI4JwdVs0SHVHCFFqmCL3X4f6+dZIabNSdTlo6UfTxbM4LvGNyoqMC99fasg9/
0XV/eyb51O783NVT4ZGumapiz07W/Urlw3QIgM0lmINoH0RlD1Aqh58LW4EUd+zA
IkwVm5OpcU6Am5ubysVmInNBiU5OmhMAN1TVdLaTz2r5R+ooducLijBE7gMnNluZ
yPgC/UdkFEUwT4oW4xpzeuXASX+94/E+r1OGfesPq/qou21P8fAh59K0Fskp1ssf
vEPF3R2bOU9ivbOb0Q6aYRNFI2974Q==
=zBVd
-----END PGP SIGNATURE-----

--At+QsLQe3QIxJ5HT--
