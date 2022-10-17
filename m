Return-Path: <linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A76C4332F
	for <linux-spi@archiver.kernel.org>; Mon, 17 Oct 2022 11:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiJQLto (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Mon, 17 Oct 2022 07:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiJQLtl (ORCPT
        <rfc822;linux-spi@vger.kernel.org>); Mon, 17 Oct 2022 07:49:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C572DC6
        for <linux-spi@vger.kernel.org>; Mon, 17 Oct 2022 04:49:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F4926108F
        for <linux-spi@vger.kernel.org>; Mon, 17 Oct 2022 11:49:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9882C433D6;
        Mon, 17 Oct 2022 11:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666007372;
        bh=4X4LcN25+lwO+RURYoBcclRumNpUbLtS15XOQm1NekI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ftAE4sZsXTkhWtV3nnykV5VDl8B03mhkzitol6v/bciMt7AmS7yg4Q55mSdLlBlXd
         AiA9gPKvWjvbmzBwClq5ago7hUWFS7n4WEP++RjZr5ncNbPyfZ41CxXY4/SboifAhO
         Ob4MZJ8LEYrhvoc774Vk16SosK+8fRgYhDzy5mYB5cJ0iEOg+74o4skG5w9xPllpKk
         H5PRKqTvatiL4p/Y7F18BrNgCCJJTBhU2tYAeJzSru2Ht7+xjJ9HdV1SspQxQ30yFY
         pFskIi8TznXnCF2iMXLQ9i7O15EIssi2cJmzBFqcwC4BhK5uYuvey5TzjJiHOmi/8h
         4h9+bJsjfTmRg==
Date:   Mon, 17 Oct 2022 12:49:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Chris Lesiak <chris.lesiak@licor.com>
Cc:     linux-spi@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [PATCH] spi: spi-imx: mx51 support for more than 4 gpio chip
 selects
Message-ID: <Y01BSOOv+KZ6ndMl@sirena.org.uk>
References: <20221007152830.699869-1-chris.lesiak@licor.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JAI05UtFAHXTUaLm"
Content-Disposition: inline
In-Reply-To: <20221007152830.699869-1-chris.lesiak@licor.com>
X-Cookie: Apply only to affected area.
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--JAI05UtFAHXTUaLm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Oct 07, 2022 at 10:28:30AM -0500, Chris Lesiak wrote:
> The MX51_ECSPI_CTRL and MX51_ECSPI_CONFIG registers have bit fields
> that only support the four slave select channels.  If we are using
> a gpio to support chip_select > 3, we need to be careful not to

This doesn't apply against current code, please check and resend.
Please also try to avoid outdated terminology and refer to chip selects.

--JAI05UtFAHXTUaLm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmNNQUcACgkQJNaLcl1U
h9DpyAf9G46SBvAabphTKXQWPFIcxCYMxzmw1hFy2AXDpqwFlaEd2gcysvDYIiO/
3Lo1KXsw4TXayk/D0kVSeXjfbjCVKU38sTlZbmuGHrdPHPcwLWyz8ocZKabs+3f1
xQv3jQymgD0qEoBjruJ4U2MS9dDmv+7df6pDsQD5gndcFyyTpFGzSazxYCluY3b0
6yJQSnEi98d5evQWP0YTCRwZAhtcwKiPHAd/G0bgVxXYmc/JaSWRG/d/VUvr2pK+
O+ZrSFVoPtFQLd/DzZwcGp1YdhNgQ1DH2IFxYAjm5GIg3rWPLS5HycDZLekqgDZP
9HCS9jCKW0/LpjNjWeoWxsI3+0GLow==
=xTQl
-----END PGP SIGNATURE-----

--JAI05UtFAHXTUaLm--
