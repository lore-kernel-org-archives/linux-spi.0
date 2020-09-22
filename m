Return-Path: <SRS0=+Fl2=C7=vger.kernel.org=linux-spi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD84C2D0E2
	for <linux-spi@archiver.kernel.org>; Tue, 22 Sep 2020 11:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C27239D2
	for <linux-spi@archiver.kernel.org>; Tue, 22 Sep 2020 11:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1600773815;
	bh=ARItKB/jx518shbzz7yox5coMjXxlB1rVsnaXlMr7v4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=knfV7vfhLUhUujRv2G3aAtZzyBKkoNOxYDWD036tkJJZ4EThDBxTHeUjeFM3Q+SQb
	 r6+i7oBoO6ION/X5X1Dgn9dzBIZ1gGPd2k5W9B6yWgYRq24ZCjiMhYv582/YS5sqHO
	 vhas0LXYTDV9NTmiXluv+uPLo1H4TY6QrJ9Q8V18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIVLXf (ORCPT <rfc822;linux-spi@archiver.kernel.org>);
        Tue, 22 Sep 2020 07:23:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726531AbgIVLXe (ORCPT <rfc822;linux-spi@vger.kernel.org>);
        Tue, 22 Sep 2020 07:23:34 -0400
Received: from localhost (fw-tnat.cambridge.arm.com [217.140.96.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2EB1238A1;
        Tue, 22 Sep 2020 11:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600773814;
        bh=ARItKB/jx518shbzz7yox5coMjXxlB1rVsnaXlMr7v4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DMhrdBbVQD9pfqoT8E0/g0b8Ie0PQ6UErTZ4VKjX+V0vw5KHYq0b4VWDhVM3PkOmg
         Ijp8zHaF13kMflpxhAyNBDLg4Me8IW4I0I0By4YpnOnLbVg4poI/Lgn+UkPzgOn53Z
         oc413K3WWnGobtJabG3x5YAFVTXtiJTbrG0QQaCM=
Date:   Tue, 22 Sep 2020 12:22:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>, linux-spi@vger.kernel.org
Subject: Re: users of spi_unregister_controller() broken?
Message-ID: <20200922112241.GO4792@sirena.org.uk>
References: <20200921110805.GI21278@pengutronix.de>
 <20200921120029.GA4792@sirena.org.uk>
 <20200922100715.yxu55etwq64pry4n@skbuf>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bJ3jXuwtxrXxD2iT"
Content-Disposition: inline
In-Reply-To: <20200922100715.yxu55etwq64pry4n@skbuf>
X-Cookie: Love thy neighbor, tune thy piano.
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-spi.vger.kernel.org>
X-Mailing-List: linux-spi@vger.kernel.org


--bJ3jXuwtxrXxD2iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 22, 2020 at 01:07:15PM +0300, Vladimir Oltean wrote:

> Does it help if you call spi_controller_get(dspi->ctlr) at the beginning
> of dspi_remove, and spi_controller_put(dspi->ctlr) at the end of it?

That'd be another way to do it but TBH it feels pretty contorted.  Just
allocating separate driver data seems a lot less trouble, or taking
copies of fields that are needed to clean up before freeing the
controller.

--bJ3jXuwtxrXxD2iT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl9p3oAACgkQJNaLcl1U
h9A34Qf+NNBywQt0uXJFW62Rg9tcD44OqnMhZnta4cVouQMuK96v6EIZ3bqlyOcq
YmpzVMrHG4HAHvdRMgji2xA4OgFYHdvA32vQbNvtZjuttJ0z4IxSlkmTB6fV8Cyz
86/DXZh7Gq7m3A3E26/H+RzhF68ZhV+yHLBRtvUqsK4SQgUkeNp+ETHV4g5T4rUz
Vwh1WqBYGhDxxIQT9dA13Kq8xRSSGN91Pk35/lgmwtQYNYpHM42+7RSHNMn3H2H5
W5nQXJZeq2xSShLM2tarNJN2urxvIvZyTVYEdZaYzYH4UXnP3UE/yyFtINJNJP5v
LvjdlklQ1WF/T5xeQA0n0OwkrbN0WQ==
=UkzY
-----END PGP SIGNATURE-----

--bJ3jXuwtxrXxD2iT--
