Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08445C4361B
	for <linux-spi@archiver.kernel.org>; Thu, 17 Dec 2020 17:26:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D17C6235DD
	for <linux-spi@archiver.kernel.org>; Thu, 17 Dec 2020 17:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727260AbgLQR0W (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Thu, 17 Dec 2020 12:26:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgLQR0W (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Thu, 17 Dec 2020 12:26:22 -0500
Date:   Thu, 17 Dec 2020 17:25:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608225941;
        bh=xLMc/g9mnU1bL3Jqs927GyUiBY/U/XC8FwWvJM2cfeY=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=V7gSZJnreqazz2QaV4Uamd96KfGbxiZrce64Qhv7wcmLvZJXGoPfiWqOIwWAiw9LF
         l96pib/+6/RJLwreIWaLIqVrUBXPMPG3l1F22UccX4hhM4HPVIyksR+sIr7IliajZw
         S5GVPJeMc4WBjkoyrq2NFl6ZoCuwNck8mr+qjtYiCb5jkc5T3Y2Pb+Zocg3hG8B4Mi
         cYHg2QqEiuRy5ZqtUbj3xmHFZxeHk5pUyVupqTMwP+hjj8gtg7Csuq6XdzrbLsnzVw
         PuJ2Mg/yVe1JOKXKBMR1iFG046TUE6QT/ORFyewYvFLKNxsSt+kXN2HlbF4w0YLK3o
         4TBHIBnNbiXKg==
From:   Mark Brown <broonie@kernel.org>
To:     kostap@marvell.com
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, mw@semihalf.com, jaz@semihalf.com,
        nadavh@marvell.com, bpeled@marvell.com, stefanc@marvell.com
Subject: Re: [PATCH v2 1/2] spi: orion: enable clocks before spi_setup
Message-ID: <20201217172528.GG4708@sirena.org.uk>
References: <20201217170933.10717-1-kostap@marvell.com>
 <20201217170933.10717-2-kostap@marvell.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="kadn00tgSopKmJ1H"
Content-Disposition: inline
In-Reply-To: <20201217170933.10717-2-kostap@marvell.com>
X-Cookie: I'll eat ANYTHING that's BRIGHT BLUE!!
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--kadn00tgSopKmJ1H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 17, 2020 at 07:09:31PM +0200, kostap@marvell.com wrote:

> +	/*
> +	 * Make sure the clocks are enabled before
> +	 * configuring the SPI controller.
> +	 */
> +	clk_prepare_enable(orion_spi->clk);
> +	if (!IS_ERR(orion_spi->axi_clk))
> +		clk_prepare_enable(orion_spi->axi_clk);
> +
>  	return orion_spi_setup_transfer(spi, NULL);
>  }

There's no matching disable here so we'll leak the enables every time
setup() is called - we should unwind the enables after calling
_setup_transfer().  It may be more sensible to just take a runtime PM
reference rather than do the raw clock API stuff, one less call and
means if anything else gets added to runtime PM it'll be handled.

--kadn00tgSopKmJ1H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl/blIcACgkQJNaLcl1U
h9BkXwf7BSPq2fElEKheAbNxwx5Zm86UCtONGfv6ORWCBWThJTyhTTkrEUqsUTUn
Ui8fawRs/0n5PJHZC3lW2FM8eftyCf8LTR6UvaU/Hv6PAENEhus3L3RgMQiRVcTp
+BBcYnGFJw/FdZh3Uf4LrMBLdaVpJ1Vi75tVUV0moqI/qLIBFLo22p+3TmlN3OVS
PzJjhSYzAfiGtA7QuvkF5qmP1VY90PfTD2yFQIxYfbvXT/c6h+hbk0XhfFMJ1COm
2cOgJXV905+xTWvJeQ/0kwYOtOZHy8IEXtlEHwNcE0oAiJ7N+PzQ6wYUklOEMrPE
KNM9RBy4NpWYEdCEbsp4uEC8sgUWvA==
=IhY9
-----END PGP SIGNATURE-----

--kadn00tgSopKmJ1H--
